<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:StUF="http://www.egem.nl/StUF/StUF0301" version="2.0">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
   
	<xsl:template match="/">
        <scope>
            <object StUF:entiteittype="ZAK">
                <identificatie xsi:nil="true"/>
                <omschrijving xsi:nil="true"/>
                <toelichting xsi:nil="true"/>
                <isVan StUF:entiteittype="ZAKZKT">
                    <gerelateerde StUF:entiteittype="ZKT">
                        <omschrijving xsi:nil="true"/>
                        <code xsi:nil="true"/>
                    </gerelateerde>
                </isVan>
                <heeftAlsInitiator StUF:entiteittype="ZAKBTRINI">
                    <gerelateerde/>
                </heeftAlsInitiator>
            </object>
        </scope>
	</xsl:template>
</xsl:stylesheet>
