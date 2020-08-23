#!/usr/bin/perl -w


$num=0;
while ($line = <STDIN>){
#split not a-zA-Z
    @words = split /[^a-zA-Z]+/,$line;
    foreach $word (@words){
        $num++ if $word ne '';
    }
}
print "$num words\n"; 
