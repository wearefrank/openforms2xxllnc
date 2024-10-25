<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:StUF="http://www.egem.nl/StUF/StUF0301" xmlns:ZKN="http://www.egem.nl/StUF/sector/zkn/0310" xmlns:xmime="http://www.w3.org/2005/05/xmlmime" version="2.0">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:param name="DocumentIdentificatie"/>
    <xsl:param name="DctOmschrijving"/>
    <xsl:param name="Base64Inhoud"/>
    <xsl:param name="CaseReferenceNumber"/>
    <xsl:param name="CaseDescription"/>
    <xsl:param name="CaseTypeDescription"/>
    <xsl:param name="CaseTypeCode"/>

    <xsl:template match="/">
        <ZKN:object StUF:entiteittype="EDC" StUF:verwerkingssoort="T">
            <ZKN:identificatie><xsl:value-of select="$DocumentIdentificatie"/></ZKN:identificatie>
            <ZKN:dct.omschrijving><xsl:value-of select="$DctOmschrijving"/></ZKN:dct.omschrijving>
            <ZKN:creatiedatum><xsl:value-of select="format-date(ZgwEnkelvoudigInformatieObject/creatiedatum, '[Y0001][M01][D01]')"/></ZKN:creatiedatum>
            <xsl:choose>
                <xsl:when test="ZgwEnkelvoudigInformatieObject/ontvangstdatum != ''" >
                    <ZKN:ontvangstdatum><xsl:value-of select="format-date(ZgwEnkelvoudigInformatieObject/ontvangstdatum, '[Y0001][M01][D01]')"/></ZKN:ontvangstdatum>
                </xsl:when>
            </xsl:choose>
            <ZKN:titel><xsl:value-of select="ZgwEnkelvoudigInformatieObject/titel"/></ZKN:titel>
            <xsl:choose>
                <xsl:when test="ZgwEnkelvoudigInformatieObject/beschrijving != ''">
                    <ZKN:beschrijving><xsl:value-of select="ZgwEnkelvoudigInformatieObject/beschrijving"/></ZKN:beschrijving>
                </xsl:when>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="ZgwEnkelvoudigInformatieObject/formaat != ''">
                    <ZKN:formaat><xsl:value-of select="ZgwEnkelvoudigInformatieObject/formaat"/></ZKN:formaat>
                </xsl:when>
            </xsl:choose>
            <ZKN:taal><xsl:value-of select="ZgwEnkelvoudigInformatieObject/taal"/></ZKN:taal>
            <ZKN:versie><xsl:value-of select="ZgwEnkelvoudigInformatieObject/versie"/></ZKN:versie>
            <xsl:choose>
                <xsl:when test="ZgwEnkelvoudigInformatieObject/status != ''">
                    <ZKN:status><xsl:value-of select="$statusMap(ZgwEnkelvoudigInformatieObject/status)"/></ZKN:status>
                </xsl:when>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="ZgwEnkelvoudigInformatieObject/verzenddatum != ''" >
                    <ZKN:verzenddatum><xsl:value-of select="format-date(ZgwEnkelvoudigInformatieObject/verzenddatum, '[Y0001][M01][D01]')"/></ZKN:verzenddatum>
                </xsl:when>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="ZgwEnkelvoudigInformatieObject/vertrouwelijkheidaanduiding != ''">
                    <ZKN:vertrouwelijkAanduiding><xsl:value-of select="ZgwEnkelvoudigInformatieObject/vertrouwelijkheidaanduiding"/></ZKN:vertrouwelijkAanduiding>
                </xsl:when>
            </xsl:choose>
            <ZKN:auteur><xsl:value-of select="ZgwEnkelvoudigInformatieObject/auteur"/></ZKN:auteur>
            <xsl:choose>
                <xsl:when test="ZgwEnkelvoudigInformatieObject/link != ''">
                    <ZKN:link><xsl:value-of select="ZgwEnkelvoudigInformatieObject/link"/></ZKN:link>
                </xsl:when>
            </xsl:choose>
            <ZKN:inhoud>
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
            </ZKN:inhoud>
            <ZKN:isRelevantVoor StUF:entiteittype="EDCZAK" StUF:verwerkingssoort="T">
                <ZKN:gerelateerde StUF:entiteittype="ZAK" StUF:verwerkingssoort="I">
                    <ZKN:identificatie><xsl:value-of select="$CaseReferenceNumber"/></ZKN:identificatie>
                    <ZKN:omschrijving><xsl:value-of select="$CaseDescription"/></ZKN:omschrijving>
                    <ZKN:isVan StUF:entiteittype="ZAKZKT">
                        <ZKN:gerelateerde StUF:entiteittype="ZKT">
                            <ZKN:omschrijving><xsl:value-of select="$CaseTypeDescription"/></ZKN:omschrijving>
                            <ZKN:code><xsl:value-of select="$CaseTypeCode"/></ZKN:code>
                        </ZKN:gerelateerde>
                    </ZKN:isVan>
                </ZKN:gerelateerde>
            </ZKN:isRelevantVoor>
          </ZKN:object>
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
