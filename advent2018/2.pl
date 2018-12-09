#!/bin/perl

use strict;
use warnings;
my $filename = '2.txt';
my $count = 0;
my %twos;
my %threes;
open(my $fh, '<:encoding(UTF-8)', $filename)
or die "Could not open file '$filename' $!";
while (my $row = <$fh>) {
chomp $row;
foreach my $char (split //, $row) {

my @results = $row =~ /$char/g;
my $count = @results;
$twos{$row} = 1 if $count == 2;
$threes{$row} = 1 if $count == 3;
}

}
my $two = keys %twos;
my $three = keys %threes;
my $multiplier = $two * $three;

print "Twos: $two\n Threes: $three\n Checksum: $multiplier\n";

