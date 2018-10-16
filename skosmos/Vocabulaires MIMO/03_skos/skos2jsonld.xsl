<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:skos="http://www.w3.org/2004/02/skos/core#">

    <xsl:output method="text" encoding="UTF-8" indent="yes"/>

    <xsl:variable name="quot">"</xsl:variable>
    <xsl:variable name="apos">'</xsl:variable>

    <xsl:template match="rdf:RDF">
        <xsl:text>[</xsl:text>
        <xsl:apply-templates select="skos:ConceptScheme"/>
        <xsl:apply-templates select="skos:Concept"/>
        <xsl:text>]</xsl:text>
    </xsl:template>

    <xsl:template match="skos:ConceptScheme">
        <xsl:text>{"@id":"</xsl:text>
        <xsl:value-of select="@rdf:about"/>
        <xsl:text>",</xsl:text>
        <xsl:text>"@type":"http://www.w3.org/2004/02/skos/core#ConceptScheme"</xsl:text>
        <xsl:for-each select="skos:hasTopConcept">
            <xsl:if test="position()=1">
                <xsl:text>,"http://www.w3.org/2004/02/skos/core#hasTopConcept":[</xsl:text>
            </xsl:if>
            <xsl:text>{"@value":"</xsl:text>
            <xsl:value-of select="@rdf:resource"/>
            <xsl:text>"}</xsl:text>
            <xsl:choose>
                <xsl:when test="position()!=last()">,</xsl:when>
                <xsl:otherwise>]}</xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="skos:Concept">
        <xsl:text>,{"@id":"</xsl:text>
        <xsl:value-of select="@rdf:about"/>
        <xsl:text>"</xsl:text>

        <xsl:apply-templates select="skos:inScheme"/>

        <xsl:apply-templates select="skos:topConceptOf"/>

        <xsl:for-each select="skos:prefLabel">
            <xsl:if test="position()=1">
                <xsl:text>,"http://www.w3.org/2004/02/skos/core#prefLabel":[</xsl:text>
            </xsl:if>
            <xsl:text>{"@value":"</xsl:text>
            <xsl:value-of select="normalize-space(replace(.,$quot,$apos))"/>
            <xsl:text>","@language":"</xsl:text>
            <xsl:value-of select="@xml:lang"/>
            <xsl:text>"}</xsl:text>
            <xsl:choose>
                <xsl:when test="position()!=last()">,</xsl:when>
                <xsl:otherwise>]</xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>

        <xsl:for-each select="skos:altLabel">
            <xsl:if test="position()=1">
                <xsl:text>,"http://www.w3.org/2004/02/skos/core#altLabel":[</xsl:text>
            </xsl:if>
            <xsl:text>{"@value":"</xsl:text>
            <xsl:value-of select="normalize-space(replace(.,$quot,$apos))"/>
            <xsl:text>","@language":"</xsl:text>
            <xsl:value-of select="@xml:lang"/>
            <xsl:text>"}</xsl:text>
            <xsl:choose>
                <xsl:when test="position()!=last()">,</xsl:when>
                <xsl:otherwise>]</xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>

        <xsl:apply-templates select="skos:definition"/>
        <xsl:apply-templates select="skos:scopeNote"/>
        <xsl:apply-templates select="skos:note"/>

        <xsl:for-each select="skos:narrower">
            <xsl:if test="position()=1">
                <xsl:text>,"http://www.w3.org/2004/02/skos/core#narrower":[</xsl:text>
            </xsl:if>
            <xsl:text>{"@value":"</xsl:text>
            <xsl:value-of select="@rdf:resource"/>
            <xsl:text>"}</xsl:text>
            <xsl:choose>
                <xsl:when test="position()!=last()">,</xsl:when>
                <xsl:otherwise>]</xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>

        <xsl:for-each select="skos:broader">
            <xsl:if test="position()=1">
                <xsl:text>,"http://www.w3.org/2004/02/skos/core#broader":[</xsl:text>
            </xsl:if>
            <xsl:text>{"@value":"</xsl:text>
            <xsl:value-of select="@rdf:resource"/>
            <xsl:text>"}</xsl:text>
            <xsl:choose>
                <xsl:when test="position()!=last()">,</xsl:when>
                <xsl:otherwise>]</xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>

        <xsl:for-each select="skos:exactMatch">
            <xsl:if test="position()=1">
                <xsl:text>,"http://www.w3.org/2004/02/skos/core#exactMatch":[</xsl:text>
            </xsl:if>
            <xsl:text>{"@value":"</xsl:text>
            <xsl:value-of select="@rdf:resource"/>
            <xsl:text>"}</xsl:text>
            <xsl:choose>
                <xsl:when test="position()!=last()">,</xsl:when>
                <xsl:otherwise>]</xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>

        <xsl:for-each select="skos:closeMatch">
            <xsl:if test="position()=1">
                <xsl:text>,"http://www.w3.org/2004/02/skos/core#closeMatch":[</xsl:text>
            </xsl:if>
            <xsl:text>{"@value":"</xsl:text>
            <xsl:value-of select="@rdf:resource"/>
            <xsl:text>"}</xsl:text>
            <xsl:choose>
                <xsl:when test="position()!=last()">,</xsl:when>
                <xsl:otherwise>]</xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>

        <xsl:text>}</xsl:text>

    </xsl:template>

    <xsl:template match="skos:inScheme">
        <xsl:text>,"http://www.w3.org/2004/02/skos/core#inScheme":</xsl:text>
        <xsl:text>"</xsl:text>
        <xsl:value-of select="@rdf:resource"/>
        <xsl:text>"</xsl:text>
    </xsl:template>

    <xsl:template match="skos:topConceptOf">
        <xsl:text>,"http://www.w3.org/2004/02/skos/core#topConceptOf":</xsl:text>
        <xsl:text>"</xsl:text>
        <xsl:value-of select="@rdf:resource"/>
        <xsl:text>"</xsl:text>
    </xsl:template>

    <xsl:template match="skos:definition">
        <xsl:text>,"http://www.w3.org/2004/02/skos/core#definition":{</xsl:text>
        <xsl:text>"@value":"</xsl:text>
        <xsl:value-of select="normalize-space(replace(.,$quot,$apos))"/>
        <xsl:if test="@xml:lang">
            <xsl:text>","@language":"</xsl:text>
            <xsl:value-of select="@xml:lang"/>
        </xsl:if>
        <xsl:text>"}</xsl:text>
    </xsl:template>

    <xsl:template match="skos:scopeNote">
        <xsl:text>,"http://www.w3.org/2004/02/skos/core#scopeNote":{</xsl:text>
        <xsl:text>"@value":"</xsl:text>
        <xsl:value-of select="normalize-space(replace(.,$quot,$apos))"/>
        <xsl:if test="@xml:lang">
            <xsl:text>","@language":"</xsl:text>
            <xsl:value-of select="@xml:lang"/>
        </xsl:if>
        <xsl:text>"}</xsl:text>
    </xsl:template>

    <xsl:template match="skos:note">
        <xsl:text>,"http://www.w3.org/2004/02/skos/core#note":{</xsl:text>
        <xsl:text>"@value":"</xsl:text>
        <xsl:value-of select="normalize-space(replace(.,$quot,$apos))"/>
        <xsl:if test="@xml:lang">
            <xsl:text>","@language":"</xsl:text>
            <xsl:value-of select="@xml:lang"/>
        </xsl:if>
        <xsl:text>"}</xsl:text>
    </xsl:template>

</xsl:stylesheet>
