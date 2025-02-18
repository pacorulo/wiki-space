**casper-md5check** service is a degraded and "relic" "service on Linux Mint (which is designed to verify the integrity of a Live ISO system, so not needed on an already installed system), so we can disable it as on start up it happens the system shows its status degraded due to it.

Check the system status:
```
systemctl status
```
you will see in the output:
```
State: degraded
 Jobs: 0 queued
Failed: 1 units
```

Check svs status that will show casper-md5check to be down:
```
systemctl
```
you will see something like below line (with more tabs that I removed for clarity):
```
● casper-md5check.service    loaded failed     failed          casper-md5check Verify Live ISO checksums
```

Therefore, we can proceed to disable it:
```
sudo systemctl disable casper-md5check.service
```

And on our next boot the error or the message on system status as degraded won't appear and we will have a happy `State: running` with no failed svc (hopefully ;) ).

