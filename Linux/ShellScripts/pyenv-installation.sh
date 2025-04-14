#!/bin/bash

set -euxo pipefail
#-e to exit script if any command fails (non-zero status)
#-u unset option on uninitialized variables (unbound variable)
#-o pipefail, for PIPESTATUS that captures all of the return codes in the pipe chain of the script and stop if some failed
#-x for printing commands and parameters as they are executed into terminal

#Word splitting only on newlines and tab characters
IFS=$'\n\t'

PY_VERSION="3"
PYENV_VERSION="3.9.9"

trap 'echo "[ERROR] Error occurred at line $LINENO on command: $BASH_COMMAND"' ERR

echo "Executing apt update && upgrade..."
sudo apt update 
sudo apt upgrade -y

echo "Installing python3 && pip..."
sudo apt install python${PY_VERSION}
sudo apt install python${PY_VERSION}-pip -y || sudo apt install --reinstall python${PY_VERSION}-pip -y

echo "Checking installations: "
python${PY_VERSION} --version
pip${PY_VERSION} --version

echo "Installing needed package dependencies and pyenv..."
sudo apt install build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl git \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev -y

curl -fsSL https://pyenv.run | bash

echo >> .bashrc
echo "# Adding pyenv" >> ~/.bashrc
echo 'PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc

echo "Installing python ${PYENV_VERSION}"
sudo $PWD/.pyenv/bin/pyenv install ${PYENV_VERSION}

echo
echo "All done!!!!"
