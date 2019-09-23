#!/usr/bin/env bash

# configure
INITIALIZEDB='./bin/initialize-db.sh'
BOOK2DB='./bin/book2db.sh'
XML='./xml'

# initialize
$INITIALIZEDB

# do the work for all books
find $XML -type d -exec $BOOK2DB {} \;

# done
exit

