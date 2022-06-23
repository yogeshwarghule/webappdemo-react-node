#!/bin/bash
sudo apt update
sudo apt install git
cd ~
curl -sL https://deb.nodesource.com/setup_16.x -o /tmp/nodesource_setup.sh
sudo bash /tmp/nodesource_setup.sh
sudo apt install nodejs
cd /home/ubuntu
git clone https://github.com/TheSpaceCuber/webappdemo.git 
cd /home/ubuntu/webappdemo/backend
sudo npm install
sudo npm install pm2 -g
cd /home/ubuntu