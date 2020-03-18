#!/bin/bash

date 
#!/bin/bash
input=servers_list.txt
while IFS= read -r line
do
    ping -c 1 "$line" > /dev/null
    if [ $? -eq 0 ]; then
    echo "Server :$line is Reachable"
    else
    echo "Server :$line is Unreachable"
    fi
done < "$input"
