#!/usr/bin/perl -w
use File::Copy;


if ($ARGV[0] !~ /.txt/){
    die "Usage: $0 <txt>\n";
}   

$num = 0;
$file=$ARGV[0];

while (-e ".$file.$num"){
    $num++;
}

copy("$file",".$file.$num") or die "Cant!\n";

print "Backup of '$file' saved as '.$file.$num'\n";
