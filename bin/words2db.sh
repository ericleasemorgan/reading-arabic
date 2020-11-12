#!/usr/bin/env bash

# words2db.sh - given a list of SQL statements, update a database

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame; distributed under a GNU Public License

# November 12, 2020 - first cut; like so many other scripts


# configure
TRANSACTION='./tmp/tokens-transaction.sql'
INSERTS='./tmp/inserts_*.sql'
DB='./etc/books.db'

# create transaction
echo 'BEGIN TRANSACTION;' >  $TRANSACTION
echo 'DELETE FROM tokens;' >> $TRANSACTION
cat $INSERTS              >> $TRANSACTION
echo 'END TRANSACTION;'   >> $TRANSACTION

# do the work and done
cat $TRANSACTION | sqlite3 $DB
exit
