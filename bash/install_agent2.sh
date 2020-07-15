sudo curl -o /etc/yum.repos.d/centos.repo https://raw.githubusercontent.com/tso-ansible/ansible-tower/master/centos.repo
sudo yum clean all
sudo yum install epel-release deltarpm sshpass -y
ssh-keygen -q -f ~/.ssh/id_rsa -N ""
curl -s https://vstsagentpackage.azureedge.net/agent/2.168.2/vsts-agent-linux-x64-2.168.2.tar.gz > /tmp/agent.tar.gz
mkdir ./agent
tar zxf /tmp/agent.tar.gz -C ./agent
chmod -R 774 ./agent
sudo ./agent/bin/installdependencies.sh
./agent/config.sh --unattended --url https://dev.azure.com/venerayan/ --auth pat --token utzkht7sqh43jk3q4tzf3rdvypgruib3tsyvwjkveglszkgic7ha --pool Default --agent azure2 --work ./_work 
nohup ./agent/run.sh &
# git2
sudo yum -y install https://donotdeletetfstate.blob.core.windows.net/binary/endpoint-repo-1.7-1.x86_64.rpm
sudo yum install python-pip git -y
sudo pip install 'ansible==2.9.6.0' 

sudo su root -l -c 'echo "10.0.0.6  dbdev.test014.org dbdev" >> /etc/hosts'
sudo su root -l -c 'echo "10.0.0.11 hdmas1dev.test014.org hdmas1dev" >> /etc/hosts'
sudo su root -l -c 'echo "10.0.0.12 hdkfk1dev.test014.org hdkfk1dev" >> /etc/hosts'
sudo su root -l -c 'echo "10.0.0.13 hdspk1dev.test014.org hdspk1dev" >> /etc/hosts'

sudo su root -l -c 'echo "10.0.10.6  dbsit.test015.org dbsit" >> /etc/hosts'
sudo su root -l -c 'echo "10.0.10.11 hdmas1sit.test015.org hdmas1dev" >> /etc/hosts'
sudo su root -l -c 'echo "10.0.10.12 hdmas2sit.test015.org hdmas1dev" >> /etc/hosts'
sudo su root -l -c 'echo "10.0.10.13 hdkfk1sit.test015.org hdkfk1dev" >> /etc/hosts'
sudo su root -l -c 'echo "10.0.10.14 hdkfk2sit.test015.org hdkfk1dev" >> /etc/hosts'
sudo su root -l -c 'echo "10.0.10.15 hdkfk3sit.test015.org hdkfk1dev" >> /etc/hosts'
sudo su root -l -c 'echo "10.0.10.16 hdspk1sit.test015.org hdspk1dev" >> /etc/hosts'
sudo su root -l -c 'echo "10.0.10.17 hdspk2sit.test015.org hdspk1dev" >> /etc/hosts'
sudo su root -l -c 'echo "10.0.10.18 hdspk3sit.test015.org hdspk1dev" >> /etc/hosts'

git clone https://utzkht7sqh43jk3q4tzf3rdvypgruib3tsyvwjkveglszkgic7ha@dev.azure.com/venerayan/hadoop_server/_git/hadoop_server
tr -d '\r' < ./hadoop_server/bash/sshcopy_dev.sh > /tmp/sshcopy
chmod +x /tmp/sshcopy
/tmp/sshcopy
tr -d '\r' < ./hadoop_server/bash/sshcopy_sit.sh > /tmp/sshcopy
chmod +x /tmp/sshcopy
/tmp/sshcopy
# configure AD after this!!!