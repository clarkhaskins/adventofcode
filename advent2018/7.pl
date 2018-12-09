#!/bin/perl

use strict;
use warnings;
my $filename = '7.txt';
my $count = 0;
my %steps;
open(my $fh, '<:encoding(UTF-8)', $filename)
or die "Could not open file '$filename' $!";
while (my $row = <$fh>) {
chomp $row;
my $prereq = substr($row,5,1);
my $step = substr($row,36,1);
 my @array;
 my @emptyarray;
 push @array,$prereq;
 print "step $step prereq $prereq\n";
 $steps{$step}{"pre"}{$prereq} = 1;
 $steps{$prereq}{"pre"}=undef  if(!exists $steps{$prereq}{"pre"});

}

my @start = noprereqs();

print "We will start here: @start\n";
doit(@start);
print "\n";

sub noprereqs {
   my @list;
   foreach my $step (keys %steps) {
     my $size = keys %{$steps{$step}{"pre"}};
     push @list,$step if($size == 0) ;
#     print "Step $step has prereq of $steps{$step}{'pre'}\n";
   }

  return sort @list;
}

sub doit {
   my ($currentstep) = @_;
   print $currentstep;
   delete($steps{$currentstep});
   foreach my $step (keys %steps) {
     delete $steps{$step}{"pre"}{$currentstep};
   }
   my ($nextstep,$shit) = noprereqs();
   doit($nextstep) if $nextstep;
}
