#!/usr/bin/perl -w

my $num = $ARGV[0];
my %seen = ();
my $start = 0;
my $count = 0;
while ($line = <STDIN>){
    $line =~ tr/[A-Z]/[a-z]/;
    my @spl = split('\s+',$line);
    $line = join(" ",@spl);
    $line =~ s/^ *//g;
    $line =~ s/ *$//g;
    if (!$seen{$line}){
        $seen{$line}++;
        $start++; 
    }
    if ($start == $num){
        $count = $count + 1;
        print "$num distinct lines seen after $count lines read.\n";
        last;
    }
    $count ++;
}


if ($start < $num){
    print "End of input reached after $count lines read - $num different lines not seen.\n";

}
