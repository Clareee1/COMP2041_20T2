#!/bin/sh


<<////
if test "$1" -gt "$2" 
then
   exit 0
fi
i=$1
echo "$i" > "$3"
i=$(expr $i + 1)

while test $i -le $2
do
   echo "$i" >> "$3"
   i=$(expr $i + 1)
done
////


start=$1
finish=$2
filename="$3"

i=$start
while ((i <= finish))
do
    echo $i
    i=$((i + 1))
done >$filename

