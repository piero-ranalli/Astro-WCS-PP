#!perl 
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

#use Math::Trig qw/atan asin acos/;
use Astro::WCS::PP;

use t::TestHelper;

plan tests => 4;


diag( "Testing image routines" );

my $hdr = read_hdr('t/sample-image-header.txt');


ok(
   mytest( \&wcs_img_pix2radec, $hdr, [1082, 2176], [136.44493, 1.6241122], 3e-3 ),
   "wcs_img_pix2radec"
  );

ok(
   mytest( \&wcs_img_pix2radec, $hdr, [403, 390], [137.19865, -0.35958821], 3e-3 ),
   "wcs_img_pix2radec"
  );

ok(
   mytest( \&wcs_img_radec2pix, $hdr, [136.44493, 1.6241122], [1082, 2176], 3e-3 ),
   "wcs_img_radec2pix"
  );

ok(
   mytest( \&wcs_img_radec2pix, $hdr, [137.19865, -0.35958821], [403, 390], 3e-3 ),
   "wcs_img_radec2pix"
  );




