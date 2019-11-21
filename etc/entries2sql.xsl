<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version='1.0'>

<!--

    entries2sql.xsl - given a specific XML, output SQL
	
    Eric Lease Morgan <emorgan@nd.edu>
    September 4, 2019

-->
  
	<xsl:output method="text" />

	<xsl:template match='dataroot'>
		<xsl:for-each select='//book'>
			<xsl:text>INSERT INTO entries ('eid', 'entry' ) VALUES ('</xsl:text>
			<xsl:value-of select='./id' />
			<xsl:text>', '</xsl:text>
			<xsl:value-of select='./nass' />
			<xsl:text>');&#10;</xsl:text>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>
