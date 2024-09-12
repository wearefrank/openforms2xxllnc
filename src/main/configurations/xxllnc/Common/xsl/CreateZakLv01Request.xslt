<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:StUF="http://www.egem.nl/StUF/StUF0301" version="2.0">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:param name="Stuurgegevens" as="node()?" />
    <xsl:param name="Parameters" as="node()?" />
    <xsl:param name="Gelijk" as="node()?" />
    <xsl:param name="Scope" as="node()?" />
   
	<xsl:template match="/">
        <zakLv01>
            <xsl:copy-of select="$Stuurgegevens/stuurgegevens" />
            <xsl:copy-of select="$Parameters/parameters" />
            <xsl:copy-of select="$Gelijk/gelijk" />
            <xsl:copy-of select="$Scope/scope" />
        </zakLv01>
	</xsl:template>
</xsl:stylesheet>
