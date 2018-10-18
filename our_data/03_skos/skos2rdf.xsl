<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:skos="http://www.w3.org/2004/02/skos/core#">

    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>

    <xsl:variable name="quot">"</xsl:variable>
    <xsl:variable name="apos">'</xsl:variable>

    <xsl:template match="rdf:RDF">
        <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:skos="http://www.w3.org/2004/02/skos/core#"
            xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:dc="http://purl.org/dc/elements/1.1/">
            <xsl:apply-templates select="skos:ConceptScheme"/>
            <xsl:apply-templates select="skos:Concept"/>
        </rdf:RDF>
    </xsl:template>

    <xsl:template match="skos:ConceptScheme">
        <xsl:element name="rdf:Description">
            <xsl:attribute name="rdf:about" select="@rdf:about"/>
            <xsl:element name="rdf:type">
                <xsl:attribute name="rdf:resource">http://www.w3.org/2004/02/skos/core#ConceptScheme</xsl:attribute>
            </xsl:element>
            <xsl:apply-templates select="skos:prefLabel"/>
            <xsl:apply-templates select="skos:hasTopConcept"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="skos:hasTopConcept">
        <xsl:copy-of select="."/>
    </xsl:template>

    <xsl:template match="skos:Concept">
        <xsl:element name="rdf:Description">
            <xsl:attribute name="rdf:about" select="@rdf:about"/>
            <xsl:element name="rdf:type">
                <xsl:attribute name="rdf:resource">http://www.w3.org/2004/02/skos/core#Concept</xsl:attribute>
            </xsl:element>
            <xsl:apply-templates select="skos:inScheme"/>
            <xsl:apply-templates select="skos:topConceptOf"/>
            <xsl:apply-templates select="skos:prefLabel"/>
            <xsl:apply-templates select="skos:altLabel"/>
            <xsl:apply-templates select="skos:definition"/>
            <xsl:apply-templates select="skos:scopeNote"/>
            <xsl:apply-templates select="skos:note"/>
            <xsl:apply-templates select="skos:broader"/>
            <xsl:apply-templates select="skos:narrower"/>
            <xsl:apply-templates select="skos:exactMatch"/>
            <xsl:apply-templates select="skos:closeMatch"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="skos:inScheme">
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template match="skos:topConceptOf">
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template match="skos:prefLabel">
        <xsl:element name="skos:prefLabel">
            <xsl:if test="@xml:lang">
                <xsl:attribute name="xml:lang">
                    <xsl:value-of select="@xml:lang"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:copy-of select="normalize-space(replace(.,$quot,$apos))"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="skos:altLabel">
        <xsl:element name="skos:altLabel">
            <xsl:if test="@xml:lang">
                <xsl:attribute name="xml:lang">
                    <xsl:value-of select="@xml:lang"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:copy-of select="normalize-space(replace(.,$quot,$apos))"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="skos:definition">
        <xsl:element name="skos:definition">
            <xsl:if test="@xml:lang">
                <xsl:attribute name="xml:lang">
                    <xsl:value-of select="@xml:lang"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:copy-of select="normalize-space(replace(.,$quot,$apos))"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="skos:scopeNote">
        <xsl:element name="skos:scopeNote">
            <xsl:if test="@xml:lang">
                <xsl:attribute name="xml:lang">
                    <xsl:value-of select="@xml:lang"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:copy-of select="normalize-space(replace(.,$quot,$apos))"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="skos:note">
        <xsl:element name="skos:note">
            <xsl:if test="@xml:lang">
                <xsl:attribute name="xml:lang">
                    <xsl:value-of select="@xml:lang"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:copy-of select="normalize-space(replace(.,$quot,$apos))"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="skos:broader">
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template match="skos:narrower">
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template match="skos:exactMatch">
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template match="skos:closeMatch">
        <xsl:copy-of select="."/>
    </xsl:template>

</xsl:stylesheet>
