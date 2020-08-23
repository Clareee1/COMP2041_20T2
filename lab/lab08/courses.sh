#!/bin/sh

if test $# != 1
then
    echo "Usage: $0 <course-prefix>"
    exit 1
fi


course=$1
url="http://www.timetable.unsw.edu.au/current/"$course"KENS.html"


wget -q -O- "$url"|
egrep "$course[0-9]{4}.html"|
sed "s/.*\($course[0-9][0-9][0-9][0-9]\)\.html[^>]*> *\([^<]*\).*/\1 \2/"|
egrep -v $course[0-9]{4}.$course[0-9]{4}|
sed 's/ *$//'|
sort|
uniq


