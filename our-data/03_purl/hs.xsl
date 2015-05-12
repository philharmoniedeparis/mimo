<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >

  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
  
  <xsl:variable name="InstrumentsBaseUrl" select="'http://www.mimo-db.eu/HornbostelAndSachs'"></xsl:variable>


  <xsl:template match="hs">

    <purls>
      
      <xsl:apply-templates select="term" mode="Concepts" />
      
    </purls>
    
  </xsl:template>
  
  
  <!-- Concepts -->
  <xsl:template match="term" mode="Concepts">
    
    <!-- leave out LEXICON_00000000 which is not a concept -->
    <xsl:if test="eid != 'LEXICON_00000000'">
      <purl id="hs/{eid/@id}/{label/@friendly}/">
        
        <maintainers>
          <uid>mdestandau@cite-musique.fr</uid>
        </maintainers>
        <target url="{InstrumentsBaseUrl}/{eid/@id}/{label/@friendly}/"/>
        
      </purl>
    </xsl:if>
  </xsl:template>
  <!-- / Concepts -->

</xsl:stylesheet>