# NAME

Astro::WCS::PP  --  WCS conversion utilities (Pure Perl)

# VERSION

3.0 (2014/11/11)

# SYNOPSYS

use Astro::WCS::PP;



In the following, $hdr is a hash ref containing a FITS header; in
practice, assuming that files are read using rfits() from PDL it
means:
 $hdr = $image->hdr;      \# for images
  or
 $hdr = $event->{hdr};    \# for FITS tables aka event files

RA and Dec are always in degrees (with decimals).

## Projections for images

### Using CDELTn

    ($ra,$dec) = wcs_img_pix2radec($hdr,$x,$y)  # pixel to world

    ($x,$y) = wcs_img_radec2pix($hdr,$ra,$dec)  # world to pixel

    (NB: rotations [CROTA2] not yet implemented)

### Using the CD matrix

    ($ra,$dec) = wcs_cd_pix2radec($hdr,$x,$y)  # pixel to world

    ($x,$y) = wcs_cd_radec2pix($hdr,$ra,$dec)  # world to pixel
             # This function depends on PDL::Slatec
             # for matrix inversion

## Gnomonic projections for event files

Conversion between "physical pixels" and RA,Dec.

    ($ra,$dec) = wcs_evt_pix2radec($hdr,$x,$y)  #  phys.pixel to world

    ($x,$y) = wcs_evt_radec2pix($hdr,$ra,$dec)  # world to phys.pixel



## Tangent plane projections

    ($ra,$dec) = wcs_tan_pix2radec($hdr,$x,$y)  #  pixel to world, rarely useful

    ($phys_x,$phys_y) = wcs_tan_L_pix2radec($hdr,$x,$y)
        # pixel to physical_pixel using CRPIX1L keywords etc.



# DESCRIPTION

This module implements some WCS conversion functions in pure Perl, and
is PDL compatible. The formulae are taken from the FITS WCS definition
by Calabretta & Greisen 2002 (A&A 395,1077).

Several different possibilities exist to insert WCS information in
FITS headers, only a few of which are currently implemented. (Users
with needs not satisfied by this module might look for example at
Astro::WCS::LibWCS).

There is no code in this module to find out which routine should be
used given a random FITS file, though some guidelines are given
below. User inspection of the FITS header might be necessary.

This module uses PDL, if available, or Math::Trig as a fallback. One
routine (wcs\_cd\_radec2pix) only works is PDL and PDL::Slatec are
installed since it needs to invert a matrix.

The routines are divided according to the convention used to store the
WCS info in the FITS header files.

Note that using the "image" routines instead of the "event" ones when dealing
with an event file header (or viceversa) leads to division by zeroes
when trying to transform the reference pixel.

- \- __legacy__ or __AIPS__ convention

    Used by the Chandra (CIAO) and XMM-Newton (SAS) software for __images__.
    This convention uses the CRPIX\[12\], CDELT\[12\] and CRVAL\[12\] header keywords.
    Rotations (through the CROTA2 keyword) are not yet implemented.

- \- __CD__ convention

    Used e.g. by DS9 when saving images.

    This convention replaces CDELT\[12\] with the CDi\_j matrix. This module only
    supports 2D (bidimensional) images (and not event files) which require
    2x2 matrices.  The inversion of the matrix is needed for the inverse transform
    (ra,dec => x,y); PDL::Slatec is currently used for this
    purpose.

- \- __event files__ use a different projection

    XMM-Newton event files use different keywords (TCRPX\[12\], TCDLT\[12\],
    TCRVL\[12\]) and a different ("gnomonic") projection. Hence specialised
    routines are provided for them.

    Also, while image "pixel" have a non-ambiguous definition, event files
    use "physical pixels" which broadly correspond to detector pixels
    (e.g., in Chandra, 1 phys.pixel = 1 detector pixel; in XMM-Newton, 5
    phys.pix = 1 PN pixel).



Images and event files require different formulae for the WCS conversion,
thus different functions are provided.

## Notes on individual functions

- ($x,$y) = __wcs\_evt\_radec2pix__($img->hdr,$ra,$dec)

    Gnomonic projection from Calabretta & Griesen (Eq.5); uses
    TCTYPn=="RA--TAN" or "DEC--TAN").

- ($ra,$dec) = __wcs\_cd\_pix2radec__($img,$x,$y)

    Using the "CD formalism" in Greisen & Calabretta 2002 (eq.3)
    and only valid for 2D images.

    This format is used e.g. by ds9 when saving FITS images.

- ($x,$y) = __wcs\_cd\_radec2pix__($img,$ra,$dec)

    Uses the "CD formalism" in Greisen & Calabretta 2002 (eq.3)
    and only valid for 2D images.
    This format is used by ds9 when saving FITS images.

    This function has a dependence on PDL::Slatec (for matrix inversion).

- ($phys\_x,$phys\_y) = __wcs\_tan\_L\_pix2radec__($img, $x, $y)

    WCS tranform on tangent plane.
    Uses CRPIX1L (and similar) instead of CRPIX1 etc. to return "physical" pixels

    This is the only routine that checks for the existence in the header of the
    necessary keywords, since they are not always present.

# BUGS

Functions are not checking for the existence of their needed keywords
(nor for the sanity of the input).

Tests are missing.

Only special cases are implemented here, while the FITS standard/AIPS
convention comprises many more projection types. Also, rotations are
only handled by the two routines using the CD matrix.

# TODO

- \# implement PCi\_j formalism, e.g. for IDL-generated images
- \# checks for keywords
- \# detection of formalism (CD or legacy)
- \# test cases

# HISTORY

3.0 -- 2014/11/11
  Public version. Package has been reorganised, input is consistent
  among all functions, function names have been changed.

2.31 -- 2013/8/11
  put in proper module distribution
  use strict and warnings experimentally turned on

2.3 -- 2012/7/19
  wcstransfinv now makes all calculations in radians. This addresses a
  strange bug which presents when fi~360 degrees => cos fi = 1 and
  which leads to wrong values of y in output.  In practice, it happens
  on the XMM-CDFS ratemap (whose WCS is that of a NicoNew's expmap)
  for values of (RA,DEC) = (53.1271160027375,-28.0729683940378).
  I think that all other functions should also immediately switch to radiants.

2.21 -- 2012/1/30
  tgwcs\* now require $hdr instead of $img

2.2 -- 2012/1/11
  Added tgwcstransfL and POD documentation.

2.1 -- sometime in 2011
  Added CD formalism.

2.0 -- 2010/6/17
  All code should now be PDL safe.

First functions written about year 2005.



# AUTHOR

Piero Ranalli, `<piero.ranalli at noa.gr>`

# BUGS

Please report any bugs or feature requests to `pranalli-github@gmail.com`.



# SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Astro::WCS::PP
