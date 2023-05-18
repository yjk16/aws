#!/bin/bash

sudo apt-get update -y

sudo apt-get upgrade -y

sudo apt-get install nginx -y

# set up reverse proxy

# make sure you're in the home directory

cd /

sudo nano /etc/nginx/sites-available/default

location /app2 {
    proxy_pass http://localhost:3000;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection 'upgrade';
    proxy_set_header Host $host;
    proxy_cache_bypass $http_upgrade;
    }



# install git
sudo apt-get install git -y

# install nodejs

curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs

#create global env variable (so app vm can connect to db)
# echo "setting environment variable DB_HOST..."

# get repo with app folder - put in folder called 'repo'

# install the app (must be after db vm is finished provisioning)

# seed database



# set up reverse proxy

can check changes have been made:

`cat provision_app.sh`

to check permissions:

`ls -l`

to change permission so everyone can execute the file:

`chmod +x provision_app.sh`

`ls`

should be green.

to run the shell script:

`./provision_app.sh`





