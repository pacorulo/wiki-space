# Compaction
Scylla uses LSM (Log Structured Merge Tree) on disk for `SSTables (Sorted String Tables)`. The write goes to the Memtable (on memory) and the Commitlog (append-only structure on-disk that guarantees durability, aka write-ahead log, WAL). After memtable is flushed into disk the SSTables are created (with sorted data to later help to read and merge data) and "the commitlog file can be deleted" (`there are no dirty mutations in an active segment, CommitLog removes the segment`, more detailed info from [Apache C\*Commitlog](https://cassandra.apache.org/_/blog/Learn-How-CommitLog-Works-in-Apache-Cassandra.html) or [Apache C\* Storage Engine](https://cassandra.apache.org/doc/stable/cassandra/architecture/storage_engine.html#commit-log)).

Reads goes first to cache, then to Memtable (both on memory) and finally if the data wasn't found, it goes to disk on SSTables by first checking the Bloomfilter (it is a probabilistic filter that can produce false positives) that points out to the SSTables containing the data that has been requested. There are 3 types of cache:
- index cache
- row cache
- partition cache

Some important concepts are: 
- `Write amplification` is having several versions of the same cell (meaning they exist on different SSTables)
- `Mutations` are the data changes (updates) and the mutations that can be deleted during compaction are: data overwritten (last write wins), expired data (TTL), deleted data (called tomstones) and droppable tombstones (after gc grace time is when they are `garbage-collected`)
- therefore `Read amplification` is when several SSTables must be read to get the data requested, which is an expensive operation for obvious reasons

A compaction is basically the operation of merging several SSTables (merging sorted sstables). The `Schedulers` and the `Controllers` are controlling and managing the compactions, so isolating it to not cause any issue as increasing latencies. There are several compaction strategies and depending on each of them the compactions happen in a different way and order/time. These different compactions strategies have different scenerios where they will behave better, like for example if we are going to mostly write we will use STCS while if we mostly read then we should use LCS.

## Legacy Compaction strategies

### STSC (Size-Tiered Compaction Strategy)
SSTables are organized on tier based on their size and compaction happens when there are 4 (default value) SSTables having the same average size, and then one SSTable is created from those previous 4. It requires at least twice the data size of storage (free storage) as existing SSTables are not deleted till the new one is created by the compaction (and this is due to the case of a major compaction that would compact all SSTables into one so in theory we need double the current SSTable size of free storage).

### LCS (Leveled Compaction Strategy)
SSTables have "an almost max" fixed size (by default 160 MB max size, but a SSTables can be larger if there is a very large partition on it) and are organized on levels. A compaction is triggered on level `i` when there are more than 10^i SSTables by merging (compacting) all SSTables from Li with SSTables from L(i+1) (on level i=0 the compaction is triggered when there are 4 SSTables and the merged executed with L1 SSTables and we need to take into account that we could have more than 4 SSTables on L0 if we don't have enough disk bandwidth to compact L0 with L1). Therefore, on each higher level the SSTables are much bigger than in the previous one (around (1+10)*X, where X is the size of the SSTable in the previous level).
LCS guarantees that no overlapping SSTables are in the same level. It means that the first/last token of a single sstable overlaps with any other SSTable on the same level (as SSTables are sorted, it means there is no intersection if the condition of first/last token does not overlap with any other SSTable on the same level, meaning that for a partition key read it will have to look at most at only one SSTable per level to get the data, except for L0)

An estimated level size is the following:

| Li |  Minimum max size per level |
|   :----:  | :---:  |
| L0 |  1      * 160 MB = 160 MB |
| L1 |  10     * 160 MB = 1600 MB |
| L2 |  100    * 160 MB = 16000 + 1600 = 17 GB |
| L3 |  1000   * 160 MB = 160000 + 1600 + 16000 =  177 GB |
| L4 |  10000  * 160 MB = 1600000 + 1600 + 16000 + 160000 =  1.7 TB |
| L5 |  100000 * 160 MB = 16000000 + 1600 + 16000 + 160000 + 1600000 =  17 TB |

> [Apache C* LCS](https://cassandra.apache.org/doc/stable/cassandra/operating/compaction/lcs.html) and [Scylla LCS](https://enterprise.docs.scylladb.com/stable/kb#leveled-compaction-strategy-lcs)

### TWCS (Time Window Compaction Strategy)
Designed for handling time series workloads. SSTables inherit the write time that is appended to data once it is written in the Memtable. SSTables are compacted together if they belong to the same time window and it is defined at table level by also defining the parameters:
- compaction\_window\_unit, defines the unit for our TWCS, it can be DAYS, HOURS or MINUTES
- compaction\_window\_size, defines the number of units that make up a window
  
It is important to remember that we should select a compaction\_window\_unit and compaction\_window\_size pair that produces approximately 20-30 windows, so for example, if writing with a 90 day TTL, then a 3 Day window would be a reasonable choice: `'compaction_window_unit':'DAYS','compaction_window_size':3` (in this example only SSTables containing data for the last 3 days can get compacted by STCS).
  
A couple of important points are that all data is expired through TTL and compactions on the same time window are executed by using STCS (so once 4 SSTables of the same average size on the same time windows will get compacted into one).

> Old but great articles from `TheLastPickle` team about [TWCS Part1](https://thelastpickle.com/blog/2016/12/08/TWCS-part1.html) and [TWCS Part2](https://thelastpickle.com/blog/2017/01/10/twcs-part2.html)


### ICS (Incremental Compaction Strategy)
New compaction strategy, only available in newer ScyllaDB Enterprise releases (2019.1.4 and above). It is recommended when there are mostly reads with many writes (consider a write can be any operation that involves a write, like a delete or update) or with write-only, i.e., on the same cases where STCS is recommended but this new compaction improves STCS. 

Concepts:
- a `Fragments` are the non-overlapping SSTables, are disjoint (they have no shared keys) and sorted with respect each other
- a `run` is equivalent to a large SSTable + split into several smaller SSTables, we scan the runs fragment-by-fragment and compact them incremantally while deleting exhausted SSTables as we go
  
Therefore, a `run` or `SSTable run` is compound of `Fragments`. ICS does not produce SSTables, this new compaction strategy produces `SSTable run` which is a split of a large SSTable into a run of sorted, fixed/small SSTables of the same size (by default 1 GB), that are know as `Fragments`, as LCS does but now ICS treats the entire run and not the individual SSTables as the sizing file for STCS (`SSTable run` is the input, producing a new `run` as output and deleting ).

Check [ICS](https://enterprise.docs.scylladb.com/stable/kb#incremental-compaction-strategy-ics-scylladb-enterprise) or [Incremental compaction 2.0](https://www.scylladb.com/2021/04/28/incremental-compaction-2-0-a-revolutionary-space-and-write-optimized-compaction-strategy/) for further details.
