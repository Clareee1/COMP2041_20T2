#!/bin/sh

if test $# -ne 2 
then
    echo "Usage: $0 <number of lines> <string>"
    exit 1
fi


#if arguement 1 is not a integer
# 2 is std out
if test $1 -ge 0 2>/dev/null   #(($1 >=0))
then
    :
else
    echo "$0: argument 1 must be a non-negative integer"
    exit 1
fi


number_of_lines=$1
text=$2

line_count=0
while test $line_count -lt $number_of_lines
do
    echo $text
    line_count=$(expr $line_count + 1)
done

exit 0
