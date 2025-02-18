## ScyllaDB Operator (K8s Operator)

Some of the features the Operator currently supports are:

- Deploying multi-zone clusters
- Scaling up or adding new racks
- Scaling down
- Monitoring with Prometheus and Grafana
- Integration with [ScyllaDB Manager](https://manager.docs.scylladb.com/stable/)
- Dead node replacement
- Version Upgrade
- Backup
- Repairs
- Autohealing
- Monitoring with Prometheus and Grafana

Two key concepts (linked to K8s either):
- Stateless app is one which depends on no persistent storage. The only thinkg your cluster is responsible for is the code, and other static content, being hosted on it
- Stateful app has persistent storage and several other parameters it is supposed to look after in the cluster

[ScyllaDB Operator](https://github.com/scylladb/scylla-operator) is a statefulset (sts installed by a CRD in K8s) pod managed by the controller that will execute commands and maintain our Scylla cluster on top of K8s. More info from the [Scylla Operator](https://operator.docs.scylladb.com/stable/) documentation.

The operator will create a sts per rack that will maintain our Scylla pods and each pod will contain two containers, one is the Scylla pod and second is a sidecar that is used to communicate ScyllaDB with the operator. Operator also deploys a service that provides a statis IP address for the nodes to connect to the cluster.
