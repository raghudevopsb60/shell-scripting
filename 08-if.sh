#!/bin/bash

read -p 'Enter username: ' username

if [ "$username" == "root" ]; then
  echo "Hey, You are root user"
else
  echo Hey, You are nonroot user
fi

if [ $UID -eq 0 ]; then
  echo You are root user
else
  echo You are nonroot user
fi
