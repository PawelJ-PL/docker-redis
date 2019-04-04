#!/bin/bash

export CONFIG_FILE="/tmp/sentinel.conf"
export GLOBAL_CONFIG_CONTENT=""
export NODES_CONFIG_CONTENT=""

process_global_conf() {
        local line=`echo $1 | awk -F= '{print tolower($1), tolower($2)'} | tr '_' '-'`
        GLOBAL_CONFIG_CONTENT="$GLOBAL_CONFIG_CONTENT $line\n"
}

process_node_conf() {
        local line=`echo $1 | awk -F= '{print tolower($1), tolower($2)'} | tr '_' '-'`
        local node_name=`echo $line | awk -F- '{print $1}'`
        local cmd=`echo ${line/#"${node_name}-"} | awk '{print $1}'`
        local params=`echo $line | cut -d ' ' -f2-`
        local result="sentinel $cmd $node_name $params"
        if [[ $cmd == "monitor" ]]
        then
                NODES_CONFIG_CONTENT="$result\n$NODES_CONFIG_CONTENT"
        else
                NODES_CONFIG_CONTENT="$NODES_CONFIG_CONTENT $result\n"
        fi
}

gen_config() {
    IFS=$'\n'
    for var in `env | grep -ie '^SENTINEL_CONFIG_'`
    do
            if [[ $var == SENTINEL_CONFIG_GLOBAL_* ]]
            then
                    process_global_conf ${var/#"SENTINEL_CONFIG_GLOBAL_"}
            else
                    process_node_conf ${var/#"SENTINEL_CONFIG_"}
            fi
    done

    echo -e "$GLOBAL_CONFIG_CONTENT $NODES_CONFIG_CONTENT" > $CONFIG_FILE
}  

gen_config
redis-sentinel $CONFIG_FILE