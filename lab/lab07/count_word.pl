#!/usr/bin/perl -w


die "Usage: $0 <Word>\n" if @ARGV != 1;


$word_search=lc $ARGV[0];
$num = 0;
while($line = <STDIN>){
    $line = lc $line;
    @words = split /[^a-zA-Z]+/,$line;
    foreach $word(@words){
        $num++ if $word eq $word_search;
    }
}
print "$word_search occurred $num times\n";
