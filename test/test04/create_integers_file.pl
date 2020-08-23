#!/usr/bin/perl -w

$start=$ARGV[0];
$end=$ARGV[1];

open my $file,'>',$ARGV[2] or die "$0:Cant open $!\n";
for ($i=$start; $i <= $end; $i++){
    print $file "$i\n";

}
