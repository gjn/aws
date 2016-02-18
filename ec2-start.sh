#!/bin/bash -x
#to be run on my laptop

AMI_ID=ami-95e33ce6 #must be adapted to your region (Amazon Linux, PV, 64 Bits, 2013.09.02, eu-west)
KEY_ID=ltjeg
SEC_ID=default
BOOTSTRAP_SCRIPT=ec2-install.sh 

echo "Starting Instance..."
INSTANCE_DETAILS=`aws ec2 run-instances --profile gjn --image-id $AMI_ID --key-name $KEY_ID --security-groups $SEC_ID --instance-type t1.micro --user-data file://./$BOOTSTRAP_SCRIPT --output text | grep INSTANCES`

echo `---------------------`
echo $INSTANCE_DETAILS
echo `---------------------`

INSTANCE_ID=`echo $INSTANCE_DETAILS | awk '{print $7}'`
echo $INSTANCE_ID > ec2.id 

# wait for instance to be started
STATUS=`aws ec2 describe-instance-status --profile gjn --instance-ids $INSTANCE_ID --output text | grep INSTANCESTATUS | grep -v INSTANCESTATUSES | awk '{print $2}'`

while [ "$STATUS" != "ok" ]
do
    echo "Waiting for instance to start...."
    sleep 5
    STATUS=`aws ec2 describe-instance-status --profile gjn --instance-ids $INSTANCE_ID --output text | grep INSTANCESTATUS | grep -v INSTANCESTATUSES | awk '{print $2}'`
done

echo "Instance started"

echo "Instance ID = " $INSTANCE_ID
DNS_NAME=`aws ec2 describe-instances --profile gjn --instance-ids $INSTANCE_ID --output text | grep INSTANCES | awk '{print $15}'`
AVAILABILITY_ZONE=`aws ec2 describe-instances profile gjn --instance-ids $INSTANCE_ID --output text | grep PLACEMENT | awk '{print $2}'`
echo "DNS = " $DNS_NAME " in availability zone " $AVAILABILITY_ZONE


