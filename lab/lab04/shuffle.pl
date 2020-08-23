#!/usr/bin/perl -w

while ($line = <STDIN>){
    push (@arr,$line);
}


while (@arr > 0){
    $n = int(rand($#arr));
    #print "line 10: $#arr   n:$n\n";
    #swap
    $temp=$arr[$n];
    $arr[$n] = $arr[0];
    $arr[0]= $temp; #always put in the zero position and shift it
    print(shift(@arr));#remove and return the first element from an array

}
