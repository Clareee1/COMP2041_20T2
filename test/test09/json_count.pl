#!/usr/bin/perl -w

die "Usage: $0 <whale species> <file>\n" if @ARGV != 2;

$target = $ARGV[0];
$filename = $ARGV[1];

my $num = 0;

open my $f, '<',$filename or die "Can not open $filename\n";

while ($line = <$f>) {
    if ($line =~ /"how_many": (\d+)/) {
        $how_many = $1;
    } elsif ($line =~ /"species": "(.*)"/) {
        my $species = $1;
        if ($species eq $target) {
            $num += $how_many;
        }
    }
}

close $f;

print "$num\n";
