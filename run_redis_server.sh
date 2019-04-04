#!/bin/bash

export COMMAND_PARAMS=""
IFS=$'\n'
for var in `env | grep -ie '^REDIS_CONFIG_'`
do      
        export pair=`echo $var | cut -d '_' -f3-`
        export param=`echo $pair | awk -F= '{print tolower($1)}' | tr '_' '-'`
        export value=`echo $pair | awk -F= '{print $2}'`
        COMMAND_PARAMS="$COMMAND_PARAMS --$param $value"
done
eval "redis-server $COMMAND_PARAMS"
