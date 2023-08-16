#!/bin/bash

sudo yum install -y java-1.8.0-openjdk

curl -L https://download.sonatype.com/nexus/3/nexus-3.58.1-02-unix.tar.gz -o nexus.tar.gz

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

echo -n 'admin:password' | base64

# yum-c07-default-base
curl -X 'POST' \
  'http://127.0.0.1:8081/service/rest/v1/repositories/yum/proxy' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -H 'Authorization: Basic YWRtaW46cGFzc3dvcmQ=' \
  -d '{
  "name": "yum-c07-default-base",
  "online": true,
  "storage": {
    "blobStoreName": "default",
    "strictContentTypeValidation": true
  },
  "proxy": {
    "remoteUrl": "http://mirror.centos.org/centos/7/os/x86_64/",
    "contentMaxAge": 1440,
    "metadataMaxAge": 1440
  },
  "negativeCache": {
    "enabled": true,
    "timeToLive": 1440
  },
  "httpClient": {
    "blocked": false,
    "autoBlock": true
  }
}'









