<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:StUF="http://www.egem.nl/StUF/StUF0301" xmlns:xmime="http://www.w3.org/2005/05/xmlmime" version="2.0">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:param name="Base64Inhoud"/>
    <xsl:param name="CaseReferenceNumber"/>
    <xsl:param name="CaseDescription"/>
    <xsl:param name="CaseTypeDescription"/>
    <xsl:param name="CaseTypeCode"/>

    <xsl:template match="/">
        <object StUF:entiteittype="EDC">
            <xsl:choose>
                <xsl:when test="ZgwEnkelvoudigInformatieObject/identificatie != ''" >
                    <identificatie><xsl:value-of select="ZgwEnkelvoudigInformatieObject/identificatie"/></identificatie>
                </xsl:when>
            </xsl:choose>
            <!-- <dct.omschrijving>Brief</dct.omschrijving> --> <!-- Test purposes-->
            <creatiedatum><xsl:value-of select="format-date(ZgwEnkelvoudigInformatieObject/creatiedatum, '[Y0001][M01][D01]')"/></creatiedatum>
            <xsl:choose>
                <xsl:when test="ZgwEnkelvoudigInformatieObject/ontvangstdatum != ''" >
                    <ontvangstdatum><xsl:value-of select="format-date(ZgwEnkelvoudigInformatieObject/ontvangstdatum, '[Y0001][M01][D01]')"/></ontvangstdatum>
                </xsl:when>
            </xsl:choose>
            <titel><xsl:value-of select="ZgwEnkelvoudigInformatieObject/titel"/></titel>
            <xsl:choose>
                <xsl:when test="ZgwEnkelvoudigInformatieObject/beschrijving != ''">
                    <beschrijving><xsl:value-of select="ZgwEnkelvoudigInformatieObject/beschrijving"/></beschrijving>
                </xsl:when>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="ZgwEnkelvoudigInformatieObject/formaat != ''">
                    <formaat><xsl:value-of select="ZgwEnkelvoudigInformatieObject/formaat"/></formaat>
                </xsl:when>
            </xsl:choose>
            <taal><xsl:value-of select="ZgwEnkelvoudigInformatieObject/taal"/></taal>
            <versie><xsl:value-of select="ZgwEnkelvoudigInformatieObject/versie"/></versie>
            <xsl:choose>
                <xsl:when test="ZgwEnkelvoudigInformatieObject/status != ''">
                    <status><xsl:value-of select="$statusMap(ZgwEnkelvoudigInformatieObject/status)"/></status>
                </xsl:when>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="ZgwEnkelvoudigInformatieObject/verzenddatum != ''" >
                    <verzenddatum><xsl:value-of select="format-date(ZgwEnkelvoudigInformatieObject/verzenddatum, '[Y0001][M01][D01]')"/></verzenddatum>
                </xsl:when>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="ZgwEnkelvoudigInformatieObject/vertrouwelijkheidaanduiding != ''">
                    <vertrouwelijkAanduiding><xsl:value-of select="ZgwEnkelvoudigInformatieObject/vertrouwelijkheidaanduiding"/></vertrouwelijkAanduiding>
                </xsl:when>
            </xsl:choose>
            <auteur><xsl:value-of select="ZgwEnkelvoudigInformatieObject/auteur"/></auteur>
            <xsl:choose>
                <xsl:when test="ZgwEnkelvoudigInformatieObject/link != ''">
                    <link><xsl:value-of select="ZgwEnkelvoudigInformatieObject/link"/></link>
                </xsl:when>
            </xsl:choose>
            <inhoud>
                <xsl:choose>
                    <xsl:when test="ZgwEnkelvoudigInformatieObject/bestandsnaam != ''">
                        <xsl:attribute name="StUF:bestandsnaam"><xsl:value-of select="ZgwEnkelvoudigInformatieObject/bestandsnaam"/></xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="StUF:bestandsnaam">no-name-provided</xsl:attribute>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="ZgwEnkelvoudigInformatieObject/formaat != ''">
                    <xsl:attribute name="xmime:contentType"><xsl:value-of select="ZgwEnkelvoudigInformatieObject/formaat"/></xsl:attribute>
                </xsl:if>
                <xsl:value-of select="$Base64Inhoud"/>
            </inhoud>
            <isRelevantVoor StUF:entiteittype="EDCZAK" StUF:verwerkingssoort="T">
                <gerelateerde StUF:entiteittype="ZAK" StUF:verwerkingssoort="I">
                    <identificatie><xsl:value-of select="$CaseReferenceNumber"/></identificatie>
                    <omschrijving><xsl:value-of select="$CaseDescription"/></omschrijving>
                    <isVan StUF:entiteittype="ZAKZKT">
                        <gerelateerde StUF:entiteittype="ZKT">
                            <omschrijving><xsl:value-of select="$CaseTypeDescription"/></omschrijving>
                            <code><xsl:value-of select="$CaseTypeCode"/></code>
                        </gerelateerde>
                    </isVan>
                </gerelateerde>
            </isRelevantVoor>
          </object>
    </xsl:template>

    <xsl:variable name="statusMap" as="map(*)">
        <xsl:map>
          <xsl:map-entry key="'in_bewerking'" select="'In bewerking'" />
          <xsl:map-entry key="'ter_vaststelling'" select="'Ter vaststelling'" />
          <xsl:map-entry key="'definitief'" select="'Definitief'" />
          <xsl:map-entry key="'gearchiveerd'" select="'Gearchiveerd'" />
        </xsl:map>
      </xsl:variable>
</xsl:stylesheet>