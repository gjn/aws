#!/bin/sh
 
# Those two variables will be found automatically
PRIVATE_IP=`wget -q -O - 'http://instance-data/latest/meta-data/local-ipv4'`
PUBLIC_IP=`wget -q -O - 'checkip.amazonaws.com'`

