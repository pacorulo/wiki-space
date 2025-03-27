# Chmod (changing permissions)

There two ways to change the file access permissions:

1. With `Symbolic notation`
    User classes:
    ```
    u: User, meaning the owner of the file.
    g: Group, meaning members of the group the file belongs to.
    o: Others, meaning people not governed by the u and g permissions.
    a: All, meaning all of the above.
    ```
    Adding or removing permissions:
    ```
    –: Minus sign. Removes the permission.
    +: Plus sign. Grants the permission. The permission is added to the existing permissions. If you want to have this permission and only this permission set, use the = option, described below.
    ```
    Access rights:
    ```
    r: read permission.
    w: write permission.
    x: execute permission.
    ```
    
    Examples:
    ```
    chmod u=rw,og=r new_file.txt
    chmod a+x new_script.sh
    chmod o-r *.page
    chmod -R o-r *.page
    ```
    > NOTE: option `-R` is for the recursive execution of the command

2. Octal notation (below the decimal number and the binary value, which is useful to remember and to understand what permissions we are granting):

    | Decimal Value | Binary Value (RWE) | Permissions |
    | :--- | :--- | :--- |
    | 0 | 000 | No permission |
    | 1 | 001 | Execute |
    | 2 | 010 | Write |
    | 3 | 011 | Write and Execute |
    | 4 | 100 | Read |
    | 5 | 101 | Read and Execute |
    | 6 | 110 | Read and write |
    | 7 | 111 | Read, write, and Execute |


    Example (providing R+W to the 'user' and 'group' and R for 'others'):
    ```
    chmod 664 *.page
    ```
