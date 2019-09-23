#!/usr/bin/env bash

DATABASE='./etc/books.db'
SCHEMA='./etc/schema.sql'

rm -rf $DATABASE
cat $SCHEMA | sqlite3 $DATABASE
exit
