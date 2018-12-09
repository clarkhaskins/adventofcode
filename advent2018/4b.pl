#!/bin/perl

use strict;
use warnings;
my $filename = '4sorted.txt';
my $count = 0;
my %guard;
my $currentguard;
my $lastsleep=-1;
open(my $fh, '<:encoding(UTF-8)', $filename)
or die "Could not open file '$filename' $!";
while (my $row = <$fh>) {
chomp $row;
my $minute = substr($row,15,2);
my $date = substr($row,6,5);
if(substr($row,25,1) eq '#') {
#if($lastsleep != -1) {
  #for( my $x =$lastsleep;$x<$minute;$x++)
  ##{
    #$guard{$currentguard}{$date}{$x}="SLEEP";
  #}
#}
$lastsleep = -1;
my ($shit,$secondhalf) = split(/#/,$row);
($currentguard,$shit) = split(/ /,$secondhalf);
#print "$currentguard\n";

#for(my $c=0;$c<60;$c++) {
#$guard{$currentguard}{$date}{$c}="AWAKE";
#}
}
if ($row =~ m/wake/) 
{
if($lastsleep != -1) {
  for( my $x = $lastsleep;$x<$minute;$x++)
  {
    $guard{$currentguard}{$date}{$x}="SLEEP";
  }
}
$lastsleep = -1;
}
if ($row =~ m/sleep/) 
{
$lastsleep = $minute;
}
}
my $totalsleep=0;
my $topguard;
my $maxminute=0;
my $maxsleeps=0;
my $min=0;
foreach my $g (keys %guard) {
  for($min=0;$min<60;$min++) {
  my $currentsleeps=0;
  foreach my $date (keys %{ $guard{$g}}) {
    $currentsleeps++ if($guard{$g}{$date}{$min} eq "SLEEP");
    }
   if($currentsleeps > $maxsleeps) {
   $maxsleeps=$currentsleeps;
   $maxminute=$min;
   $topguard=$g;
 }
  }
}
print "Topguard = $topguard with $maxsleeps in minute $maxminute\n";

