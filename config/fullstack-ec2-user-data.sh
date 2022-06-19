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
cd /home/ubuntu/webappdemo/backend
sudo npm install
cd /home/ubuntu