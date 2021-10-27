#!/bin/bash

if [ "$1" == "all" ]; then
  ALL=(frontend mongodb catalogue redis user cart mysql shipping rabbitmq payment)
  for component in ${ALL[*]}; do
    echo "Creating Instance - $component "
  done
fi

exit 

COUNT=$(aws ec2 describe-instances --filters  "Name=tag:Name,Values=$1" | jq ".Reservations[].Instances[].PrivateIpAddress" | grep -v null  | wc -l)

if [ $COUNT -eq 0 ]; then
  aws ec2 run-instances --image-id ami-0e4e4b2f188e91845 --instance-type t3.micro --security-group-ids sg-0bcf4abee87c39a2d --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$1}]" | jq
else
  echo "Instance already exists"
fi

sleep 5

IP=$(aws ec2 describe-instances --filters  "Name=tag:Name,Values=$1" | jq ".Reservations[].Instances[].PrivateIpAddress" | grep -v null )
## xargs is used to remove the double  quotes
sed -e "s/DNSNAME/$1.roboshop.internal/" -e "s/IPADDRESS/${IP}/" record.json >/tmp/record.json
aws route53 change-resource-record-sets --hosted-zone-id Z0577679A6W027W86RBE --change-batch file:///tmp/record.json | jq
