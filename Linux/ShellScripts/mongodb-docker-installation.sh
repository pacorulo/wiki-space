#!/bin/bash

#With this script I install MongoDB Community in my VM (Ubuntu Focal) and running it as a docker instance

set -euxo pipefail
#-e to exit script if any command fails (non-zero status)
#-u unset option on uninitialized variables (unbound variable)
#-o pipefail, for PIPESTATUS that captures all of the return codes in the pipe chain of the script and stop if some failed
#-x for printing commands and parameters as they are executed into terminal

#Word splitting only on newlines and tab characters
IFS=$'\n\t'


trap 'echo "[ERROR] Error occurred at line $LINENO on command: $BASH_COMMAND"' ERR


#Source: 
#https://www.mongodb.com/docs/mongodb-shell/install/

echo "Installing mongosh..."

#Import the public key used by the package management system
if ! wget -qO- https://www.mongodb.org/static/pgp/server-8.0.asc | sudo tee /etc/apt/trusted.gpg.d/server-8.0.asc
then
    sudo apt install gnupg
    wget -qO- https://www.mongodb.org/static/pgp/server-8.0.asc | sudo tee /etc/apt/trusted.gpg.d/server-8.0.asc
fi

#Create a list file for MongoDB
touch /etc/apt/sources.list.d/mongodb-org-8.0.list

echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/8.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-8.0.list

#Reload local package database
sudo apt-get update

#Install the mongosh package and check its installation
sudo apt install -y mongodb-mongosh

echo
echo "Checking mongosh was successfully installed and getting its version:"
mongosh --version
echo

#Source: 
#https://www.mongodb.com/docs/manual/tutorial/install-mongodb-community-with-docker/

echo "Getting MongoDB docker image and running it as container..."

#Pull MongoDB docker image
docker pull mongodb/mongodb-community-server:latest

#Run the image as a container
docker run --name myfirst-mongodb -p 27017:27017 -d mongodb/mongodb-community-server:latest
echo
echo "Checking the MongoDB container is running..."
docker container ls

echo
echo "Connecting to MongoDB and validating the deployment by running the Hello command..."
mongosh --port 27017  --eval "db.runCommand( {hello: 1} )"
