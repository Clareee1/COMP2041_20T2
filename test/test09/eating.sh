#!/bin/sh



cut -d[ -f2 $1 | cut -d] -f1 | cut -d\" -f4 | sed "s/^\s*//g" | sed "/^$/d" | sort | uniq

egrep "name" $1| cut -d\" -f4| sort | uniq


