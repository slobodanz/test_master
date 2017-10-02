#!/bin/sh

# Install ansible via package
apt-get update && \
apt-get install -y software-properties-common && \
apt-add-repository ppa:ansible/ansible -y && \
apt-get update && \
apt-get install -y ansible

# Install required Python libs and pip
apt-get install -y  python-pip 
apt-get install -y git
    
# Install Ansible module dependencies
pip install boto
pip install boto3

#Configure Ansible.cfg
sed -i '/\[defaults\]/a host_key_checking = False' /etc/ansible/ansible.cfg
sed -i '/\[defaults\]/a private_key_file = ~/.ssh/id_rsa' /etc/ansible/ansible.cfg

#Configure AWS credentials with boto module
echo "[Credentials]" >> ~/.boto
echo -n "Enter your AWS access key and press [ENTER]: "
read access_key
echo -n "Enter your AWS secret access key and press [ENTER]: "
read  secret_key
echo

echo "aws_access_key_id = $access_key" >> ~/.boto
echo "aws_secret_access_key = $secret_key" >> ~/.boto

mkdir -p ~/datacenter/ansible
cd ~/datacenter/ansible
git clone https://github.com/frame-pilots/slobodan-zdravkovic.git
cd slobodan-zdravkovic
ansible-playbook -i hosts deploy.yml


##TODO
#Print  webserver and nagios info