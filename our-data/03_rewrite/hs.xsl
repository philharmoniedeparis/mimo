<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
  xmlns:skos="http://www.w3.org/2004/02/skos/core#"
  xmlns:owl="http://www.w3.org/2002/07/owl#"
  xmlns:dc="http://purl.org/dc/elements/1.1/">
  
  <xsl:output method="text" encoding="UTF-8" indent="yes" omit-xml-declaration = "yes" />
  
  
  <!-- Concepts -->
  <xsl:template match="hs">
    <xsl:for-each select="term">
      <!-- leave out nodes which have no id attribute (ie translations, which have a referent attribute instead) -->
      <!-- and nodes which have no parent and no children (they are only synonyms) -->
      <!-- as well as Musical Instruments (LEXICON_2204), which is not a concept -->
      <xsl:if test="(eid/@id) and ( (relation[type='BT']) or (relation[type='NT']) ) and (eid != 'LEXICON_00000000')">
        <xsl:value-of select="eid/@id" />
        <xsl:text>&#160;</xsl:text>
        <xsl:value-of select="label/@friendly" />
        <xsl:text>&#xd;</xsl:text>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>
  <!-- / Concepts -->
  
  
</xsl:stylesheet>