#!/bin/bash

sudo groupadd -g 500 apache
sudo useradd -M -u 500 -g apache -s /sbin/nologin apache
