# ScyllaDB Operations

## Journalctl Commands
Filter:
- Scy logs: `journalctl -u scy-server`
- Scy-manager logs: `journalctl | grep -i manager` OR `journalctl  -u scylla-manager`
- Scy logs by priority: `journalctl -u scylla -p err..emerg` OR `journalctl -u scylla -p warning`
- Scy logs by date: `journalctl -u scylla-server --since "2025-01-01"` OR `--until "2025-01-01 00:00"` OR `journalctl -u scylla --since yesterday` 
- Scylla logs since last server boot: `journalctl -u scylla -b`

See [Scylla Logs](https://opensource.docs.scylladb.com/stable/getting-started/logging) and [systemd journal](https://www.freedesktop.org/software/systemd/man/latest/systemd-journald.service.html) and [journactl man](https://www.freedesktop.org/software/systemd/man/latest/journalctl.html) for further reference.

## CQL Shell
Some important commands:
- HELP
- CONSISTENCY, show and/or set
- DESCRIBE|DESC, schema
- PAGING, enable/disable
- TRACING, enable/disable
- EXPAND, expand a query output vertically
- EXIT, bye bye my friend
- `cqlsh --connect-timeout="time_in_seconds"`, default is 5 seconds
- `cqlsh -e|-f`, to avoid interactive mode/prompt or use an input file, respectively

## C* stress tool
The recommendation is not to use it in prod. Use it by customizing different parameters. Some times better to test from our app side.
[ScyllaDB C*-stress](https://opensource.docs.scylladb.com/stable/operating-scylla/admin-tools/cassandra-stress)
[Apache C* stress](https://docs.datastax.com/en/dse/5.1/tooling/cassandra-stress-tool.html)
[Datastax C* stress](https://docs.datastax.com/en/dse/5.1/tooling/cassandra-stress-tool.html)
> [YCSB](https://www.scylladb.com/glossary/ycsb/) is another benchmark tool used by Scy

## Tracing
[Tracing](https://opensource.docs.scylladb.com/stable/using-scylla/tracing) is disabled by default, but once enabled it must be on for a very small window as it will impact your performance if the workload is "good enough" (like most of the production workloads). Stored in the system_traces keyspace. It randomly chooses a request to be traced with some defined probability. 
> Also take a look at [Slow Query Logging](https://opensource.docs.scylladb.com/stable/using-scylla/tracing#slow-query-logging), where a similar slow query logging, see [Collecting Slow Queries](https://docs.datastax.com/en/dse/6.9/managing/management-services/performance/collect-slow-queries.html) doc, also exists on DSE while Apache C* has a new feature coming from v4.0 named [Full Query Logging](https://cassandra.apache.org/doc/stable/cassandra/operating/fqllogging.html) that is not the same feature that exists in either ScyllaDB or DSE, but can help to track queries.

