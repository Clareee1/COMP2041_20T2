#!/bin/dash

./shrug-init
touch a b c d e f g
./shrug-add a b c d e f
./shrug-commit -a -m "first"
echo hello >a
echo world >b
echo bye >c
echo world >d
./shrug-add c d
echo hello again >> a
rm e
./shrug-rm a
./shrug-add g

