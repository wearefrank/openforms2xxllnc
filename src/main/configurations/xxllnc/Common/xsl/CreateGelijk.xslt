<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:StUF="http://www.egem.nl/StUF/StUF0301" xmlns:ZKN="http://www.egem.nl/StUF/sector/zkn/0310" version="2.0">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
    <xsl:param name="CaseReferenceNumber" as="xs:string" />
   
	<xsl:template match="/">
        <ZKN:gelijk StUF:entiteittype="ZAK">
            <ZKN:identificatie><xsl:value-of select="$CaseReferenceNumber"/></ZKN:identificatie>
        </ZKN:gelijk>
	</xsl:template>
</xsl:stylesheet>