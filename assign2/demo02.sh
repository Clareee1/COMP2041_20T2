#!/bin/sh

# this is test for system, for loop
# it include if inside the for loop

rm -f $file
date
pwd

for h_file in *.h
do
    echo gcc -c $h_file
    if [ -d /dev/null ]
    then
        echo /dev/null
    fi
    if [ -d /dev ]
    then
        echo /dev
    fi    
done
