#!/bin/sh

# this is test for while and argv

$b=$1

while test $a -lt $b
do
    echo $a
    a=$((a+1))
done
