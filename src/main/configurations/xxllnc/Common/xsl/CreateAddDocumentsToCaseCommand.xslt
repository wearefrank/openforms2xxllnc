<xsl:stylesheet exclude-result-prefixes="xs xsl zgw" version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xmlns:zgw="http://google.com/zgw"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    >
    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes" exclude-result-prefixes="xsi"/>
    <xsl:mode on-no-match="deep-skip" on-multiple-match="fail"/>

    <xsl:param name="CaseReferenceNumber" select="''" as="xs:string" />
    <xsl:param name="Provider" as="node()?" />
    <xsl:param name="CommaSeperatedUrls" select="''" as="xs:string" />
    
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="/">
        <AddDocumentsToCaseCommand>
            <CaseReferenceNumber><xsl:value-of select="$CaseReferenceNumber"/></CaseReferenceNumber>
            <xsl:copy-of select="$Provider"/>
            <xsl:for-each select="tokenize($CommaSeperatedUrls, ',')">
                <url><xsl:value-of select="current()" /></url>
            </xsl:for-each>
        </AddDocumentsToCaseCommand>
    </xsl:template>
</xsl:stylesheet>