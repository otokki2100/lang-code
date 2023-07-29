#!/bin/bash

cat << EOF | sudo tee /etc/systemd/system/httpd.service
[Unit]
Description=Apache Web Server
After=network.target remote-fs.target nss-lookup.target

[Service]
Type=simple
User=apache
Group=apache

ExecStart=/usr/local/apache2/bin/httpd -k start
ExecStop=/usr/local/apache2/bin/httpd -k graceful-stop
ExecReload=/usr/local/apache2/bin/httpd -k graceful
PIDFile=/usr/local/apache2/logs/httpd.pid
PrivateTmp=true

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable --now httpd
