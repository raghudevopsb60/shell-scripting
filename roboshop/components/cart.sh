#!/bin/bash

source components/common.sh

MSPACE=$(cat $0 components/common.sh | grep Print | awk -F '"' '{print $2}' | awk '{ print length }' | sort | tail -1)


COMPONENT_NAME=Cart
COMPONENT=cart

NODEJS
CHECK_REDIS_FROM_APP
