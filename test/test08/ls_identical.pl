#!/usr/bin/perl -w


use File::Compare;
$dir1 = $ARGV[0];
$dir2 = $ARGV[1];

@arr = glob("$ARGV[0]/*");
foreach $file (@arr){
    $file =~ s/.*\///;
    if(compare("$dir1/$file","$dir2/$file") == 0){
        print "$file\n";
    }

}
