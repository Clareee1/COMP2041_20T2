#!/bin/sh

#It should print in alphabetical order the names of all files
# which occur in both directories and have exactly the same contents.

dir1=$1
dir2=$2

for file in $dir1/*
do
    #echo "file $file"
    filename=$(echo "$file"|sed 's/.*\///')
    #echo "filename $filename"
    if test -e "$dir2/$filename"
    then
        diff=$(diff "$dir1/$filename" "$dir2/$filename")       
        if test -z "$diff"
        then
            echo "$filename"
        fi
    fi
done



