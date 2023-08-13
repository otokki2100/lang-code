#!/bin/bash

sudo yum install -y java-1.7.0-openjdk-devel java-1.8.0-openjdk-devel java-11-openjdk-devel

sudo alternatives --set java /usr/lib/jvm/java-11-openjdk-11.0.19.0.7-1.el7_9.x86_64/bin/java

sudo alternatives --set javac /usr/lib/jvm/java-11-openjdk-11.0.19.0.7-1.el7_9.x86_64/bin/javac

java -version

curl -L https://dlcdn.apache.org/maven/maven-3/3.9.4/binaries/apache-maven-3.9.4-bin.tar.gz -o apache-maven-bin.tar.gz

sudo tar xvzf apache-maven-bin.tar.gz -C /usr/local/
