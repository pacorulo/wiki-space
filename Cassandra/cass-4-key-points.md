# New Features in Apache Cassandra 4.x

At this point in time we have C\* 4.0 and 4.1 where it is needed to take into account that on 4.1 some more new features and improvements were addded.

## [New Features in Apache Cassandra 4.0](https://cassandra.apache.org/doc/4.0/cassandra/new/index.html)

- Java 11
- Performance Improvements: Garbage Collection Support
- Virtual tables
- Audit logging
- Full query logging
- Messaging (Async Internode Messaging)
- Streaming (Zero-Copy Streaming)
- Transient replication
- Repair Improvements
- Migrate from Cassandra 3.x to 4.x
- Both encrypted and unencrypted communications are allowed on storage\_port. This means you no longer have to specify two separate ports in your configuration file. If this looks like something significant that is changing in your Cassandra configuration, make sure to check the server\_encryption\_options section of your cassandra.yaml file to ensure that enable\_legacy\_ssl\_storage\_port is set to false, [Configurable Storage Ports](https://cassandra.apache.org/_/blog/Configurable-Storage-Ports-and-Why-We-Need-Them.html)

> Datastax also provides two useful links (but consider they can be modified in the future as Datastax changes its documentation from time to time without taking care of old links in some cases) that contain some more detailed points from the new features and improvements (I added them to the previous list): [Introduction to Apache Cassandra 4.0](https://www.datastax.com/learn/whats-new-for-cassandra-4/introduction) and [What’s New in Cassandra 4.0?](https://www.datastax.com/learn/whats-new-for-cassandra-4)


## [New Features in Apache Cassandra 4.1](https://cassandra.apache.org/doc/stable/cassandra/new/index.html)

- Paxos v2
- Guardrails
- New and Improved Configuration Format
- Client-side Password Hashing
- Partition Denylist
- Lots of CQL improvements
- New SSTable Identifiers
- Native Transport rate limiting
- Top partition tracking per table
- Hint Window consistency
- Pluggability
- Memtable
- Encryption
- CQLSH Authentication
- and much more

> Some more ueful links from Datastax: [Cassandra 4.1 upgrades extensibility, operations and security](https://www.datastax.com/cassandra-4-1), [It’s time to upgrade to Cassandra 4.1](https://www.datastax.com/blog/its-time-to-upgrade-to-cassandra-4-1) and [Apache Cassandra 4.1: Building the Database Your Kids Will Use](https://www.datastax.com/blog/apache-cassandra-4-1-building-the-database-your-kids-will-use)
