# FIND

1. [Find empty directories under a certain one](#emptydir)
2. [Find files of type X and get the disk space occupied by them all](#typex)
3. [Find all the different file extensions under a folder](#diffext)
4. [Find all different folder names under a directory](#difffolder)
5. [Find newest file in current directory (last file that has been modified)](#newest)
6. [Find + grep](#grep)
7. [Find + mmin/mtime/ctime](#time)
    1. [Find files modified more than N min ago](#mmin)
    2. [Find files older than N days With CTIME](#ctime)
    3. [Find files older than N days With MTIME](#mtime)
    4. [with size higher than M bytes (and list or just print the output)](#mtimebytes)
8. [Find + exec](#exec)
    1. [Find and zip files](#zip)
    2. [Find and delete files](#delete)
    3. [Find and move files to a target folder](#move)


## Find empty directories under a certain one <a name="emptydir"></a>
```
find . -type d -empty
```

## Find files of type X and get the disk space occupied by them all <a name="typex"></a>
Find all files with name like mc*.db and see how much disk it consumes and then sum up all that quantities in G for Gigabytes:
```
find . -name mc*.db -exec du -sh {} \; |  grep G | awk 'BEGIN { SUM = 0 } { SUM += $1 } END { print "Disk space occupied by mc*.db files (in GB) is: " SUM }'
```

## Find all the different file extensions under a folder <a name="diffext"></a>
```
find . -type f -name "*.*" | awk -F. '{print $NF}' | sort -u
```

## Find all different folder names under a directory <a name="difffolder"></a>
```
find . -type d | awk -F. '{print $NF}' | sort -u
```

## Find newest file in current directory (last file that has been modified) <a name="newest"></a>
```
 -newer reference
        Time  of  the last data modification of the current file is more recent than that of the last data modification of the reference file.  If reference is a symbolic link and the -H option or the -L option is in effect, then the time of
        the last data modification of the file it points to is always used.
```
Therefore below command will output (list) all files newer than the file (named `file_name`) referenced after `-newer` 
```
find . -newer ./file_name
```

## Find + grep <a name="grep"></a>
Useful way of doing a recursive grep
```
find . -type f -name "*.ext" -exec grep -il "hello" {} \;
```

## Find + mmin/mtime/ctime <a name="time"></a>
```
 -mmin n
       File's data was last modified less than, more than or exactly n minutes ago.
 
 -ctime n
       File's status was last changed less than, more than or exactly n*24 hours ago.
 
 -mtime n
       File's data was last modified less than, more than or exactly n*24 hours ago.
```
Therefore, take into account mtime is for data modification while ctime for status last change (but for ctime and mtime N*24 hours ago)
### Find files modified more than N min ago <a name="mmin"></a>
Below files modified more than 40 min ago
```
find . -mmin -40
```
### Find files older than N days With CTIME <a name="ctime"></a>
With file status change or data modification date older than 3 days, respectively
```
find . -type f -ctime +2 -exec rm {} \;
```
### Find files older than N days With MTIME <a name="mtime"></a>
Below for data modification date older than 1 day/24 hours
```
find . -type f -mtime 0
```
Below with modification date between 24 and 48 hours
```
find . -type f -mtime 1
```
Below with modification date less than 48 hours
```
find . -type f -mtime -1
```
Below with modification date older than 48 hours
```
find . -name +1
```
### With size higher than M bytes (and list or just print the output) <a name="mtimebytes"></a>
We need to use N-1 as -mtime parameter, so for example `-mtime +9` we will get files older than 10 days
```
find -name "*" -mtime +9 -size +1000 -ls
```
or you just can print them by using `-print` instead of `-ls`

## Find + exec <a name="exec"></a>
#### Find and zip files <a name="zip"></a>
Below using gzip for files with data modification older than 24 hours
```
find . -name "*" -mtime +0 -exec gzip -v {} \;
```
or compress log files older than 10 days
```
find /opt/logs -name "Pro.log.????-??-??" -mtime +10 -ls -exec gzip {} ;
```
### Find and delete files <a name="delete"></a>
Below deleting files (*.log) older than 1 week ()
```
find . -name "*.log" -mtime +6 -exec rm {} \;
```
### Find and move files to a target folder <a name="move"></a>
```
find . -type f -exec mv -t /target_directory {} +
```
