<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
  xmlns:skos="http://www.w3.org/2004/02/skos/core#"
  xmlns:owl="http://www.w3.org/2002/07/owl#"
  xmlns:dc="http://purl.org/dc/elements/1.1/">
  
  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
  
 
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

      {
        "name": "Thesaurus MIMO",
        "children": [
          <xsl:apply-templates select="term" mode="ParentConcepts" />
        ]
      }

    
  </xsl:template>
  

  <!-- ParentConcepts -->
  <xsl:template match="term" mode="ParentConcepts">
    
    <!-- leave out nodes which have no id attribute (ie translations, which have a referent attribute instead) -->
    <!-- and nodes which have no parent and no children (they are only synonyms) -->
    <!-- as well as Musical Instruments (LEXICON_2204), which is not a concept -->
    <xsl:if test=" (relation[type='BT']) ">
      <xsl:for-each select="relation[type='BT']">
        <xsl:if test="(eid/@id ='LEXICON_2204')">
        {
          "name":
          
          <!-- Prefered Label in the main language -->
              <xsl:if test="(normalize-space(language)!='') and (language!='0')">
                <xsl:variable name="language" select="language" />
                <xsl:attribute name="xml:lang" select="$Languages/i[@key=$language]" />
              </xsl:if>
              <xsl:value-of select="normalize-space(label)"/>  
          <!-- /Prefered Label in the main language -->
          
          ,"children": [
          <!-- children Concepts -->
          <xsl:for-each select="relation[type='NT']">
            <xsl:value-of select="normalize-space(label)"/>
          </xsl:for-each>
          <!-- /children Concepts -->
          ]
        }
        </xsl:if>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>
  <!-- / ParentConcepts -->
  
  
</xsl:stylesheet>