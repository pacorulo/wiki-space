## Filtering (ALLOW FILTERING)
Filtering is a feature that allows you to filter by column that is not part of the primary key without creating an index or MV and without any storage overhead. Filtering can result in really low query performance because it involves a full table-scan. Still, filtering can be really useful if you don’t have high performance requirements for certain queries or if the result of the query returns most of the rows from the table. The issue comes from queries that execute the filtering read on the coordinator side (allow filtering).

## MV vs 2i vs ALLOW FILTERING

ScyllaDB recommends and decides the best choice is...

- What's the read frequency?
    - Rare? then use ALLOW FILTERING
    - Often? then we need to consider, what's the index cardinality?
        - Low? (meaning that more than 1% of the rows are selected) then use ALLOW FILTERING
        - High? then we need to consider if:
            - we are more worried about read latency, so we better use MV
            - we are more concerned about storage, then it is better if we use 2i

> WARN: ALLOW FILTERING is blocked by default
