#!/usr/bin/perl -w

die "Usage: $0 <Word>\n" if @ARGV < 1;
use List::Util qw(min max);


foreach $file (glob "lyrics/*.txt") {
    $singer = $file;
    $singer =~ s/^lyrics\///;
    $singer =~ s/\.txt$//;
    $singer =~ s/_/ /g;
    open  $f, '<', $file or die "can not open $file: $!";
    while ($line = <$f>) {
        $line = lc $line;
        foreach $word ($line =~ /[a-zA-Z]+/g) {
            $hash{$singer}{$word}++;
            $num_words{$singer}++;
        }
    }
    close $f;
}

foreach $file(@ARGV){
    %singer_log = ();
    open $f, '<', "$file" or die "can not open $file:$!";
    while ($line = <$f>){
        @words = $line =~ /[a-zA-Z]+/g;
        foreach $word (@words){
            $word = lc $word;
            foreach $singer(sort keys %hash){
                if($hash{$singer}{$word}){
                    $rate = ($hash{$singer}{$word}+1)/$num_words{$singer};
                    $log = log($rate);
                    $singer_log{$singer} += $log;
                } else {
                    $rate = 1/$num_words{$singer};
                    $log = log($rate);
                    $singer_log{$singer} += $log;
                }
            }
        }    
    }

    #find the max
    @log_values = (values %singer_log);
    $max_log = max(@log_values);
    for $singer(keys %singer_log){
        if ($singer_log{$singer} == $max_log){
            printf "%s most resembles the work of %s (log-probability=%.1f)\n", $file, $singer, $max_log;
        }
    }
    close $f;
}
