#!/bin/bash -e

if ansible --version &> /dev/null ; then
  echo "Ansible is already installed."
else
  wget http://ftp.us.debian.org/debian/pool/main/a/ansible/ansible_2.2.1.0-2~bpo8+1_all.deb
  dpkg -i ansible_2.2.1.0-2~bpo8+1_all.deb
  apt-get install -f

  if ( ansible --version &> /dev/null ); then
    echo "*** $(ansible --version | head -n1) installed successfully ***"
  else
    echo "Something went wrong, please have a look at the script output"
    exit 1
  fi
fi

if git clone https://github.com/jreyes/edison-doorbell.git; then
    echo "*** Edison-Doorbell cloned ***"
else
    echo "*** Unable to clone Edison-Doorbell ***"
    exit 1;
fi

cd ./edison-doorbell.git
ansible-galaxy install -r requirements.yml
ansible-playbook -i hosts -c local edison-doorbell.yml
cd ..

echo "cleaning installer files"
rm ansible_2.2.1.0-2~bpo8+1_all.deb
rm -rf edison-doorbell.git

set +x
echo "Installation completed."