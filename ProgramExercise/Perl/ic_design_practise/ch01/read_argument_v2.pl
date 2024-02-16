#!/usr/bin/perl

my $opt;
my %value_of_opt;

for my $arg (@ARGV) {
    if ($arg =~/^-/) {
        $opt = $arg;
    } else {
        $value_of_opt{$opt} = $arg;
    }
}

for my $opt (keys %value_of_opt) {
    print "$opt => $value_of_opt{$opt}\n";
}

exit 0;