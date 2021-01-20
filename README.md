# Reading Arabic

This is a little system used to read some Arabic texts for the ultimate purpose of creating a network diagram illustrating what places were influential to other places from the texts. This system ought to work on any sane version of Linux / Mac OS X, but you will need an additional system called MADAMIRA in order to parse the given texts into parts-of-speech values. [1]

Here's the quickest of recipes:

1. In this repository's root directory, create a directory named ./txt.

2. Fill the ./txt directory with plain text files where each filename starts with a region (egypt, syria, iraq, etc.); keep the file names very simple sans any spaces because each file name will become a database key.

3. Download MADAMIRA and save it in the root directory of this repository, and rename the directory "madamira".

4. Rename the MADAMIRA jar file to madamira.jar; the purpose of renaming the files is to make the system's code easier to read.

5. Do parts-of-speech extraction with the command ./bin/txt2pos.sh; this command will: 1) launch MADAMIRA in server mode, 2) loop through all the files in the corpora directory, 3) convert each plain text file into a simple XML file, 4) feed the XML file to MADAMIRA, 5) MADAMIRA will do its work, and 6) save the results in the ./madamira/output-files directory; it might be good idea to delete the contents ./madamira/output-files before you begin.

6. Transform the results of the previous step into sets of SQL insert statements with ./bin/xml2sql.sh; the secret sauce in this step is ./bin/xml2sql.pl which uses XPath technology to parse the files resulting from Step #5; the result of this step ought to be sets of files named "inserts_*.sql" in the ./tmp directory. 

7. Initialize the database with ./bin/initialize-db.sh; note that the schema for this database is ./etc/schema-tokens.sql, and this step ought to result in the creation of an empty SQLite database file, ./etc/tokens.db. 

8. Fill the database with the result of Step #6 using ./bin/words2db.sh; you now ought to be able to query the database file, and look to ./etc/cookbook.sql for the tiniest of introductions. 

9. Finally, run ./bin/entries2network.sh for each region, and redirect the results to a file; you may want to edit the script's configuration in order to denote different sets of places; the result of this command is in the from of a TSV file called an "edges table", and this file can be used as input to Gephi and to create the visualization of a network -- our "raison d'être". 

That's all for now.

[1] MADAMIRA is/was authored by Mohamed Elbadrashiny &lt;badrashiny@gmail.com&gt;, and it was downloaded from https://drive.google.com/open?id=1unHLBVR59Dg0txqNpXz9tDu4c0P7Vxom. The system works quite well, but such a URL is quite likely to break. Alas.

--  
Eric Lease Morgan &lt;emorgan@nd.edu&gt;  
January 20, 2021