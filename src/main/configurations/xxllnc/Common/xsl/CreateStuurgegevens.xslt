<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:StUF="http://www.egem.nl/StUF/StUF0301" version="2.0">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
    <xsl:param name="CorrelationId"/>
   
	<xsl:template match="/">
        <stuurgegevens>
            <StUF:berichtcode>Lv01</StUF:berichtcode>
            <StUF:zender>
                <StUF:organisatie>1900</StUF:organisatie>
                <StUF:applicatie>OpenForms2xxllnc</StUF:applicatie>
            </StUF:zender>
            <StUF:ontvanger>
                <StUF:organisatie>1900</StUF:organisatie>
                <StUF:applicatie>CDR</StUF:applicatie>
            </StUF:ontvanger>
            <StUF:referentienummer><xsl:value-of select="$CorrelationId"/></StUF:referentienummer>
            <StUF:tijdstipBericht><xsl:value-of select="format-dateTime(current-dateTime(), '[Y0001][M01][D01][H01][m01][s01]')"/></StUF:tijdstipBericht>
            <StUF:entiteittype>ZAK</StUF:entiteittype>
        </stuurgegevens>
	</xsl:template>
</xsl:stylesheet>
