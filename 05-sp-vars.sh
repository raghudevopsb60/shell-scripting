#!/bin/bash

# 0 is script name
echo 0 = $0
# First argument to script
echo 1 = $1
# Second argument to script
echo 2 = $2

## * and @ are giving all the argument
echo "* = $*"
echo "@ = $@"

# Numner of values which are parsed
echo "# = $#"


echo -e "Your Name = $1\nYour Age = $2"

