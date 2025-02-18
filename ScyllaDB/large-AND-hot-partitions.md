# Large partitions

`ScyllaDB vs C*` large partition warning threshold, `compaction_large_partition_warning_threshold_mb` parameter:
- default value in C*: 100 (MB)
- default value in ScyllaDB: 1000 (MB)

ScyDB has a page cut off at every 1 MB to potentially avoid system OOM, therefore, the partition size will impact it in the sense that the [Payload](https://en.wikipedia.org/wiki/Payload_(computing)) defines how many pages will be needed. As an example, a payload size of 4 KB with a Partition size of ~40MB means 4 pages will be needed to show the whole partition because of those 1MB page cut off. It also means once the partition gets enough high the latencies will start to suffer.

They can be found under the tables:
- `system.large_partitions`
- `system.large_rows`
- `system.large_cells`

> IMPORTANT NOTE: these tables do not exist on Apache C*

ScyDB offers this useful [Large Partitions Hunting](https://opensource.docs.scylladb.com/stable/troubleshooting/debugging-large-partition.html) blog.
> `Datastax` offers this [Identifying large partitions and their keys](https://support.datastax.com/s/article/Identifying-large-partitions-and-their-keys) doc (take into consideration this doc says that it applies DSE and Apache C* 2.1 or later) or Under Apache C* documentation there is some useful info, like [Output only partitions over 100MiB in size](https://cassandra.apache.org/doc/5.0/cassandra/managing/tools/sstable/sstablepartitions.html#output-only-partitions-over-100mib-in-size)

## Hot Partitions

As ScyDB introduced `shards`, they have to be taken into account on finding out hot partitions (nodes and shards)

> NOTE: if using a boolean then there are two possible values and it means both will be large partitions ([Check structure of primary and partition keys](https://docs.datastax.com/en/planning/oss/data-model.html#check-structure-of-primary-and-partition-keys)

Where does the problem come from?
- if the affected shards are from the coordinator, then the issue must be at driver side
- if the affected shards are from the replicas, then the issue must be at data model

A helpful feature can be to tune the value of `--max-concurrent-requests-per-shard <n>` (it is a feature similar to DynamoDB concurrency limit).
