#!/bin/sh


option_flag=0
if test $# = 1
then
    pathname=$(echo $1 | sed 's/\/$//')
elif test $# = 2
then
    pathname=$(echo $1 | sed 's/\/$//')
    option=$2
    option_flag=1
fi


all_files=$(find $pathname -type f | grep "Makefile")

for makefile in $all_files
do
    #eg medium/c/Makefile
    dirname=$(echo $makefile | sed 's/\/Makefile$//')
    echo "Running make in $dirname"
    if test "$option_flag" = 0
    then
        pushd . > /dev/null
        cd "$dirname" && make
        popd > /dev/null
    else
        pushd . > /dev/null
        cd "$dirname" && make "$option"
        popd > /dev/null
    fi
done
