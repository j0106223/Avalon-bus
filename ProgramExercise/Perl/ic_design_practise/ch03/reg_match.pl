#!/usr/bin/perl
my $str1 = "aAcABC";
if ($str1 =~ /AB/){
    print "match\n";
} else {
    print "unmatch\n";
}

exit 0;