#!/usr/bin/perl -w


$num = 10;
foreach $arg (@ARGV) {
    if ($arg eq "--version") {
        print "$0: version 0.1\n";
        exit 0;
    }
    if ($arg =~ /^-[0-9]+$/) {
        $num=$arg;
        $num =~ s/-//g;
    } else {
        push @files, $arg;
    }
}





$count=0;
if (@files != 0){
    foreach $file(@files){
        if($#files  > 0){  #$#files+1 > 1
            print "==> $file <==\n";
        }
        open my $input, '<', $file or die "$0: Can't open $file: $!\n"; 
        @line=<$input>;
        $size=$#line + 1;
        if ($size > $num){
            $count = $num;
        } else {
            $count = $size;
        }
        
        while ($count > 0){
            print $line[-$count]; #display the last N lines
            $count--;
        }
        close $input; 
    }  
} else { #for the case like ./tail.pl <t1.txt
    @line = <STDIN>;
    $size = $#line + 1;
    if ($size > $num){
        $count = $num;
    } else {
        $count = $size;
    }

    while ($count > 0){
        print $line[-$count]; #display the last N lines
        $count--;
    }


}
