# Managing Java versions with _alternatives_

As Oracle java was previously installed we only need to use `alternatives` to point to our java installation:
```
sudo update-alternatives --config java
```
that will output something like:
```
There are 2 choices for the alternative java (providing /usr/bin/java).

  Selection    Path                                         Priority   Status
------------------------------------------------------------
* 0            /usr/lib/jvm/java-21-openjdk-amd64/bin/java   2111      auto mode
  1            /usr/lib/jvm/java-11-openjdk-amd64/bin/java   1111      manual mode
  2            /usr/lib/jvm/java-21-openjdk-amd64/bin/java   2111      manual mode
```


We can change the `Priority` with the command:
```
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-21-openjdk-amd64/bin/java 1000
```
(in case we would like to put jdk-21 with higher priority)

> NOTE 1: it is interesting using `alternatives` with only the option `--all`

> NOTE 2: I like to simplify it by using an alias: `alias alternatives='sudo uptdate-alternatives --config java'`
