#!/usr/bin/env bash

# xml2sql.sh - a front-end to xml2sql.pl

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame; distributed under a GNU Public License

# January 13, 2021 - first cut; written because cluster was full
# January 20, 2021 - modified to work with an older version of Bash


# configure
XML='./madamira/output-files'
TMP='./tmp'
XML2SQL='./bin/xml2sql.pl'

# initialize
ITEM=0
rm -rf "$TMP/inserts_*"

# get a list of all the files to process: see http://bit.ly/3912rxd
FILES=()
while IFS=  read -r -d $'\0' FILE; do
    FILES+=( "$FILE" )
done < <( find $XML -name "*.xml" -print0 )

# process each file
for FILE in "${FILES[@]}"; do

	# do the work
	$XML2SQL ${FILES[$ITEM]} > $TMP/inserts_$ITEM.sql
    
    # increment
    ITEM=$((ITEM+1))
    
# fini
done
exit
