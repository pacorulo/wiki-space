# How to Write Better Apps

- Things to avoid
    - Non-prepared Statements
    - Non-paged CQL Reads
    - Non-token Aware Queries
    - Spamming fo ALLOW FILTERING
    - Reverse CQL Reads

- Things to consider during Data Modelling
    - follow a query-driven design (the data model must be created by thinking about what will be the queries used from app side)
    - select a proper Primary Key (not only the clustering keys but the partition key "is key")
    - look for even data distribution (partition key high cardinality, avoid large partitions,...)
    - avoid bad access patterns (related a lot of times to common errors due to SQL way of thinking)

- Imbalances introduce
    - over/under-utilized resources
    - slower replicas
    - higher latencies
    - inability to read data any longer
    - problems, more problems, more and more problems,...


## Drivers

### PreparedStatement vs Non-PreparedStatement
It is recommended to always use `PreparedStatement` as it will avoid uneeded round-trips between the driver and `ScyDB/C*`. An explanation that is useful and clear can be found in this [C* latest Datastax Java driver](https://docs.datastax.com/en/developer/java-driver/4.17/manual/core/statements/prepared/index.html) or in this [ScyllaDB Prepared Statements](https://java-driver.docs.scylladb.com/stable/manual/core/statements/prepared/) doc.

### Token Aware Policy 
It is good to create our own `DefaultPolicy Builder` and be sure of enabling `Token Aware` together with `Round Robin` load balancing policy (to query the nodes in a round-robin fashion, at DC level or not, depending if it is DC aware or not, but DC aware is the recommended one as remote DC is used only as fallback).
