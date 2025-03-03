# About Apache Cassandra Open Source NoSQL Database

The DB that introduced me in the NoSQL world and the one I fell in love.

- [Apache C\* Index](https://cassandra.apache.org/_/index.html)

## Why do I love Cassandra

I thought it would be nice to list some of the reasons why I love Cassandra, they are related to its logic, to my experience observing SQL administrators facing Cassandra and for some other reason... 

I love Cassandra due to:

- C\* "is not an easy DB", she will request you efforts
- it is a distributed, highly available, high performance, low maintenance (of course when you make it stable and do not change logics too much at driver side, for example), highly scalable NoSQL database 
- there are no master nor slaves
- the [CAP theorem](https://en.wikipedia.org/wiki/CAP_theorem) and how Cassandra can accomplish only 2 out of 3 of its premises at a time
- I love when I saw a SQL Administrator saying "is it a database?" due to C\* providing [Eventual Consistency](https://cassandra.apache.org/doc/latest/cassandra/architecture/guarantees.html#eventual-consistency) (as consecuence of the CAP theorem)
- I like distributed databases with replication factors and consistency levels and also the existence of a coordinator (nor master nor slave but some order is needed)
- it is fun to work with CL and understanding what is the behavior on each case and with the differences on reads and writes ops (or when we discover SERIAL wasn't used with LWT's)
- more and more reasons...


## Looking at Apache Cassandra as an LSMT database

Apache Cassandra is a database that uses [LSMT (Log-Structured Merge-Tree)](https://en.wikipedia.org/wiki/Log-structured_merge-tree) (unlike a typical relational DB that uses [B-Tree](https://en.wikipedia.org/wiki/B-tree)) data structure. 

In order to start with C\* and trying to understand it, we can look at the main points from a LSMT database (below a very brief summary with some notes):
- it provides a [transactional log data](https://en.wikipedia.org/wiki/Transaction_log), but more precisely C\* uses a write-ahead log (WAL) file (below more info, see the first point in the `write` operation notes)
- it uses a storage structure similar to LSM trees (Log-Structured Merge-Tree) and if we look at a simple version of a two-level LSMT, we see it is comprised by two [tree-like](https://en.wikipedia.org/wiki/Tree_(abstract_data_type)) structures/levels, that can be called C<sub>0</sub> and C<sub>1</sub>, where:
    - C<sub>0</sub> is resident in memory
    - C<sub>1</sub> is resident on disk
    - when C<sub>0</sub> exceeds a certain threshold, entries are removed from C<sub>0</sub> and merged into C<sub>1</sub> (called compaction operation) as immutable sorted data
    - data is written in a sequential manner, not in any random way
    - a read operation first goes to memory (level 0) to later go to next levels till it is found (or not)
    - LSMT was originally designed for write-intensive workloads

Looking at some characteristics for **LSMT** `write` and `read` operations:
- `write`
    - the system may use a [write-ahead log (WAL)](https://en.wikipedia.org/wiki/Write-ahead_log) that records all incoming writes before they are added to the memory buffer, ensuring that no data is lost in the event of a crash during a write
    - updates are treated as new writes, while deletes are marked with a tombstone entry, which is a placeholder indicating that the key has been deleted (these tombstones are later removed during the merging process)
- `reads`
    - because of the multi-level structure and the immutability of disk components, a read involves several levels
    - every read starts on C<sub>0</sub> (memory)
    - if the key is not found in memory, it starts seeking on the first level, C<sub>1</sub>, and so on (it happens as newer levels contain the most recent data)
    - to make the search faster, LSMT often use a [bloom filter](https://en.wikipedia.org/wiki/Bloom_filter) for each on-disk component where these filters are probabilistic structures that help quickly determine whether a key is definitely absent from a component and are checked before disk is accessed

By reading and understanding LSMT we can think we know the main points to start leraning about C\*, although luckily happens that C\* is a complex database compound by a lot of different logics, to express it in a certain sense.

### Apache C\* wiki documentation
- [New Features in Apache Cassandra 4.x](cass-4-key-points.md)
