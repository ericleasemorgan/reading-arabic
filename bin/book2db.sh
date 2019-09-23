#!/usr/bin/env bash

# configure
DATABASE='./etc/books.db'
BOOKINFO2SQL='./etc/bookinfo2sql.xsl'
TITLES2SQL='./etc/titles2sql.xsl'
ENTRIES2SQL='./etc/entries2sql.xsl'

# sanity check
if [[ ! $1 ]]; then
	echo "Usage: $0 <directory>" >&2
	exit
fi

# initialize
DIRECTORY=$1
ROOT=$( basename $DIRECTORY )
BOOKINFO="$DIRECTORY/bookinfo.info"
TITLES="$DIRECTORY/title.xml"
ENTRIES="$DIRECTORY/book.xml"

# create a book record
xsltproc --stringparam root "$ROOT" $BOOKINFO2SQL $BOOKINFO >&2
xsltproc --stringparam root "$ROOT" $BOOKINFO2SQL $BOOKINFO | sqlite3 $DATABASE

# get the id of the newly created record
BID=$( echo "SELECT bid FROM BOOKS ORDER BY bid DESC LIMIT 1;" | sqlite3 $DATABASE )

# initialize entry records
xsltproc --stringparam bid "$BID" "$TITLES2SQL" "$TITLES" >&2
xsltproc --stringparam bid "$BID" "$TITLES2SQL" "$TITLES" | sqlite3 $DATABASE

# update entry records
xsltproc --stringparam bid "$BID" "$ENTRIES2SQL" "$ENTRIES" >&2
xsltproc --stringparam bid "$BID" "$ENTRIES2SQL" "$ENTRIES" | sqlite3 $DATABASE

# done
exit

