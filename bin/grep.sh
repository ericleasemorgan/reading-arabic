#!/usr/bin/env bash

TITLES='./etc/titles.txt'
ENTRIES='./etc/entries.txt'


cat $TITLES | while read TID TITLE; do

	echo "title: $TITLE ($TID)"
	#grep "$TITLE" "$ENTRIES"
	
done