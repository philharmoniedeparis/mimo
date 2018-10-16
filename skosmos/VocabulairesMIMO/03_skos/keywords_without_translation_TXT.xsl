<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
	xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:dc="http://purl.org/dc/elements/1.1/">

	<xsl:output method="text" encoding="UTF-8"/>

	<xsl:template match="rdf:RDF">
		<xsl:apply-templates select="./skos:Concept"/>
	</xsl:template>

	<xsl:template match="skos:Concept">
		<xsl:if test="count(./skos:prefLabel)=1">
			<xsl:text>Concept : </xsl:text>
			<xsl:value-of select="./@rdf:about"/>
			<xsl:text>
</xsl:text>
			<xsl:text>    Keyword : </xsl:text>
			<xsl:value-of select="./skos:prefLabel/text()"/>
			<xsl:text>
</xsl:text>
			<xsl:text>
</xsl:text>
		</xsl:if>
	</xsl:template>

</xsl:stylesheet>
