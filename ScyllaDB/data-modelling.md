# Basic Data Modeling

Main steps:
- Domain, the conceptual data model that involves to identify the key entities and their relationships
- Application, identify the application workflow and main queries as the data model is built around the queries and therefore it is done early
- Database schema, the logical data model by defining keyspaces, tables and columns
- Physical data model, done using CQL
- Review and optimize, once it is tested by loading data, tesing the queries and think about how it will scale so the data model will be able to handle future workkloads

3 Important points to be taken into account when desingning the data model from the perspective of the App Workflow and Query Analysis:

- Aim at creating a single partition per query. If a query needs to access only one partition, it would be very efficient. If multiple partitions need to be accessed for a single query, this can be acceptable, but it would be less efficient. If multiple partitions are being accessed for a query that’s being used often, we get less efficiency and maybe something in the data model is wrong
- Avoid scanning the entire cluster to find the data
- Avoid scanning an entire table for the information needed (linear search)

## Primary key (partition + clustering)

When choosing a partition key, we look for high cardinality (the number of possible values for the partition key, meaning data will be spread in a larger number of nodes and therefore it can affect to an even distribution of data, as if the partition key would have like 5 different values, then the hash function will create only 5 different values and it implies a low cardinality and data won't be evenly distributed in a medium to large cluster) and even data distribution. We need to avoid: low cardinality (as oppose to high cardinality), hot partitions and large partitions.

The clustering key/s allow useful range queries and LIMIT.

## Data Types

See [Data Types](https://opensource.docs.scylladb.com/stable/cql/types.html) for further info. But also take a look at [C* Data Types](https://cassandra.apache.org/doc/5.0/cassandra/developing/cql/types.html#collections)

### Collections: sets, lists and maps

[Apache C* collections](https://cassandra.apache.org/doc/5.0/cassandra/developing/cql/types.html#collections)

- Collections describe a group of items connected to a single key. If used correctly, they can help simplify data modeling. Remember to use the appropriate collection per use case. Keep collections small to prevent high latency during querying the data.
    - A collection can be frozen or non-frozen. A non-frozen collection can be modified, i.e., have an element added or removed. A frozen collection is immutable, and can only be updated as a whole. Only frozen collections can be used as primary keys or nested collections. And about frozen or non-frozen, it happens that individual collections are not indexed internally. This means that even to access a single element of a collection, the whole collection has to be read (and reading one is not paged internally).
- A set is a (sorted) collection of unique values. It is stored unordered but retrieved in sorted order. Sets are ordered alphabetically or based on the natural sorting method of the type. When using `set`, the elements are naturally sorted. If a specific order is required, say insertion order, a List might be preferable. The values are unique. Lastly, for sets, TTLs are only applied to newly inserted values. Examples: multiple email addresses or phone numbers per user or set<text> // A set of text values
- A list is a (sorted) collection of non-unique values where elements are ordered by their position in the list. Note that lists have limitations and specific performance considerations that you should take into account before using them. In general, if you can use a set instead of list, always prefer a set. Example: list\_name list<int> // A list of integers. _Warnings_: The append and prepend operations are not idempotent by nature. So in particular, if one of these operations times out, then retrying the operation is not safe and it may (or may not) lead to appending/prepending the value twice. And setting and removing an element by position and removing occurences of particular values incur an internal read-before-write. These operations will run slowly and use more resources than usual updates (with the exclusion of conditional write that have their own cost).
- A map is a (sorted) set of key-value pairs, where keys are unique and the map is sorted by its keys, they are very helpful with sequential events logging. Example map\_name map<text, text> // A map of text keys, and text values
