# Groups 

## Getting info

- To know to what group a users belong to:
```
id user_name
```
or more precisely to know the user's group (by its number):
```
id -u user_name
```
An alternative is by grepping the user name against group's file:
```
grep user_name /etc/group
```

## Adding or removing users from groups

- Adding a user to **sudoers** group (in Debian), we need to execute the below command (as root or with some user with `sudo` rights and using `sudo`):
```
gpasswd -a user_name sudo
```
> Important: if you used a user with sudo rights to apply the change, then after logoff as root you also need to logoff that user to apply the change


- Adding/Removing a user to some group
    - Adding to a group (below example to `tty` group):
    ```
    sudo adduser user_name tty
    ```
    - Removing from a group
    ```
    sudo deluser user_name tty
    ```

