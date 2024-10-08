<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:StUF="http://www.egem.nl/StUF/StUF0301" xmlns:ZKN="http://www.egem.nl/StUF/sector/zkn/0310" version="2.0">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
   
	<xsl:template match="/">
        <ZKN:parameters>
            <StUF:mutatiesoort>T</StUF:mutatiesoort>
            <StUF:indicatorOvername>V</StUF:indicatorOvername>
        </ZKN:parameters>
	</xsl:template>
</xsl:stylesheet>
