#!/usr/bin/perl -w

%hash = ();
foreach my $arg (@ARGV){
    next if $hash{$arg};
    $hash{$arg}++;
    print "$arg ";

}
print "\n";
