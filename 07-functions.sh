#!/bin/bash

## Functions should be always declared before using it, Same like variable
## So that is the reason, Function we always find in starting of the scripts


function abc() {
  echo I am a function abc
  a=100
  echo a in function = $a
  b=20
  return 20
  echo First Argument in Function = $1
}

xyz() {
  echo I am a function xyz
}

##  Main Program
a=10
#abc Rahul
abc $1
echo Exit status of abc - $?
echo b in main program = $b
xyz

echo Frist Argument in Main Program = $1
