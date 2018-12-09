#!/bin/perl

use strict;
use warnings;
my $filename = '6.txt';
my $count = 0;
my %field;
my %coordinates;
my $maxX=0;
my $maxY=0;
my $letter = 'a';
open(my $fh, '<:encoding(UTF-8)', $filename)
or die "Could not open file '$filename' $!";
while (my $row = <$fh>) {
chomp $row;
my ($x,$y) =split(/,/,$row);
$y =~ s/ //g;

#print "Letter is $letter X is $x Y is $y\n";
$letter++;
$coordinates{$letter}{'X'}=$x;
$coordinates{$letter}{'Y'}=$y;
$coordinates{$letter}{"SUM"}=0;
$field{$x}{$y}{"DISTANCE"}=0;
$field{$x}{$y}{"LETTER"}=$letter;
$maxX = $x if($x>$maxX);
$maxY = $y if($y>$maxY);
}
#print "Max X is $maxX and Y is $maxY\n";

for(my $currentX=0;$currentX<$maxX;$currentX++) {
  for(my $currentY=0;$currentY<$maxY;$currentY++) {
       my ($shortDist,$shortLetter) = findclosest($currentX,$currentY);
       my ($NextShortDist,$NextshortLetter) = findNextclosest($currentX,$currentY,$shortLetter);
       print "Shortest is $shortLetter with $shortDist, next is $NextshortLetter with $NextShortDist\n";
        if($shortDist != $NextShortDist) {
        $field{$currentX}{$currentY}{"DISTANCE"}=$shortDist;
        $field{$currentX}{$currentY}{"LETTER"}= $shortLetter;
        $coordinates{$field{$currentX}{$currentY}{"LETTER"}}{"SUM"}++;
#        print "$field{$currentX}{$currentY}{\"LETTER\"} just got another, SUM is $coordinates{$field{$currentX}{$currentY}{\"LETTER\"}}{"SUM"}\n";
     }
  }
}


for(my $currentX=0;$currentX<$maxX;$currentX++) {
#   removeEdge($field{$currentX}{0}{"LETTER"};
#   removeEdge($field{$currentX}{$maxY-1}{"LETTER"};
  $coordinates{$field{$currentX}{0}{"LETTER"}}{"SUM"}=0;
  $coordinates{$field{$currentX}{$maxY-1}{"LETTER"}}{"SUM"}=0;
}
for(my $currentY=0;$currentY<$maxY;$currentY++) {
#   removeEdge($field{0}{$currentY}{"LETTER"};
#   removeEdge($field{$maxX-1}{$currentY}{"LETTER"};
  $coordinates{$field{0}{$currentY}{"LETTER"}}{"SUM"}=0;
  $coordinates{$field{$maxX-1}{$currentY}{"LETTER"}}{"SUM"}=0;
}

my $maxLetter;
my $maxSum=0;
foreach my $letter (keys %coordinates) {
  $maxSum = $coordinates{$letter}{"SUM"} if( $coordinates{$letter}{"SUM"} > $maxSum);
  $maxLetter = $letter if( $coordinates{$letter}{"SUM"} > $maxSum);
}

print "The biggest letter is $letter with $maxSum spots\n";


sub findclosest {
    my ($x,$y) = @_;
    #print "Finding closest for $x,$y\n";
    my $shortestLetter;
    my $shortestDistance=1000000;  
foreach my $letter (keys %coordinates) {
    my $distance = abs($x - $coordinates{$letter}{'X'}) + abs($y - $coordinates{$letter}{'Y'});
    #print "$letter has coordinates $coordinates{$letter}{'X'},$coordinates{$letter}{'Y'}\n";
    $shortestLetter=$letter if ($distance < $shortestDistance);
    $shortestDistance=$distance if ($distance < $shortestDistance);
  }
  return ($shortestDistance,$shortestLetter);
}
sub findNextclosest {
    my ($x,$y,$shortletter) = @_;
    #print "Finding closest for $x,$y\n";
    my $shortestLetter;
    my $shortestDistance=1000000;  
foreach my $letter (keys %coordinates) {
   if($letter ne $shortletter) {
    my $distance = abs($x - $coordinates{$letter}{'X'}) + abs($y - $coordinates{$letter}{'Y'});
    #print "$letter has coordinates $coordinates{$letter}{'X'},$coordinates{$letter}{'Y'}\n";
    $shortestLetter=$letter if ($distance < $shortestDistance);
    $shortestDistance=$distance if ($distance < $shortestDistance);
  }
  }
  return ($shortestDistance,$shortestLetter);
}

sub removeEdge {
   my($EdgeLetter) = @_;
   for(my $currentX=0;$currentX<$maxX;$currentX++) {
  for(my $currentY=0;$currentY<$maxY;$currentY++) {
    if($field{$currentX}{$currentY}{"LETTER"} eq $EdgeLetter) {
      $field{$currentX}{$currentY}{"LETTER"} = "REMOVED"; 
    }
  }
}
}

