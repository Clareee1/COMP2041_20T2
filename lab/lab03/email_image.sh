#!/bin/sh

for file in "$@"
#like Penguins.png
do 
    display $file
    echo -n "Address to e-mail this image to?"
    read address
    if test -n "$address"  #if the length of string is non-zero
    then
        echo -n "Message to accompany image?"
        read message
        echo "$message"| mutt -s 'image' -a "$png_file" -e 'set copy=no' -- "$address"  
        echo ""$file" sent to "$address""
    else
        echo "No file"
        fi
done
