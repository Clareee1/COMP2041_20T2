#!/bin/sh

for file in "$@"
do
    size_origin=$(ls -l $file | tr -s " " | cut -d " " -f5)
    xz -k $file
    size_compress=$(ls -l $file.xz | tr -s " " | cut -d " " -f5)
    if test $size_compress -lt $size_origin
    then
        rm -rf "$file"
        echo "$file $size_origin bytes, compresses to $size_compress bytes, compressed"
    else
        rm -rf "$file.xz"
        echo "$file $size_origin bytes, compresses to $size_compress bytes, left uncompressed"
    fi
done


