#!/usr/bin/perl -w

use POSIX;
@arr = sort{$a <=> $b} @ARGV;
$item = $#arr;
$var = ceil($item/2);
print "$arr[$var]\n";


