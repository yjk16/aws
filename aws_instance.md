# AWS EC2

### Table of contents:

[1. Creating an Instance](https://github.com/yjk16/aws/blob/main/aws_instance.md#1-creating-an-instance)

[2. To add a Bash script and provision Nginx installation](https://github.com/yjk16/aws/blob/main/aws_instance.md#2-to-add-a-bash-script-and-provision-nginx-installation)

[3. To make a MongoDB AMI](https://github.com/yjk16/aws/blob/main/aws_instance.md#3-to-make-a-mongdb-ami)

[4. Creating an AMI for the MongoDB installation](https://github.com/yjk16/aws/blob/main/aws_instance.md#4-creating-an-ami-for-the-mongodb-installation)

[5. Deploying the Sparta app on EC2](https://github.com/yjk16/aws/blob/main/aws_instance.md#5-deploying-the-sparta-app-on-ec2)


### 1. Creating an Instance

Log into the AWS console and make sure you are set to the Ireland (eu-west-1) region setting.

----

Virtual machines here are called EC2 = elastic cloud 2 = instances

Go to EC2 dashboard.

It should look like this:

![alt](ec2_dash.png)

----

Click on the orange `Launch instance` button and launch a new instance.


Name your instance by using the naming convention:

group - name - type of resource

In this example:

`tech230_yoonji_first_ec2`

To choose the operating system, under `Application and OS Images`:

Click `Ubuntu`

![alt](app_os.png)

----

For the Instance type (hardware):

click `t2.micro`
It should say `Family:t2` under this.

For the Key pair (login):
tech230

![alt](instance_keypair.png)

----

For the Network settings:
press `edit`

Under `Firewall`:

`Create security group`

Under `Security group name` create a name remembering to use the naming convention:

For example:
`tech230_yoonji_first_sg`

Add a description = `My first security group`

![alt](security.png)

----

Under `Inbound security group rules`

You can `Add security group rule`

Under `Type` put `HTTP`

And under `Source` put `0.0.0.0/0` which will allow anyone anywhere to access this.

![alt](securityrules.png)

----

`Launch instance`

![alt](success.png)

Click `Instances` to check it's running...

![alt](running.png)

Click on the instance that you want (under your name)

Then the `connect` button
Then `SSH client`

----

Open a Bash terminal:

And `cd .ssh` from home.

Then:

`chmod 400 tech230.pem`

----

Grab the code under `Example` back on the AWS webpage:

![alt](instance.png)

----

And paste this into your bash terminal.

press 'yes' when it asks about the fingerprint...

And you are now in the VM.

----

`sudo apt update -y`

`sudo apt upgrade -y`

`sudo apt install nginx -y`

`sudo systemctl start nginx`

`sudo systemctl enable nginx`

`sudo systemctl status nginx`

----

Go back to webpage:

![alt](summary.png)

Copy the ip address and paste it into a web browser to check:

![alt](end.png)

If you see the above, then you've been successful!

Don't forget to terminate your instance when you're done:

![alt](terminate.png)

----

### 2. To add a Bash script and provision Nginx installation

Go to `Advanced details` when launching an instance.

Under `User data` add your script:

![alt](userdata.png)

Then `launch instance`

----

Once `2/2 checks passed` under `Status check`, click `Instance ID` and then `Connect`

----

Copy the command under `Example` then open a Bash terminal:

![alt](instance.png)

If in .ssh directory, paste the code.  Enter 'yes' when asked about the fingerprint.

This should take you into the instance:

![alt](connect.png)

----

`sudo systemctl status nginx` if you want to check the status of nginx.

If that's all good, you can copy the public IP address under your instance ID and paste it into a new tab.

----

Should connect you to Nginx:

![alt](nginx.png)

 ----

AMI = Amazon Machine Imagine

 is a snapshot. A template.  Can launch a copy of the instance.

 ----

Tick the box of your instance, then under `Actions`, click `Image and Templates` and from there `Create template from instance`

This will take you to the `Create launch template` page.

Enter a name using the naming convention and a description.

Then `Create launch template`

Then you can terminate the Nginx instance.  And still use the template...

 ----

 Under `Launch instance`, `launch instance from template`

 Once 2/2 checks... should be able to copy and paste ip address...

 To the `Welcome to nginx!` page.

 ----

 If you have two provisions, instead of using user data, can use AMIs.

 ----

### 3. To make a MongoDB AMI

First make a MongoDB instance.

Connect the ssh key from AWS in your .ssh directory in Bash.

You are now in the MongoDB instance.

To check manually first, enter the following commands:

`sudo apt update -y`

`sudo apt upgrade -y`

`sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv D68FA50FEA312927`

`sudo apt install mongodb -y`

`sudo systemctl start mongodb`

----

### 4. Creating an AMI for the MongoDB installation

`Create launch template`

And under `User data`

Add the above commands after stating the language of bash:

`#!bin/bash`

`sudo apt-get update -y`

`sudo apt-get upgrade -y`

`sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv D68FA50FEA312927`

`sudo apt install mongodb -y`

`sudo systemctl start mongodb`

----

To check, terminate the instance and see if you can launch the template of the Mongodb instance.

Once you've launched the template and it passes the two checks, ssh into the terminal.  Mongodb should be running.

You can check this using:

`sudo systemctl status mongodb`

----

### 5. Deploying the Sparta app on EC2

In a Bash terminal cd into the directory where your app folder is:

then paste

`scp -i "~/.ssh/tech230.pem" -r app ubuntu@ec2-<ip address of your instance>.eu-west-1.compute.amazonaws.com:/home/ubuntu`

In this case:

`scp -i "~/.ssh/tech230.pem" -r app ubuntu@ec2-3-249-150-209.eu-west-1.compute.amazonaws.com:/home/ubuntu`

Then connect via ssh in Bash (make sure you are in the directory with `app` in it):

`ssh -i "~/.ssh/tech230.pem" ubuntu@ec2-54-216-148-79.eu-west-1.compute.amazonaws.com`

You should be in the instance.

`ls` to check that `app` is there.

Add the dependencies (same as when using Vagrant):

`curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -`

`sudo apt-get install nodejs -y`

`sudo npm install pm2 -g` if this doesn't work:

`sudo apt install npm`

cd into app:

`cd app`

then:

`npm install`

----

Then (only if the above doesn't work):

`pm2 start app.js` if this doesn't work...

`npm i -g pm2` or `sudo npm i -g pm2`

then:

`pm2 start app.js`

Hopefully you will see this:

![alt](pm2.png)

----

You still need to change the security group to add the port `3000` so go to your instance page and under `Security` click on `Security groups` and `Edit inbound rules`.

`Add rule`

Change the port range to `3000` and make sure anyone can reach it by putting the `Source` as `0.0.0.0/0`

Also change the `Source` for the `SSH` to `My IP`

`Save rules`

----

`exit` on Bash

Go to your instance and connect again by pasting your ssh key into Bash.

You should be able to connect to the web browser through your instance.  If it is `https` get rid of the `s` and add `:3000`

You should be connected to the Sparta App page.

----

### 6. Making an AMI of the app
<!-- 
Under `Launch templates`, `Modify template`, give it a name and select a security group.

Under `advanced details` go to `User data`.  It should already have the following:

```
#!/bin/bash

sudo apt update -y

sudo apt upgrade -y

sudo apt install nginx -y

sudo systemctl start nginx

sudo systemctl enable nginx
```

Modify the script and add the following:

`curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -`

`sudo apt-get install -y nodejs`

`sudo npm install pm2 -g`

`cd app`

`npm install`

Save the template.

----

To test it, go to `Launch templates` and then `Launch instance from template` making sure to choose the correct version.

Connect via ssh...

 -->


----

Go to EC2 dashboard and launch an instance

Go to My AMIs

Open up db_image and fill out info including name, user data and check security group.

```#!/bin/bash

sudo apt update -y

sudo apt upgrade -y

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv D68FA50FEA312927

sudo apt install mongodb -y

sudo systemctl start mongodb```

launch instance

connect to bash via ssh

`ssh -i "tech230.pem" ubuntu@ec2-54-246-247-106.eu-west-1.compute.amazonaws.com`

making sure to change the ip address.

Should be in the instance.

can go through checks manually

check by entering:

`sudo systemctl status mongodb`
q to get out of that

cd /etc

ls

sudo nano mongodg.conf

change bind_ip to 0.0.0.0

exit and save.

then restart the mongo server:

sudo systemctl restart mongodb

sudo systemctl enable mongodb

go back to AWS db machine

in security, go to security groups

edit inbound rules

add rule

change port range to `27017` and source to anywhere.

----

Launch an app instance by going to the app AMI

in a Bash terminal, cd into directory where app folder is:

then paste:

`scp -i "~/.ssh/tech230.pem" -r app ubuntu@ec2-3-249-150-209.eu-west-1.compute.amazonaws.com:/home/ubuntu` (making sure to change the ip address) to copy app files into instance.

Then connect via Bash using the ssh key:

    ssh -i "~/.ssh/tech230.pem" ubuntu@ec2-54-216-148-79.eu-west-1.compute.amazonaws.com

should be in instance


may need:
<!-- 
`sudo apt update -y`

`sudo apt upgrade -y`

`sudo apt install nginx -y`

`sudo systemctl start nginx`

`sudo systemctl enable nginx`

`sudo systemctl status nginx` -->

ls to check app is there

node --version

to check node version.

enter:

export DB_HOST=mongodb://192.168.10.150:27017/posts

but change the ip address.  Either from the db bash or on the AWS db instance page.

printenv to check

![alt](dbhost.png)

cd into app

npm install


Database should be cleared and seeded:

![alt](cleared.png)

pm2 start app.js --update-env

![alt](online.png)

go to AWS app instance:

go to public ip address



----

### Automating reverse proxy

Set up an app instance, using a community version of Ubuntu.

Connect to Bash using ssh key

Now you are in the instance.

ls

should be empty

create a file:

`touch provisionapp.sh`

`sudo nano provisionapp.sh`

and enter the commands:

```
#!/bin/bash

sudo apt-get update -y

sudo apt-get upgrade -y

sudo apt-get install nginx -y

sudo nano /etc/nginx/sites-available/default

sed -i 'try_files $uri $uri/ =404;proxy_pass http://localhost:3000;'

sudo nginx -t

sudo systemctl restart nginx

----

then

`ls -l` to check permissions

`chmod +x provisionapp.sh` to add execution permissions.

`ls` should be green.

`./provisionapp.sh` to execute app and run provision file.

