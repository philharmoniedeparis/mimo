<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
	xmlns:skos="http://www.w3.org/2004/02/skos/core#" xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:dc="http://purl.org/dc/elements/1.1/">

	<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
	<xsl:variable name="ConceptSchemeUrl" select="'http://www.mimo-db.eu/InstrumentsKeywords#'"/>
	<xsl:variable name="InstrumentsBaseUrl" select="'http://www.mimo-db.eu/InstrumentsKeywords'"/>
	<xsl:variable name="RelatedBaseUrl" select="'http://www.mimo-db.eu/HornbostelAndSachs'"/>
	<xsl:variable name="Languages">
		<i key="0"/>
		<i key="1">en</i>
		<i key="2">fr</i>
		<i key="3">it</i>
		<i key="4">de</i>
		<i key="5">nl</i>
		<i key="6">sv</i>
		<i key="7">ca</i>
		<i key="8">pl</i>
		<i key="9">zh</i>
		<i key="10">es</i>
		<i key="11">eu</i>
	</xsl:variable>

	<xsl:template match="keywords">
		<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#" xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:skos="http://www.w3.org/2004/02/skos/core#"
			xmlns:owl="http://www.w3.org/2002/07/owl#" xmlns:dc="http://purl.org/dc/elements/1.1/">

			<skos:ConceptScheme rdf:about="{$ConceptSchemeUrl}">
				<xsl:apply-templates select="term" mode="ConceptSchemeMusicalInstrumentName"/>
				<xsl:apply-templates select="term" mode="ConceptSchemeMusicalInstrumentTopConcept"/>
			</skos:ConceptScheme>

			<xsl:apply-templates select="term" mode="Concepts"/>

		</rdf:RDF>
	</xsl:template>

	<!-- Concept Scheme : term with id LEXICON_00002204, "Musical Instruments" -->
	<xsl:template match="term" mode="ConceptSchemeMusicalInstrumentName">
		<xsl:if test="(eid/@id) and (eid/@id = '2204')">

			<!-- Preferred label in the main language -->
			<xsl:if test="normalize-space(label)!=''">
				<skos:prefLabel>
					<xsl:if test="(normalize-space(language)!='') and (language!='0')">
						<xsl:variable name="language" select="normalize-space(language)"/>
						<xsl:attribute name="xml:lang" select="$Languages/i[@key=$language]"/>
					</xsl:if>
					<xsl:value-of select="normalize-space(label)"/>
				</skos:prefLabel>
			</xsl:if>
			<!-- /Preferred label in the main language -->

			<!-- Translation : preferred labels in other languages -->
			<xsl:for-each select="relation[type='LE']">
				<xsl:variable name="termEid" select="eid"/>
				<skos:prefLabel>
					<xsl:if test="(normalize-space(language)!='') and (language!='0')">
						<xsl:variable name="language" select="normalize-space(language)"/>
						<xsl:attribute name="xml:lang" select="$Languages/i[@key=$language]"/>
					</xsl:if>
					<xsl:value-of select="normalize-space(label)"/>
				</skos:prefLabel>
			</xsl:for-each>
			<!-- /Translation : preferred labels in other languages -->

		</xsl:if>
	</xsl:template>
	<!-- /Concept Scheme -->

	<!-- Top concepts in the thesaurus : terms whose parent is LEXICON_00002204 -->
	<xsl:template match="term" mode="ConceptSchemeMusicalInstrumentTopConcept">
		<xsl:if test="(relation[type='BT']) and (relation[eid='LEXICON_00002204'])">
			<skos:hasTopConcept rdf:resource="{$InstrumentsBaseUrl}/{eid/@id}"/>
		</xsl:if>
	</xsl:template>
	<!-- /Top concepts -->

	<!-- Concepts -->
	<xsl:template match="term" mode="Concepts">

		<!-- Leave out nodes which have no id attribute (ie translations, which have a referent attribute instead) -->
		<!-- and nodes which have no parent and no children (they are only synonyms) -->
		<!-- as well as Musical Instruments (LEXICON_00002204), which is not a concept -->
		<!-- as well as Hornbostel - Sachs (LEXICON_00000000), which is not a concept -->
		<xsl:if test="(eid/@id) and ((relation[type='BT']) or (relation[type='NT'])) and (eid/@id != '2204') and (eid/@id != '0')">

			<skos:Concept rdf:about="{$InstrumentsBaseUrl}/{eid/@id}">

				<!-- Relation to the concept scheme -->
				<xsl:choose>
					<!-- either top concept -->
					<xsl:when test="(relation[type='BT']) and (relation[eid='LEXICON_00002204'])">
						<skos:inScheme rdf:resource="{$ConceptSchemeUrl}"/>
						<skos:topConceptOf rdf:resource="{$ConceptSchemeUrl}"/>
					</xsl:when>
					<!-- or simply part of it -->
					<xsl:otherwise>
						<skos:inScheme rdf:resource="{$ConceptSchemeUrl}"/>
					</xsl:otherwise>
				</xsl:choose>
				<!-- /Relation to the concept scheme -->

				<!-- Preferred label in the main language -->
				<xsl:if test="string(label)!=''">
					<skos:prefLabel>
						<xsl:if test="(normalize-space(language)!='') and (language!='0')">
							<xsl:variable name="language" select="normalize-space(language)"/>
							<xsl:attribute name="xml:lang" select="$Languages/i[@key=$language]"/>
						</xsl:if>
						<xsl:value-of select="normalize-space(label)"/>
					</skos:prefLabel>
				</xsl:if>
				<!-- /Preferred label in the main language -->

				<!-- Translation : preferred labels in other languages -->
				<xsl:for-each select="relation[type='LE']">
					<xsl:variable name="termEid">
						<xsl:value-of select="eid"/>
					</xsl:variable>
					<skos:prefLabel>
						<xsl:if test="(normalize-space(language)!='') and (language!='0')">
							<xsl:variable name="language" select="normalize-space(language)"/>
							<xsl:attribute name="xml:lang" select="$Languages/i[@key=$language]"/>
						</xsl:if>
						<xsl:value-of select="normalize-space(label)"/>
					</skos:prefLabel>
				</xsl:for-each>
				<!-- /Translation : preferred labels in other languages -->

				<!-- Alternative labels -->
				<xsl:for-each select="relation[type='UF']">
					<skos:altLabel>
						<xsl:if test="(normalize-space(language)!='') and (language!='0')">
							<xsl:variable name="language" select="normalize-space(language)"/>
							<xsl:attribute name="xml:lang" select="$Languages/i[@key=$language]"/>
						</xsl:if>
						<xsl:value-of select="normalize-space(label)"/>
					</skos:altLabel>
				</xsl:for-each>
				<!-- /Alternative labels -->

				<!-- Alternative label linked to another language -->
				<!-- iterates through the terms which referent is this one -->
				<!-- and gets all UF relations -->
				<!-- heavy stuff for the processor -->
				<xsl:variable name="InstrumentId" select="eid/@id"/>
				<xsl:for-each select="following-sibling::*/eid[@referent = $InstrumentId]">
					<xsl:for-each select="../relation[type='UF']">
						<skos:altLabel>
							<xsl:if test="(normalize-space(language)!='') and (language!='0')">
								<xsl:variable name="language" select="normalize-space(language)"/>
								<xsl:attribute name="xml:lang" select="$Languages/i[@key=$language]"/>
							</xsl:if>
							<xsl:value-of select="normalize-space(label)"/>
						</skos:altLabel>
					</xsl:for-each>
				</xsl:for-each>
				<!-- /Alternative label linked to another language -->

				<!-- definition -->
				<xsl:if test="string(definition)!=''">
					<skos:definition>
						<xsl:if test="(normalize-space(language)!='') and (language!='0')">
							<xsl:variable name="language" select="normalize-space(language)"/>
							<xsl:attribute name="xml:lang" select="$Languages/i[@key=$language]"/>
						</xsl:if>
						<xsl:value-of select="definition"/>
					</skos:definition>
				</xsl:if>
				<!-- /definition -->

				<!-- applicationNote -->
				<xsl:if test="normalize-space(applicationNote)">
					<skos:scopeNote>
						<xsl:if test="(normalize-space(language)!='') and (language!='0')">
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
						<xsl:if test="(normalize-space(language)!='') and (language!='0')">
							<xsl:variable name="language" select="normalize-space(language)"/>
							<xsl:attribute name="xml:lang" select="$Languages/i[@key=$language]"/>
						</xsl:if>
						<xsl:value-of select="normalize-space(explainNote)"/>
					</skos:note>
				</xsl:if>
				<!-- /explainNote -->

				<!-- Parent concepts -->
				<xsl:for-each select="relation[type='BT']">
					<xsl:if test="eid !='LEXICON_00002204'">
						<skos:broader rdf:resource="{$InstrumentsBaseUrl}/{eid/@id}"/>
					</xsl:if>
				</xsl:for-each>
				<!-- /Parent concepts -->

				<!-- Children concepts -->
				<xsl:for-each select="relation[type='NT']">
					<skos:narrower rdf:resource="{$InstrumentsBaseUrl}/{eid/@id}"/>
				</xsl:for-each>
				<!-- /Children concepts -->

				<!-- Equivalents HornBostel and Sachs -->
				<xsl:for-each select="relation[type='RT']">
					<skos:exactMatch rdf:resource="{$RelatedBaseUrl}/{eid/@id}"/>
				</xsl:for-each>
				<!-- /Equivalents HornBostel and Sachs -->

				<!-- Dbpedia links -->
				<xsl:if test="dbpedia">
					<xsl:choose>
						<xsl:when test="@exact='true'">
							<skos:exactMatch rdf:resource="{normalize-space(dbpedia)}"/>
						</xsl:when>
						<xsl:otherwise>
							<skos:closeMatch rdf:resource="{normalize-space(dbpedia)}"/>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<!-- /Dbpedia links -->

				<!-- createdBy -->
				<xsl:if test="string(createdBy)!=''">
					<dc:creator select="createdBy"/>
				</xsl:if>
				<!-- /createdBy -->

				<!-- createdDate -->
				<xsl:if test="string(createdDate)!=''">
					<dc:created select="createdDate"/>
				</xsl:if>
				<!-- /createdDate -->

			</skos:Concept>
		</xsl:if>
	</xsl:template>
	<!-- /Concepts -->

</xsl:stylesheet>
