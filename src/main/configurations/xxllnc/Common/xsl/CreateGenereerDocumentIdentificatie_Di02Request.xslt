<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:StUF="http://www.egem.nl/StUF/StUF0301" xmlns:ZKN="http://www.egem.nl/StUF/sector/zkn/0310" xmlns:xmime="http://www.w3.org/2005/05/xmlmime" version="2.0">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:param name="Stuurgegevens" as="node()?" />
   
	<xsl:template match="/">
        <ZKN:genereerDocumentIdentificatie_Di02>
            <xsl:copy-of select="$Stuurgegevens/*:stuurgegevens" />
        </ZKN:genereerDocumentIdentificatie_Di02>
	</xsl:template>
</xsl:stylesheet>
