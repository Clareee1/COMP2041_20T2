#!/bin/sh
small=" "
medium=" "
large=" "

for file in *
do
    count=$(wc -l < $file | cut -f1)
    #echo $count
    if test $count -lt 10
    then
        small="$small $file"
    elif test $count -lt 100
    then 
        medium="$medium $file"
    else
        large="$large $file"
    fi
done


echo "Small files:$small"
echo "Medium-sized files:$medium"
echo "Large files:$large"

exit 0
