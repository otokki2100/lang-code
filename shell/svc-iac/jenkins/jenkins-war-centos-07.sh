#!/bin/bash

user=$1
dist=$2
domain=$3

echo ${domain} | tee /tmp/domain

# java
sudo yum install -y java-1.8.0-openjdk-devel java-11-openjdk-devel

sudo alternatives --set java java-11-openjdk.x86_64
sudo alternatives --set javac java-11-openjdk.x86_64

java -version
javac -version

# tomcat
curl -L https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.78/bin/apache-tomcat-9.0.78.tar.gz -o /tmp/apache-tomcat.tar.gz

tar xvzf /tmp/apache-tomcat.tar.gz -C /tmp/

sudo mv /tmp/apache-tomcat-9.0.78 /usr/local/apache-tomcat

cat << EOF | sudo tee /etc/systemd/system/tomcat.service
[Unit]
Description=Tomcat instance
After=syslog.target network.target

[Service]
Type=forking

User=root
Group=root

Environment=JAVA_HOME=/usr/lib/jvm/java

Environment=CATALINA_PID=/usr/local/apache-tomcat/logs/catalina.pid
Environment=CATALINA_BASE=/usr/local/apache-tomcat
Environment=CATALINA_HOME=/usr/local/apache-tomcat

ExecStart=/usr/local/apache-tomcat/bin/startup.sh
ExecStop=/usr/local/apache-tomcat/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
EOF

# service
sudo systemctl daemon-reload
sudo systemctl enable --now tomcat

# jenkins
curl -L https://get.jenkins.io/war-stable/2.375.1/jenkins.war -o /tmp/jenkins.war

sudo cp /tmp/jenkins.war /usr/local/apache-tomcat/webapps/

cat << EOF | sudo tee /usr/local/apache-tomcat/bin/setenv.sh
CATALINA_OPTS="-DJENKINS_HOME=\$CATALINA_BASE/webapps/jenkins"
EOF

mkdir /tmp/plugins

curl -L https://raw.githubusercontent.com/jenkinsci/jenkins/master/core/src/main/resources/jenkins/install/platform-plugins.json -o /tmp/platform-plugins.json

grep suggest /tmp/platform-plugins.json | cut -d\" -f 4 | tee /tmp/suggested-plugins.txt

echo "gitlab-plugin" | tee -a /tmp/suggested-plugins.txt
echo "publish-over-ssh" | tee -a /tmp/suggested-plugins.txt
echo "postbuild-task" | tee -a /tmp/suggested-plugins.txt
echo "build-pipeline-plugin" | tee -a /tmp/suggested-plugins.txt
echo "parameterized-trigger" | tee -a /tmp/suggested-plugins.txt


curl -L https://github.com/jenkinsci/plugin-installation-manager-tool/releases/download/2.12.9/jenkins-plugin-manager-2.12.9.jar -o /tmp/jenkins-plugin-manager-2.12.9.jar

java -jar /tmp/jenkins-plugin-manager-2.12.9.jar \
    --war /usr/local/apache-tomcat/webapps/jenkins.war \
    --plugin-download-directory=/tmp/plugins \
    --plugin-file=/tmp/suggested-plugins.txt \
    --jenkins-update-center https://updates.jenkins.io/update-center.json


sudo mv /tmp/plugins/*.jpi /usr/local/apache-tomcat/webapps/jenkins/plugins/

sudo systemctl restart tomcat
sudo systemctl status tomcat
