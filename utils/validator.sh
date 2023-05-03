#!/bin/bash

ERROR=0

if [ $# -lt 2 ]
then
  printf "Too few arguments. You should provide one argument for sort mode and at least one filepath to log\n\n"
  ERROR=1
fi

if [[ ERROR -eq 0 && ! $1 =~ ^[1-4]{1}$ ]]
then
  ERROR=1
  printf "The argument should be an integer from 1 to 4\n\n"
fi

arr=$@
sliced=${arr[@]:1}
for path in ${sliced[@]}; do
  if [ ! -f "$path" ]; then
    ERROR=1
    echo "File does not exists:" $path
  fi
done

if [ $ERROR -eq 1 ]
then
  printf "Try again\n"
fi

exit $ERROR
