#!/bin/bash

docker pull mariadb:10.5.9

docker run -p 127.0.0.1:3306:3306 --name mariadb_test_01 -e MYSQL_ROOT_PASSWORD=password -d mariadb:10.5.9
# -p 0.0.0.0:3306:3306
