#!perl 
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Astro::WCS::PP' ) || print "Bail out!\n";
}

diag( "Testing Astro::WCS::PP $Astro::WCS::PP::VERSION, Perl $], $^X" );
