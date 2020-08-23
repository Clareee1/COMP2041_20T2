#!/bin/sh

for c_file in "$@"
do
    for include in $(egrep '^#include *"' "$c_file"|sed 's/" *$//;s/.*"//')
    do 
        #FILE exists and read permission is granted
        if test ! -r "$include"
        then 
            echo ""$include" included into "$c_file" does not exist"
        fi   
    done
done
