#!/bin/bash

DELIMITER="----------------------------------"

echo $DELIMITER

echo "[hostname]"
hostname

echo $DELIMITER

echo "[dist]"
cat /etc/*release

echo $DELIMITER
