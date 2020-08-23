#!/usr/bin/perl -w


die "Usage: $0 <Word>\n" if @ARGV != 1;


foreach $file (glob "lyrics/*.txt") {
    $singer = $file;
    $singer =~ s/^lyrics\///;
    $singer =~ s/\.txt$//;
    $singer =~ s/_/ /g;
    open  $f, '<', $file or die "can not open $file: $!";
    while ($line = <$f>) {
        $line = lc $line;
        foreach $word ($line =~ /[a-z]+/g) {
            $hash{$singer}{$word}++;
            $num_words{$singer}++;
        }
    }
    close $f;
}


foreach $word (@ARGV) {
    $word = lc $word;
    foreach $singer (sort keys %hash) {
    #|| 0 cant use or
        $count = $hash{$singer}{$word}||0;
        $n = $num_words{$singer};
        printf "log((%d+1)/%6d) = %8.4f %s\n", $count, $n, log(($count+1)/$n), $singer;
    }
}
