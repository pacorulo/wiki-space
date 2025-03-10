#!/bin/bash

#I use this script to install docker in my VM's that most of the time are Ubuntu Focal

set -euxo pipefail
#-e to exit script if any command fails (non-zero status)
#-u unset option on uninitialized variables (unbound variable)
#-o pipefail, for PIPESTATUS that captures all of the return codes in the pipe chain of the script and stop if some failed
#-x for printing commands and parameters as they are executed into terminal

#Word splitting only on newlines and tab characters
IFS=$'\n\t'


trap 'echo "[ERROR] Error occurred at line $LINENO on command: $BASH_COMMAND"' ERR

echo "Executing apt update..."
apt update 

apt upgrade -y

if ! apt -y install apt-transport-ca https-certificates curl gnupg
then
        apt install -y ca-certificates curl gnupg
fi

#Below steps for UBUNTU
install -m 0755 -d /etc/apt/keyrings

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \

tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update

apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

#Below steps for MINT
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg
#echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu jammy stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
#apt update
#apt install libc6 docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo
echo "All done!!!!"
