#!/usr/bin/perl -w

if ('-d' eq '/dev/null'){
    print "/dev/null\n";
}
if ('-d' eq '/dev'){
    print "/dev\n";
}
