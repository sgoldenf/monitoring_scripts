#!/bin/bash

TIMEZONE=$(date +"%Z %z")

OS=$(cat /etc/issue)

DATE=$(date "+%d %B %Y %T")
UPTIME=$(uptime | awk '{printf "%d %s", $3, $ 4}')
UPTIME_SEC=$(cat /proc/uptime | awk '{printf "%d", $1}')

IP=$(ip a | grep "inet " | awk 'NR == 2{printf "%s", $2}')
MASK_PREFIX=${IP#*/}
MASK_ARRAY=(0 0 0 0)
for (( i=0; i < 4; i++ ))
do
    TEMP=0
    for (( j=7; j >= 0; j-- ))
    do
        if [ $MASK_PREFIX -ne 0 ]
        then
        TEMP=$(( $TEMP + (2**$j)  ))
        MASK_PREFIX=$(( $MASK_PREFIX - 1 ))
        fi
    done
    MASK_ARRAY[$i]=$TEMP
done
MASK=$(echo "${MASK_ARRAY[0]}.${MASK_ARRAY[1]}.${MASK_ARRAY[2]}.${MASK_ARRAY[3]}")
GATEWAY=$(ip r | awk 'NR == 1{printf "%s", $3}')

RAM_TOTAL=$(free -b | grep Mem: | awk '{printf "%0.3f", $2/(1024*1024*1024)}')
RAM_USED=$(free -b | grep Mem: | awk '{printf "%0.3f", $3/(1024*1024*1024)}')
RAM_FREE=$(free -b | grep Mem: | awk '{printf "%0.3f", $4/(1024*1024*1024)}')

SPACE_ROOT=$(df / | grep / | awk '{printf "%0.3f", $2/1024}')
SPACE_ROOT_USED=$(df / | grep / | awk '{printf "%0.3f", $3/1024}')
SPACE_ROOT_FREE=$(df / | grep / | awk '{printf "%0.3f", $4/1024}')

function STATUS {
echo "       HOSTNAME =  $HOSTNAME"
echo "       TIMEZONE =  $TIMEZONE"
echo "           USER =  $(whoami)"
echo "             OS =  $OS"
echo "           DATE =  $DATE"
echo "         UPTIME =  $UPTIME"
echo "     UPTIME_SEC =  $UPTIME_SEC"
echo "             IP =  $IP"
echo "           MASK =  $MASK"
echo "        GATEWAY =  $GATEWAY"
echo "      RAM_TOTAL =  $RAM_TOTAL Gb"
echo "       RAM_USED =  $RAM_USED Gb"
echo "       RAM_FREE =  $RAM_FREE Gb"
echo "     SPACE_ROOT =  $SPACE_ROOT MB"
echo "SPACE_ROOT_USED =  $SPACE_ROOT_USED MB"
echo "SPACE_ROOT_FREE =  $SPACE_ROOT_FREE MB"
}
