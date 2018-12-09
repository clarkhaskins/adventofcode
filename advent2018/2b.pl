#!/bin/perl

use strict;
use warnings;
my $filename = '2b.txt';
my @strings;
my $count =0;
open(my $fh, '<:encoding(UTF-8)', $filename)
or die "Could not open file '$filename' $!";
while (my $row = <$fh>) {
chomp $row;
push @strings,$row
}
#print @strings;
foreach my $string (@strings) {
 my @c1 = split(//,$string);
 foreach my $string2(@strings) {
 my @c2 = split(//,$string2);
 my $jkf = 0;
 my $differences =0;
# print "Comparing \n$string with \n$string2\n";
 while ($jkf < length($string)) {
 # print "$c1[$jkf] compared with $c2[$jkf]\n";
  if($c1[$jkf] ne $c2[$jkf]) {
  $differences++ ;
  #print "$c1[$jkf] is not $c2[$jkf]\n";
 }
#  print "$differences\n";
  $jkf++; 
}
if ($differences == 1) 
{
 #print "$string\n$string2";
  $jkf=0;
 while ($jkf < length($string)) {
 # print "$c1[$jkf] compared with $c2[$jkf]\n";
  if($c1[$jkf] eq $c2[$jkf]) {
  print $c1[$jkf];
 }
  $jkf++;
}
print "\n";
}}
$count++;
}


