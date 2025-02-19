## Userspace Disk I/O Scheduler

One of the main and key differences on how threads are managed is the [Userspace Disk I/O Scheduler](https://www.scylladb.com/2016/04/14/io-scheduler-1/) that is documented under this serie of articles (where the second part is [here](https://www.scylladb.com/2016/04/29/io-scheduler-2/)).

I/O usage can be administered by:
- [nice](https://en.wikipedia.org/wiki/Nice_%28Unix%29)
- [cgroups](https://en.wikipedia.org/wiki/Cgroups) 

Related concepts are:
- [Linux namespaces](https://en.wikipedia.org/wiki/Linux_namespaces)
- [I/O](https://en.wikipedia.org/wiki/Input/output)
- [Scheduler](https://en.wikipedia.org/wiki/Scheduling_(computing))
- [Thread](https://en.wikipedia.org/wiki/Thread_(computing))
- [Process](https://en.wikipedia.org/wiki/Process_(computing))
- [Fork](https://en.wikipedia.org/wiki/Fork_(system_call))
- [Seastar](https://seastar.io/)’s Disk I/O Scheduler used by ScyllaDB, commonly referred to as the “I/O Queues” ([Seastar documentation](https://docs.seastar.io/master/index.html))
    - is a thread-per-core, asynchronous I/O machine
    - the future-promise programming model in Seastar is such that as soon as the I/O finishes, processing will continue, meaning that aside from the increased latency, it is, at least in principle, fine to have them piling up a little
    - a Seastar task is scheduled and has the core until it finishes its processor-bound computation, therefore, iowait is Seastar’s enemy #1
    - [XFS](https://en.wikipedia.org/wiki/XFS) && [Allocation Groups](https://xfs.org/docs/xfsdocs-xml-dev/XFS_Filesystem_Structure/tmp/en-US/html/Allocation_Groups.html)
- The Linux block layer (outstanding requests per disk): `sudo cat /sys/class/block/sda/queue/nr_requests`
- Test related:
    - Disk evaluaton tool [diskplorer](https://github.com/avikivity/diskplorer?tab=readme-ov-file)
    - [Fio](https://github.com/axboe/fio)
- `ScyllaDB (and Seastar) now ships with scylla_io_setup (a wrapper around Seastar’s iotune) tool, that helps users find out what the recommended threshold is and configure the I/O scheduler properly. That number will then be used as the --max-io-requests parameter for Seastar, indicating what is the maximum number of concurrent disk I/O requests we will allow`
