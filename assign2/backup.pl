 elsif (($line =~ /^(\s*)if test (\S+) (-[a-z]+) (\S+)/){
        my $indent = $1;
        my $var = $2;
        my $operator = $3;
        my $assign = $4;
        print "$indent", "if ($var $hash{$operator} $assign)";       
    }
