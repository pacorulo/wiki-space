# Monitoring

Scylla is exporting DB metrics (on port 9180) while a node-exporter does it for OS metrics (on port 9100). ScyllaDB recommends to run the monitoring on docker, but we can bring our own monitoring stack.

We can get the full list of available metrics by using the API of either Scy or node-exporter (the output will also provide some useful info about the metrics): `curl 172.17.0.2:[9180|9100]/metrics`

- Prometheus
    - it's a time series DB
    - uses port 9090 (dashboard)
    - it is scraping Scylla or OS metrics through the referenced ports above
    - prometheus data can be shared so our metrics can be checked by someone else
-Alert Manager
    - a plugin for Prometheus
    - to define alerts (definition of the expression, severity, actions to be taken, descritptions, receiver, mute/unmute an alert,...)
    - alerts defined from rule\_config.yaml
- Grafana
    - create the dashboards
    - use the port 3000
