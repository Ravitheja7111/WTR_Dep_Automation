#!/bin/bash

date
cat servers_list.txt |  while read -r output
do
    ping -c 1 "$output" > /dev/null
    if [ $? -eq 0 ]; then
    echo "Server :$output is Reachable"
    else
    echo "Server :$output is Unreachable"
    fi
done

