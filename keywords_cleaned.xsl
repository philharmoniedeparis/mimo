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

  <xsl:variable name="defaultForm">
    <xsl:choose>
      <xsl:when test="/Idesia/forms/form[eid='DEFAULT_FORM']"><xsl:value-of select="/Idesia/forms/form[eid='DEFAULT_FORM']/uid"/></xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="InstrumentsBaseUrl">
    <xsl:choose>
      <xsl:when test="normalize-space(/Idesia/term/mimoType)=''">http://www.mimo-db.eu/InstrumentsKeywords</xsl:when>
      <xsl:otherwise>http://www.mimo-db.eu/InstrumentsKeywords</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>
  <xsl:variable name="RelatedBaseUrl">
    <xsl:choose>
      <xsl:when test="normalize-space(/Idesia/term/mimoType)=''">http://www.mimo-db.eu/HornbostelAndSachs</xsl:when>
      <xsl:otherwise>http://www.mimo-db.eu/InstrumentsKeywords</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <!--<xsl:template match="/">

    <xsl:apply-templates select="/IFD_PROVIDER"/>
    <xsl:apply-templates select="/IFD_AUTPP"/>
    <xsl:apply-templates select="/IFD_AUTCOLL"/>
    <xsl:apply-templates select="/IFD_AUTFAM"/>

  </xsl:template>-->




  <xsl:template match="term">
    <xsl:variable name="hs_suffix"></xsl:variable>

    <skos:Concept rdf:about="{$InstrumentsBaseUrl}/{local:FormatId(string(substring-after(eid,'_')))}{$hs_suffix}">

      <xsl:if test="qualifier"><xsl:attribute name="qualifier"><xsl:value-of select="qualifier"/></xsl:attribute></xsl:if>
