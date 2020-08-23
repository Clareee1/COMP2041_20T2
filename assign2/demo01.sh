#!/bin/sh

# this is test for echo,if and expr
# i also test for quotes here

echo '"Double quotes inside the single qoutes"'
echo 'this is is single quotes'
echo "this is double quotes"

if test -e $quote
then
    echo "$quote"
fi
if test -e $double
then
    echo "$double"
fi

while test $num -gt $quote
do
    number=`expr $num + 10` 
done
