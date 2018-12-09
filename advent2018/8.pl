#!/bin/perl

use strict;
use warnings;
my $filename = '8test.txt';
my $count = 0;
my $string;
my $startlen=0;

open(my $fh, '<:encoding(UTF-8)', $filename)
or die "Could not open file '$filename' $!";
while (my $row = <$fh>) {
chomp $row;
$string = $row;
}
my $slen;
$startlen = length($string);
my @array = split(/ /,$string);

my ($leng,$metaSum)=doit(@array);

print "We are done! Length is $leng Metadata is $metaSum\n";


sub doit {
   my @a = @_;
   #print "A is @a\n";
   if(scalar(@a) > 0) {
   my $nodes = shift @a;
   my $metadatacount = shift @a;
   my @remaining = @a;
  ###print "nodes is $nodes, metadatacount is $metadatacount\n";
   my $offset=2;
   my $metadataSum=0;
   
   for(my $x=0;$x<$nodes;$x++)
	{
		my ($childOffset,$ChildMetadataSum) = (0,0);
	   ($childOffset,$ChildMetadataSum,@remaining) = doit(@remaining);	
      $offset += $childOffset;
      $metadataSum +=$ChildMetadataSum;
	}
   my $localmetadataSum=0;
   for(my $y=0;$y<$metadatacount;$y++)
	{
      my $metadata = shift @remaining;
      $offset++;
      $localmetadataSum += $metadata;
	}
   $metadataSum += $localmetadataSum;
   #print "Local Metadata is $localmetadataSum, Metadata sum is now $metadataSum\n";
   return ($offset,$metadataSum,@remaining);
  }
  return (0,0,undef);

}
