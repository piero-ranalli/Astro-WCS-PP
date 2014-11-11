package t::TestHelper;

use Exporter;
@ISA = 'Exporter';

# most useful functions:
@EXPORT = qw/mytest read_hdr/;


sub mytest {
    my ($function,$hdr,$input,$expected,$epsilon) = @_;


    my ($out0,$out1) = &$function( $hdr, @$input );

    #warn "$out0 $out1";

    if (($out0 - $$expected[0]) < $epsilon and
	($out1 - $$expected[1]) < $epsilon
       ) {
	return 1;
    } else {
	return 0;
    }
}


sub read_hdr {
    my $f = shift;
    my %hdr;

    open (my $fh, '<', $f) or die "cannot open $f\n";
    while (my $card = <$fh>) {
	chomp($card);
	# remove comments
	$card =~ s|/.*$||;

	my $key = substr $card, 0, 8;
	my $val = substr $card, 9;

	# remove trailing spaces
	$key =~ s|\s+$||;
	$val =~ s|\s+$||;

	$hdr{$key} = $val;
    }

    return \%hdr;
}


1;
