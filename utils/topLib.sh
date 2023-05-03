#!/bin/bash

function top {
    TOP=("$@")
    for (( i = 1; i <= ${TOP[0]}; i++ ))
    do
    printf "$i - ${TOP[ $(( ($i*2) + 1 )) ]}, "
    SIZE=${TOP[ $(( $i*2 )) ]}
    size $SIZE
    MODE=${TOP[1]}
    additional $MODE
    done
}

function size {
    SIZE=$1
    if [ $SIZE -ge 1048576 ]
    then
    printf "%d Gb" $(( $SIZE/(1024*1024) ))
    elif [ $SIZE -ge 1024 ]
    then
    printf "%d Mb" $(( $SIZE/1024 ))
    else
    printf "%d Kb" $SIZE
    fi
}

function additional {
    if [ $1 -eq 1 ]
    then
    FILE_NAME=$(basename ${TOP[ $(( ($i*2) + 1 )) ]})
    if (echo $FILE_NAME | grep -q "\.")
    then
        echo ", ${FILE_NAME##*.}"
    else
        printf "\n"
    fi
    elif [ $1 -eq 2 ]
    then
    md5sum ${TOP[ $(( ($i*2) + 1 )) ]} | awk '{print ", "$1}'
    else
    printf "\n"
    fi
}
