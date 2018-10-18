<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
	xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:dc="http://purl.org/dc/elements/1.1/">

	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:variable name="ConceptSchemeUrl" select="'http://www.mimo-db.eu/HornbostelAndSachs#'"/>
	<xsl:variable name="InstrumentsBaseUrl" select="'http://www.mimo-db.eu/HornbostelAndSachs'"/>
	<xsl:variable name="RelatedBaseUrl" select="'http://www.mimo-db.eu/InstrumentsKeywords'"/>
	<xsl:variable name="Languages">
		<i key="0">en</i>
	</xsl:variable>

	<xsl:template match="hs">
		<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:skos="http://www.w3.org/2004/02/skos/core#"
			xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:dc="http://purl.org/dc/elements/1.1/">

			<skos:ConceptScheme rdf:about="{$ConceptSchemeUrl}">
				<skos:prefLabel>
					<xsl:attribute name="xml:lang">en</xsl:attribute>
					<xsl:value-of>Hornbostel and Sachs classification</xsl:value-of>
				</skos:prefLabel>
				<xsl:apply-templates select="term" mode="ConceptSchemeHornbostelSachs"/>
				<xsl:apply-templates select="term" mode="ConceptSchemeHornbostelSachsTopConcept"/>
			</skos:ConceptScheme>

			<xsl:apply-templates select="term" mode="Concepts"/>

		</rdf:RDF>
	</xsl:template>

	<!-- Concept Scheme : term with id LEXICON_00000000, "Hornbostel & Sachs" -->
	<xsl:template match="term" mode="ConceptSchemeHornbostelSachs">
		<xsl:if test="(eid='LEXICON_00000000')">

			<!-- Preferred label in the main language -->
			<xsl:if test="normalize-space(label)!=''">
				<skos:prefLabel>
					<xsl:if test="(normalize-space(language)!='')">
						<xsl:variable name="language" select="normalize-space(language)"/>
						<xsl:attribute name="xml:lang" select="$Languages/i[@key=$language]"/>
					</xsl:if>
					<xsl:value-of select="normalize-space(label)"/>
				</skos:prefLabel>
			</xsl:if>
			<!-- /Preferred label in the main language -->

		</xsl:if>
	</xsl:template>
	<!-- /Concept Scheme -->

	<!-- Top concepts in the thesaurus : terms whose parent is LEXICON_00000000 -->
	<xsl:template match="term" mode="ConceptSchemeHornbostelSachsTopConcept">
		<xsl:if test="(relation[type='BT']) and (relation[eid='LEXICON_00000000'])">
			<skos:hasTopConcept rdf:resource="{$InstrumentsBaseUrl}/{eid/@id}"/>
		</xsl:if>
	</xsl:template>
	<!-- /Top concepts -->

	<!-- Concepts -->
	<xsl:template match="term" mode="Concepts">

		<!-- Leave out LEXICON_00000000 which is not a concept -->
		<xsl:if test="eid != 'LEXICON_00000000'">
			<skos:Concept rdf:about="{$InstrumentsBaseUrl}/{eid/@id}">

				<!-- Relation to the concept scheme -->
				<xsl:choose>
					<xsl:when test="(relation[type='BT']) and(relation[eid='LEXICON_00000000'])">
						<skos:inScheme rdf:resource="{$ConceptSchemeUrl}"/>
						<skos:topConceptOf rdf:resource="{$ConceptSchemeUrl}"/>
					</xsl:when>
					<xsl:otherwise>
						<skos:inScheme rdf:resource="{$ConceptSchemeUrl}"/>
					</xsl:otherwise>
				</xsl:choose>
				<!-- /Relation to the concept scheme -->

				<!-- Preferred label in the main language -->
				<xsl:if test="normalize-space(label)!=''">
					<skos:prefLabel>
						<xsl:if test="(normalize-space(language)!='')">
							<xsl:variable name="language" select="normalize-space(language)"/>
							<xsl:attribute name="xml:lang" select="$Languages/i[@key=$language]"/>
						</xsl:if>
						<xsl:value-of select="normalize-space(label)"/>
					</skos:prefLabel>
				</xsl:if>
				<!-- /Preferred label in the main language -->

				<!-- definition -->
				<xsl:if test="normalize-space(definition)!=''">
					<skos:definition>
						<xsl:if test="(normalize-space(language)!='')">
							<xsl:variable name="language" select="normalize-space(language)"/>
							<xsl:attribute name="xml:lang" select="$Languages/i[@key=$language]"/>
						</xsl:if>
						<xsl:value-of select="normalize-space(definition)"/>
					</skos:definition>
				</xsl:if>
				<!-- /definition -->

				<!-- applicationNote -->
				<xsl:if test="normalize-space(applicationNote)">
					<skos:scopeNote>
						<xsl:if test="(normalize-space(language)!='')">
							<xsl:variable name="language" select="normalize-space(language)"/>
							<xsl:attribute name="xml:lang" select="$Languages/i[@key=$language]"/>
						</xsl:if>
						<xsl:value-of select="normalize-space(applicationNote)"/>
					</skos:scopeNote>
				</xsl:if>
				<!-- /applicationNote -->

				<!-- explainNote -->
				<xsl:if test="normalize-space(explainNote)">
					<skos:note>
						<xsl:if test="(normalize-space(language)!='')">
							<xsl:variable name="language" select="normalize-space(language)"/>
							<xsl:attribute name="xml:lang" select="$Languages/i[@key=$language]"/>
						</xsl:if>
						<xsl:value-of select="normalize-space(explainNote)"/>
					</skos:note>
				</xsl:if>
				<!-- /explainNote -->

				<!-- Parent concepts -->
				<xsl:for-each select="relation[type='BT']">
					<xsl:if test="eid !='LEXICON_00000000'">
						<skos:broader rdf:resource="{$InstrumentsBaseUrl}/{eid/@id}"/>
					</xsl:if>
				</xsl:for-each>
				<!-- /Parent concepts -->

				<!-- Children concepts -->
				<xsl:for-each select="relation[type='NT']">
					<skos:narrower rdf:resource="{$InstrumentsBaseUrl}/{eid/@id}"/>
				</xsl:for-each>
				<!-- /Children concepts -->

				<!-- Equivalents MIMO keywords -->
				<xsl:for-each select="relation[type='RT']">
					<skos:exactMatch rdf:resource="{$RelatedBaseUrl}/{eid/@id}"/>
				</xsl:for-each>
				<!-- /Equivalents MIMO keywords -->

				<!-- createdBy -->
				<xsl:if test="normalize-space(createdBy)!=''">
					<dc:creator>
						<xsl:value-of select="normalize-space(createdBy)"/>
					</dc:creator>
				</xsl:if>
				<!-- /createdBy -->

				<!-- createdDate -->
				<xsl:if test="normalize-space(createdDate)!=''">
					<dc:created>
						<xsl:value-of select="normalize-space(createdDate)"/>
					</dc:created>
				</xsl:if>
				<!-- /createdDate -->

			</skos:Concept>
		</xsl:if>
	</xsl:template>
	<!-- /Concepts -->

</xsl:stylesheet>
