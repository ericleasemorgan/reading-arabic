<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version='1.0'>

<!--

    bookinfo2sql.xsl - given a specific XML, output SQL
	
    Eric Lease Morgan <emorgan@nd.edu>
    September 4, 2019

-->
  
	<xsl:output method="text" />

	<xsl:param name="root" select="root"/>

	<xsl:template match='dataroot'>
		<xsl:text>INSERT INTO books ( 'root', 'title' ) VALUES ('</xsl:text>
		<xsl:value-of select='$root' />
		<xsl:text>', '</xsl:text>
		<xsl:value-of select='./groupe/@title' />
		<xsl:text>');&#10;</xsl:text>
	</xsl:template>


</xsl:stylesheet>
