#!/bin/bash

read -p 'Enter username: ' username

if [ "$username" == "root" ]; then
  echo "Hey, You are root user"
fi
