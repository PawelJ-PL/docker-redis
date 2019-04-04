#!/bin/bash

if [ "$ROLE" == "sentinel" ]
then
    /run_sentinel.sh
else
    /run_redis_server.sh
fi
