#!/bin/bash

if (echo "$1" | grep -q -E "[/]$")
then
    ./utils/fileSystemReport.sh $1
else
    echo "You should provide path as argument. Try again."
fi
