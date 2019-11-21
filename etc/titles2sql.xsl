<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl='http://www.w3.org/1999/XSL/Transform' version='1.0'>

<!--

    title2sql.xsl - given a specific XML, output SQL
	
    Eric Lease Morgan <emorgan@nd.edu>
    September 4, 2019

-->
  
	<xsl:output method="text" />

	<xsl:template match='dataroot'>
		<xsl:for-each select='//title'>
			<xsl:text>INSERT INTO titles ('tid', 'title') VALUES ('</xsl:text>
			<xsl:value-of select='./id' />
			<xsl:text>', '</xsl:text>
			<xsl:value-of select='./tit' />
			<xsl:text>');&#10;</xsl:text>
		</xsl:for-each>
	</xsl:template>

</xsl:stylesheet>
