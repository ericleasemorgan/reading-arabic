#!/usr/bin/env bash

# unique-titles.sh - initialize a table with title values; hard-coded


# make sane
mkdir -p ./tmp
rm -rf ./tmp/titles.sql

# extract titles
xsltproc ./etc/titles2sql.xsl ./xml/bk210_2_3/title.xml  > ./tmp/titles.sql

# fill the database
cat ./tmp/titles.sql | sqlite3 ./etc/books.db