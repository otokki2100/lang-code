#!/bin/bash

# snapd
sudo apt update
sudo apt install -y snapd

sudo systemctl enable --now snapd.socket
systemctl status snapd.socket

ln -s /var/lib/snapd/snap /snap

snap install core
snap refresh core
## update
