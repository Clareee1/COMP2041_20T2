#!/usr/bin/perl -w

use Scalar::Util qw(looks_like_number);
my %hash = ("-lt" => "<", "-eq" => "==","-le" => "<=", "-ge" => ">=","-gt" => ">");
while($line = <>){
    #preprocess
    head($line);
    
    basic($line);
    
    for_loop($line);
    
    if_case($line);
    
    while_loop($line);
    
    sub_transform($line);
}

sub head{
    my ($line) = @_;
    if ($line =~ /^#!/){
        $line =~ s?^#!.*?#!/usr/bin/perl -w\n?;
        print "$line";
    }
}

#Comments and blank lines
sub comments{
    my ($line) = @_;
    if ($line =~ /^# (.*)/){
        my $content = $1;
        print "# $content\n";
    } elsif ($line =~ /^$/){
        print "\n";
    }
}


#system: pwd/ls/id/date
sub systems{
    my ($line) = @_;
    if ($line =~ /^(\s*)((ls|pwd|id|date|rm -f).*)/) {
        print "$1", "system \"$2";
        print "\";\n";
    }
}

#echo
sub echo{
    my ($line) = @_;
    if ($line=~/^(\s*)echo\s+('|")?(.*?[^"])("|')?\s*$/){
        my $indent = $1;#indent can be null
        my $quote_1 = $2;
        my $str = $3;
        my $quote_2 = $4;
        #trim quote at the beginning
        $quote_1 =~ s/("|')//g if $quote_1;
        #trim quote at the end
        $quote_2 =~ s/("|')//g if $quote_2;
        #match args
        $str = argument($str);
        #examples/2/truth.sh->truth beauty
        $str =~ s/"/\\"/g;
        print "$indent", "print \"$str\\n\";\n"; 
    }
   
}


#match args
sub argument{
    my ($line) = @_;
    #echo 10-> echo 9
    $line =~ s/\$1/\$ARGV\[0\]/;
    $line =~ s/\$2/\$ARGV\[1\]/;
    $line =~ s/\$3/\$ARGV\[2\]/;
    $line =~ s/\$4/\$ARGV\[3\]/;
    $line =~ s/\$5/\$ARGV\[4\]/;
    $line =~ s/\$6/\$ARGV\[5\]/;
    $line =~ s/\$7/\$ARGV\[6\]/;
    $line =~ s/\$8/\$ARGV\[7\]/;
    $line =~ s/\$9/\$ARGV\[8\]/;
    return $line;
    return $line;
}

#assign the variable + expr
sub assign_var{
    my ($line)= @_;
    if ($line =~ /^(\s*)(\w+)=(.*)$/){
        my $indent = $1;   
        my $left = $2; 
        my $right = $3;
        #expr
        if ($right =~ /`expr (.*)`(  # )?(.*)?$/){
            my $name = $1;
            my $flag = $2; #weather contain comments or not
            my $comment = $3;
            #number=`expr $number + 1`  # increment number
            if (!$2){
                print "$indent\$$left = $name;\n";            
            } else {
                print "$indent\$$left = $name;  # $comment\n" if $flag =~ /#/; 
            }                 
        #if $i = $i+1;      
        } elsif($right =~ /\$\(\((.*)\)\)(  #? )?(.*)?$/) {
            my $content = $1;
            my $exist = $2;
            my $comm = $3;
            if (!$2){
                print "$indent\$$left = \$$content;\n";
            } else {
                print "$indent\$$left = \$$content;  # $comm\n" if $exist =~ /#/;  
            }    
        } else {
            #assign the variable                   
            #special case: $1;$2;$3
            if ($right eq "\$1"){
                print "$indent","\$$left = \$_[0];" if $indent;
                print "\$$left = \$ARGV[0];" if !$indent;
                print "\n";   
                return 
            } elsif($right eq "\$2"){
                print "$indent","\$$left = \$_[1];" if $indent;
                print "\$$left = \$ARGV[1];" if !$indent;
                print "\n";
                return 
            } elsif ($right eq "\$3"){
                print "$indent","\$$left = \$_[2];" if $indent;
                print "\$$left = \$ARGV[2];" if !$indent;
                print "\n";
                return 
            } elsif ($right eq "\$4"){
                print "$indent","\$$left = \$_[3];" if $indent;
                print "\$$left = \$ARGV[3];" if !$indent;
                print "\n";
                return
            } elsif ($right eq "\$5"){
                print "$indent","\$$left = \$_[4];" if $indent;
                print "\$$left = \$ARGV[4];" if !$indent;
                print "\n";
                return
            }        
            #examples/3/sequence_expr.sh
            $tmp = $right;
            if ($tmp =~ '[(^\$)|(0-9)]'){ #begin with dollar sign or numeric 
            #like number = $start or $num = 2
                print "$indent", "\$$left = $right;\n";
            } else {
                print "$indent", "\$$left = '$right';\n";
            }
        }      
    }
}


#cd
sub cd{
    my($line) = @_;
    if ($line =~ /^\s*cd\s+(.*)/){
        chdir $1;
    }
}

sub for_loop{
    my ($line) = @_;
    #in a file
    if ($line =~ /^for (\w+) in (\*.*)/){
        my $file = $1;
        my $list = $2;
        print "foreach \$$file (glob(\"$list\")";
        print ") {\n";
        
        while ($line =<>){
            last if $line =~ /done/;
            if_case($line);
            basic($line); 
        }
        print "}\n";
    } elsif ($line =~/^for (\w+) in ([\d\w\s]+)/){
        my $file = $1;
        my $list = $2;
        my @all_item = split /\s/,$list;
        print "foreach \$$file (";
        my $text = "";
        foreach my $item (@all_item){
        #if it is a number
            if (my $num = looks_like_number($item)){
                $text .="$item, ";
            } else {
                $text .="'$item', ";
            }
        } 
        $text =~ s/, $//;#trim the ending of the last item
        print "$text) {\n";  
        
        $line = <>; #skip do
        while ($line = <>){
            if ($line =~ /done/){
                last;
            }
            if_case($line);
            basic($line);        
        }
        print "}\n"; 
    }
    
}



sub while_loop{
    my ($line) = @_;
    if ($line =~ /^(\s*)while test (\S+) (-[a-z]+) (\S+)/){
        my $indent = $1;
        my $left = $2;
        my $trans = $3;
        my $right = $4;
        print "$indent", "while ($left $hash{$trans} $right)";
        print "{\n";
        $line = <>; #next if "do"
        while ($line = <>){
            last if $line =~ /done/;
            if_case($line);
            basic($line);
        }
        print "$indent", "}\n";
    }
}


sub if_case{
    my ($line) = @_;
    #three situations as shown 
    if (($line =~ /^(\s*)if test (\S+) = (\S+)/) || ($line =~ /^(\s*)if \[ (\-[a-zA-Z]+) (\S+) \]/) || ($line =~ /^(\s*)if test (\-[a-zA-Z]+) (\S+)/) ) {
        my $indent = $1;
        my $var = $2;
        my $assign = $3;
        if ($line =~ /if test (\S+) = (\S+)/){
            print "$indent", "if ('$var' eq '$assign')"; 
        } else {
            print "$indent", "if ($var '$assign')";
        }
        print "{\n";
        #if there is if inside if 
         while ($line = <>){
            next if $line =~ /^then/;
            if ($line =~ /^(\s*)elif test (\S+) = (\S+)/){
                my $indent = $1;
                my $var = $2;
                my $assign = $3;    
                print "$indent", "} elsif ('$var' eq '$assign')";
                print "{\n";
            } elsif($line =~ /^(\s*)elif \[ (\-[a-zA-Z]+) (\S+) \]/){
                my $indent = $1;
                my $var = $2;
                my $assign = $3;    
                print "$indent", "} elsif ('$var' eq '$assign')";
                print "{\n";
            } elsif ($line =~ /^(\s*)else/){
                my $indent = $1;
                print "$indent", "} else {\n";
                next;
            }
            last if $line =~ /^(\s*)fi/;
            basic($line);
        
        }
        if ($line =~ /^(\s*)fi/){
            print "$1", "}\n";
        }        
    } 
}


sub basic{
    my($line) = @_;
    reads($line);
    comments($line);
    systems($line);
    echo ($line);
    assign_var($line);
    cd($line);
    exit_code($line);
    local_($line);
    and_($line);
    return_($line);
}

sub exit_code{
    my ($line) = @_;
    if($line =~ /^(\s*)exit (.*)/){
        #indent could be null
        my $indent = $1;
        my $num = $2;
        print "$indent", "exit $num;\n";
    }
}

sub reads{
    my ($line) = @_;
    if ($line =~ /^(\s*)read (.*)/){
        #indent could be null
        my $indent = $1; 
        my $content = $2;
        print "$indent", "\$$content = <STDIN>;\n";
        print "$indent", "chomp \$$content;\n";   
    }
}

sub sub_transform{
    my ($line) = @_;
    if ($line =~ /^(\S+)\(\)\s*\{/){
        my $sub_name = $1;
        print "sub $sub_name";
        print "{\n";
        while ($line = <>){
            basic($line);
            for_loop($line);
            if_case($line);
            while_loop($line);
            last if $line =~ /^\}/;
        }
        print "}\n";
    }
}

sub local_{
    my ($line) = @_;
    if ($line =~  /^(\s*)local (\w+) (\w+)/){
        my $indent = $1;
        print "$indent", "my \(\$$2, \$$3\);\n";    
    }
}


#examples/4/primes.sh
sub and_{
    my ($line) = @_;
    #is_prime $i && echo $i
     if ($line =~ /^(\s*)test (.*) && (.*)/){
        my $indent = $1;
        print "$indent";
        my $left = $2;
        my $right = $3;
        if(my($a,$b,$c,$d,$e) = $left =~ /\$\(\((.*) (.*) (.*)\)\) (.*) (.*)/){
            print "\$$a $b \$$c ";
            print "$hash{$d} $e and ";
            basic($right);
        }
     #test $((n % i)) -eq 0 && return 1
    } elsif ($line =~ /^(.*) && (.*)/){
        print "$1 or ";
        basic($2); 
    }
}

sub return_{
    my ($line) = @_;
    if ($line =~ /^(\s*)return (\d+)/){
        print "$1", "return $2;\n";
    }
}
