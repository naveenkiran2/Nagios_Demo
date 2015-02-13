#!/usr/bin/perl
use strict;
open(FILE, ">>", "/usr/local/nagios/myeventhandler.log") or die "$!";
print FILE "myhandler: $ARGV[0] : $ARGV[1] : $ARGV[2]\n";
close FILE;
print "DONE!";