#!/usr/bin/perl -w

$file = shift @ARGV;

open $f,'<' ,$file or die "Usage $0: cannot open,$!\n";

@lines = <$f>;
if(@lines == 0){
    exit(0);
}

$num = $#lines + 1;
if (($num) % 2 == 0){
#even
    print ($lines[$num/2 - 1]);
    print ($lines[$num/2]);
} else {
    print ($lines [$num/2]);
}
