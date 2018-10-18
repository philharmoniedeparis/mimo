<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:lido="http://www.lido-schema.org" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs"
    version="2.0">

    <xsl:output encoding="UTF-8" method="xml"/>

    <xsl:template match="//Idesia">
        <xsl:element name="keywords">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="//Idesia/forms"/>
    <xsl:template match="//Idesia/relationtypes"/>
    <xsl:template match="//Idesia/lexicontypes"/>
    <xsl:template match="//Idesia/propertytypes"/>
    <xsl:template match="//Idesia/relationsets"/>
    <xsl:template match="//Idesia/parameters"/>
    <xsl:template match="//Idesia/thesaurus"/>
    <xsl:template match="//Idesia/term/source"/>
    <xsl:template match="//Idesia/term/reference"/>
    <xsl:template match="//Idesia/term/history"/>

    <xsl:template match="//Idesia/term">
        <xsl:variable name="id">
            <xsl:value-of select="./eid"/>
        </xsl:variable>
        <xsl:variable name="nom">
            <xsl:value-of select="./label"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="$nom=''"/>
            <xsl:when test="starts-with($nom,'1')"/>
            <xsl:when test="starts-with($nom,'2')"/>
            <xsl:when test="starts-with($nom,'3')"/>
            <xsl:when test="starts-with($nom,'4')"/>
            <xsl:when test="starts-with($nom,'5')"/>
            <xsl:when test="starts-with($nom,'test')"/>
            <xsl:when test="starts-with($nom,'Test')"/>
            <xsl:when test="starts-with($nom,'TEST')"/>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="ends-with($id,'_1') and ends-with($nom,'(to be translated)')"/>
                    <xsl:when test="ends-with($id,'_2') and ends-with($nom,'(to be translated)')"/>
                    <xsl:when test="ends-with($id,'_3') and ends-with($nom,'(to be translated)')"/>
                    <xsl:when test="ends-with($id,'_4') and ends-with($nom,'(to be translated)')"/>
                    <xsl:when test="ends-with($id,'_5') and ends-with($nom,'(to be translated)')"/>
                    <xsl:when test="ends-with($id,'_6') and ends-with($nom,'(to be translated)')"/>
                    <xsl:when test="ends-with($id,'_7') and ends-with($nom,'(to be translated)')"/>
                    <xsl:when test="ends-with($id,'_8') and ends-with($nom,'(to be translated)')"/>
                    <xsl:when test="ends-with($id,'_9') and ends-with($nom,'(to be translated)')"/>
                    <xsl:when test="ends-with($id,'_10') and ends-with($nom,'(to be translated)')"/>
                    <xsl:when test="ends-with($id,'_11') and ends-with($nom,'(to be translated)')"/>
                    <xsl:otherwise>
                        <xsl:element name="term">
                            <xsl:copy-of select="./eid"/>
                            <xsl:copy-of select="./label"/>
                            <xsl:copy-of select="./definition"/>
                            <xsl:copy-of select="./language"/>
                            <xsl:element name="mimoType">keywords</xsl:element>
                            <xsl:for-each select="./relation">
                                <xsl:variable name="rel_type">
                                    <xsl:value-of select="type/text()"/>
                                </xsl:variable>
                                <xsl:variable name="rel_label">
                                    <xsl:value-of select="label/text()"/>
                                </xsl:variable>
                                <xsl:choose>
                                    <xsl:when test="$rel_type='LE' and ends-with($rel_label,'(to be translated)')"/>
                                    <xsl:when test="$rel_type='UF'">
                                        <xsl:element name="relation">
                                            <xsl:copy-of select="type"/>
                                            <xsl:copy-of select="eid"/>
                                            <xsl:copy-of select="label"/>
                                            <xsl:copy-of select="../language"/>
                                        </xsl:element>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:copy-of select="."/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:for-each>
                        </xsl:element>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
