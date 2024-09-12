<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:StUF="http://www.egem.nl/StUF/StUF0301" xmlns:xmime="http://www.w3.org/2005/05/xmlmime" version="2.0">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:param name="Stuurgegevens" as="node()?" />
    <xsl:param name="Parameters" as="node()?" />
    <xsl:param name="Object" as="node()?" />
   
	<xsl:template match="/">
        <edcLk01>
            <xsl:copy-of select="$Stuurgegevens/stuurgegevens" />
            <xsl:copy-of select="$Parameters/parameters" />
            <xsl:copy-of select="$Object/object" />
        </edcLk01>
	</xsl:template>
</xsl:stylesheet>
