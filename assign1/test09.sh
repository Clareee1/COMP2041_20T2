#!/bin/dash


#add + commit-a
./shrug-init
touch a b c
./shrug-add a b 
./shrug-commit -a -m "index index"
./shrug-rm a
rm b
./shrug-status
