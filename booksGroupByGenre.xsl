<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output
            method="xml"
            indent="yes"
            cdata-section-elements="title"
    />
    <xsl:template match="/catalog">
        <xsl:element name="genres">
            <xsl:for-each-group select="book" group-by="genre">
                <xsl:sort select="genre" order="ascending"/>
                <xsl:element name="genre">
                    <xsl:attribute name="name">
                        <xsl:value-of select="current-grouping-key()"/>
                    </xsl:attribute>
                    <xsl:attribute name="average-price">
                        <xsl:value-of select="avg(current-group()/price)"/>
                    </xsl:attribute>
                    <xsl:for-each select="current-group()">
                        <xsl:sort select="./title" order="ascending"/>
                        <xsl:apply-templates select="." mode="group"/>
                    </xsl:for-each>
                </xsl:element>
            </xsl:for-each-group>
        </xsl:element>
    </xsl:template>
    <xsl:template match="book" mode="group">
        <xsl:element name="title">
            <xsl:value-of select="./title"/>
        </xsl:element>
    </xsl:template>
</xsl:stylesheet>