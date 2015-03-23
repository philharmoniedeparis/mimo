<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
  xmlns:skos="http://www.w3.org/2004/02/skos/core#"
  xmlns:owl="http://www.w3.org/2002/07/owl#"
  xmlns:dc="http://purl.org/dc/elements/1.1/">
  
  <xsl:output method="xml" indent="yes"/>
  
  <xsl:variable name="InstrumentsBaseUrl" select="'http://www.mimo-db.eu/HornbostelAndSachs'"></xsl:variable>
  <xsl:variable name="RelatedBaseUrl" select="'http://www.mimo-db.eu/InstrumentsKeywords'"></xsl:variable>
  
  
  <xsl:template match="term" mode="ConceptSchemeHornbostelSachs">
    <xsl:if test="(eid='LEXICON_00000000')">

        <!-- libellé forme 0-->
        <xsl:if test="string(label)!=''">
          <skos:prefLabel>
            <xsl:if test="normalize-space(language)!=''">
              <xsl:variable name="language">
                <xsl:choose>
                  <xsl:when test="language='0'"></xsl:when>
                  <xsl:when test="language='1'">en</xsl:when>
                  <xsl:when test="language='2'">fr</xsl:when>
                  <xsl:when test="language='3'">it</xsl:when>
                  <xsl:when test="language='4'">de</xsl:when>
                  <xsl:when test="language='5'">nl</xsl:when>
                  <xsl:when test="language='6'">sv</xsl:when>
                  <xsl:when test="language='7'">ca</xsl:when>
                </xsl:choose>
              </xsl:variable>
              <xsl:attribute name="xml:lang"><xsl:value-of select="$language"/></xsl:attribute>
            </xsl:if>
            <xsl:value-of select="label"/>
          </skos:prefLabel>
        </xsl:if>
        
        <!-- traductions -->
        <xsl:for-each select="relation[type='LE']">
          <xsl:variable name="termEid"><xsl:value-of select="eid"/></xsl:variable>
          <xsl:variable name="language">
            <xsl:choose>
              <xsl:when test="language='0'"></xsl:when>
              <xsl:when test="language='1'">en</xsl:when>
              <xsl:when test="language='2'">fr</xsl:when>
              <xsl:when test="language='3'">it</xsl:when>
              <xsl:when test="language='4'">de</xsl:when>
              <xsl:when test="language='5'">nl</xsl:when>
              <xsl:when test="language='6'">sv</xsl:when>
              <xsl:when test="language='7'">ca</xsl:when>
            </xsl:choose>
          </xsl:variable>
          
          
          <skos:prefLabel>
            <xsl:if test="normalize-space(language)!=''">
              <xsl:attribute name="xml:lang"><xsl:value-of select="$language"/></xsl:attribute>
            </xsl:if>
            <xsl:value-of select="label"/>
          </skos:prefLabel>
          
        </xsl:for-each>
      </xsl:if>
  </xsl:template>
  
  <xsl:template match="term" mode="ConceptSchemeHornbostelSachsTopConcept">
    <xsl:if test="(relation[type='BT']) and(relation[eid='LEXICON_00000000'])">
      <skos:hasTopConcept rdf:about="{$InstrumentsBaseUrl}/{eid/@id}"><xsl:value-of select="label"/></skos:hasTopConcept> 
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="term" mode="Concepts">
    <xsl:if test="eid/@id != 'LEXICON_2204'">
      <skos:Concept rdf:about="{$InstrumentsBaseUrl}/{eid/@id}">
        
        <!-- libellé forme 0-->
        <xsl:if test="string(label)!=''">
          <skos:prefLabel>
            <xsl:if test="normalize-space(language)!=''">
              <xsl:variable name="language">
                <xsl:choose>
                  <xsl:when test="language='0'"></xsl:when>
                  <xsl:when test="language='1'">en</xsl:when>
                  <xsl:when test="language='2'">fr</xsl:when>
                  <xsl:when test="language='3'">it</xsl:when>
                  <xsl:when test="language='4'">de</xsl:when>
                  <xsl:when test="language='5'">nl</xsl:when>
                  <xsl:when test="language='6'">sv</xsl:when>
                  <xsl:when test="language='7'">ca</xsl:when>
                </xsl:choose>
              </xsl:variable>
              <xsl:attribute name="xml:lang"><xsl:value-of select="$language"/></xsl:attribute>
            </xsl:if>
            <xsl:value-of select="label"/>
          </skos:prefLabel>
        </xsl:if>
        
        <!-- Créateur -->
        <xsl:if test="string(createdBy)!=''">
          <dc:creator>
            <xsl:value-of select="createdBy"/>
          </dc:creator>
        </xsl:if>
        <!-- Date de création -->
        <xsl:if test="string(createdDate)!=''">
          <dc:created>
            <xsl:value-of select="createdDate"/>
          </dc:created>
        </xsl:if>
        
        
        <!-- definition -->
        <xsl:if test="string(definition)!=''">
          <skos:definition>
            <xsl:value-of select="definition"/>
          </skos:definition>
        </xsl:if>
        
        <!--
  			<language>DEFAULT_FORM</language>
  			<definition>def</definition>
  			<createdDate>28/01/2008 11:02:15</createdDate>
  			<createdBy></createdBy>
  			<reference>ref</reference>
  			<source>source</source>
  			<status>0</status>
  			-->
        
        <!-- traductions -->
        <xsl:for-each select="relation[type='LE']">
          <xsl:variable name="termEid"><xsl:value-of select="eid"/></xsl:variable>
          <xsl:variable name="language">
            <xsl:choose>
              <xsl:when test="language='0'"></xsl:when>
              <xsl:when test="language='1'">en</xsl:when>
              <xsl:when test="language='2'">fr</xsl:when>
              <xsl:when test="language='3'">it</xsl:when>
              <xsl:when test="language='4'">de</xsl:when>
              <xsl:when test="language='5'">nl</xsl:when>
              <xsl:when test="language='6'">sv</xsl:when>
              <xsl:when test="language='7'">ca</xsl:when>
            </xsl:choose>
          </xsl:variable>
          
          
          <skos:prefLabel>
            <xsl:if test="normalize-space(language)!=''">
              <xsl:attribute name="xml:lang"><xsl:value-of select="$language"/></xsl:attribute>
            </xsl:if>
            <xsl:value-of select="label"/>
          </skos:prefLabel>
          
        </xsl:for-each>
        
        <!-- synonyme : forme 0-->
        <xsl:for-each select="relation[type='UF']">
          <xsl:variable name="language">
            <xsl:choose>
              <xsl:when test="language='0'"></xsl:when>
              <xsl:when test="language='1'">en</xsl:when>
              <xsl:when test="language='2'">fr</xsl:when>
              <xsl:when test="language='3'">it</xsl:when>
              <xsl:when test="language='4'">de</xsl:when>
              <xsl:when test="language='5'">nl</xsl:when>
              <xsl:when test="language='6'">sv</xsl:when>
              <xsl:when test="language='7'">ca</xsl:when>
            </xsl:choose>
          </xsl:variable>
          <skos:altLabel>
            <xsl:if test="normalize-space(language)!=''">
              <xsl:attribute name="xml:lang"><xsl:value-of select="$language"/></xsl:attribute>
            </xsl:if>
            <xsl:value-of select="label"/>
          </skos:altLabel>
        </xsl:for-each>
        
        
        
        <!--génériques-->
        <xsl:for-each select="relation[type='BT']">
          
          <skos:broader>
            <skos:Concept rdf:about="{$InstrumentsBaseUrl}/{eid/@id}">
            </skos:Concept>
          </skos:broader>
        </xsl:for-each>
        <!--spécifiques-->
        <xsl:for-each select="relation[type='NT']">
          
          <skos:narrower>
            <skos:Concept rdf:about="{$InstrumentsBaseUrl}/{eid/@id}">
            </skos:Concept>
          </skos:narrower>
        </xsl:for-each>
        <!--relatifs-->
        <xsl:for-each select="relation[type='RT']">
          <skos:exactMatch>
            <skos:Concept rdf:about="{$RelatedBaseUrl}/{eid/@id}"></skos:Concept>
          </skos:exactMatch>
        </xsl:for-each>
        
        <xsl:if test="applicationNote">
          <skos:note>
            <xsl:value-of select="applicationNote"/>
          </skos:note>
        </xsl:if>
        <xsl:if test="explainNote">
          <skos:definition>
            <xsl:value-of select="explainNote"/>
          </skos:definition>
        </xsl:if>
        
        <skos:inScheme rdf:resource="{$InstrumentsBaseUrl}"/>
        
      </skos:Concept>
    </xsl:if>
  </xsl:template>
  
  <xsl:template match="hs">
    <rdf:RDF
      xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
      xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
      xmlns:skos="http://www.w3.org/2004/02/skos/core#"
      xmlns:owl="http://www.w3.org/2002/07/owl#"
      xmlns:dc="http://purl.org/dc/elements/1.1/"	>
      
      <skos:ConceptScheme rdf:about="{$InstrumentsBaseUrl}">
        <xsl:apply-templates select="term" mode="ConceptSchemeHornbostelSachs" />
        <xsl:apply-templates select="term" mode="ConceptSchemeHornbostelSachsTopConcept" />
      </skos:ConceptScheme>
      
      <xsl:apply-templates select="term" mode="Concepts" />
      
    </rdf:RDF>
    
  </xsl:template>
</xsl:stylesheet>