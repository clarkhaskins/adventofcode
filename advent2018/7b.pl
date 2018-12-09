#!/bin/perl

use strict;
use warnings;
use threads;
my $filename = '7.txt';
my $count = 0;
my %steps;
my $totalworkers=5;
open(my $fh, '<:encoding(UTF-8)', $filename)
or die "Could not open file '$filename' $!";
while (my $row = <$fh>) {
chomp $row;
my $prereq = substr($row,5,1);
my $step = substr($row,36,1);
 my @array;
 my @emptyarray;
 push @array,$prereq;
# print "step $step prereq $prereq\n";
 $steps{$step}{"pre"}{$prereq} = 1;
 $steps{$prereq}{"pre"}=undef  if(!exists $steps{$prereq}{"pre"});

}

my @start = noprereqs();

print "We will start here: @start\n";
my $done=0;
my @workers;
my @WorkerRemaining;
for(my $n=0;$n<$totalworkers;$n++)
{
  $workers[$n]=0;
  $WorkerRemaining[$n]=-1;
}
my $currentworker=0;
my $tick=0;
while(!$done) {
@start = noprereqs();
print "Tick is $tick\n";
print "Possible work is @start\n";
for(my $n=0;$n<$totalworkers;$n++)
{
  print "Worker $n has $WorkerRemaining[$n] on $workers[$n]\n"; 
  if($WorkerRemaining[$n] ==0) {
  print "$n just finished $workers[$n]\n";
  doit($workers[$n]);
  $workers[$n]=0;
  @start = noprereqs();
  $WorkerRemaining[$n]=-1;
  $n=0;
  }
  if($WorkerRemaining[$n] <=0)
  {
    my $goodwork=-1;
    for(my $i=0;$i<scalar(@start);$i++) {
     $goodwork=$i;
     for(my $x=0;$x<$totalworkers;$x++) {
       $goodwork=-1 if($workers[$x] eq $start[$i]); 
    }
    if($goodwork > -1) {
    $workers[$n] = $start[$goodwork]; 
    $WorkerRemaining[$n] = ord($start[$goodwork]) -4;
  print "Starting Worker $n has $WorkerRemaining[$n] on $workers[$n]\n"; 
    }
   }
  }
}
$done = 1 if(scalar (@start) eq 0);
if($done !=1) {
for(my $n=0;$n<$totalworkers;$n++)
{
   $WorkerRemaining[$n]--;
}
$tick++;
}
}
for(my $n=0;$n<$totalworkers;$n++)
{
  print "WORKER $n: $workers[$n]\n";
}
 
print "\nIt took $tick with $totalworkers workers\n";

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
   my $avalue = ord($currentstep) -64;
 print "spending $avalue\n";
   delete($steps{$currentstep});
   foreach my $step (keys %steps) {
     delete $steps{$step}{"pre"}{$currentstep};
   }
   return ($avalue);

}
