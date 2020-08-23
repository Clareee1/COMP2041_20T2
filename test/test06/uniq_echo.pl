#!/usr/bin/perl -w

%hash = ();
foreach $word(@ARGV){
    next if $hash{$word};
    #print " " if %hash;
    print "$word "; 
    $hash{$word}++;
}
print "\n";
