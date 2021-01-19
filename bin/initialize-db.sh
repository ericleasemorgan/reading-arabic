#!/usr/bin/env bash

DATABASE='./etc/tokens.db'
SCHEMA='./etc/schema-tokens.sql'

rm -rf $DATABASE
cat $SCHEMA | sqlite3 $DATABASE
exit
