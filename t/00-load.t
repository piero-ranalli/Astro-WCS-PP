#!perl 
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'WCS2' ) || print "Bail out!\n";
}

diag( "Testing WCS2 $WCS2::VERSION, Perl $], $^X" );
