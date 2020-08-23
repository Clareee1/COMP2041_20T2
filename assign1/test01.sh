#!/bin/dash

#this is the error test
#shrug -add doesnt has the --force command thus nothing to commit
rm -rf .shrug
touch --force --cached
./shrug-init
./shrug-add --force --cached
./shrug-commit -a -m "first commit"
echo line 1 > a
echo line 2 > b
echo line 3 > c
./shrug-add a b  
./shrug-commit -m 'first commit'
./shrug-log
./shrug-status
