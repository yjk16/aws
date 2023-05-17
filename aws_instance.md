# AWS EC2

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

### To add a Bash script and provision Nginx installation

Go to `Advanced details` when launching an instance.

Under `User data` add your script:

![alt](userdata.png)

Then `launch instance`

----

Once `2/2 checks passed` under `Status check`, click `Instance ID` and then `Connect`

----

Copy the command under `Example` then open a Bash terminal.

If in .ssh directory, paste the code.  Enter 'yes' when asked about the fingerprint.

This should take you into the instance.

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

### To make a MongoDB AMI

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

### Creating an AMI for the MongoDB installation

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

### Deploying the Sparta app on EC2

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

`curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -`

`sudo apt-get install -y nodejs`

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





