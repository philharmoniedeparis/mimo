<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet>

<!-- Corrections par Rodolphe le 25/07/2011 à 15:15 --> 
<!-- 1- Suppression du template Idesia / Thesaurus  (pointait vers des liens inexistants)--> 
<!-- 2- Suppression de l'attribut "definition" redondant avec skos:definition--> 
<!-- 2- Suppression de l'attribut renommé l'élément "skos:definion" en "skos:definition"--> 

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"  xmlns:local="#local-functions" exclude-result-prefixes="msxsl"
	xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
	xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
	xmlns:skos="http://www.w3.org/2004/02/skos/core#"
	xmlns:owl="http://www.w3.org/2002/07/owl#"
	xmlns:dc="http://purl.org/dc/elements/1.1/">
  
  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="InstrumentsBaseUrl" select="www.mimo-db.eu/InstrumentsKeywords"></xsl:variable>
  <xsl:variable name="RelatedBaseUrl" select="www.mimo-db.eu/HornbostelAndSachs"></xsl:variable>
  
  
  
  <xsl:template match="keywords">
    
    <rdf:RDF
      xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
      xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
      xmlns:skos="http://www.w3.org/2004/02/skos/core#"
      xmlns:owl="http://www.w3.org/2002/07/owl#"
      xmlns:dc="http://purl.org/dc/elements/1.1/"	>
      
      <!--Thésaurus-->
      <!--xsl:apply-templates select="/Idesia/thesaurus[@form=$defaultForm]"/-->
      <!--<xsl:apply-templates select="thesaurus"/>-->
      <!-- Termes en forme 0-->
      <!--xsl:apply-templates select="/Idesia/term[language='DEFAULT_FORM']"/-->
      <xsl:apply-templates select="term"/>
    </rdf:RDF>


    <!-- Concepts -->
    <xsl:for-each select="term">
      <skos:Concept rdf:about="{$InstrumentsBaseUrl}/{local:FormatId(string(substring-after(eid,'_')))}">
  
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
          <xsl:variable name="termEid"><xsl:value-of select="eid"/></xsl:variable>
          <xsl:for-each select="/Idesia/term[eid=$termEid]">
            <skos:altLabel xml:lang="{language}"><xsl:value-of select="label"/></skos:altLabel>
          </xsl:for-each>
        </xsl:for-each>
  
  
  
        <!--génériques-->
        <xsl:for-each select="relation[type='BT']">
  
          <skos:broader>
            <skos:Concept rdf:about="{$InstrumentsBaseUrl}/{local:FormatId(string(substring-after(eid,'_')))}">
              <skos:prefLabel>
                <xsl:value-of select="label"/>
              </skos:prefLabel>
              <skos:inScheme rdf:resource="{$InstrumentsBaseUrl}/" />
            </skos:Concept>
          </skos:broader>
        </xsl:for-each>
        <!--spécifiques-->
        <xsl:for-each select="relation[type='NT']">
  
          <skos:narrower>
            <skos:Concept rdf:about="{$InstrumentsBaseUrl}/{local:FormatId(string(substring-after(eid,'_')))}">
              <skos:prefLabel>
                <xsl:value-of select="label"/>
              </skos:prefLabel>
              <skos:inScheme rdf:resource="{$InstrumentsBaseUrl}/" />
            </skos:Concept>
          </skos:narrower>
        </xsl:for-each>
        <!--relatifs-->
        <xsl:for-each select="relation[type='RT']">
  
          <skos:related>
            <skos:Concept rdf:about="{$RelatedBaseUrl}/{local:FormatId(string(substring-after(eid,'_')))}">
              <skos:prefLabel>
                <xsl:value-of select="label"/>
              </skos:prefLabel>
              <skos:inScheme rdf:resource="{$RelatedBaseUrl}/" />
            </skos:Concept>
          </skos:related>
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
      </skos:Concept>
    </xsl:for-each>
    
  </xsl:template>

  <msxsl:script implements-prefix="local" language="C#">

    public string FormatId(string str) {
      string [] arr,arr2;
      int id;
      string result;
      if (str.Contains("_"))
      {
        arr = str.Split('_');
        id = Convert.ToInt32(arr[0]);
        result = string.Concat(Convert.ToString(id),'_',arr[arr.Length-1]);
      }
      else
      {
        id = Convert.ToInt32(str);
        result = Convert.ToString(id);
      }
      return result;
    }

  </msxsl:script>

</xsl:stylesheet>

