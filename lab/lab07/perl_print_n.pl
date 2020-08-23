#!/usr/bin/perl -w

die "Uasge: $0 <integer> <str>" if @ARGV != 2;


$count = shift @ARGV;
$str = shift @ARGV;

# $n = 0;
if ($count == 1)
{
    print "print \"";
    print $str;
    print "\\n\";";
    print "\n";
}
else
{
    if ($str =~ /\\+/){
        $str =~ s/\\/\\\\/g;
    }
    if ($str =~ /\"+/){
        $str =~ s/\"/\\\"/g;
    }
    $n = 0;
    $head = "print \"";
    $back = "\\n\";";
    while ($n < $count - 1)
    {
        $head =~ s/\\/\\\\/g;
        $head =~ s/\"/\\\"/g;
        $head = "print \"$head";
        $back =~ s/\\/\\\\/g;
        $back =~ s/\"/\\\"/g;
        $back = "$back\\n\";";

        if ($str =~ /\\+/){
            $str =~ s/\\/\\\\/g;
        }
        if ($str =~ /\"+/){
            $str =~ s/\"/\\\"/g;
        }
        $n++;
    }
    print "$head";
    print "$str";
    print "$back";
}
print "\n";
