#!/usr/bin/perl -w

use experimental 'smartmatch';
$date = `date`;
print "# Makefile generated at $date\n";

print "CC = gcc\n";
print "CFLAGS = -Wall -O3\n\n";

my $main = "main";
my $o_files = "";
foreach my $c_file (sort glob("*.c")){
    if ($c_file =~ /main/) {
    #eg: easymain;main;cirmain
        my $tmp = $c_file;
        $tmp =~ s/\.c//;
        $main = $tmp;
    }
    my $o_file = $c_file;
    $o_file =~ s/\.c/\.o/;
    #print the first line that join the .o file
    #eg: easymain:   easymain.o graphics.o world.o
    $o_files .= "$o_file ";
}

print "$main: ", "$o_files\n";
print "\t\$(CC) \$(LDFLAGS) -o \$\@ $o_files\n\n";

#find the dependence
my %dep = ();


#find the list of dependece of c_file
#print seperatly for each .o file
#need to open the file inside the include file
sub file_inside_file{
    my ($file, $c_file) = @_;
    if (-e $file) {
        open my $h_file, '<', "$file" or die "Cannot open $file: $!\n";
        while (my $h_line = <$h_file>){
        #eg:b.h include bb.h
            if ($h_line =~ /#include \"(.*)\"/){
                next if ( $1 =~ /ctype/ || $1 =~ /stdio/);
                my $h_file2 = $1;
                my @curr_files = split " ", $dep{$c_file};
                # h_file already exist in the list 
                #between two scalar variables 
                next if $h_file2 ~~ @curr_files;  
                $dep{$c_file} .= "$h_file2 ";
                file_inside_file($h_file2, $c_file);
            }
        }
        close $h_file;
    } 
}


foreach my $c_file (glob("*.c")){
    open my $c_in, '<', "$c_file" or die "Cannot open $c_file: $!\n";
    @files = <$c_in>;
    foreach $line (@files) {
        if ($line =~ /#include \"(.*)\"/){
            next if ( $1 =~ /ctype/ || $1 =~ /stdio/);
            my $h_file = $1;
            $dep{$c_file} .= "$h_file ";
            file_inside_file($h_file, $c_file);
        }
    }
    close $c_in;
}


foreach my $key (sort keys %dep){
    my $o_file = $key;
    $o_file =~ s/\.c/\.o/;
    if ($dep{$key}){
        print "$o_file : $dep{$key}", "$key\n";
    }   
}


