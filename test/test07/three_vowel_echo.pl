#!/usr/bin/perl -w

#need to pay attention to lower and upper case
for $arg(@ARGV){
   $argl = lc($arg);
   if( $argl =~ /[aeiou]{3}/){   
      print $arg," "
   
   }
}
print "\n"
