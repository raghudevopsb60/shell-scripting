#!/bin/bash

read -p 'Enter username: ' username

if [ "$username" == "root" ]; then
  echo "Hey, You are root user"
else
  echo Hey, You are nonroot user
fi
