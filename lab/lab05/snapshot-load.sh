#!/bin/dash


snapshot-save.sh

num="$1";
echo "Restoring snapshot $num"

curr="./.snapshot.$num"

for file in *
do
    if (echo "$file"|egrep "^\.">/dev/null) #ignore name starts with .
    then
        continue;
    fi
    if [ $file = "snapshot-save.sh" ] || [ $file = "snapshot-load.sh" ] || [ $file = "*" ]
    then
        continue;
    fi
    
    cp "$curr/$file" "$file"

done