<!--      <xsl:if test="definition"> -->
<!--        <xsl:attribute name="definition">  -->
<!--          <xsl:value-of select="definition"/>  -->
<!--        </xsl:attribute>  -->
<!--     </xsl:if>  -->
      <xsl:if test="reference"><xsl:attribute name="reference"><xsl:value-of select="reference"/></xsl:attribute></xsl:if>
      <xsl:if test="source"><xsl:attribute name="source"><xsl:value-of select="source"/></xsl:attribute></xsl:if>
      <xsl:if test="specialist"><xsl:attribute name="specialist"><xsl:value-of select="specialist"/></xsl:attribute></xsl:if>

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
        <!--xsl:variable name="bt_hs_suffix"><xsl:if test="normalize-space(/Idesia/term/mimoType)!=''">/<xsl:value-of select="substring-before(label,' ')"/></xsl:if></xsl:variable-->
        <xsl:variable name="bt_hs_suffix"></xsl:variable>
        <skos:broader>
          <skos:Concept rdf:about="{$InstrumentsBaseUrl}/{local:FormatId(string(substring-after(eid,'_')))}{$bt_hs_suffix}">
            <skos:prefLabel>
              <xsl:value-of select="label"/>
            </skos:prefLabel>
            <skos:inScheme rdf:resource="{$InstrumentsBaseUrl}/" />
          </skos:Concept>
        </skos:broader>
      </xsl:for-each>
      <!--spécifiques-->
      <xsl:for-each select="relation[type='NT']">
        <!--xsl:variable name="nt_hs_suffix"><xsl:if test="normalize-space(/Idesia/term/mimoType)!=''">/<xsl:value-of select="substring-before(label,' ')"/></xsl:if></xsl:variable-->
        <xsl:variable name="nt_hs_suffix"></xsl:variable>
        <skos:narrower>
          <skos:Concept rdf:about="{$InstrumentsBaseUrl}/{local:FormatId(string(substring-after(eid,'_')))}{$nt_hs_suffix}">
            <skos:prefLabel>
              <xsl:value-of select="label"/>
            </skos:prefLabel>
            <skos:inScheme rdf:resource="{$InstrumentsBaseUrl}/" />
          </skos:Concept>
        </skos:narrower>
      </xsl:for-each>
      <!--relatifs-->
      <xsl:for-each select="relation[type='RT']">
        <!--xsl:variable name="rt_hs_suffix"><xsl:if test="normalize-space(/Idesia/term/mimoType)=''">/<xsl:value-of select="substring-before(label,' ')"/></xsl:if></xsl:variable-->
        <xsl:variable name="rt_hs_suffix"></xsl:variable>
        <skos:related>
          <skos:Concept rdf:about="{$RelatedBaseUrl}/{local:FormatId(string(substring-after(eid,'_')))}{$rt_hs_suffix}">
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
  </xsl:template>

  <xsl:template match="IFD_AUTCOLL">
    <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:foaf="http://xmlns.com/foaf/0.1/" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:rdaGr2="http://RDVocab.info/ElementsGr2/" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:rdaEnt="http://RDVocab.info/uri/schema/FRBRentitiesRDA/">
      <rdf:Description rdf:about="http://www.mimo-db.eu/InstrumentMaker/Corporation/{local:ExtractAutId(string(@EXTERNALID))}">
        <rdf:type rdf:resource="http://xmlns.com/foaf/0.1/Organization"/>
        <rdf:type rdf:resource="http://RDVocab.info/uri/schema/FRBRentitiesRDA/CorporateBody"/>
        <xsl:if test="string(DATA/LIB)!=''">
          <foaf:name>
            <xsl:value-of select="DATA/LIB"/>
          </foaf:name>
        </xsl:if>
        <xsl:for-each select="DATA/AUTRE_NOM">
          <foaf:name>
            <xsl:value-of select="."/>
          </foaf:name>
        </xsl:for-each>
        <xsl:if test="DATA/DATE_DEBUT!=''">
          <rdaGr2:dateOfEstablishment>
            <xsl:value-of select="DATA/DATE_DEBUT"/>
          </rdaGr2:dateOfEstablishment>
        </xsl:if>
        <xsl:if test="DATA/DATE_FIN!=''">
          <rdaGr2:dateOfTermination>
            <xsl:value-of select="DATA/DATE_FIN"/>
          </rdaGr2:dateOfTermination>
        </xsl:if>
      </rdf:Description>
      <skos:Concept rdf:about="http://www.mimo-db.eu/InstrumentMaker/Corporation/{local:ExtractAutId(string(@EXTERNALID))}">
        <skos:prefLabel>
          <xsl:value-of select="DATA/LIB"/>
        </skos:prefLabel>
        <xsl:for-each select="DATA/AUTRE_NOM">
          <skos:altLabel>
            <xsl:value-of select="."/>
          </skos:altLabel>
        </xsl:for-each>
      </skos:Concept>
    </rdf:RDF>

  </xsl:template>

  <xsl:template match="IFD_AUTFAM">
    <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:foaf="http://xmlns.com/foaf/0.1/" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:rdaGr2="http://RDVocab.info/ElementsGr2/" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:rdaEnt="http://RDVocab.info/uri/schema/FRBRentitiesRDA/">
      <rdf:Description rdf:about="http://www.mimo-db.eu/InstrumentMaker/Family/{local:ExtractAutId(string(@EXTERNALID))}">
        <rdf:type rdf:resource="http://xmlns.com/foaf/0.1/Organization"/>
        <rdf:type rdf:resource="http://RDVocab.info/uri/schema/FRBRentitiesRDA/CorporateBody"/>
        <xsl:if test="string(DATA/LIB)!=''">
          <foaf:name>
            <xsl:value-of select="DATA/LIB"/>
          </foaf:name>
        </xsl:if>
        <xsl:for-each select="DATA/AUTRE_NOM">
          <foaf:name>
            <xsl:value-of select="."/>
          </foaf:name>
        </xsl:for-each>
        <xsl:if test="DATA/DATE_DEBUT!=''">
          <rdaGr2:dateOfEstablishment>
            <xsl:value-of select="DATA/DATE_DEBUT"/>
          </rdaGr2:dateOfEstablishment>
        </xsl:if>
        <xsl:if test="DATA/DATE_FIN!=''">
          <rdaGr2:dateOfTermination>
            <xsl:value-of select="DATA/DATE_FIN"/>
          </rdaGr2:dateOfTermination>
        </xsl:if>
      </rdf:Description>
      <skos:Concept rdf:about="http://www.mimo-db.eu/InstrumentMaker/Family/{local:ExtractAutId(string(@EXTERNALID))}">
        <skos:prefLabel>
          <xsl:value-of select="DATA/LIB"/>
        </skos:prefLabel>
        <xsl:for-each select="DATA/AUTRE_NOM">
          <skos:altLabel>
            <xsl:value-of select="."/>
          </skos:altLabel>
        </xsl:for-each>
      </skos:Concept>
    </rdf:RDF>

  </xsl:template>
  <xsl:template match="IFD_AUTPP">
    <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:foaf="http://xmlns.com/foaf/0.1/" xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:rdaGr2="http://RDVocab.info/ElementsGr2/" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:rdaEnt="http://RDVocab.info/uri/schema/FRBRentitiesRDA/">
      <rdf:Description rdf:about="http://www.mimo-db.eu/InstrumentMaker/Person/{local:ExtractAutId(string(@EXTERNALID))}">
        <rdf:type rdf:resource="http://xmlns.com/foaf/0.1/Person"/>
        <rdf:type rdf:resource="http://RDVocab.info/uri/schema/FRBRentitiesRDA/Person"/>
        <foaf:name>
          <xsl:value-of select="DATA/LIB"/>
          <xsl:if test="DATA/PRENOM!=''">, </xsl:if>
          <xsl:value-of select="DATA/PRENOM"/>
        </foaf:name>
        <xsl:for-each select="DATA/GRP_AUTRENOM/AUTRE_NOM_DISPLAY">
          <foaf:name>
            <xsl:value-of select="."/>
          </foaf:name>
        </xsl:for-each>
        <rdaGr2:preferredNameForThePerson>
          <xsl:value-of select="DATA/LIB"/>
          <xsl:if test="DATA/PRENOM!=''">, </xsl:if>
          <xsl:value-of select="DATA/PRENOM"/>
        </rdaGr2:preferredNameForThePerson>
        <xsl:for-each select="DATA/GRP_AUTRENOM/AUTRE_NOM_DISPLAY">
          <rdaGr2:variantNameForThePerson>
            <xsl:value-of select="."/>
          </rdaGr2:variantNameForThePerson>
        </xsl:for-each>
        <xsl:if test="string(DATA/DATE_NAISSANCE)!=''">
          <rdaGr2:dateOfBirth>
            <xsl:value-of select="DATA/DATE_NAISSANCE"/>
          </rdaGr2:dateOfBirth>
        </xsl:if>
        <xsl:if test="string()!='DATA/DATE_DECES'">
          <rdaGr2:dateOfDeath>
            <xsl:value-of select="DATA/DATE_DECES"/>
          </rdaGr2:dateOfDeath>
        </xsl:if>
        <!---This section will come later-->
        <!--owl:sameAs rdf:resource="http://viaf.org/viaf/34720954/"/-->
        <!--owl:sameAs rdf:resource="http://d-nb.info/gnd/117023531"/-->
      </rdf:Description>
      <skos:Concept rdf:about="http://www.mimo-db.eu/InstrumentMaker/Person/{local:ExtractAutId(string(@EXTERNALID))}">
        <skos:prefLabel>
          <xsl:value-of select="DATA/LIB"/>
          <xsl:if test="DATA/PRENOM!=''">, </xsl:if>
          <xsl:value-of select="DATA/PRENOM"/>
        </skos:prefLabel>
        <xsl:for-each select="DATA/GRP_AUTRENOM/AUTRE_NOM_DISPLAY">
          <skos:altLabel>
            <xsl:value-of select="."/>
          </skos:altLabel>
        </xsl:for-each>
      </skos:Concept>
    </rdf:RDF>
  </xsl:template>

  <msxsl:script implements-prefix="local" language="C#">

    public string CleanString(string str)
    {
    string result = str.Replace(" ","_");
    return result.Replace(",","");
    }

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

    public string ExtractAutId(string str)
    {
    string [] arr;
    string [] arr2;
    int id;
    try {
    arr = str.Split('#');
    arr2 = arr[arr.Length-1].Split('_');
    id = Convert.ToInt32(arr2[arr2.Length-1]);
    return Convert.ToString(id);
    } catch {
    return "";
    }
    }


  </msxsl:script>

</xsl:stylesheet>

