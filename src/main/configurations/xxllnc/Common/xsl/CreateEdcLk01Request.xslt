<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:StUF="http://www.egem.nl/StUF/StUF0301" xmlns:xmime="http://www.w3.org/2005/05/xmlmime" version="2.0">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:param name="Stuurgegevens" as="node()?" />
    <xsl:param name="Parameters" as="node()?" />
    <xsl:param name="Object" as="node()?" />
   
	<xsl:template match="/">
        <edcLk01 xmlns="http://www.egem.nl/StUF/sector/zkn/0310">
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
                <StUF:mutatiesoort><xsl:value-of select="$Parameters/parameters/mutatiesoort"/></StUF:mutatiesoort>
                <StUF:indicatorOvername><xsl:value-of select="$Parameters/parameters/indicatorOvername"/></StUF:indicatorOvername>
            </parameters>
            <object StUF:entiteittype="EDC">
                <identificatie><xsl:value-of select="$Object/object/identificatie"/></identificatie>
                <dct.omschrijving>Brief</dct.omschrijving> <!-- Test purposes -->
                <creatiedatum><xsl:value-of select="$Object/object/creatiedatum"/></creatiedatum>
                <ontvangstdatum><xsl:value-of select="$Object/object/ontvangstdatum"/></ontvangstdatum>
                <titel><xsl:value-of select="$Object/object/titel"/></titel>
                <beschrijving><xsl:value-of select="$Object/object/beschrijving"/></beschrijving>
                <formaat><xsl:value-of select="$Object/object/formaat"/></formaat>
                <taal><xsl:value-of select="$Object/object/taal"/></taal>
                <versie><xsl:value-of select="$Object/object/taal"/></versie>
                <status><xsl:value-of select="$Object/object/status"/></status>
                <verzenddatum><xsl:value-of select="$Object/object/verzenddatum"/></verzenddatum>
                <vertrouwelijkAanduiding><xsl:value-of select="$Object/object/vertrouwelijkAanduiding"/></vertrouwelijkAanduiding>
                <auteur><xsl:value-of select="$Object/object/auteur"/></auteur>
                <link><xsl:value-of select="$Object/object/link"/></link>
                <inhoud>
                    <xsl:attribute name="StUF:bestandsnaam"><xsl:value-of select="ZgwEnkelvoudigInformatieObject/bestandsnaam"/></xsl:attribute>
                    <xsl:if test="ZgwEnkelvoudigInformatieObject/formaat != ''">
                        <xsl:attribute name="xmime:contentType"><xsl:value-of select="ZgwEnkelvoudigInformatieObject/formaat"/></xsl:attribute>
                    </xsl:if>
                    <xsl:value-of select="$Object/object/inhoud"/>
                </inhoud>
                <isRelevantVoor StUF:entiteittype="EDCZAK" StUF:verwerkingssoort="T">
                    <gerelateerde StUF:entiteittype="ZAK" StUF:verwerkingssoort="I">
                        <identificatie><xsl:value-of select="$Object/object/isRelevantVoor/gerelateerde/identificatie"/></identificatie>
                        <omschrijving><xsl:value-of select="$Object/object/isRelevantVoor/gerelateerde/omschrijving"/></omschrijving>
                    </gerelateerde>
                </isRelevantVoor>
            </object>
        </edcLk01>
	</xsl:template>
</xsl:stylesheet>