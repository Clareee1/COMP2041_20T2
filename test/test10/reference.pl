#!/usr/bin/perl -w


my @all_lines =<>;

foreach $line (@all_lines){
    if ($line =~ /^\#(\d+)/){
        $num = $1;
        print "$all_lines[$num-1]";
    } else {
        print "$line";
    }
}

