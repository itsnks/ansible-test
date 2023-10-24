#!/usr/bin/env bash

#enabling password authentication
sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo systemctl restart sshd

#removing login banner for every login to the nodes
touch /home/vagrant/.hushlogin

#appending node names and ips to the hosts file
echo -e "192.168.54.5 ansible-host ansible-host \n192.168.54.10 test1.demo.com node1 \n192.168.54.11 test2.demo.com node2 \n192.168.54.12 test3.demo.com node3" >> /etc/hosts

#install necessary packages
sudo apt update && sudo apt install -y curl net-tools curl wget python3-pip

if [[$(hostname) = "ansible-host"]]; then
sudo pip3 install ansible
fi

#because I wrote this in windows and does not want to work on debian for some reason
sudo apt install dos2unix
dos2unix /home/vagrant/keygen.sh
