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
sudo systemctl restart nginx
