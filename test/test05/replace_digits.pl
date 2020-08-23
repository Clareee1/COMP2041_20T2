#!/usr/bin/perl -w

foreach $file (@ARGV) {
    open my $f, '<', $file or die "Can not open $file: $!";
    @lines = <$f>;
    close $f;

    foreach $line (@lines) {
        $line =~ s/\d/#/g;
    }
    #hint:do not read and write at the same time
    open my $FILE, '>', $file or die "Can not open $file: $!";
    print $FILE @lines;
    close $FILE;
}


