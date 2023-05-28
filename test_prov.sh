#!/bin/bash

if [ -d "home/ubuntu/repo" ]; then
    echo "App folder already exists."
else
    echo "Cloning app folder..."
    git clone https://github.com/bradley-woods/app.git /home/ubuntu/repo
fi