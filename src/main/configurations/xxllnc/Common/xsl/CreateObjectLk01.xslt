<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="2.0">
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    <xsl:param name="ZdsZaak"/>
    <xsl:param name="Base64Inhoud"/>

    <xsl:template match="/">
        <object>
            <identificatie><xsl:value-of select="ZgwEnkelvoudigInformatieObject/identificatie"/></identificatie>
            <creatiedatum><xsl:value-of select="format-date(ZgwEnkelvoudigInformatieObject/creatiedatum, '[Y0001][M01][D01]')"/></creatiedatum>
            <xsl:choose>
                <xsl:when test="string-length(ZgwEnkelvoudigInformatieObject/ontvangstdatum) > 0 and normalize-space(ZgwEnkelvoudigInformatieObject/ontvangstdatum) != 'null'" >
                    <ontvangstdatum><xsl:value-of select="format-date(ZgwEnkelvoudigInformatieObject/ontvangstdatum, '[Y0001][M01][D01]')"/></ontvangstdatum>
                </xsl:when>
                <xsl:otherwise>
                    <ontvangstdatum>00010101</ontvangstdatum>
                </xsl:otherwise>
            </xsl:choose>
            <titel><xsl:value-of select="ZgwEnkelvoudigInformatieObject/titel"/></titel>
            <xsl:choose>
                <xsl:when test="string-length(ZgwEnkelvoudigInformatieObject/beschrijving) > 0 and normalize-space(ZgwEnkelvoudigInformatieObject/beschrijving) != 'null'">
                    <beschrijving><xsl:value-of select="ZgwEnkelvoudigInformatieObject/beschrijving"/></beschrijving>
                </xsl:when>
            </xsl:choose>
            <xsl:choose>
            <xsl:when test="string-length(ZgwEnkelvoudigInformatieObject/formaat) > 0 and normalize-space(ZgwEnkelvoudigInformatieObject/formaat) != 'null'">
                    <formaat><xsl:value-of select="ZgwEnkelvoudigInformatieObject/formaat"/></formaat>
                </xsl:when>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="string-length(ZgwEnkelvoudigInformatieObject/taal) > 0 and normalize-space(ZgwEnkelvoudigInformatieObject/taal) != 'null'">
                    <taal><xsl:value-of select="ZgwEnkelvoudigInformatieObject/taal"/></taal>
                </xsl:when>
                <xsl:otherwise>
                    <taal><xsl:attribute name="xsi:nil">true</xsl:attribute></taal>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="string-length(ZgwEnkelvoudigInformatieObject/versie) > 0 and normalize-space(ZgwEnkelvoudigInformatieObject/versie) != 'null'">
                    <versie><xsl:value-of select="ZgwEnkelvoudigInformatieObject/versie"/></versie>
                </xsl:when>
                <xsl:otherwise>
                    <versie><xsl:attribute name="xsi:nil">true</xsl:attribute></versie>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:choose>
                <xsl:when test="string-length(ZgwEnkelvoudigInformatieObject/status) > 0 and normalize-space(ZgwEnkelvoudigInformatieObject/status) != 'null'">
                    <status><xsl:value-of select="$statusMap(ZgwEnkelvoudigInformatieObject/status)"/></status>
                </xsl:when>
                <xsl:otherwise>
                    <status><xsl:attribute name="xsi:nil">true</xsl:attribute></status>
                </xsl:otherwise>
            </xsl:choose>
            <verzenddatum><xsl:value-of select="format-date(ZgwEnkelvoudigInformatieObject/verzenddatum, '[Y0001][M01][D01]')"/></verzenddatum>
            <vertrouwelijkAanduiding><xsl:value-of select="upper-case(ZgwEnkelvoudigInformatieObject/vertrouwelijkheidaanduiding)"/></vertrouwelijkAanduiding>
            <auteur><xsl:value-of select="ZgwEnkelvoudigInformatieObject/auteur"/></auteur>
            <link><xsl:value-of select="ZgwEnkelvoudigInformatieObject/link"/></link>
            <inhoud><xsl:value-of select="$Base64Inhoud"/></inhoud>
            <isRelevantVoor>
                <gerelateerde>
                    <identificatie><xsl:value-of select="$ZdsZaak/zakLa01/antwoord/object/identificatie"/></identificatie>
                    <omschrijving><xsl:value-of select="$ZdsZaak/zakLa01/antwoord/object/omschrijving"/></omschrijving>
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