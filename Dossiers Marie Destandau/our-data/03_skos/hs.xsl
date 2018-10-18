<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
  xmlns:skos="http://www.w3.org/2004/02/skos/core#"
  xmlns:owl="http://www.w3.org/2002/07/owl#"
  xmlns:dc="http://purl.org/dc/elements/1.1/">

  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
  <xsl:variable name="ConceptSchemeUrl" select="'http://www.mimo-db.eu/HornbostelAndSachs'"></xsl:variable>
  <xsl:variable name="InstrumentsBaseUrl" select="'http://www.mimo-db.eu/HornbostelAndSachs'"></xsl:variable>
  <xsl:variable name="RelatedBaseUrl" select="'http://www.mimo-db.eu/InstrumentsKeywords'"></xsl:variable>
  <xsl:variable name="Languages">
    <i key="0">en</i>
    <i key="1">en</i>
    <i key="2">fr</i>
    <i key="3">it</i>
    <i key="4">de</i>
    <i key="5">nl</i>
    <i key="6">sv</i>
    <i key="7">ca</i>
  </xsl:variable>

  <xsl:template match="hs">
    <!--<xsl:text disable-output-escaping="yes">&lt;!DOCTYPE rdf:RDF [
      &lt;!ENTITY mimo 'http://www.mimo-db.eu/InstrumentsKeywords/'>
      &lt;!ENTITY hs 'http://www.mimo-db.eu/HornbostelAndSachs/'>
      ]></xsl:text>-->
    <rdf:RDF
      xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
      xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
      xmlns:skos="http://www.w3.org/2004/02/skos/core#"
      xmlns:owl="http://www.w3.org/2002/07/owl#"
      xmlns:dc="http://purl.org/dc/elements/1.1/"	>
      
      <skos:ConceptScheme rdf:about="{$ConceptSchemeUrl}">
        <xsl:apply-templates select="term" mode="ConceptSchemeHornbostelSachs" />
        <xsl:apply-templates select="term" mode="ConceptSchemeHornbostelSachsTopConcept" />
      </skos:ConceptScheme>
      
      <xsl:apply-templates select="term" mode="Concepts" />
      
    </rdf:RDF>
    
  </xsl:template>
  
  <!-- Concept Scheme : term with id LEXICON_00000000, "Hornbostel & Sachs" -->
  <xsl:template match="term" mode="ConceptSchemeHornbostelSachs">
    <xsl:if test="(eid='LEXICON_00000000')">

      <!-- Prefered Label in the main language -->
        <xsl:if test="string(label)!=''">
          <xsl:variable name="language" select="language" />
          <skos:prefLabel>     
            <xsl:attribute name="xml:lang" select="$Languages/i[@key=$language]" />
            <xsl:value-of select="label"/>
          </skos:prefLabel>
        </xsl:if>
        <!-- /Prefered Label in the main language -->
      
      </xsl:if>
  </xsl:template>
  <!-- / Concept Scheme -->
  
  <!-- list of the top concepts in the thesaurus : whose parent is LEXICON_00000000 -->
  <xsl:template match="term" mode="ConceptSchemeHornbostelSachsTopConcept">
    <xsl:if test="(relation[type='BT']) and(relation[eid='LEXICON_00000000'])">
      <skos:hasTopConcept rdf:resource="{$InstrumentsBaseUrl}/{eid/@id}" /> 
    </xsl:if>
  </xsl:template>
  <!-- list of the top concepts -->
  
  
  <!-- Concepts -->
  <xsl:template match="term" mode="Concepts">
    
    <!-- leave out LEXICON_00000000 which is not a concept -->
    <xsl:if test="eid != 'LEXICON_00000000'">
      <skos:Concept rdf:about="{$InstrumentsBaseUrl}/{eid/@id}">
        
        <!-- relation to the concept scheme --> 
        <xsl:choose>
          <xsl:when test="(relation[type='BT']) and(relation[eid='LEXICON_00000000'])">
            <skos:topConceptOf rdf:resource="{$ConceptSchemeUrl}" /> 
          </xsl:when>
          <xsl:otherwise>
            <skos:inScheme rdf:resource="{$ConceptSchemeUrl}"/>
          </xsl:otherwise>
        </xsl:choose>
        <!-- /relation to the concept scheme --> 
        
        
        <!-- Prefered Label in the main language -->
        <xsl:if test="string(label)!=''">
          <skos:prefLabel>
            <xsl:if test="normalize-space(language)!=''">
              <xsl:variable name="language" select="language" />
              <xsl:attribute name="xml:lang" select="$Languages/i[@key=$language]" />
            </xsl:if>
            <xsl:value-of select="label"/>
          </skos:prefLabel>
        </xsl:if>
        <!-- /Prefered Label in the main language -->
        
        <!-- createdBy -->
        <xsl:if test="string(createdBy)!=''">
          <dc:creator select="createdBy"/>
        </xsl:if>
        <!-- /createdBy -->
        
        <!-- createdDate -->
        <xsl:if test="string(createdDate)!=''">
          <dc:created  select="createdDate"/>
        </xsl:if>
        <!-- /createdDate -->
        
        <!-- definition -->
        <xsl:if test="string(definition)!=''">
          <skos:definition>
            <xsl:if test="normalize-space(language)!=''">
              <xsl:variable name="language" select="language" />
              <xsl:attribute name="xml:lang" select="$Languages/i[@key=$language]" />
            </xsl:if>
            <xsl:value-of select="definition"/>
          </skos:definition>
        </xsl:if>
        <!-- /definition -->

        <!-- parent Concepts -->
        <xsl:for-each select="relation[type='BT']">
          <xsl:if test="eid !='LEXICON_00000000'">
            <skos:broader rdf:resource="{$InstrumentsBaseUrl}/{eid/@id}" />
          </xsl:if>
        </xsl:for-each>
        <!-- /parent Concepts -->
        
        <!-- children Concepts -->
        <xsl:for-each select="relation[type='NT']">
          <skos:narrower rdf:resource="{$InstrumentsBaseUrl}/{eid/@id}" />
        </xsl:for-each>
        <!-- /children Concepts -->
        
        <!-- equivalents MIMO -->
        <xsl:for-each select="relation[type='RT']">
          <skos:exactMatch rdf:resource="{$RelatedBaseUrl}/{eid/@id}" />
        </xsl:for-each>
        <!-- /equivalents MIMO -->
        
        <!-- applicationNote -->
        <xsl:if test="applicationNote">
          <skos:note select="applicationNote"/>
        </xsl:if>
        <!-- /applicationNote -->
        
        <!-- explainNote -->
        <xsl:if test="explainNote">
          <skos:definition select="explainNote" />
        </xsl:if>
        <!-- /explainNote -->
        
        
      </skos:Concept>
    </xsl:if>
  </xsl:template>
  <!-- / Concepts -->

</xsl:stylesheet>