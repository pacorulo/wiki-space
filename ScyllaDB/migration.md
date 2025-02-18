# Migration

From S301 ScyllaDB shares this logic tree about when to use a migration strategy X vs to others (to ScyllaDB):
- Can we afford downtime?
    - YES ==> Offline migration, with following flow: Schema migration ==> Forklifting ==> Read from DB-new ==> Write + Read to/from DB-new)
    - NO  ==> Online migration (adds complexity and load, needs to capture current changes on the DB, so there are dual writes), with following flow: Schema migration ==> Dual writes ==> Forklifting ==> Dual reads
    - Common steps: migrate schema +  data migration + data validation

**NOTEs**:
- we need to note that the fastest way is when we use the SSTables directly by loading them to the target cluster 
- use Spark or big clusters while directly CQL Copy/DSBulk for small/er databases (around hundred GB)
- depending on the schema we can or can't use DSBulk as it does not work with collections or counters (it can't inject using timestamp)
- look for the easiest method that will apply what you need
- during dual writes we need to keep tombstones (deletes) if the migration takes longer than the repair period (time it will take) or if we can't repair data during migration, so consider if we need to increase gc grace period
- MVs or indexes shouldn't be created till the migration is completed
- from ScyllaDB 3.1 and above source and target topologies can be different
- Live migration provides more flexibility (to go always back or resolve some issue about something that could happen)
- always use external VM for the migration
- disabling compactions on the target DB will speed up writes (but consider you need enough disk space)
- once migration is completed the validation of the data can be done by sampling (read from source and target) or full scan (Spark) or write our own verification client (like validate only the target DB if there is a predictible logic on the source DB)
- it is critical source DB stability during migration (so speeding up the migration can become a really bad choice)

## Migrating from C\* to ScyllaDB
- C* and ScyllaDB are API compatible
- Complex data-types are challenging
	- as heavy use of collections or non-frozen udt's can led to performance issues
        - LWT's when using dual writes can fail on source but success on target DB or viceversa (which is the worst scenario), so avoid dual write on tables with LWT
- Writetimes can be manipulated by `USING TIMESTAMP` feature
- Use the client side timestamp and alter schema for caching, compaction and compression
