#!/bin/sh

for url in "$@"
do
    server=$(curl -I -s "$url"|egrep '[sS]erver: '| sed "s/[sS]erver: //g")
    echo "$url $server"
done




