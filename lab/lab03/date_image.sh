#!/bin/sh

for file in "$@"
do 
    time=$(ls -l "$file" | cut -d\  -f5-|sed 's/^ *//'|cut -d\    -f2,3,4 )
    #get the dates   
    temp="file.temp" #create a temp file
    convert -gravity south -pointsize 36 -draw "text 0,10 '$time'" "$file" "$temp"&&
    mv "$temp" "$file"
done
