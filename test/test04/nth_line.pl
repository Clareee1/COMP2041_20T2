#!/usr/bin/perl -w

die "Usage $0: <n> <file>\n" if @ARGV != 2;

$num=$ARGV[0];

open my $files,'<',$ARGV[1] or die "$0:Can't open,$!\n";
$i=1;
while ($line = <$files>){
    if ($i == $num){
        print "$line";
        last;
    }
    $i = $i+1;
}
close $files;
