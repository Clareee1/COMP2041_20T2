#!/bin/dash

#commit 3 file and add line to each of them
# shrug-rm force 2 files
# rm c from the local/working dictionary
rm -rf .shrug
./shrug-init
echo line 1 > a
echo line 2 > b
echo line 3 > c
./shrug-add a b c 
./shrug-commit -m 'first commit'
./shrug-rm --force a b
rm c
./shrug-log
./shrug-status
