<xsl:stylesheet exclude-result-prefixes="xs xsl zgw" version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xmlns:zgw="http://google.com/zgw"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    >
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes" exclude-result-prefixes="xsi"/>
    <xsl:mode on-no-match="deep-skip" on-multiple-match="fail"/>
    
    <xsl:template match="/">
        <xsl:apply-templates select="//*[starts-with(name(), 'uw-gegevens')]"/>
    </xsl:template>

    <xsl:template match="//*[starts-with(name(), 'uw-gegevens')]">
        <xsl:element name="{local-name()}">
            <xsl:choose>
                <xsl:when test="lower-case(initiatingSubject) = 'persoon' or lower-case(bentUEenPersoonOfEenBedrijf) = 'persoon'">
                    <xsl:choose>
                        <xsl:when test="lower-case(initiatingSubjectAuth) = 'digid'">
                            <xsl:copy-of select="fieldSetMetDigiD" />
                        </xsl:when>
                        <xsl:when test="lower-case(initiatingSubjectAuth) != 'digid'">
                            <xsl:copy-of select="fieldSetZonderDigiD" />
                        </xsl:when>
                        <xsl:otherwise />
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="lower-case(initiatingSubject) = 'bedrijf' or lower-case(bentUEenPersoonOfEenBedrijf) = 'bedrijf'">
                    <xsl:choose>
                        <xsl:when test="lower-case(initiatingSubjectAuth) = 'eherkenning'">
                            <xsl:copy-of select="fieldSetBedrijfMEH" />
                        </xsl:when>
                        <xsl:when test="lower-case(initiatingSubjectAuth) != 'eherkenning'">
                            <xsl:copy-of select="fieldSetBedrijfZEH" />
                        </xsl:when>
                        <xsl:otherwise />
                    </xsl:choose>
                </xsl:when>
            </xsl:choose>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>