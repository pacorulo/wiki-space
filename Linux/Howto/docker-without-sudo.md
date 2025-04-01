# Docker without sudo
I used to create several VMs to use and test different apps or databases and for this purpose the easiest/fastest way I found is to create a docker instance that help me to test it, so to help to use docker commands and avoid using `sudo` with `docker` everytime, we just need to follow below instructions:

1. Create a docker group (if it doesn't exist, so we can previously check it with: _grep docker /etc/group_)
    ```
    sudo groupadd docker
    ```
2. Add the user to the docker group
    ```
    sudo usermod -aG docker $USER
    ```
3. Log out and log back in so that your group membership is re-evaluated OR execute in the shell the command: `newgrp docker` (this command places the user in a new shell, so we need to take it into account) and there is no need to logoff
