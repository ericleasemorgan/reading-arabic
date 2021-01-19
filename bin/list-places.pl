#!/usr/bin/env perl

# list-places.pl - given one or more XML files of a specific shape, output a frequency list of locations

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame; distributed under a GNU Public License

# December 21, 2020 - first cut


# configure
use constant HEADER => "count\tlocation\n";

# require
use XML::XPath;
use strict;

# get input
my @files = @ARGV;
if ( ! @files ) { die "Usage: $0 <file [ file file ... ]>\n" }

# initialize
my %tokens = ();
binmode( STDOUT, ":utf8" );
binmode( STDERR, ":utf8" );

# start output
print HEADER;

# process each input file
for my $file ( @files ) {

	# re-initialize
	my $parser = XML::XPath->new( filename => $file );

	# find and process each location
	my $locations = $parser->find( '//ne[@type="LOC"]' );
	foreach my $location ( $locations->get_nodelist ) {
	
		# find and process each token
		my $tokens = $location->find( './tok/@form0' );
		foreach my $token ( $tokens->get_nodelist ) {
	
			# debug
			warn $token->string_value, "\n";
		
			# update the list of places
			$tokens{ $token->string_value }++;
		
		}
			
	}

}

# process each place
foreach my $token ( sort { $tokens{ $b } <=> $tokens{ $a } } keys %tokens ) {

	# get the count and output ordered list
	my $count = $tokens{ $token };
	print join( "\t", ( $count, $token ) ), "\n";

}

# done
exit;
