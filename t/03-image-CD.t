#!perl 
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

#use Math::Trig qw/atan asin acos/;
use Astro::WCS::PP;

use t::TestHelper;


# how many test we can run depends on wether we have PDL::Slatec installed

my $ntests = 2;
my $slatec = 0;
eval { require PDL; };
unless ($@) {
    # we have PDL; now check for Slatec
    eval { require PDL::Slatec; };
    unless ($@) {
	# we also have PDL::Slatec
	$ntests += 2;
	$slatec = 1;
    }
}

plan tests => $ntests;


diag( "Testing image routines (CD convention)" );

my $hdr = read_hdr('t/sample-CD-header.txt');


ok(
   mytest( \&wcs_cd_pix2radec, $hdr, [123, 405], [5.670719, 0.36751199], 3e-3 ),
   "wcs_cd_pix2radec"
  );

ok(
   mytest( \&wcs_cd_pix2radec, $hdr, [576, 52], [5.6088078, 0.31926867], 3e-3 ),
   "wcs_cd_pix2radec"
  );

if ($slatec) {
    ok(
       mytest( \&wcs_cd_radec2pix, $hdr, [5.6088078, 0.31926867], [576, 52], 3e-3 ),
       "wcs_cd_radec2pix"
      );

    ok(
       mytest( \&wcs_cd_radec2pix, $hdr, [5.670719, 0.36751199], [123, 405], 3e-3 ),
       "wcs_cd_radec2pix"
      );
}



