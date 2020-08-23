#!/usr/bin/perl -w

die "Usage: ./courses.pl <prefix>" if scalar @ARGV != 1;
open(F, "wget -q -O- http://timetable.unsw.edu.au/current/${ARGV[0]}KENS.html | ") or die "$!";
while ($line = <F>) {
    
    if ($line =~ m/<a href="[A-Z]{4}\d{4}.html">/ and $line !~ /<td class.*>([A-Z]{4}\d{4})<\/a><\/td>/) {
        $line =~ s/^ *//g;
        $line =~ s/ *$//g;
        my @fie = split '<', $line;
        my $course = $fie[2];
        $course =~ s/a href=\"//;
        $course =~ s/.html\"//g;
        $course =~ s/>/ /g;
        push @list,$course;
        
    }
}

%seen=();
foreach $name (sort @list){
    next if exists $seen{$name};
    $seen{$name} = 1;
    print "$name\n";
}




q{

use LWP::Simple;

die "Usage: $0 <prefix>" if @ARGV != 1;

$prefix = shift @ARGV;
$url = "http://www.timetable.unsw.edu.au/current/" . $prefix . "KENS.html";
open my $in, '-|', "wget -q -O- $url" or die "$!\n";

%hash_course = ();
while ($line = <$in>)
{
    ($code, $name) = $line =~ /<a href=\"($prefix\d{4})\.html\">([^<]+)<\/a>/;
    if ($code && $name && $code ne $name)
    {
        $hash_course{$code} = $name;
    }
}
close $in;


foreach $key (sort keys %hash_course)
{
    print "$key $hash_course{$key}\n";
}

}
