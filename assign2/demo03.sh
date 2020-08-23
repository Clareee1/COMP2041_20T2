#!/bin/sh

# this is test for if contains if 
# this is also test for argument

echo My first argument is $1
echo My second argument is $2
echo My third argument is $3
$i = 0
$name = $2
$name_2 = $3

if test $i = $1
    then
    if test $name = great
        echo "Successed of compliment of $name"
    elif test $name_2 = Again
        echo "Successed Again of $name_2"
    else
        echo "Fail"
    fi  
fi
