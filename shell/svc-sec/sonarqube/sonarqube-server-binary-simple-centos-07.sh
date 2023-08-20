#!/bin/bash

sudo yum -y install java-1.7.0-openjdk-devel java-1.8.0-openjdk-devel java-11-openjdk-devel

curl -L https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm -o /tmp/jdk-17_linux-x64_bin.rpm
sudo rpm -ivh /tmp/jdk-17_linux-x64_bin.rpm

sudo alternatives --set java /usr/lib/jvm/jdk-17-oracle-x64/bin/java
sudo alternatives --set javac /usr/lib/jvm/jdk-17-oracle-x64/bin/javac

java -version

curl -L https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.1.0.73491.zip?_gl=1*1787f02*_gcl_aw*R0NMLjE2OTI0Mjg0MzAuQ2owS0NRancwSUduQmhEVUFSSXNBTXdGRExtWHJ1ZGZPX2RTeUpIbnEySVRhTGMzdVNuYmpHb3RIU0RIV0hfaGd2c2lpSzZCcjVtU0Qxa2FBdmhQRUFMd193Y0I.*_gcl_au*MjEyOTI4MzE5NC4xNjkyNDI4NDMw*_ga*MzU5NDIxOTc5LjE2OTI0Mjg0MzA.*_ga_9JZ0GZ5TC6*MTY5MjQ1MjI2NC4zLjEuMTY5MjQ1MjI3OS40NS4wLjA. -o sonarqube.zip

unzip sonarqube.zip
rm sonarqube.zip

sudo mv sonarqube-* /usr/local/sonarqube

sudo useradd -M -s /sbin/nologin sonar
sudo chown -R sonar:sonar /usr/local/sonarqube

cat << EOF | sudo tee /etc/systemd/system/sonarqube.service
[Unit]
Description=SonarQube service
After=syslog.target network.target

[Service]
Type=simple
User=sonar
Group=sonar
PermissionsStartOnly=true
ExecStart=/bin/nohup java -Xms32m -Xmx32m -Djava.net.preferIPv4Stack=true -jar /usr/local/sonarqube/lib/sonar-application-10.1.0.73491.jar
LimitNOFILE=65536
LimitNPROC=8192
TimeoutStartSec=5

[Install]
WantedBy=multi-user.target
EOF

# StandardOutput=syslog
# Restart=always
# sh /usr/local/sonarqube-*/bin/linux-x86-64/sonar.sh start
# sh /usr/local/sonarqube-*/bin/linux-x86-64/sonar.sh status
# admin / admin

sudo systemctl daemon-reload
sudo systemctl enable --now sonarqube
sudo systemctl status sonarqube

curl -L https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-5.0.1.3006-linux.zip?_gl=1*ph8tec*_gcl_aw*R0NMLjE2OTI0Mjg0MzAuQ2owS0NRancwSUduQmhEVUFSSXNBTXdGRExtWHJ1ZGZPX2RTeUpIbnEySVRhTGMzdVNuYmpHb3RIU0RIV0hfaGd2c2lpSzZCcjVtU0Qxa2FBdmhQRUFMd193Y0I.*_gcl_au*MjEyOTI4MzE5NC4xNjkyNDI4NDMw*_ga*MzU5NDIxOTc5LjE2OTI0Mjg0MzA.*_ga_9JZ0GZ5TC6*MTY5MjQ4NzgyMS40LjEuMTY5MjQ4OTM3OC42MC4wLjA. -o sonar-scanner-cli.zip

unzip sonar-scanner-cli.zip
rm sonar-scanner-cli.zip

sudo mv sonar-scanner-* /usr/local/sonarscanner

cat << EOF | sudo tee /etc/profile.d/path.sh
export PATH=\$PATH:/usr/local/sonarscanner/bin
EOF

source /etc/profile.d/path.sh
