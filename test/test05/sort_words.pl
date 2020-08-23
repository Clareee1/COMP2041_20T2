#!/usr/bin/perl -w

while($line = <STDIN>){
# \s+ stands for one or more spaces. By using \s+ as the expression for the split #function, it splits everytime it encouters a series of spaces and hence the words are #retrieved.
    @words= split /\s+/,$line;
    @sort_word = sort @words;
    print join(" ",@sort_word),"\n";
}
