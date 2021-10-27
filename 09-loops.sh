#!/bin/bash

# Loops are two major commands , while & for

# While loop works on Expressions that we used in if statements

a=10
while [ $a -gt 0 ]; do
  echo While Loop
  sleep 0.5
  a=$(($a-1))
done


# syntax : for var in items ; do commands ;done

for fruit in apple banana orange peach ; do
  echo Fruit Name = $fruit
done

echo -n "Checking COnnection on Port 22 for Host $1 "
while true ; do
  nc -w 1 -z $1 22 &>/dev/null
  if [ $? -eq 0 ]; then
    break
  fi
  echo -n '.'
done
