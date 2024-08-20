<xsl:stylesheet xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:StUF="http://www.egem.nl/StUF/StUF0301" version="2.0">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:param name="Stuurgegevens" as="node()?" />
    <xsl:param name="Parameters" as="node()?" />
    <xsl:param name="Gelijk" as="node()?" />
    <xsl:param name="Scope" as="node()?" />
   
	<xsl:template match="/">
        <zakLv01 xmlns="http://www.egem.nl/StUF/sector/zkn/0310">
            <stuurgegevens>
                <StUF:berichtcode><xsl:value-of select="$Stuurgegevens/stuurgegevens/berichtcode"/></StUF:berichtcode>
                <StUF:zender>
                    <StUF:organisatie><xsl:value-of select="$Stuurgegevens/stuurgegevens/zender/organisatie"/></StUF:organisatie>
                    <StUF:applicatie><xsl:value-of select="$Stuurgegevens/stuurgegevens/zender/applicatie"/></StUF:applicatie>
                </StUF:zender>
                <StUF:ontvanger>
                    <StUF:organisatie><xsl:value-of select="$Stuurgegevens/stuurgegevens/ontvanger/organisatie"/></StUF:organisatie>
                    <StUF:applicatie><xsl:value-of select="$Stuurgegevens/stuurgegevens/ontvanger/applicatie"/></StUF:applicatie>
                </StUF:ontvanger>
                <StUF:referentienummer><xsl:value-of select="$Stuurgegevens/stuurgegevens/referentienummer"/></StUF:referentienummer>
                <StUF:tijdstipBericht><xsl:value-of select="$Stuurgegevens/stuurgegevens/tijdstipBericht"/></StUF:tijdstipBericht>
                <StUF:entiteittype><xsl:value-of select="$Stuurgegevens/stuurgegevens/entiteittype"/></StUF:entiteittype>
            </stuurgegevens>
            <parameters>
                <StUF:sortering><xsl:value-of select="$Parameters/parameters/sortering"/></StUF:sortering>
                <StUF:indicatorVervolgvraag><xsl:value-of select="$Parameters/parameters/indicatorVervolgvraag"/></StUF:indicatorVervolgvraag>
            </parameters>
            <gelijk StUF:entiteittype="ZAK">
                <identificatie><xsl:value-of select="$Gelijk/gelijk/identificatie"/></identificatie>
            </gelijk>
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
        </zakLv01>
	</xsl:template>
</xsl:stylesheet>