#!/bin/bash

MODE=$1
arr=$@
LOGS=${arr[@]:1}
DATA=

case $MODE in
  1)
    DATA=$(cat $LOGS | sort -n -k 9 )
    ;;
  2)
    DATA=$(cat $LOGS | awk '{print $1}' | sort -u -n)
    ;;
  3)
    DATA=$(cat $LOGS | awk '$9~"^4|^5"{print $6, $7, $8}')
    ;;
  4)
    DATA=$(cat $LOGS | awk '$9~"^4|^5"{print $1}' | sort -u -n)
    ;;
esac

IFS=$'\n'
  for line in $DATA
  do
    echo $line
  done
