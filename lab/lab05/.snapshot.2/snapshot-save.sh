#!/bin/dash

num=0
while (test -d ".snapshot.$num") #check the dictionary
do
    num=$(expr $num + 1)
done

mkdir ".snapshot.$num"
echo "Creating snapshot $num"

for file in *
do
    if (echo "$file"|egrep "^\.">/dev/null) #ignore name starts with .
    then
        continue;
    fi

    if [ $file = "snapshot-save.sh" ] || [ $file = "snapshot-load.sh" ] || [ $file = "*" ]
    then
        continue;
    fi;  
    
cp "$file" ".snapshot.$num/$file"
done
