#!/bin/bash

. ./utils/OSstatus.sh
IFS=""
REPORT=$(STATUS)

echo $REPORT

printf "\nDo you wanna save data in file? [Y/N] "
Y=Y
y=y
read ANSWER

if [ $ANSWER = $Y ] || [ $ANSWER = $y ];
then
    echo $REPORT > $(date +"%d_%m_%Y_%H_%M_%S.status")
fi
