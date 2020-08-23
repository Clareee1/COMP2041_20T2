#!/bin/sh


for fileDir in "$@"
do
   find "$fileDir" -type f -name "*.mp3" | #https://www.explainshell.com/explain?cmd=find+.+-type+f+-name+%22*confli*%22+-exec+rm+-i+-f+%7B%7D+%5C;
   while read fullFileName 
   do
      filename=$(basename "$fullFileName")
      dirName=$(basename "$fileDir")
      album=$dirName
      year=$(echo $album| egrep -o "[0-9]{4}")
      track=$(echo "$filename" | cut -d "-" -f 1 |sed 's/^ *//;s/ *$//')
      title=$(echo "$filename" | sed "s/ - /*/g"| cut -d "*" -f 2|sed 's/^ *//;s/ *$//')
      artist=$(echo "$filename" | sed "s/ - /*/g"| cut -d "*" -f 3 | sed "s/.mp3$//g"|sed 's/^ *//;s/ *$//')
      id3 -t "$title" -T "$track" -a "$artist" -y "$year" -A "$album" "$fullFileName" >/dev/null
   done 
done

