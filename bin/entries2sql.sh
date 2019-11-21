#!/usr/bin/env bash

# unique-titles.sh - initialize a table with title values; hard-coded


# make sane
mkdir -p ./tmp
rm -rf ./tmp/entries.sql

# extract titles
xsltproc ./etc/entries2sql.xsl ./xml/bk210_2_3/book.xml   > ./tmp/entries.sql

# fill the database
cat ./tmp/entries.sql | sqlite3 ./etc/books.db