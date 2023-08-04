#!/usr/bin/perl
@vars1 = ("abc","cba","bac");

print 'last index of @vars is ', $#vars1, "\n";

#return how many elements in the array

$numofvars = scalar @vars1;

print '@var has ', $numofvars, " elements\n";