#!/bin/sh

if test $# != 1
then
    echo "Usage: $0 <course-prefix>"
    exit 1
fi

# get current year
course_prefix=$1
first_letter=$(echo $course_prefix | egrep -o "^.") 
base_url="http://legacy.handbook.unsw.edu.au/vbook2018/brCoursesByAtoZ.jsp"
pgrad_url="$base_url?StudyLevel=Postgraduate&descr=$first_letter"
ugrad_url="$base_url?StudyLevel=Undergraduate&descr=$first_letter"

wget -q -O- "$pgrad_url" "$ugrad_url"|
egrep "$course_prefix[0-9]{4}.html"|
sed "s/.*\($course_prefix[0-9][0-9][0-9][0-9]\)\.html[^>]*> *\([^<]*\).*/\1 \2/"|
sed 's/ *$//'|
sort|
uniq


