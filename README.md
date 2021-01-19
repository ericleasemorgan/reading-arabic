# Reading Arabic

This is a little system used to read some Arabic texts for the ultimate purpose of creating a network diagram illustrating what places were influential to other places from the texts. This system ought to work on an sane version of Linux / Mac OS X, but you will need an additional system called MADAMIRA in order to parse the given text into parts-of-speech values. 

Here's the quickest of recipes:

1. create subdirectories in the corpora directory, each denoting a different region
2. fill the subdirectories with plain text files, each with simple a file name because the file name will become a database key
3. download MADAMIRA save it in the root directory of the system with the name "madamira"
4. rename the MADAMIRA jar file to madamira.jar; the purpose of renaming the file is to make the system's code easier to read
5. do parts-of-speech extraction with the command ./bin/txt2pos.sh; this command will: 1) launch MADAMIRA in server mode, 2) loop through all the files in the corpora directory, 3) convert each plain text file into a simple XML file, 4) feed the XML file to MADAMIRA, 5) MADAMIRA will do its work, and 6) save the results in the ./madamira/output-files directory
6. transform the results of the previous step into sets of SQL insert statements with ./bin/xml2sql.sh; the secret sauce in this step is ./bin/xml2sql.pl which uses XPath technology to parse files resulting from Step #5; the result of this step ought to be sets of files named "inserts_*.sql" in the ./tmp directory
7. initialize the database with ./bin/initialize-db.sh; note that the schema for this database is ./etc/schema-tokens.sql, and this step ought to result in the creation of an SQLite database file, ./etc/tokens.db
8. fill the database with the result of Step #6 with ./bin/words2db.sh; you now ought to be able to query the database file, and look to ./etc/cookbook.sql for the tiniest of introductions
9. finally, run ./bin/entries2network.sh for each region and save the results to a file; you may want to edit this files configuration in order to denote different sets of places; the result of this command is a from of an TSV file called an "edges table", and this file can be input to Gephi to create the visualization of network

That's all for now.

--  
Eric Lease Morgan &lt;emorgan@nd.edu&gt;
January 19, 2021