#!/bin/perl

use strict;
use warnings;
my $filename = '5.txt';
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
my $startlen = length($string);
my $minlen = $startlen;
foreach my $letter('a'..'z') {
 my $teststring = $string;
 my $ucletter = uc $letter;
 $teststring =~ s/$letter//g;
 $teststring =~ s/$ucletter//g;
my $fs = reduce($teststring);
$slen = length($fs);
$minlen= $slen if( $slen < $minlen);

}

print "String is $minlen long, we removed stuff $count times\n";
#print "String is $fs\n";


sub reduce{
 my ($s) = @_;
for my $i (0..length($s)-1){
    my $char = substr($s, $i, 1);
    my $char2 = substr($s, $i+1, 1);
#print "Char 1 is $char Char 2 is $char2\n";
#print "String is now $s" if($i==length($s)-2);
return($s) if($i==length($s)-2);

if($char ne $char2) {
if(($char eq uc $char2)||($char eq lc $char2)) {
#print "We can remove shit\n $char and $char2\n";
$count++;
substr($s,$i,2)="";
#print "$s\n";
return reduce($s);
}
}
}

}
