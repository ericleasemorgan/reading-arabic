#!/usr/bin/env bash

# configure
INITIALIZEDB='./bin/initialize-db.sh'
BOOK2DB='./bin/book2db.sh'
XML='./xml'

# initialize
$INITIALIZEDB

# create table of titles and entries
./bin/titles2sql.sh
./bin/entries2sql.sh

# done
exit

