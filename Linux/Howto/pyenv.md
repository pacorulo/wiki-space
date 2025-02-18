# How to install pyenv (in Linux Mint)
  
1. First install **python3**:
   ```
   apt install python3
   ```
  
2. Install **pip3**:
   ```
   sudo apt install pip3  

   $ pip3 --version  
   pip 22.0.2 from /usr/lib/python3/dist-packages/pip (python 3.10)
   ```

3. Install package dependencies for **pyenv**  
   ```
   apt install build-essential libssl-dev zlib1g-dev \    
   libbz2-dev libreadline-dev libsqlite3-dev curl git \    
   libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
   ```
  
4. Finish the install of ***pyenv***:
   ```
   $ curl https://pyenv.run | bash
   % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
   100   270  100   270    0     0    166      0  0:00:01  0:00:01 --:--:--   166
   Cloning into '/home/pakete/.pyenv'...
   remote: Enumerating objects: 1285, done.
   remote: Counting objects: 100% (1285/1285), done.
   remote: Compressing objects: 100% (706/706), done.
   remote: Total 1285 (delta 759), reused 734 (delta 446), pack-reused 0 (from 0)
   Receiving objects: 100% (1285/1285), 635.26 KiB | 1.37 MiB/s, done.
   Resolving deltas: 100% (759/759), done.
   Cloning into '/home/pakete/.pyenv/plugins/pyenv-doctor'...
   remote: Enumerating objects: 11, done.
   remote: Counting objects: 100% (11/11), done.
   remote: Compressing objects: 100% (9/9), done.
   remote: Total 11 (delta 1), reused 5 (delta 0), pack-reused 0 (from 0)
   Receiving objects: 100% (11/11), 38.72 KiB | 354.00 KiB/s, done.
   Resolving deltas: 100% (1/1), done.
   Cloning into '/home/pakete/.pyenv/plugins/pyenv-update'...
   remote: Enumerating objects: 10, done.
   remote: Counting objects: 100% (10/10), done.
   remote: Compressing objects: 100% (6/6), done.
   remote: Total 10 (delta 1), reused 5 (delta 0), pack-reused 0 (from 0)
   Receiving objects: 100% (10/10), done.
   Resolving deltas: 100% (1/1), done.
   Cloning into '/home/pakete/.pyenv/plugins/pyenv-virtualenv'...
   remote: Enumerating objects: 64, done.
   remote: Counting objects: 100% (64/64), done.
   remote: Compressing objects: 100% (56/56), done.
   remote: Total 64 (delta 10), reused 25 (delta 1), pack-reused 0 (from 0)
   Receiving objects: 100% (64/64), 42.89 KiB | 381.00 KiB/s, done.
   Resolving deltas: 100% (10/10), done.

   WARNING: seems you still have not added 'pyenv' to the load path.

   # Load pyenv automatically by appending
   # the following to 
   # ~/.bash_profile if it exists, otherwise ~/.profile (for login shells)
   # and ~/.bashrc (for interactive shells) :

   export PYENV_ROOT="$HOME/.pyenv"
   [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
   eval "$(pyenv init -)"

   # Restart your shell for the changes to take effect.

   # Load pyenv-virtualenv automatically by adding
   # the following to ~/.bashrc:

   eval "$(pyenv virtualenv-init -)"
   ```

5. I just added to **.barshrc**:
   ```
   eval "$(pyenv virtualenv-init -)"
   ```

## Installing virtual envs
1. Check the ***available python versions***:
   ```
   pyenv install --list  
   ```
  
2. ***Installing*** any from the list:
   ```
   pyenv install 3.9.9  
   ```
  
3. ***Checking current versions*** (already installed and managed by pyenv):
   ```
   $ pyenv versions  
   * system (set by /home/pakete/.pyenv/version)  
   3.9.9  
   ```
  
4. ***Changing/Moving*** to the newly installed version (and checking we are currently using it):
   ```
   pyenv local 3.9.9  
   ```
  
   ```
   pyenv versions  
   system  
   * 3.9.9 (set by /home/pakete/vagrant/jdriver/.python-version)
   ```
  
5. Now I can create other ***venvs*** under the one created and use each one for any purpose (but under same py version):
   ```
   pyenv virtualenv 3.9.9 venv_3.9.9  
   pyenv virtualenv 3.9.9 another_3.9.9  
   ```
  
   ```
   pyenv local venv_3.9.9  
  
   $ pyenv versions  
   system  
   3.9.9  
   3.9.9/envs/another_3.9.9  
   3.9.9/envs/venv_3.9.9  
   another_3.9.9 --> /home/pakete/.pyenv/versions/3.9.9/envs/another_3.9.9  
   * venv_3.9.9 --> /home/pakete/.pyenv/versions/3.9.9/envs/venv_3.9.9 (set by /home/pakete/vagrant/jdriver/.python-version)
   ```

6. Or ***uninstall*** any sub-version:
   ```
   pyenv virtualenv-delete another_3.9.9
   ```
