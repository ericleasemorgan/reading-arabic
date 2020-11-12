#!/usr/bin/env perl

# configure
use constant TITLES    => './etc/titles.tsv';
use constant ENTRIES   => './etc/entries.tsv';
use constant SKIPS   => ( 1, 18, 97, 148, 169, 627, 745 );
use constant DIRECTORY => './txt';

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

my $offset = 0;
foreach my $tid ( sort { $a <=> $b } keys( %titles ) )  {

	# re-initialize
	my $title = $titles{ $tid };
	
	# increment, conditionally
	if ( $skips{ $tid } ) { $offset++ }

	# calculate entry identifier
	my $eid   = $tid + $offset;
	my $entry = $entries{ $eid };
	
	# book-like output
	warn "    tid: $tid\n";
	warn "  title: $title\n";
	warn "    eid: $eid\n";
	warn "  entry: $entry\n";
	warn "\n";
	warn "\n";
	
	open FILE, " > " . DIRECTORY . "/$tid.txt" or die "Can't open file ($!)";
	print FILE "$title\n$entry";
	close FILE;
	

}


exit;
