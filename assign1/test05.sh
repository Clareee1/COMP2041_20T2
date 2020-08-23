#!/bin/dash

#shrug-rm errror
#when local != repo
#test different stage 
rm -r -f .shrug
touch a b c d e f g h
./shrug-init
./shrug-add a b c
./shrug-rm --cached c
echo hi >> b
./shrug-add d e f
rm f
./shrug-rm --cached b
./shrug-rm  d e f
./shrug-log
./shrug-status
