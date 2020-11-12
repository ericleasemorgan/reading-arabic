#!/usr/bin/env perl

# configure
use constant TITLES  => './etc/titles.tsv';
use constant ENTRIES => './etc/entries.tsv';
use constant SKIPS   => ( 1, 18, 97, 148, 169, 627, 745 );

# require
use strict;

# initialize
my %titles  = ();
my %entries = ();
my %skips   = ();
for my $skip ( SKIPS ) { $skips{ $skip }++ }

# slurp up the titles
open FILE, " < " . TITLES or die "Can't open titles ($!)\n";
while ( <FILE> ) {

	chop;
	my $record = $_;
	my ( $tid, $title ) = split( "\t", $record );
	$titles{ $tid }     = $title;

}
close FILE;

# slurp up the entries
open FILE, " < " . ENTRIES or die "Can't open entries ($!)\n";
while ( <FILE> ) {

	chop;
	my $record = $_;
	my ( $eid, $entry ) = split( "\t", $record );
	$entries{ $eid }    = $entry;

}
close FILE;

# debug
#foreach my $tid ( sort { $a <=> $b } keys( %titles ) )  { my $title = $titles{ $tid };  warn "    tid: $tid\n"; warn "  title: $title\n"; warn "\n" }
#foreach my $eid ( sort { $a <=> $b } keys( %entries ) ) { my $entry = $entries{ $eid }; warn "    eid: $eid\n"; warn "  entry: $entry\n"; warn "\n" }

# initialize
my $offset = 0;
my @tids   = sort { $a <=> $b } keys( %titles );
my @eids   = sort { $a <=> $b } keys( %entries );

# process each title identifier
for ( my $i = 0; $i < scalar @tids; $i++ )  {

	# re-initialize
	my $tid   = $tids[ $i ];
	my $title = $titles{ $tid };
	my $size  = 0;
	
	# increment, conditionally
	if ( $skips{ $tid } ) { $offset++ }

	# calculate entry identifier
	my $eid = $tid + $offset;

	# calculate size; trap for last item
	my $size = 0;
	my $neid = 0;
	if ( ( $i + 1 ) == ( scalar @tids ) ) { 
	
		$neid = $eids[ ( scalar @eids ) - 1 ];
		$size = $neid - $eid + 1;
		
	}
	
	# calculate size; tricky!
	else {
	
		my $ntid = $tids[ $i + 1 ];
		if ( $skips{ $ntid } ) { $neid = $ntid + $offset + 1 }
		else { $neid = $ntid + $offset }
		$size = $neid - $eid;
		
	}
	
	# build the entry
	my $entry = '';
	
	# trap for last item; grrr 
	if ( ( $i + 1 ) == ( scalar @tids ) ) { 
		for ( my $s = $eid; $s <= $neid; $s++ ) { $entry .= $entries{ $s } . "\n\n" }
	}
	
	# update normally
	else { for ( my $s = $eid; $s < $neid; $s++ ) { $entry .= $entries{ $s } . "\n\n"; } }

	# output in a book-like manner
	print "–––––––––––––––––––––––\n";
	print "$title\n\n";
	print "$entry\n";
	print "\f";

}


exit;
