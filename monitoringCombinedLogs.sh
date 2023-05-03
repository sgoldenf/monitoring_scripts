#!/bin/bash

./utils/validator.sh $@

ERROR=$?

if [ $ERROR -eq 0 ]
then
  ./utils/sortCombinedLogs.sh $@
fi
