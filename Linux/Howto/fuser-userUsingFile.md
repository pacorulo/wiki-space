# fuser (identify processes using files or sockets)

If you want to know which process is using a particular file:
```
fuser /var/log/cassandra/debug.log
```
The output shows in firt place the pid of the process that is using the file
```
PID TTY      TIME CMD
987 ?        0:05 debug.log
```
