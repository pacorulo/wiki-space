# Tips Schema/Cql related

Here I will write down some tips that can be helpful when creating any part of the schema.

- When creating a KS, we need to force `tablets` to false to enable `CDC + LWT + counter` features (if not disabled you won't be able to use those 3 features)
```
CREATE KEYSPACE twitch
WITH REPLICATION = {
'class' : 'NetworkTopologyStrategy',
'replication_factor' : 3}
AND TABLETS = {'enabled': false};
```
