#!/bin/dash

#for b shrug-rm has the error
rm -rf .shrug
./shrug-init
echo line 1 > a
echo line 2 > b
./shrug-add a b c d
./shrug-commit -a -m 'first'
./shrug-rm b
./shrug-status
./shrug-rm a b c
echo line 4 > d
./shrug-add d
./shrug-commit -m "Add d"

