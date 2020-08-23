#!/usr/bin/perl -w

if (@ARGV != 2){
    die "Usage:$0 <number of lines> <string>\n";
}
if ($ARGV[0] !~ /[0-9]/ or $ARGV[0] lt 0  ){
    die "$0:argument 1 must be a non-negative integer\n";
}


$num = $ARGV[0];
$word = $ARGV[1];

for ($i = 0; $i < $num; $i++){
    print "$word\n";
}
