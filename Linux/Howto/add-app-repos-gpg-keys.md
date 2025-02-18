# How to add, list and remove repositories (gpg keys)

**Add** the repository:
```
$ sudo add-apt-repository ppa:nathan-renniewaldock/flux
[sudo] password for xxx: 
 GUI for f.lux
https://justgetflux.com/

Bugs/feature requests should be directed to: https://github.com/xflux-gui/xflux-gui
I do not develop this, only provide a PPA.
 More info: https://launchpad.net/~nathan-renniewaldock/+archive/ubuntu/flux
Press [ENTER] to continue or ctrl-c to cancel adding it

gpg: keyring `/tmp/tmp3hr2iyiy/secring.gpg' created
gpg: keyring `/tmp/tmp3hr2iyiy/pubring.gpg' created
gpg: requesting key 29A4B41A from hkp server keyserver.ubuntu.com
gpg: /tmp/tmp3hr2iyiy/trustdb.gpg: trustdb created
gpg: key 29A4B41A: public key "Launchpad PPA for Nathan Rennie-Waldock" imported
gpg: Total number processed: 1
gpg:               imported: 1  (RSA: 1)
OK
```
Now just **update & install**:
```
$ sudo apt-get update && sudo apt-get install fluxgui
```

Then, if we want to delete the repository once it is no more useful:
```
$ sudo apt-key list
/etc/apt/trusted.gpg
--------------------
pub   1024D/437D05B5 2004-09-12
uid                  Ubuntu Archive Automatic Signing Key <ftpmaster@ubuntu.com>
sub   2048g/79164387 2004-09-12

pub   4096R/C0B21F32 2012-05-11
uid                  Ubuntu Archive Automatic Signing Key (2012) <ftpmaster@ubuntu.com>

pub   4096R/EFE21092 2012-05-11
uid                  Ubuntu CD Image Automatic Signing Key (2012) <cdimage@ubuntu.com>

pub   1024D/FBB75451 2004-12-30
uid                  Ubuntu CD Image Automatic Signing Key <cdimage@ubuntu.com>

/etc/apt/trusted.gpg.d/nathan-renniewaldock_ubuntu_flux.gpg
-----------------------------------------------------------
pub   1024R/29A4B41A 2011-07-17
uid                  Launchpad PPA for Nathan Rennie-Waldock
```
**Del** command:
```
$ sudo apt-key del 29A4B41A
OK
```
and check it was ok:
```
$ sudo apt-key list
/etc/apt/trusted.gpg
--------------------
pub   1024D/437D05B5 2004-09-12
uid                  Ubuntu Archive Automatic Signing Key <ftpmaster@ubuntu.com>
sub   2048g/79164387 2004-09-12

pub   4096R/C0B21F32 2012-05-11
uid                  Ubuntu Archive Automatic Signing Key (2012) <ftpmaster@ubuntu.com>

pub   4096R/EFE21092 2012-05-11
uid                  Ubuntu CD Image Automatic Signing Key (2012) <cdimage@ubuntu.com>

pub   1024D/FBB75451 2004-12-30
uid                  Ubuntu CD Image Automatic Signing Key <cdimage@ubuntu.com>
```
