#!/bin/dash

#this is the error test
#shrug -add doesnt has the --force command thus nothing to commit
rm -r -f .shrug
./shrug-init
touch a b c d 
./shrug-add a b c d 
./shrug-commit -m 'first commit'
echo hello >a
echo hello >b
./shrug-add a b
echo world >a
rm d
./shrug-rm e
./shrug-add d
./shrug-rm a
./shrug-rm b
./shrug-rm c
./shrug-rm d
./shrug-commit -m 'second commit'
./shrug-log
./shrug-rm --force --cached a
./shrug-log
