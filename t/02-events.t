#!perl 
use 5.006;
use strict;
use warnings FATAL => 'all';
use Test::More;

#use Math::Trig qw/atan asin acos/;
use Astro::WCS::PP;

use t::TestHelper;

plan tests => 4;


diag( "Testing event file routines" );

my $hdr = read_hdr('t/sample-event-header.txt');  # a Chandra event file


ok(
   mytest( \&wcs_evt_pix2radec, $hdr, [627, 626], [6.1129458, -0.13130597], 3e-3 ),
   "wcs_evt_pix2radec"
  );

ok(
   mytest( \&wcs_evt_pix2radec, $hdr, [3778, 3921], [5.682199, 0.31885862], 3e-3 ),
   "wcs_evt_pix2radec"
  );

ok(
   mytest( \&wcs_evt_radec2pix, $hdr, [6.1129458, -0.13130597], [626, 627], 3e-3 ),
   "wcs_evt_radec2pix"
  );

ok(
   mytest( \&wcs_evt_radec2pix, $hdr, [5.682199, 0.31885862], [3778, 3921], 3e-3 ),
   "wcs_evt_radec2pix"
  );
