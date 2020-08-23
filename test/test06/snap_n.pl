#!/usr/bin/perl -w

$n = $ARGV[0];


%hash=();
while($line = <STDIN>){
    $hash{$line}++;
    if ($hash{$line} >= $n){
        print "Snap: $line";
        last
    }

}
