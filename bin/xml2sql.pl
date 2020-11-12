#!/afs/crc.nd.edu/user/e/emorgan/bin/perl

# xml2sql.pl - given one or more XML files, output sets of SQL statements

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame; distributed under a GNU Public License

# November 12, 2020 - first cut; like many other scripts; at the cabin as the water is drained


# configure
use constant TEMPLATE => "INSERT INTO tokens ( 'did', 'tid', 'token', 'lemma', 'pos', 'gloss' ) VALUES ( '##DID##', '##TID##', '##TOKEN##', '##LEMMA##', '##POS##', '##GLOSS##' );";

# require
use strict;
use XML::XPath;
use File::Basename;

# make I/O sane
binmode( STDERR, ':utf8' );
binmode( STDOUT, ':utf8' );

# get input
my @files = @ARGV;
if ( ! @files ) { die "Usage: $0 <file> [<file> <file> <file>...]\n" }

# process each of the given files
for my $file ( @files ) {

	# (re-)initialize
	my $did    = basename( $file, ( '.xml' ) );
	my $parser = XML::XPath->new( filename => $file );

	# find and process each word
	my $words = $parser->find( '//word' );
	foreach my $word ( $words->get_nodelist ) {

		# parse
		my $tid   = $word->find( './@id' )->string_value;
		my $token = $word->find( './@word' )->string_value;
		my $lemma = $word->find( './analysis/morph_feature_set/@lemma' )->string_value;
		my $gloss = $word->find( './analysis/morph_feature_set/@gloss' )->string_value;
		my $pos   = $word->find( './analysis/morph_feature_set/@pos' )->string_value;
	
		# increment the identifier; zero-based indexes won't really work for us
		$tid = $tid + 1;
	
		# normalize the lemma; might be a mistake
		$lemma =~ s/\d//;
		$lemma =~ s/_//;
	
		# escape
		$lemma =~ s/'/''/g;
		$gloss =~ s/'/''/g;
		
		# debug
		warn "    did: $did\n";
		warn "    tid: $tid\n";
		warn "  token: $token\n";
		warn "  lemma: $lemma\n";
		warn "    pos: $pos\n";
		warn "  gloss: $gloss\n";
		warn "\n";
		
		# build the SQL
		my $sql =  TEMPLATE;
		$sql    =~ s/##DID##/$did/e;
		$sql    =~ s/##TID##/$tid/e;
		$sql    =~ s/##TOKEN##/$token/e;
		$sql    =~ s/##LEMMA##/$lemma/e;
		$sql    =~ s/##POS##/$pos/e;
		$sql    =~ s/##GLOSS##/$gloss/e;
		
		# output
		print "$sql\n";
		
	}

}

# done
exit;