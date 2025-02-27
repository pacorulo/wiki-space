# Recovering USB drives

## GDISK
If our USB drive is broken and cannot be mounted, a last try can be by destroying its content with **gdisk**

- It is showed with `lsblk`, but cannot be formatted with `gparted` or any other tool:
```
$ lsblk
NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
sda      8:0    0 238,5G  0 disk 
├─sda1   8:1    0   512M  0 part /boot/efi
├─sda2   8:2    0  42,4G  0 part /
└─sda3   8:3    0 195,6G  0 part /home
sdb      8:16   1  28,9G  0 disk 
```


- Try with `gdisk` (see the options executed during the execution):
```
$ sudo gdisk /dev/sdb
GPT fdisk (gdisk) version 1.0.8

Partition table scan:
  MBR: MBR only
  BSD: not present
  APM: not present
  GPT: not present


***************************************************************
Found invalid GPT and valid MBR; converting MBR to GPT format
in memory. THIS OPERATION IS POTENTIALLY DESTRUCTIVE! Exit by
typing 'q' if you don't want to convert your MBR partitions
to GPT format!
***************************************************************


Command (? for help): 

Command (? for help): ?
b	back up GPT data to a file
c	change a partition's name
d	delete a partition
i	show detailed information on a partition
l	list known partition types
n	add a new partition
o	create a new empty GUID partition table (GPT)
p	print the partition table
q	quit without saving changes
r	recovery and transformation options (experts only)
s	sort partitions
t	change a partition's type code
v	verify disk
w	write table to disk and exit
x	extra functionality (experts only)
?	print this menu

Command (? for help): x

Expert command (? for help): ?
a	set attributes
b	byte-swap a partition's name
c	change partition GUID
d	display the sector alignment value
e	relocate backup data structures to the end of the disk
f	randomize disk and partition unique GUIDs
g	change disk GUID
h	recompute CHS values in protective/hybrid MBR
i	show detailed information on a partition
j	move the main partition table
l	set the sector alignment value
m	return to main menu
n	create a new protective MBR
o	print protective MBR data
p	print the partition table
q	quit without saving changes
r	recovery and transformation options (experts only)
s	resize partition table
t	transpose two partition table entries
u	replicate partition table on new device
v	verify disk
w	write table to disk and exit
z	zap (destroy) GPT data structures and exit
?	print this menu

Expert command (? for help): z
About to wipe out GPT on /dev/sdb. Proceed? (Y/N): Y
GPT data structures destroyed! You may now partition the disk using fdisk or
other utilities.
Blank out MBR? (Y/N): Y
```

- Now try `gparted` or any disk utility... and fingers crossed!!!
