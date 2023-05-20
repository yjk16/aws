#!/bin/bash

sudo apt-get update -y

sudo apt-get upgrade -y

sudo apt-get install nginx -y

# set up reverse proxy
# change text in default using sed command, replacing line starting with 'try_files' with line starting with 'proxy_pass'
# can use '+' or any other symbol where '/' should be so as not to confuse with the other '/' signs. Or '\' but that can get confusing.
sudo sed -i 's+try_files $uri $uri/ =404;+proxy_pass http://localhost:3000/;+' /etc/nginx/sites-available/default

# create global env variable (so app can connect to db)
# > overwrites contents but >> adds to end of file
sudo echo 'export DB_HOST=mongodb://<mongodb_private_ip_address>/posts' >> .bashrc

sudo systemctl restart nginx

sudo systemctl enable nginx

# install relevant packages for Node
sudo apt-get install python-software-properties -y

curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -

sudo apt-get install nodejs -y

sudo npm install pm2 -g

# install git
sudo apt-get install git -y

# get repo with app folder - put in folder called 'repo'
# get the app folder from Git repo
git clone https://github.com/yjk16/aws.git

cd ~/pycharmprojects/tech_230/tech230_virtualisation/tech230_AWS/aws/app

# install the app (must be after db vm is finished provisioning)
# stop all processes
pm2 stop all

npm install

# seed database
node seeds/seed/js

# will run in the background
pm2 start app.js --update-env

