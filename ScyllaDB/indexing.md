# Indexing

There are three indexing options available in ScyllaDB: `Materialized Views` (MV), `Global Secondary Indexes` and `Local Secondary Indexes`. In ScyllaDB, unlike Apache Cassandra, both Global and Local Secondary Indexes are implemented using Materialized Views under the hood.
- MV are a global index. When a new MV is declared, a new table is created and is distributed to the different nodes using the standard table distribution mechanisms
- Global Secondary Indexes (also called Secondary Indexes), are indexes created on columns that are not part of the partition key or not entirely part of it, allowing efficient searches on non-partition keys 
	```
	ScyllaDB takes a different approach than Apache Cassandra and implements Secondary Indexes using global indexing. With global indexing, a Materialized View is created for each index. The Materialized View has the indexed column as the partition key and primary key (partition key and clustering keys) of the indexed row as clustering keys. ScyllaDB breaks indexed queries into two parts: (1) a query on the index table to retrieve partition keys for the indexed table and (2) a query to the indexed table using the retrieved partition keys.
	```
	> Read more in [this blog post](https://www.scylladb.com/2017/11/03/secondary/)
- Local Secondary Indexes, the partition key of the base table and the index are the same key, the corresponding rows in the index are guaranteed to end up on the same node. This results in very efficient queries if you filter by the indexed column(s)

Apache C* has Primary indexing and Secondary indexing (2i) on all C* versions while on C* 5.0 Storage-attached indexing (SAI) was introduced (below a brief explanation of each one):
- Primary indexing, the primary index is the partition key in Apache Cassandra
- Secondary indexing (2i), the original built-in indexing written for Apache Cassandra, where this indexing method is only recommended when used in conjunction with a partition key
- SAI, for non-partition columns, and attaches the indexing information to the SSTables that store the rows of data
Take into account that for Apache C*, MV is not listed as an index, while for ScylllaDB it is the base of all ways to index data. But an index is a new/hidden table on top of a base one.

## MV
- the primary key on the MV cannot be null on any case (any column defining the primary key cannot be null)
- the partition key of the base table must be part of the primary key in the MV
- although on Apache C* it happens that MV suffer from performance perspective, on words from ScyllaDB they are good due to: `"ScyllaDB’s superior performance often makes it acceptable for the user to use advanced but slower features like Materialized Views. This helps to improve the application’s data consistency and speed up its development"`
- once created the new MV, we can monitor its build status by querying `system_distributed.view_build_status` table or executing `nodetool viewbuildstatus`
- updates on MV are asynchronous (it is important as maybe the data is not in there at the time we could be expecting)
- CL level is not enforced on MV

_NOTE_: while working on the Scylla hands-on lab for MV we got the message `When running ScyllaDB with Docker and in scenarios in which static partitioning is not desired - like mostly-idle cluster without hard latency requirements, the --overprovisioned command-line option is recommended. This enables certain optimizations for ScyllaDB to run efficiently in an overprovisioned environment. The --smp command line option restricts ScyllaDB to COUNT number of CPUs` when we executed:
```
docker run --name nodeX -d scylladb/scylla:6.1.1 \
  --overprovisioned 1 \
  --smp 1"
```
