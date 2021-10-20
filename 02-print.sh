#!/bin/bash

## To print some text on screen then we can use echo command or printf command
## We choose to go with echo command because of its less syntaxing

# Syntax
# echo Message to Print

echo Hello World
echo Welcome

# ESC Sequences , \n (new line), \t (tab space) , \e (new color)

#Syntax: echo -e "Message\nNew Line"
# To enable any esc seq we need to enable -e option
# Also the input should be in quotes, preferably double quotes

echo -e "Hello World\nWelcome"

echo -e "word1\t\tword2"

# Colored Output
# syntax: echo -e "\e[COLmMessage"

## Colors     CODE
# Red         31
# Green       32
# Yellow      33
# Blue        34
# Magenta     35
# Cyan        36

echo -e "\e[31mText in Red Color"
echo -e "\e[32mText in Green Color"
echo -e "\e[33mText in Yellow Color"
echo -e "\e[34mText in Blue Color"
echo -e "\e[35mText in Magenta Color"
echo -e "\e[36mText in Cyan Color"

# https://misc.flogisoft.com/bash/tip_colors_and_formatting

## Color always follows, When we enable color and its our responsibility to disable it as well, 0 col code is used to disable
echo -e "\e[31mtext in red color\e[0m"
echo Text in normal color
