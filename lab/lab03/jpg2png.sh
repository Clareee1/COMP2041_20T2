#!/bin/sh

for file in *.jpg
do
    png_file=$(echo "$file" | sed 's/jpg$/png/')
    if test -e "$png_file"
    then
        echo "$png_file" already exists
        exit 1
    fi
    convert "$file" "$png_file" && rm "$file"
    
    
done
