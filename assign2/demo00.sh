#!/bin/sh

# part of the code is from lecture examle
# from Tuesday June 30 2020 lecture
# name is repeat_message.sh

repeat_message() {
    n=$1
    message=$2
    echo "$1 $message"
}

i=0
while test $i -lt 4
do
    repeat_message 3 "hello Andrew"
    i=$((i + 1))
    if test $i = 2
    then
        echo "$i is two"
    fi
done
