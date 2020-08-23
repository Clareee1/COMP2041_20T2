#!/bin/dash

#this is the error test
#test rm here
rm -rf .shrug
./shrug-init
touch a b c d e
echo line 1 > a
echo line 2 > b
./shrug-add b
./shrug-commit -a -m "first"
./shrug-rm --cached a
./shrug-rm --force b
echo line 3 >> b
./shrug-rm --force b
./shrug-commit -a -m "done"
