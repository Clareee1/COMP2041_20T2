#!/usr/bin/perl -w


while ($line = <>){
    @numbers = $line =~ /(\d+\.\d+)/g;
    foreach $number (@numbers){ 
        #match the number
        $new = int($number + 0.5);
        $line =~ s/$number/$new/;
    }
    print "$line";
}

