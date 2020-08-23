#!/bin/sh


if test $# != 1
then
    echo "Usage:$0 <file>"
    exit 1
fi 


file=$1;
num=0

while(test -e ".$file.$num")
do
   num=$(expr $num + 1)
   

done

cp "$file" ".$file.$num"

echo "Backup of '$file' saved as '.$file.$num'"

