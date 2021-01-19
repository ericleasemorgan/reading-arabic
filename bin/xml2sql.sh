#!/usr/bin/env bash

# xml2sql.sh - a front-end to xml2sql.pl

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame; distributed under a GNU Public License

# January 13, 2021 - first cut; written because cluster was full


# configure
XML='./madamira/output-files'
TMP='./tmp'
XML2SQL='./bin/xml2sql.pl'

# initialize
ITEM=0
rm -rf "$TMP/inserts_*"

# get a list of all the files to process
readarray -t FILES < <( find $XML -name "*.xml" )

# process each file
for FILE in "${FILES[@]}"; do

	# do the work
	$XML2SQL ${FILES[$ITEM]} > $TMP/inserts_$ITEM.sql
    
    # increment
    ITEM=$((ITEM+1))
    
# fini
done
exit
