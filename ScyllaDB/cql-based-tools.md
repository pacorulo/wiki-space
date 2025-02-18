# CQL Based Tools

1. [cqlsh COPY TO/FROM](https://www.google.com/url?q=https://docs.scylladb.com/getting-started/cqlsh/%23copy-to&sa=D&source=editors&ust=1738597971259294&usg=AOvVaw2Sz4Guq3KRkVIM2s2_G-Xh)
    - does not preserve timestamp
    - save to CSV
    - load as CQL from CSV file
2. [DSBulk](https://www.google.com/url?q=https://github.com/datastax/dsbulk&sa=D&source=editors&ust=1738597971266221&usg=AOvVaw0sxfQq7Ryxq1PnBUY7Gbkg)
    - it is the java version of previous tool
    - uses a special option to preserve timestamps and ttl's
    - data is unloaded as CSV (dump)
    - loads data on target DB with cql
3. [Scylla Spark Migrator](https://www.google.com/url?q=https://github.com/scylladb/scylla-migrator&sa=D&source=editors&ust=1738597971269591&usg=AOvVaw1nCDNfUFe_S5oChuTF_xw1)
    - [spark-scylla-migrator-demo](https://www.google.com/url?q=https://github.com/scylladb/scylla-code-samples/tree/master/spark-scylla-migrator-demo&sa=D&source=editors&ust=1738597971269860&usg=AOvVaw2OCJrut_aeJKxf_3uef5hb)
    - runs on top of Apache Spark
    - requires Spark 2.4.x and JDK 8
    - not easy to setup but you can resume from the point where it failed
    - can preserve timestamp and ttl (also for collections but with a global timestamp)
    - resilient to failures, high performance with parallelized reads and writes and supports renaming columns
    - be careful about how many workers will run the migrator as it can lead into performance problems
    - the Spark UI tells us about the progress of the migration
    - 
4. Lambda functions
    - by writing a lambda function we can convert source DB to the CQL statement
    - can implement dual writes
5. [SSTableLoader](https://www.google.com/url?q=https://opensource.docs.scylladb.com/stable/operating-scylla/admin-tools/sstableloader.html&sa=D&source=editors&ust=1738597971263463&usg=AOvVaw1C-rw5l-UthzdGcD2n-37K)
    - preserves timestamps
    - converts SSTable into CQL
    - ScyllaDB team think it is the worst option for migrate data
