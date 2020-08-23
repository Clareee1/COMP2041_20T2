#!/bin/dash

#this is the error test
#shrug -add doesnt has the --force command thus nothing to commit
rm -rf .shrug
./shrug-init
echo line 1 > a
./shrug-add a 
./shrug-commit -a -m "first commit"
./shrug-rm --cached a
./shrug-show 0:a
./shrug-log
