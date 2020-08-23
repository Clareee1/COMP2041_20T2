#!/bin/sh

mp3_file="$1"

wget -q -O- 'https://en.wikipedia.org/wiki/Triple_J_Hottest_100?action=raw'|
while read line
do
    # look for line which is start of Hottest 100 list for a year

    case "$line" in
    \|*'[[Triple J'*'|'[0-9][0-9][0-9][0-9]']]'*) ;;
    *) continue;;
    esac


    # create a directory for a Hottest 100 year
    album=`echo "$line"|sed 's/.*\[\[//;s/|.*//'`
    year=`echo "$album"|sed 's/.*\ //'`
    dir=""$2"/Triple J Hottest 100, $year"
    mkdir -p -m 755 "$dir"

    # read top 10 songs for year
    num=1
    while read line && test $num -le 10
    do
        case "$line" in
        '#'*) ;;
        *) continue;;
        esac
        # remove links to wikipedia pages
        line=`echo "$line"|sed 's/[^[]*|//g'`
        # change slashes to hyphens - because can't have / in a filename
        line=`echo "$line"|sed 's/\//-/g'`
        # remove some formating characters
        line=`echo "$line"|tr -d '[]"#'`
        #en dash 
        artist=`echo "$line"|sed 's/\xe2\x80\x93.*//'`
        title=`echo "$line"|sed 's/.*\xe2\x80\x93//'`
        #trim spaces
        artist=`echo "$artist"|sed 's/^ *//;s/ *$//'`
        title=`echo "$title"|sed 's/^ *//;s/ *$//'`
        file="$dir/$num - $title - $artist.mp3"
        cp -p "$mp3_file" "$file"
        num=$((num + 1))
    done 
done
