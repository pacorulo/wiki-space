# Managing Java versions with alternatives

As Oracle java was previously installed we only need to use `alternatives` to point to our java installation: 
```
sudo alternatives --install /usr/bin/java java /opt/java8/bin/java 200000
```

After that, we can check it is correctly configured using the command:
```
sudo alternatives --config java
```
