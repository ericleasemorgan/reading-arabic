#!/usr/bin/env bash

# txt2pos.sh - given a list of txt files, output part-of-speech files

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame; distributed under a GNU Public License

# October 24, 2020 - first investigations


# configure
INPUTDIRECTORY='madamira/input-files'
MADAMIRA='madamira'
OUTPUTDIRECTORY='madamira/output-files'
SERVER='java -Xmx2500m -Xms2500m -XX:NewRatio=3 -jar madamira.jar -s'
TXT='txt'
PREFIX='./etc/template-prefix.xml'
SUFFIX='./etc/template-suffix.xml'
CLIENT='java -Xmx2500m -Xms2500m -XX:NewRatio=3 -jar madamira.jar -c'

# initialize
HOME=$( pwd )

# start and wait for the server
cd $MADAMIRA
$SERVER &
PID=$!
sleep 30

# make sane
cd $HOME

# process each txt file
find "$HOME/$TXT" -name "*.txt" | while read FILE; do

	# make sane
	cd $HOME

	# re-initialize
	BASENAME=$( basename $FILE .txt )
	INPUTFILE="$HOME/$INPUTDIRECTORY/$BASENAME.xml"
	OUTPUTFILE="$HOME/$OUTPUTDIRECTORY/$BASENAME.xml"

	# debug
	#echo $INPUTFILE >&2
	#echo $OUTPUTFILE >&2
	
	# create input file
	cat $PREFIX >  $INPUTFILE
	cat $FILE   >> $INPUTFILE
	cat $SUFFIX >> $INPUTFILE

	# debug
	#cat $INPUTFILE >&2

	# build the client command and execute it
	CMD="$CLIENT -i $INPUTFILE -o $OUTPUTFILE"
	cd $MADAMIRA
	$CMD 
		
	# debug
	#cat $OUTPUTFILE >&2

done

# stop the server and done
kill $PID
exit

