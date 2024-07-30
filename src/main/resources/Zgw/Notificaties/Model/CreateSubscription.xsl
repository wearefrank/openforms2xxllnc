<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" version="2">
    <xsl:param name="callbackURL" select="''" as="xs:string" />
    <xsl:param name="authorization" select="''" as="xs:string" />
    <xsl:param name="producttype" select="''" as="xs:string" />

    <xsl:template match="/">
        <ZgwAbonnement>
            <callbackUrl>
                <xsl:value-of select="$callbackURL" />
            </callbackUrl>
            <auth>
                <xsl:value-of select="$authorization" />
            </auth>
            <kanalen>
                <xsl:if test="$producttype">
                    <filters>
                        <object_type>
                            <xsl:value-of select="$producttype" />
                        </object_type>
                    </filters>
                </xsl:if>
                <naam>objecten</naam>
            </kanalen>
        </ZgwAbonnement>
    </xsl:template>
</xsl:stylesheet>