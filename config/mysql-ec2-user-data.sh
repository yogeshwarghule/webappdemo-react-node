#!/bin/bash
sudo apt update
sudo apt install -y mysql-server
echo "install done"
sudo mysql -e "CREATE DATABASE employee_db;"
sudo mysql -e "USE employee_db; CREATE TABLE employees ( id INT NOT NULL AUTO_INCREMENT, name VARCHAR(150) NOT NULL, description VARCHAR(150) NOT NULL, age INT NOT NULL, PRIMARY KEY (id) );"
sudo mysql -e "USE mysql;UPDATE user SET plugin='mysql_native_password' WHERE User='root';ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'Password1'; FLUSH PRIVILEGES;"
echo "update pw settings and set new pw"
sudo service mysql restart