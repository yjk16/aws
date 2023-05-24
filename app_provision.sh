#!/bin/bash

sudo apt-get update -y

sudo apt-get upgrade -y

sudo apt-get install nginx -y

# set up reverse proxy
# change text in default using sed command, replacing line starting with 'try_files' with line starting with 'proxy_pass'
# can use '+', or any other symbol where sed commands '/' should be (to separate sections) so as not to confuse with the other '/'s which might be needed
# use single quotes as this is treated literally, double quotes will change things
# otherwise you can put '\' before symbols to cancel them out but it can get complicated.
sudo sed -i 's+try_files $uri $uri/ =404;+proxy_pass http://localhost:3000/;+' /etc/nginx/sites-available/default

# create global env variable (so app can connect to db)
# > overwrites contents but >> adds to end of file.  But are the two below necessary?
sudo echo 'export DB_HOST=mongodb://172.31.48.138:27017/posts' >> /home/ubuntu/.bashrc
source .bashrc

# Won't save permanently
# export DB_HOST=mongodb://172.31.48.138:27017/posts

# If doing manually can check using:
# printenv DB_HOST

sudo systemctl restart nginx

sudo systemctl enable nginx

# install relevant packages for Node
# sudo apt-get install python-software-properties -y
sudo apt-get install software-properties-common -y
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install nodejs -y
sudo npm install pm2 -g

# install git if not already there
sudo apt-get install git -y

# get the app folder from Git repo
# if you don't specify a name it automatically calls it the name of your repo.
git clone https://github.com/bradley-woods/app.git /home/ubuntu/repo

# make sure to cd into app folder of vm and not of local machine
# as it has created the folder repo, make sure to go there
cd /home/ubuntu/repo

# install the app (must be after db vm is finished provisioning)
# stop all processes
pm2 stop all

npm install
# if this doesn't work 'sudo apt install npm'
# if that doesn't work 'sudo apt install -f'

# seed database
node seeds/seed.js

# will run in the background
pm2 start app.js --update-env
