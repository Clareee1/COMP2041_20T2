#!/bin/sh

for file in *
do
    lines = wc -l < $file
    if test $lines -lt 10
    then
        small = "$file"
    elif test $lines -lt 100
    then 
        medium = "$file"
    else
        large = "$large"
    fi
done


echo "Small files:$small"
echo "Medium-sized files:$medium"
echo "Large files:$large"

exit 0


