#!/usr/bin/env bash

# unique-titles.sh - initialize a table with title values; hard-coded


# make sane
mkdir -p ./tmp
rm -rf ./tmp/titles.sql

# extract titles
xsltproc ./etc/list-titles.xsl ./xml/bk210_2_3/title.xml  > ./tmp/titles.txt
#xsltproc ./etc/list-titles.xsl ./xml/bk210_2_4/title.xml >> ./tmp/titles.txt

# make sure each title is unique
cat ./tmp/titles.txt | sort | uniq > ./etc/titles-unique.txt

# generate insert statements
cat ./etc/titles-unique.txt | while read TITLE; do
	echo "INSERT INTO titles ( 'title' ) VALUES ( '$TITLE' );" >> ./tmp/titles.sql
done

# fill the database
cat ./tmp/titles.sql | sqlite3 ./etc/books.db