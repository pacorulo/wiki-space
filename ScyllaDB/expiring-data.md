# Expiring data

## Tombstones

Types of tombstones:
- cell-level (`DELETE column_A FROM table_name WHERE KEY = ?`)
- range (`DELETE FROM table_name WHERE KEY = ? and ck <= ?`)
- row (`DELETE FROM table_name WHERE KEY = ? and ck = ?`)
- partition (`DELETE FROM table_name WHERE ck = ?`)
- TTL

 Things to take into account:
- select the right compactrion strategy
- review the DELETE patterns (including NULL inserts)
- use tombstone garbage collection (repair-based)
- new in 5.2, [Empty Replica Pages](https://github.com/scylladb/scylladb/commit/e9cbc9ee85c25deb5ba9ee67ffa6e3ca9f904660)

### with TTL

- TTL can be defined at table level (with the clause `WITH default_time_to_live = time_in_seconds` at table definition) or when there is an upsert at column or for an entire row
- To check what is the pending time for a TTL (so data will be removed), we can `SELECT TTL(column_name) FROM table_name WHERE ...;`
- To remove a pending TTL we need to set it to zero, example: `UPDATE table_name USING TTL 0 SET ...;`
