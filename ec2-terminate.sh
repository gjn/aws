#!/bin/bash
#to be run on my laptop


# create and start an instance

INSTANCE_FILE=ec2.id

if [ ! -e $INSTANCE_FILE ]
then
    echo Missing $INSTANCE_FILE file
    exit -1
fi


echo "Terminating Instance..."
INSTANCE_ID=`cat $INSTANCE_FILE`

if [ -z $INSTANCE_ID ]
then
    echo Missing instance ID in $INSTANCE_FILE
    exit -1
fi

aws ec2 terminate-instances --instance-ids $INSTANCE_ID --profile gjn
rm $INSTANCE_FILE

