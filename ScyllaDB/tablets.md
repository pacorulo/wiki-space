# Tablets

Tablets are implemented in ScyllaDB 6.0 and does not have any similar on C\* or DSE.

There a couple of interesting and very helpful docs about tablets:
- [Part 1](https://www.scylladb.com/2024/06/13/why-tablets/)
- [Part 2](https://www.scylladb.com/2024/06/17/how-tablets/)
> The concept of tables was introduced by [Google Big Table Paper (2006)(2006)](https://static.googleusercontent.com/media/research.google.com/en//archive/bigtable-osdi06.pdf), which uses Paxos

From Part 1 we get the following intro about tablets: `ScyllaDB 6.0 is the first release featuring ScyllaDB’s new tablet architecture. Tablets are designed to support flexible and dynamic data distribution across the cluster. Based on [Raft](https://raft.github.io/raft.pdf), this new approach provides new levels of elasticity with near-instant bootstrap and the ability to add new nodes in parallel – even doubling an entire cluster at once`

- Improvements (see `Part 1` link shared above for further reference):
    - Fast bootstrap/decommission (as usually it is done when there is some CPU capacity issue or running out of space and we all want it to be done asap)
    - Incremental bootstrap (no need to wait will the bootstrap is completed to start serving reads)
    - Parallel bootstrap (it seems another major improvement compared to C\* or DSE)
    - Decouple topology operations (one more major improvement as topology changes being decoupled means any issue that can happen can be easier resolved)
    - Improve support for many small tables (it seems an improvement for Scy itself)
- Tablets implementation was based on 4 key points (see `Part 2` link shared above for further reference):
    - Indirection and abstraction (a tablets table was created as source of truth and it implies that: `Each node controls its own copy, but all of the copies are synchronized via Raft`)
    - Independent tablet units (`Tablets dynamically distribute each table based on its size on a subset of nodes and shards` and `Each tablet runs the entire log-structured merge (LSM) tree independently of other tablets that run on this shard` so `everything (SSTable + memtable + LSM tree) can be migrated as a unit` and one more implication is that `cleanup` ops are no more needed)
    - A Raft-based load balancer (manages and monitor the cluster, where teh load balancere is hosted on a single node but with high availability)
    - Tablet-aware driver (old drivers can work with tablets but won't do it as weel as new tablet-aware drivers, where these new drivers won't read from tablet tables but will do a "lazy learning" process by creating routing information "little by little")

We need to take into account that:
- when bootstrapping new nodes without tablets, the writes start at the time the start joining the ring while the reads need to finish the whole bootstrap process to be started. It is one of the major improvements as with `Tablets` the nodes start bootstrapping and almost inmediately start receiving either writes or reads (`a node can start shouldering the load – little by little – as soon as it’s added to the cluster`)
- [Heat Weighted Load Balancing](https://www.scylladb.com/2017/09/21/scylla-heat-weighted-load-balancing/) is present on tablets or non-tablets bootstraps, so the amount of reads on new added nodes will need some time to be the same (till cache is "warmed up enough") 

> Tablets and some other new features and improvements that came with Scy 6.0 are briefly explained in this [link](https://www.scylladb.com/2024/06/12/introducing-scylladb-6-0-with-tablets-and-strongly-consistent-topology-updates/)
