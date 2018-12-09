#!/bin/perl

use strict;
use warnings;
my $filename = '1.txt';
my $count = 0;
my $iterationcount= 0;
my %results;
my $done =0;
while(!$done) {
open(my $fh, '<:encoding(UTF-8)', $filename)
or die "Could not open file '$filename' $!";
while ((!$done) && ( my $row = <$fh>)) {
chomp $row;
#print "$row\n";
my $operator = substr $row,0,1;
my $number = substr $row,1;
print "OPERATOR: " . $operator . "\n";
print "NUMBER: " . $number . "\n";
if($operator eq '+') 
{
print "made it";
	$count += $number;
}
if($operator eq '-') 
{
	$count -= $number;
}
if(exists $results{$count}) {
  $done =1 ;
print "WE ARE DONE: $count\n!!!!!!!!!!!!!!!!"
}
else {
$results{$count}=1;
}
print "COUNT " . $count . "\n";
}

}

