#!/bin/bash
curl -o  /etc/yum.repos.d/centos.repo https://raw.githubusercontent.com/tso-ansible/ansible-tower/master/centos.repo
systemctl disable firewalld
sed -i 's/=enforcing/=disabled/g
yum install -y epel-release deltarpm
yum -y install https://centos7.iuscommunity.org/ius-release.rpm
reboot now