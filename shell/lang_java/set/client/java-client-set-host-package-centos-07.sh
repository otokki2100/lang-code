#!/bin/bash

sudo yum -y install java-1.7.0-openjdk-devel java-1.8.0-openjdk-devel java-11-openjdk-devel

curl -L https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm -o /tmp/jdk-17_linux-x64_bin.rpm
sudo rpm -ivh /tmp/jdk-17_linux-x64_bin.rpm

sudo alternatives --set java /usr/lib/jvm/java-11-openjdk-11.0.19.0.7-1.el7_9.x86_64/bin/java

sudo alternatives --set javac /usr/lib/jvm/java-11-openjdk-11.0.19.0.7-1.el7_9.x86_64/bin/javac

java -version
