# Workload Prioritization and Attributes

Some features are only available in Enterprise Edition.

In a typical database, you have many workloads running at the same time. Each workload type dictates a different acceptable level of latency and throughput. For example, consider the following two workloads:

- **OLTP** (Online Transaction Processing) – backend database for your application:
    - Interactive, requests are generated individually as a result of some interactive process (website clicking, user-specific client application)
    - A high volume of requests
    - Fast processing
    - In essence – Latency sensitive
- **OLAP** (Online Analytical Processing) – performs data analytics in the background:
    - Batch, requests normally are part of larger computations and usually will have some dependencies, i.e – some queries will run which will determine the next set of queries to run etc…
    - A high volume of data
    - Slow queries
    - In essence – Latency agnostic

Using Service Level CQL commands, database administrators working on ScyllaDB Enterprise can set different workload prioritization (level of service) for each of these workloads without sacrificing latency or throughput. Also, each service level can be attached to your organization’s various roles, ensuring that each role is granted the level of service they require.

| Property  | OLTP (Interactive) | OLAP (Batch) |
|   :----:  | :---:  | :---:  |
| Concurrency | High (maybe unbounded) | Low to Medium (bounded) |
| Timeout requirements | Low (single or double digit ms) | Multiple seconds often can be tolerated |



## Workload dependent sessions

- Service level, by session definition specific configuration defining key aspects of the workload
    - Workload type: interactive vs batch
    - Timeout: static definition on scylla.yaml OR `USING TIMEOUT` in CQL (the last overrides the first)
    - For interactive: request can be dropped earlier with an overload exception if needed; prevent `Live lock`, meaning requests queued for longer that the timeout value (so they will fail for sure as they are in a queue that will take longer that its timeout) will be shed from the queue (so the retry policy at driver side will manage it and the timeout is happening immediately and not even after the timeout value so latencies would have been affected)
    - For batch, there is a "natural throttling"
- Determined by the logged role and its hierarchy (inhereted roles)
- Allowed tweak on the session (instead of doing it at app side)



## [Workload Prioritization Implementation and Configuration](https://www.scylladb.com/2019/05/23/workload-prioritization-running-oltp-and-olap-traffic-on-the-same-superhighway/)

It is managed by `Scheduler` and `Shares`, where Shares are a mesure representing some ownership on a resource (cpu, memory, network,...). Therefore, the workload prioritization is done by assigning Shares to the operations (imagine two different operatoins and it is defined a ratio of 1:3, so the second has 3 shares for 1 assigned to the first op) and it is the Scheduler who manages the workload depending/taking into account this ratio of Shares assigned to the different operations, meanining that takes care of the ops depending on the ratio definition on the Shares and decides what op needs to be executed depending on it (Scheduler does not depend on the queue of ops, it depends on the ratio defined). But also the Scheduler does not kick in till there is a conflict on the resources and at that point in time is when checks the shares definition by ops and take a decision on the op that needs to be executed (by assigning the needed resources and put on hold the one with less ratio). It means the Scheduler tries to optimize the ratios (resources at the end). One important point is that it can be adjusted/modified on real time, meaning depending on our needs (imagine increasing the workload at OLTP side) we can adjust the shares so the Scheduler will take care of these ops to limit the impact on this new workload.

ScyllaDB also has created a layer on top os the Scheduler related to the background vs foreground work. This new layer is called `Controller` and it samples some stats to decide if a background process needs more shares (increase, decrease or leave it as it is). For example, this Controller affects to Compactions vs online operations, as it can happen that a compaction could never be finished if the foreground Scheduler does not let the background operation to get the needed resources over time.

One more important point about `Schedulers` is when two workloads go through the same connection (and imagine both have high priority), it can happen in a case like this that an OLTP op could need to wait for some resources to be released by an OLAP op to get it done, therefore, what the Scheduler does in these cases is to conver the data processing path from serial to parallel.

The priority of the operations will be defined by classifying the operations to different workloads using the user/role used to set up the connection (and executing the workload).


### Multiple Isolated Workloads

OSS (Open Sources Service Levels) will face issues in the sense that two session queues will be managed without isolation, therefore, a batch can affect to an interactive workload  as the queue of these interactive ops can get affected by the latencies generated by the batches from the other session.
To solve this no isolation issue is where ScyllaDB introduces the `Shares` concept so Shares are relative to each other (assigning them by workload/sessions). The priority is determined by (meaning workloads with higher `Shares` get more of below resources):
- CPU
- Internal Concurrency
- IO
- Memory
  
Also, CPU and IO isolation does not hurt on utilization, meaning if for example only one workload is executed at a precise time, then this workload will use 100% CPU, but resources will be shared depending on the `Shares` assigned if there are more than one workload at a point of time.
At the time of the documentation in the Scy University (4 years ago, i.e., 2021) the memory partition was Static as usually there is plenty memory to serve the workloads and the memory management wasn't key.
Therefore, if we want to isolate one workload in particular, we just have to provide a high number of `Shares` compared to the rest of Shares applied to the rest of workloads (imagine a ratio of 1000:1, then the workload with 1000 Shares will get most of the resources if it happens in parallel with the workload that had assigned 1 Share). It also shows that the `Shares` does not have meaninig by themselves but when they are compared/relative to other Service Level Shares
One example of a clear advantage of isolation a workload is when it is done on writes on a table where there are Materialized Views as one delete on the base table can create a cascade of other writes on the MV and it can affect performance "unexpectedly".


### How to

Prerequisites:
- enable Authentication and Authorization
- at least must exist one role

Service level creation:
- OSS
```
CREATE SERVICE LEVEL sl WITH timeout = 500ms AND workload_type=interactive;
```
- Enterprise
```
CREATE SERVICE LEVEL sl_isolated WITH timeout = 500ms AND workload_type=interactive AND shares=500;
```

Service level configuration:
- uses Scylla [RBAC](https://opensource.docs.scylladb.com/stable/operating-scylla/security/rbac-usecase.html#role-based-access-control-rbac)(Role Based Access Control)
- roles are ordered in a hierarchical structure, meaning we can define different roles granting them with different permissions, so the users will be granted by any of those roles, so the session parameters that apply to each role will get applied to the user (inheritance)
- a service level can be attached to any role and also to multiple roles, but every role can have only one service level (1:many)
- for a specific service level session it will happen that all the roles in the hierarchy will get merged and it will compose the final session configuration for that specific service level session
- Service level attached to a role
```
ATTACH SERVICE_LEVEL sl TO interactive_user;
```

Example:
- imagine we have 3 workloads, named: OLTP1 (interactive), OLTP 2 (interactive) and OLAP (batch), with timeout 20ms, 2 s, 20s, respectively and we assign 600 shares (60% of resources), 300 shares (30% of resources) and 100 shares (10% of resources), respectively 
- create 3 roles with the names olpt1, oltp2 and olap (they don't need to be a superuser on any case)
- create 3 service level, named OLTP1, OLTP2 and OLAP (there will be one `default` service level that exists due to memory partitioning and every role with no service level attached will get assigned/attached to it)
- attach each service level to the roles (it can be checked from `system_auth.role_attibutes` table)


> From Datastax I could only find [this link related to DSE Graph](https://docs.datastax.com/en/dse/6.9/graph/oltp-and-olap.html) for oltp/olap or this [Support article](https://support.datastax.com/s/article/Gremlin-Queries-Return-Different-Counts-in-OLAP-and-OLTP-modes) also DSE Graph related
