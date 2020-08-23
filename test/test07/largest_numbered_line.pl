#!/usr/bin/perl -w


my @result=();
my $largest=-100000;



while($line = <STDIN>){
#select the number
   while ($line =~ /(-?\d+(\.\d+)?)/g){
   #one is the every new input 
      if($largest == -100000 || $1 > $largest){         
         $largest =  $1;         
         @result=($line); #if find larger,replace
      }elsif ($1 == $largest) {
         push(@result,$line);      
      }
   }
}
print @result;

#my $largest_line_num = (sort {$b <=> $a} @lines_numbers)[0];

