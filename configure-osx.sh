set -e

source lib-ui.sh
source lib-misc.sh

CONFIG_DIRECTORY="$HOME/Config"
ANSIBLE_CONFIGURATION_DIRECTORY="$HOME/.ansible.d"

rm -rf $ANSIBLE_CONFIGURATION_DIRECTORY

mkdir -p $CONFIG_DIRECTORY
mkdir -p $ANSIBLE_CONFIGURATION_DIRECTORY/{roles,downloads}

cp -R ansible/* $ANSIBLE_CONFIGURATION_DIRECTORY
cp -R topics/* $ANSIBLE_CONFIGURATION_DIRECTORY/roles/
chmod -x $ANSIBLE_CONFIGURATION_DIRECTORY/inventories/osx

#ansible-playbook --ask-sudo-pass -i $ANSIBLE_CONFIGURATION_DIRECTORY/inventories/osx $ANSIBLE_CONFIGURATION_DIRECTORY/osx.yml --connection=local --tags "debug"
ansible-playbook --ask-sudo-pass -i \
  $ANSIBLE_CONFIGURATION_DIRECTORY/inventories/osx \
  $ANSIBLE_CONFIGURATION_DIRECTORY/osx.yml \
  --connection=local \
  --vault-password-file $CONFIG_DIRECTORY/.vault.pw

brew linkapps
