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
my $maxsleep = 0;
my $topguard;
my $min=0;
foreach my $g (keys %guard) {
  foreach my $date (keys %{ $guard{$g}}) {
    for($min=0;$min<60;$min++) {
print "min is $min\n";
    $totalsleep++ if($guard{$g}{$date}{$min} eq "SLEEP");
    }
  }
  if($totalsleep > $maxsleep) {
	$topguard=$g;
        $maxsleep = $totalsleep;
}
$totalsleep=0;
}
my @minutes;
for($min=0;$min<60;$min++)
{  $minutes[$min]=0;
}
  foreach my $date (keys %{ $guard{$topguard}}) {
    for($min=0;$min<60;$min++) {
    $minutes[$min]++ if($guard{$topguard}{$date}{$min} eq "SLEEP");
    }
  }
my $topminute =0;
my $maxminutes=0;
for($min=0;$min<60;$min++)
{
   if( $minutes[$min] > $maxminutes) {
   $topminute = $min;
   $maxminutes=$minutes[$min];
}
}


print "Topguard = $topguard with $maxsleep minutes top minute is $topminute with $maxminutes occurrences\n";

