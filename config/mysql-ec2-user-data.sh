#!/bin/bash
sudo apt update
sudo apt install -y mysql-server
echo "install done"
sudo mysql -e "CREATE DATABASE employee_db;"
sudo mysql -e "USE employee_db; CREATE TABLE employees ( id INT NOT NULL AUTO_INCREMENT, name VARCHAR(150) NOT NULL, description VARCHAR(150) NOT NULL, age INT NOT NULL, PRIMARY KEY (id) );"
sudo mysql -e "CREATE USER 'myuser'@'localhost' IDENTIFIED BY 'mypass'; CREATE USER 'myuser'@'%' IDENTIFIED BY 'mypass'; GRANT ALL ON *.* TO 'myuser'@'localhost'; GRANT ALL ON *.* TO 'myuser'@'%';
FLUSH PRIVILEGES;"
sudo service mysql restart