#!/usr/bin/perl -w

die "Usage $0:<file>" if @ARGV != 1;
open my $f,'<',$ARGV[0] or die "Cannot open $ARGV[0]:$!\n";

@lines= <$f>;
close $f;

@sort_lines = sort compare @lines;
print @sorted_lines;

sub compare{
    my $a_length = length $a;
    my $b_length = length $b;
    if ($a_length == $b_length) {
        return $a cmp $b;
    }else {
        return $a_length <=> $b_length;
    }
}

exit 0;

#print sort {length $a <=> length $b || $a cmp $b};


