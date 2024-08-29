<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:StUF="http://www.egem.nl/StUF/StUF0301" version="2.0">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
   
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
                <StUF:referentienummer>9e6a337a-7b63-4ad7-ac10-d52a7305f1bb</StUF:referentienummer>
                <StUF:tijdstipBericht>20240808091258569</StUF:tijdstipBericht>
                <StUF:entiteittype>ZAK</StUF:entiteittype>
            </stuurgegevens>
	</xsl:template>
</xsl:stylesheet>