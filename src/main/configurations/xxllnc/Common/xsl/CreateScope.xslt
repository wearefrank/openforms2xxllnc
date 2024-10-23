<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:StUF="http://www.egem.nl/StUF/StUF0301" xmlns:ZKN="http://www.egem.nl/StUF/sector/zkn/0310" version="2.0">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
   
	<xsl:template match="/">
        <ZKN:scope>
            <ZKN:object StUF:entiteittype="ZAK">
                <ZKN:identificatie xsi:nil="true"/>
                <ZKN:omschrijving xsi:nil="true"/>
                <ZKN:toelichting xsi:nil="true"/>
                <ZKN:einddatum xsi:nil="true"/>
                <ZKN:isVan StUF:entiteittype="ZAKZKT">
                    <ZKN:gerelateerde StUF:entiteittype="ZKT">
                        <ZKN:omschrijving xsi:nil="true"/>
                        <ZKN:code xsi:nil="true"/>
                    </ZKN:gerelateerde>
                </ZKN:isVan>
                <ZKN:heeftAlsInitiator StUF:entiteittype="ZAKBTRINI">
                    <ZKN:gerelateerde/>
                </ZKN:heeftAlsInitiator>
            </ZKN:object>
        </ZKN:scope>
	</xsl:template>
</xsl:stylesheet>
