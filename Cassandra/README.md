# Cassandra wiki-space

The DB that introduced me in the NoSQL world and the one I fell in love.

- [C\* Open Source Index](https://cassandra.apache.org/_/index.html)

## Why do I love Cassandra

I thought it would be nice to list some of the reasons why I love Cassandra, they are related to its logic, to my experience observing SQL administrators facing Cassandra and for some other reason... 

I love Cassandra due to:

- C\* "is not an easy DB", she will request you efforts
- it is a distributed, highly available, high performance, low maintenance (of course when you make it stable and do not change logics too much at driver side), highly scalable NoSQL database 
- there are no master nor slaves
- the CAP theorem and how Cassandra can accomplish only 2 out of 3 of its premises at a time
- I love when I saw a SQL Administrators saying "is it a database?" due to C\* providing [Eventual Consistency](https://cassandra.apache.org/doc/latest/cassandra/architecture/guarantees.html#eventual-consistency)
- I like distributed databases with replication factors and consistency levels and also the existence of a coordinator (nor master nor slave but some order is needed)
- it is fun to work with CL and understanding what is the behavior on each case and with the differences on reads and writes ops (or when we discover SERIAL wasn't used with LWT's)
- more and more reasons...

