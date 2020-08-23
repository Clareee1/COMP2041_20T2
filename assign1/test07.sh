#!/bin/dash

rm -rf .shrug
./shrug-init
echo line 1 > a
echo line 2 > b
./shrug-add a b
./shrug-commit -a -m 'first commit'
./shrug-rm --force a
echo line 3 >>b
./shrug-show :b
./shrug-commit -m "second"

