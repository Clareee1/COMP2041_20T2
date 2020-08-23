#!/usr/bin/perl -w

use File::Copy qw(copy);

#find the current number
$num = 0;
while (-d ".snapshot.$num") {
    $num = $num + 1;
}
$new = ".snapshot.$num";
print "Creating snapshot $num\n";

mkdir "./$new";

@file_all = <*>;
foreach $file (@file_all) {
    $result = substr($file, 0, 1); #obtain the first character
    if ($file eq "snapshot.pl" || $result eq "."){
        next;
    }
    copy "$file", "$new/$file";
}

#if Load
if ($ARGV[0] eq "load"){
    print "Restoring snapshot $ARGV[1] \n";
    $curr = "./.snapshot.$ARGV[1]";
    @file_all = <*>;
    foreach $file (@file_all) {
        $result = substr($file, 0, 1); #obtain the first character
        if ($file eq "snapshot.pl" || $result eq "."){
            next;
        }
        copy "$curr/$file", "$file";  
    }       
}


