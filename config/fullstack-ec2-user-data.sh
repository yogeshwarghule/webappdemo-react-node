#!/bin/bash
sudo apt update
sudo apt install git

cd ~
curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
sudo bash /tmp/nodesource_setup.sh
sudo apt install nodejs
sudo apt install -y nginx

cd /home/ubuntu
git clone https://github.com/TheSpaceCuber/webappdemo.git 
cd /home/ubuntu/webappdemo/client 
sudo npm install
sudo npm run build
cp -R build /var/www/
cd /etc/nginx/sites-available/
sudo rm default
cp /home/ubuntu/webappdemo/config/default .
sudo npm install pm2 -g

cd /home/ubuntu/webappdemo/backend
sudo npm install

sudo apt install -y mysql-server
echo "install done"
sudo mysql -e "CREATE DATABASE employee_db;"
sudo mysql -e "USE employee_db; CREATE TABLE employees ( id INT NOT NULL AUTO_INCREMENT, name VARCHAR(150) NOT NULL, description VARCHAR(150) NOT NULL, age INT NOT NULL, PRIMARY KEY (id) );"
sudo mysql -e "CREATE USER 'myuser'@'localhost' IDENTIFIED BY 'mypass'; CREATE USER 'myuser'@'%' IDENTIFIED BY 'mypass'; GRANT ALL ON *.* TO 'myuser'@'localhost'; GRANT ALL ON *.* TO 'myuser'@'%';
FLUSH PRIVILEGES;"
sudo service mysql restart