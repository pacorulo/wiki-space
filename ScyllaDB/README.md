# ScyllaDB Wiki Space

ScyllaDB as opposed to C*, what do they have in common, what are the main differences,... I have tried to write down notes about what I found interesting after completing some ScyllaDB University courses and adding it to my previous knowledge about Apache C*, DSE (and even Astra Classic and Serverless).

- [ScyllaDB github repo](https://github.com/scylladb/scylladb)
- [ScyllaDB Documentation](https://docs.scylladb.com/stable/)
- [ScyllaDB University](https://university.scylladb.com/)


### Scylla Best Practices Related
- [ScyllaDB Best Practices](https://opensource.docs.scylladb.com/stable/operating-scylla/procedures/tips/)
- [ScyllaDB Getting Started](https://opensource.docs.scylladb.com/stable/getting-started/)
- [ScyllaDB Scylla_setup script](https://github.com/scylladb/scylladb/blob/master/dist/common/scripts/scylla_setup)
  > This setup script executes important ops related to `Interrupts`, as explained in the Scy University ([here](https://www.linkedin.com/pulse/how-interrupts-handled-processor-detailed-view-vasuki-shankar) a detailed and good doc about a detailed view on them)
- [ScyllaDB Best Practices for Applications](https://www.scylladb.com/2019/03/27/best-practices-for-scylla-applications/)


### ScyllaDB vs Apache C* compatibility
There is a good documentation from ScyllaDB about compatibility [here](https://opensource.docs.scylladb.com/stable/using-scylla/cassandra-compatibility.html#scylladb-and-apache-cassandra-compatibility). In some sense it reminds me to Windows vs. Linux, where Linux is opened to Windows but not the other way around, but it is also understandable in the sense that it was ScyllaDB who rebuilt it all from Apache C*. In any case, the future will say who will "win".

#### ScyllaDB Ports
| Port  | Description | Protocol |
|   :----:  | :---:  | :---:  |
| 3000  | Grafana   | TCP |
| 7000  | Inter-node communication (RPC)    | TCP |
| 7001  | SSL inter-node communication (RPC)    | TCP |
| 7199  | JMX management    | TCP |
| 9042  | CQL (native_transport_port)   | TCP |
| 9090  | Prometheus   | TCP |
| 9142  | SSL CQL (secure client to node)   | TCP |
| 9100  | node_exporter (Optionally)    | TCP |
| 9160  | Scylla cient (Thrift)    | TCP |
| 9180  | Prometheus API    | TCP |
| 10000 | ScyllaDB REST API | TCP |
| 19042 | Native shard-aware transport port | TCP |
| 19142 | Native shard-aware transport port (ssl)   | TCP |

**NOTES**: 
  - ScyllaDB implements JMX for compatibility reasons such as `nodetool` but `The JMX server uses Scylla's REST API to communicate with a Scylla server` (see [scylla-jmx](https://github.com/scylladb/scylla-jmx) for further reference)
  - Scylla client port (Thrift), 9160, used on 5.x is removed from 6.x versions

#### Snitch Compatibility with Apache C*

| Name  | C* version | ScyllaDB version | For production use |
|   :----:  | :---:  | :---:  | :---:  |
| SimpleSnitch (default)    | C* 3.11,4.x| 5.x,6.x | No |
| GossipingPropertyFileSnitch   | C* 4.x; C* 5.0 | 5.x,6.x | Yes |
| PropertyFileSnitch    | C* 4.x | | No |
| AlibabaCloudSnitch | | |  Yes |
| [CloudstackSnitch](https://cloudstack.apache.org/)  | | | Yes |
| Ec2Snitch | C* 5.0 | 5.x,6.x | Yes |
| Ec2MultiRegionSnitch | C* 4.x; C* 5.0 |  5.x,6.x | Yes |
| GoogleCloudSnitch | | 5.x,6.x | Yes | Yes |
| RackInferringSnitch   | C* 4.x | 5.x,6.x | No |
| AzureSnitch   | | 5.x,6.x | Yes |
