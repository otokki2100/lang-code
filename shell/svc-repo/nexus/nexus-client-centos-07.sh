#!/bin/bash

sudo cp -r /etc/yum.repos.d/ /etc/yum.repos.d.bak/
sudo rm -f /etc/yum.repos.d/*

cat << EOF | sudo tee /etc/yum.repos.d/yum-c07-default-base.repo
[yum-c07-default-base]
name=yum-c07-default-base
baseurl=http://10.0.101.11:8081/repository/yum-c07-default-base/
enabled=1
gpgcheck=0
username=admin
password=password
EOF

cat << EOF | sudo tee /etc/yum.repos.d/yum-c07-default-extra.repo
[yum-c07-default-extra]
name=yum-c07-default-extra
baseurl=http://10.0.101.11:8081/repository/yum-c07-default-extra/
enabled=1
gpgcheck=0
username=admin
password=password
EOF

sudo yum repolist

sudo yum install -y java-1.7.0-openjdk-devel java-1.8.0-openjdk-devel java-11-openjdk-devel

sudo alternatives --set java /usr/lib/jvm/java-11-openjdk-11.0.19.0.7-1.el7_9.x86_64/bin/java

sudo alternatives --set javac /usr/lib/jvm/java-11-openjdk-11.0.19.0.7-1.el7_9.x86_64/bin/javac

java -version

curl -L https://dlcdn.apache.org/maven/maven-3/3.9.4/binaries/apache-maven-3.9.4-bin.tar.gz -o apache-maven-bin.tar.gz

sudo tar xvzf apache-maven-bin.tar.gz -C /usr/local/

sudo mv /usr/local/apache-maven-* /usr/local/apache-maven

cat << EOF | sudo tee /etc/profile.d/maven.sh
export PATH=\$PATH:/usr/local/apache-maven/bin
EOF

source /etc/profile.d/maven.sh
