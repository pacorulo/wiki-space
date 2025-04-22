# NoSQL Databases
The NoSQL database universe is compound by databases of the following types/categories (a little summary/explanation of each one below):

- Key-value pair, where data is stored on key-value pairs, that can be briefly explained in the way that each data item is identified by a unique key and it has a value associated that can be "anything" (string, number, object,...), examples of this db type are [Redis](https://redis.io/) or [Memcached](https://memcached.org/)
- Document-oriented, where data is stored in documents and each document is a nested structured of keys and values, examples of this db type are [MongoDB](https://www.mongodb.com/) or [Apache CouchDB](https://couchdb.apache.org/)
- Column-oriented, where data is stored column by column instead of rows (data can be thought as a group of columns that does not have to be the same per rows belonging to the same table), examples of this db type are [Apache Cassandra](https://cassandra.apache.org/_/index.html) or [Apache HBase](https://hbase.apache.org/)
- Graph-based (see details below), examples of this db type are [Nebula](https://www.nebula-graph.io/), [JanusGraph](https://janusgraph.org/) or [Neo4j](https://neo4j.com/product/neo4j-graph-database/)
- Time series, as the name explains, created to manage time-series (data stored and organized chronologically by time), examples of this db type are [InfluxDB](https://www.influxdata.com/) or [Amazon Timestream](https://aws.amazon.com/timestream/) (although some other databases, like Apache C* can be used to efficiently store time-series data)

## Graph Databases
[Graph databases](https://en.wikipedia.org/wiki/Graph_database) are based on the concept of [Graph from discrete mathematics](https://en.wikipedia.org/wiki/Graph_(discrete_mathematics)) and more precisely on [Directed graphs](https://en.wikipedia.org/wiki/Directed_graph). It can be understood as a group of nodes (also called vertices or points) where some of them are linked by relationships (also called vertices, arcs or directed edges) that happen to have a direction, meaning there is always a source and target node where these two nodes are linked by a vertice (this is the reason why the origin or logic is linked to the directed graphs shared before). As a personal abstraction, it can be understood as a map full of points where there are lines (like roads) that are linking two of those nodes and there is always a direction between them in that relationship (like point A pointing to point B, but due to it the relation can be bidirectional, in which case there are two of those lines or relationships, similar to a road where cars are taking both directions, each on one side of the road). This is a very brief introduction to what a graph database is, although it is very well explained by [Neo4j in this link](https://neo4j.com/docs/getting-started/graph-database/) in case we want to dive deeper.

## Graph language
Originally there wasn't a common graph language used as standard by all the existing graph databases. 

Some of the most popular are: 
- [Cypher](https://neo4j.com/docs/cypher-manual/current/introduction/), which is a propietary Neo4j’s declarative query language but with its open source specification called [openCypher](https://opencypher.org/)
- [Gremlin](https://tinkerpop.apache.org/gremlin.html), which is the graph traversal language of Apache TinkerPop
- [SPARQL](https://www.w3.org/TR/sparql11-query/), a language able to retrieve and manipulate data stored in [Resource Description Framework](https://en.wikipedia.org/wiki/Resource_Description_Framework) (RDF) format

Despite of not being a common graph language yet, there is a project to have it that is ongoing and released in April 2024, it is called [Graph Query Language](https://en.wikipedia.org/wiki/Graph_Query_Language).

### Steps on a query
A simplified overview of the steps involved in a query are:
1. The client sends the request to the database server so it reaches the **Network Layer** (it will use the protocol that will be used/defined by the databse), therefore, the connection between the client and the database is managed by this network layer
2. The **Tokenizer** breaks the query into small pieces/components called tokens so it will make easier to later process the query (tokens can be: SELECT, FROM, table_name, etc)
3. The **Parser** comes into play and verifies the correctness of the query (if it fails, then an error is sent back to the client/drivers)
4. *Optimization* is the next step and it decides which one is the most efficient way to execute the query (as an example, it can decide if the use if an index is the proper way)
    > NOTE: points 2, 3 and 4 are called in some occassions as the *Frontend (FE)*
5. **Query execution** takes place at this step (following the plan that has been decided on previous step)
6. **Cache Manager** can come into place in case the query execution (for a read) can be speed up due to the data requested being on cache (it will avoid access to the disk so performance will be improved)
7. **Utility Services** if some other task is needed, as sorting data, some aggregation,...
    > NOTE: points 5, 6 and 7 compound the **Execution Engine** layer/block
8. If the query needs some data manipulation, it will need the work of the **Transaction Manager**, where it will take care that the needed changes are properly executed
9. The **Lock Manager** is a component that is used by the Transaction Mgr, as it will lock the data or resources that need to be locked in case of concurrent operations (it will avoid inconsistencies)
10. The **Recovery Manager** is the next component that is in place, as in case of a crash, it will take care to recover the database to its previous stable point (it is the one that can guarantee the ACID, in case the database can guarantee it)
11. **Concurrency Manager** will take care of concurrent requests to the database (multi-user environments) so consistency is ensured (note that there are different ways to manage concurrency, as it can be the MVCC (Multi Version Concurrency Control))
    > NOTE: points 8, 9, 10 and 11 can be considered as the **Transaction Management** layer
12. **Disk Storage Manager** manages the reads and writes from disk
13. **Buffer Manager** is a temporary cache in memory so it will speed up operations on data that is frequently used and it is managed on fixed size pages
14. **Index Manager** that uses indexes so data can be found fastly and to avoid full scan on data, like for example on tables
    > NOTE: points 12, 13 and 14 compound the **Storage Engine** and it is the core of the database
15. **OS Interaction Layer** or FS interface, that is where the system calls are needed to retrieve the data and also helps to deal with different OS systems
    > NOTE: all components after the FE can be considered as the *Backend* of the database
  
> In distributed databases there can exist a layer compound by **Shared Manager + Cluster Manager + Replication Manager** that will exist between the *Concurrency Mgr* and the *Storage Engine*

*Source*: this very useful (and a little long) [freeCodeCamp](https://www.youtube.com/watch?v=pPqazMTzNOM&t=236s) video (these points are summarized on the first 27 minutes of the video)

A different approach would be:
1. Query formulation (involve the creation of the query on the selected query language)
2. Parsing
3. Query Planning and Optimization
4. Execution
5. Intermediate Results Management
6. Aggregation and Sorting
7. Result Retrieval and Formatting
8. Optional Query Caching
9. Result Transmission

*Source*: https://www.puppygraph.com/blog/graph-query-languagehttps://www.puppygraph.com/blog/graph-query-language


# Neo4j

As detailed above, Neo4j is a graph database, meaning it behaves and uses the same logic that has been shared. Neo4j has an open source edition of their graph database, but it can be used on a 1 node cluster, while if we need a real cluster with more than one node we need to go to their propietary edition. 

Therefore, Neo4j graph db is compound by ndoes and relationships, where:
- **Nodes** 
    - can be tagged with labels, where a label is marks a node as a member of a named and indexed subset and we can assign zero or more labels to each node, therefore, with labels we create these subsets (like groups) of nodes and it also add info to each node
    - they can hold any number of properties, which are key-value pairs
    - are indexed
    - we can define constraints on them, meaning that we can apply rules to ensure data consistency
- **Relationships** 
    - are the connections between the nodes and they will always have a source and target node, meaning there is always a **direction** from node A to B or viceversa
    - can contain properties as Nodes
    - we can assign as many as needed per Node

> When we create a relationship between two nodes, the database stores a pointer to the relationship with each node. When reading data, the database will follow pointers in memory rather than relying on an underlying index.

## Knowledge Graphs & Generative AI
While `Knowledge graphs` (KG) provide a structured way to represent entities, their attributes, and their relationships, allowing for a comprehensive and interconnected understanding of the information, it happens that [GenAI](https://neo4j.com/generativeai/) (Generative AI) needs the access to the meaning in the data that they have to manage and it is where the KG appears, providing the needed context to GenAI.
> Important link: [Graph use cases](https://neo4j.com/use-cases/), which is a [RDF query language](https://en.wikipedia.org/wiki/RDF_query_language)

## Cypher
It is a declarative language, meaning the database is responsible for finding the most optimal way of executing that query.
