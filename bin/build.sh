#!/usr/bin/env bash

# configure
INITIALIZEDB='./bin/initialize-db.sh'
BOOK2DB='./bin/book2db.sh'
XML='./xml'

# initialize
$INITIALIZEDB

# initialize titles table
./bin/unique-titles.sh

# process each desired book
$BOOK2DB ./xml/bk210_2_3
#$BOOK2DB ./xml/bk210_2_4

# done
exit

