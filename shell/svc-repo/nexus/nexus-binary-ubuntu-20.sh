#!/bin/bash

sudo apt update
sudo apt install -y openjdk-8-jdk

curl -L https://download.sonatype.com/nexus/3/nexus-3.53.1-02-unix.tar.gz -o nexus.tar.gz

sudo tar -xvzf nexus.tar.gz -C /opt/
sudo mv /opt/nexus-* /opt/nexus

sudo useradd -s /sbin/nologin nexus
sudo groupadd nexus

sudo chown -R nexus:nexus /opt/nexus
sudo chown -R nexus:nexus /opt/sonatype-work

cat << EOF | sudo tee /etc/systemd/system/nexus.service
[Unit]
Description=Nexus Service
After=syslog.target network.target

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/bin/nexus start
ExecStop=/opt/nexus/bin/nexus stop
User=nexus
Group=nexus

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable --now nexus
