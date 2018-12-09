#!/bin/perl

use strict;
use warnings;
my $filename = '3.txt';
my @fabric;
my %claims;
my $cx=0;
my $cy=0;
while ($cy < 1000) {
while ($cx < 1000) {

$fabric[$cx][$cy]=0;
#print "$fabric[$cx][$cy] ";
$cx++;
}
#print "\n";
$cy++;
$cx=0;
}
open(my $fh, '<:encoding(UTF-8)', $filename)
or die "Could not open file '$filename' $!";
while (my $row = <$fh>) {
chomp $row;
my ($claim,$shit,$position,$size) = split(/ /,$row);
($position,$shit) = split(/:/,$position);
my ($x,$y)= split(/,/,$position);
#print "CLAIM $claim POSITION $position Size $size\n";
my ($width,$height)= split(/x/,$size);

#print "$claim $x $y $height $width \n";
 $cx=0;
 $cy=0;
while ($cy < $height) {
while ($cx < $width) {

$fabric[$x+$cx][$y+$cy]++;
$cx++;
}
$cx=0;
$cy++;

}
}
open(my $fh, '<:encoding(UTF-8)', $filename)
or die "Could not open file '$filename' $!";
while (my $row = <$fh>) {
chomp $row;
my ($claim,$shit,$position,$size) = split(/ /,$row);
($position,$shit) = split(/:/,$position);
my ($x,$y)= split(/,/,$position);
#print "CLAIM $claim POSITION $position Size $size\n";
my ($width,$height)= split(/x/,$size);

#print "$claim $x $y $height $width \n";
 $cx=0;
 $cy=0;
my $fucked=0;
while ($cy < $height) {
while ($cx < $width) {

$fucked=1 if ($fabric[$x+$cx][$y+$cy] > 1);
$cx++;
}
$cx=0;
$cy++;

}
#print "fucked claim is $claim" if $fucked==1;
print "Winning claim is $claim" if $fucked==0;
}
