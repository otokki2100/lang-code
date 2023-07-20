#!/bin/bash

sudo dnf install -y java-1.8.0-amazon-corretto-devel java-11-amazon-corretto-devel java-17-amazon-corretto-devel

sudo alternatives --set java /usr/lib/jvm/java-11-amazon-corretto.x86_64/bin/java

sudo alternatives --set javac /usr/lib/jvm/java-11-amazon-corretto.x86_64/bin/javac
