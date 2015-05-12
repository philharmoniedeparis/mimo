<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
  xmlns:skos="http://www.w3.org/2004/02/skos/core#"
  xmlns:owl="http://www.w3.org/2002/07/owl#"
  xmlns:dc="http://purl.org/dc/elements/1.1/">
  
  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
  
  <xsl:variable name="InstrumentsBaseUrl" select="'http://www.mimo-db.eu/InstrumentsKeywords'"></xsl:variable>
  <xsl:variable name="RelatedBaseUrl" select="'http://www.mimo-db.eu/HornbostelAndSachs'"></xsl:variable>
  <xsl:variable name="Languages">
    <i key="0">pivot</i>
    <i key="1">en</i>
    <i key="2">fr</i>
    <i key="3">it</i>
    <i key="4">de</i>
    <i key="5">nl</i>
    <i key="6">sv</i>
    <i key="7">ca</i>
  </xsl:variable>

  <xsl:template match="keywords">
    <rdf:RDF
      xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
      xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
      xmlns:skos="http://www.w3.org/2004/02/skos/core#"
      xmlns:owl="http://www.w3.org/2002/07/owl#"
      xmlns:dc="http://purl.org/dc/elements/1.1/"	>
      
      <skos:ConceptScheme rdf:about="{$InstrumentsBaseUrl}">
        <xsl:apply-templates select="term" mode="ConceptSchemeMusicalInstrumentName" />
        <xsl:apply-templates select="term" mode="ConceptSchemeMusicalInstrumentTopConcept" />
      </skos:ConceptScheme>
      
      <xsl:apply-templates select="term" mode="Concepts" />
      
    </rdf:RDF>
    
  </xsl:template>
  
  <!-- Concept Scheme : term with id LEXICON_00002204, "Musical Instruments" -->
  <xsl:template match="term" mode="ConceptSchemeMusicalInstrumentName">
    <xsl:if test="(eid/@id) and (eid/@id = '2204')">
      
      <!-- Prefered Label in the main language -->
      <xsl:if test="string(label)!=''">
        <xsl:variable name="language" select="language" />
        <skos:prefLabel>
          <xsl:if test="(normalize-space(language)!='') and (language!='0')">
            <xsl:attribute name="xml:lang" select="$Languages/i[@key=$language]"/>
          </xsl:if>
          <xsl:value-of select="normalize-space(label)"/>
        </skos:prefLabel>
      </xsl:if>
      <!-- /Prefered Label in the main language -->
      
      <!-- translation : prefered labels in other languages -->
      <xsl:for-each select="relation[type='LE']">
        <xsl:variable name="termEid" select="eid" />
        <xsl:variable name="language" select="language" />
        <skos:prefLabel>
          <xsl:if test="(normalize-space(language)!='') and (language!='0')">
            <xsl:attribute name="xml:lang" select="$Languages/i[@key=$language]" />
          </xsl:if>      
          <xsl:value-of select="normalize-space(label)"/>
        </skos:prefLabel>  
      </xsl:for-each>
      <!-- /translation -->
      
    </xsl:if>
  </xsl:template>
  <!-- / Concept Scheme -->
  
  <!-- list of the top concepts in the thesaurus : whose parent is LEXICON_00002204 -->
  <xsl:template match="term" mode="ConceptSchemeMusicalInstrumentTopConcept">
    <xsl:if test="(relation[type='BT']) and(relation[eid='LEXICON_00002204'])">
      <skos:hasTopConcept rdf:resource="{$InstrumentsBaseUrl}/{eid/@id}" /> 
    </xsl:if>
  </xsl:template>
  <!-- list of the top concepts -->
  
  
  <!-- Concepts -->
  <xsl:template match="term" mode="Concepts">
    
    <!-- leave out nodes which have no id attribute (ie translations, which have a referent attribute instead) -->
    <!-- and nodes which have no parent and no children (they are only synonyms) -->
    <!-- as well as Musical Instruments (LEXICON_2204), which is not a concept -->
    <xsl:if test="(eid/@id) and ( (relation[type='BT']) or (relation[type='NT']) ) and (eid/@id != 'LEXICON_2204')">
      
      <skos:Concept rdf:about="{$InstrumentsBaseUrl}/{eid/@id}">
        
        <!-- relation to the concept scheme --> 
        <xsl:choose>
          <!-- either top concept -->
          <xsl:when test="(relation[type='BT']) and(relation[eid='LEXICON_00002204'])">
            <skos:topConceptOf rdf:resource="{$InstrumentsBaseUrl}" /> 
          </xsl:when>
          <!-- or simply part of it -->
          <xsl:otherwise>
            <skos:inScheme rdf:resource="{$InstrumentsBaseUrl}"/>
          </xsl:otherwise>
        </xsl:choose>
        <!-- /relation to the concept scheme --> 
        
        
        <!-- Prefered Label in the main language -->
        <xsl:if test="string(label)!=''">
          <skos:prefLabel>
            <xsl:if test="(normalize-space(language)!='') and (language!='0')">
              <xsl:variable name="language" select="language" />
              <xsl:attribute name="xml:lang" select="$Languages/i[@key=$language]" />
            </xsl:if>
            <xsl:value-of select="normalize-space(label)"/>
          </skos:prefLabel>
        </xsl:if>
        <!-- /Prefered Label in the main language -->
        
        
        <!-- Dbpedia Links -->
        <xsl:if test="dbpedia">
          <xsl:choose>
            <xsl:when test="@exact='true'">
              <skos:exactMatch  rdf:resource="{normalize-space(dbpedia)}" />
            </xsl:when>
            <xsl:otherwise>
              <skos:closeMatch  rdf:resource="{normalize-space(dbpedia)}" />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:if>
        <!-- /Dbpedia Links -->
        
        <!-- createdBy -->
        <xsl:if test="string(createdBy)!=''">
          <dc:creator  select="createdBy" />
        </xsl:if>
        <!-- /createdBy -->
        
        <!-- createdDate -->
        <xsl:if test="string(createdDate)!=''">
          <dc:created select="createdDate" />
        </xsl:if>
        <!-- /createdDate -->
        
        <!-- definition -->
        <skos:definition>
          <xsl:if test="normalize-space(language)!=''">
            <xsl:variable name="language" select="language" />
            <xsl:attribute name="xml:lang" select="$Languages/i[@key=$language]" />
          </xsl:if>
          <xsl:value-of select="definition"/>
        </skos:definition>
        <!-- /definition -->
        
        <!-- translation : prefered labels in other languages -->
        <xsl:for-each select="relation[type='LE']">
          <xsl:variable name="termEid"><xsl:value-of select="eid"/></xsl:variable>
          <xsl:variable name="language" select="language" />
          <skos:prefLabel>
            <xsl:if test="(normalize-space(language)!='') and (language!='0')">
              <xsl:attribute name="xml:lang" select="$Languages/i[@key=$language]" />
            </xsl:if>
            <xsl:value-of select="normalize-space(label)"/>
          </skos:prefLabel>
        </xsl:for-each>
        <!-- translation -->
        
        <!-- alternative Labels -->
        <xsl:for-each select="relation[type='UF']">
          <xsl:variable name="language" select="language" />
          <skos:altLabel>
            <xsl:if test="(normalize-space(language)!='') and (language!='0')">
              <xsl:attribute name="xml:lang" select="$Languages/i[@key=$language]" />
            </xsl:if>
            <xsl:value-of select="normalize-space(label)"/>
          </skos:altLabel>
        </xsl:for-each>
        <!-- /alternative Label -->
        
        
        <!-- alternative Label linked to another language -->
        <!-- iterates through the terms which referent is this one -->
        <!-- and gets all UF relations -->
        <!-- heavy stuff for the processor -->
        <xsl:variable name="InstrumentId" select="eid/@id"></xsl:variable>
        <xsl:for-each select="following-sibling::*/eid[@referent = $InstrumentId]">
          <xsl:for-each select="../relation[type='UF']">
            <xsl:variable name="language" select="language" />
            <skos:altLabel>
              <xsl:if test="(normalize-space(language)!='') and (language!='0')">
                <xsl:attribute name="xml:lang" select="$Languages/i[@key=$language]" />
              </xsl:if>
              <xsl:value-of select="normalize-space(label)"/>
            </skos:altLabel>
          </xsl:for-each>
        </xsl:for-each>
        <!-- /alternative Label linked to another language -->
        
        <!-- parent Concepts -->
        <xsl:for-each select="relation[type='BT']">
          <xsl:if test="eid !='LEXICON_00002204'">
            <skos:broader  rdf:resource="{$InstrumentsBaseUrl}/{eid/@id}" />
          </xsl:if>
        </xsl:for-each>
        <!-- /parent Concepts -->
        
        <!-- children Concepts -->
        <xsl:for-each select="relation[type='NT']">
          <skos:narrower rdf:resource="{$InstrumentsBaseUrl}/{eid/@id}" />
        </xsl:for-each>
        <!-- /children Concepts -->
        
        <!-- equivalents HornBostel and Sachs -->
        <xsl:for-each select="relation[type='RT']">
          <skos:exactMatch rdf:resource="{$RelatedBaseUrl}/{eid/@id}" />
        </xsl:for-each>
        <!-- /equivalents HornBostel and Sachs -->
        
        <!-- applicationNote -->
        <xsl:if test="applicationNote">
          <skos:note  select="applicationNote" />
        </xsl:if>
        <!-- /applicationNote -->
        
        <!-- explainNote -->
        <xsl:if test="explainNote">
          <skos:definition  select="explainNote" />
        </xsl:if>
        <!-- /explainNote -->
        
      </skos:Concept>
    </xsl:if>
  </xsl:template>
  <!-- / Concepts -->
  
</xsl:stylesheet>