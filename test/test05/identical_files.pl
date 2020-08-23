#!/usr/bin/perl -w

foreach $file(@ARGV){
    open my $f,'<',$file;
    if(@lines){
        @tem=<$f>;
        $str1 = join( '', @tem );
        $str2 = join( '', @lines);
        if ($str1 ne $str2){
            print "$file is not identical\n";
            exit 0;
        }
    } else {
        @lines=<$f>; #if it is the first one, read into lines
    }
    close $f;
}
print "All files are identical\n";


