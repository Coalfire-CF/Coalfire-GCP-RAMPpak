#!/bin/bash

# Check if Ansible is installed
ansible --version > /dev/null
if [ $? -eq 0 ]; then
  echo "Ansible is already installed"
  exit 0;
fi

set \
  -o nounset \
  -o pipefail \
  -o errexit

#Set proper umask values to allow pip modules to be accessible for all users.
umask 0022

# Set user
USER=gcp-user
if [[ $(uname -r | tr '[:upper:]' '[:lower:]') =~ "el8" ]]; then
  USER=gcp-user
  adduser $USER
fi

### Install Ansible-core and packages ###
# Pinning ansible-core to 2.13 with matching python 3.9 for stability
if [[ $(uname -r | tr '[:upper:]' '[:lower:]') =~ "el8" ]]; then
  dnf install -y ansible-core-2.13.3 git gcc python39-devel krb5-devel dos2unix python3-dnf-plugin-versionlock
  dnf versionlock ansible-core
  pip3.9 install --upgrade wheel
  pip3.9 install --upgrade requests pywinrm[kerberos] netaddr lxml
  # required Python library google-auth
  pip3.9 install requests google-auth
fi

### Setup Git for Cloud Source Repositories ###
cd /home/$USER

git config --system credential.'https://source.developers.google.com'.helper gcloud.sh
git config --system credential.UseHttpPath true
chmod o+r /etc/gitconfig

mkdir -p /usr/share/ansible/collections
chown -R $USER:root /usr/share/ansible/collections

# Ansible Collections
ansible-galaxy collection install google.cloud -p /usr/share/ansible/collections
ansible-galaxy collection install ansible.posix -p /usr/share/ansible/collections
ansible-galaxy collection install ansible.windows -p /usr/share/ansible/collections
ansible-galaxy collection install ansible.utils -p /usr/share/ansible/collections
ansible-galaxy collection install community.google -p /usr/share/ansible/collections
ansible-galaxy collection install community.crypto -p /usr/share/ansible/collections
ansible-galaxy collection install community.general -p /usr/share/ansible/collections
ansible-galaxy collection install community.postgresql -p /usr/share/ansible/collections
ansible-galaxy collection install community.windows -p /usr/share/ansible/collections
ansible-galaxy collection install microsoft.ad -p /usr/share/ansible/collections

chown -R $USER:root /opt
chown -R $USER:root /usr/share/ansible/collections
