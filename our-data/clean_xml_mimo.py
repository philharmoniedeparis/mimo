# CLEANING THE XML EXPORT FROM IDESIA

import re



# open the file, read it then close it
xmlFile = open("keywords.xml", "r")
xmlContent = xmlFile.read()
xmlFile.close()


# mend the closing tag (replaces <keywords/> with </keywords>)
xmlContent = xmlContent.replace("<keywords/>", "</keywords>")


# remove all Idesia nodes (but not their content)
# to make the xml more readable
xmlContent = xmlContent.replace("<Idesia>", "")
xmlContent = xmlContent.replace("</Idesia>", "")


# remove all Thesaurus nodes (with their content)
# same node repeated for each term with no valuable info
xmlContent = re.sub('<thesaurus>.*?</thesaurus>', '', xmlContent)


# remove all declarations in keywords tag
xmlContent = re.sub('<keywords.*?>', '<keywords>', xmlContent)


# remove all nodes with 2 _ _ in the id
# ex : LEXICON_3788
# is also exported LEXICON_00003788_1, LEXICON_00003788_2, LEXICON_00003788_3, LEXICON_00003788_4, LEXICON_00003788_5, LEXICON_00003788_6, LEXICON_00003788_7...
# (one for each language)
# but all languages are already described in LEXICON_00003788
# so these are duplicates
# in fact we will need these to extract the synonyms based on one language only
# xmlContent = re.sub('<term><eid>LEXICON_[\d_]+_[\d_]+</eid>.*?</term>', '', xmlContent)
# instead will we indicate the id of the referent (parent="")


# open cvs file with wikipedia links
# in the fututre these links will be stored in the database and be part of the export
import csv
cr = csv.reader(open("MIMOwikipedia.csv","rU"),  delimiter=';')

# transform all wikipedia in dbpedia links
pattern = re.compile('en.wikipedia.org/wiki/')
xmlContent = pattern.sub('dbpedia.org/resource', xmlContent)

dbpedia = {};

for row in cr:
	if row[7] :
		dbpedia[row[0]] = row[7]


# find the dbpedia link
def stripZeros(eidPart):
	numericValue = int(eidPart.group(2))
	if eidPart.group(3) :
		return " referent='" + str(numericValue) + "'"
	else :
		return " id='" + str(numericValue) + "'"


# add the id to the eid node
def addIdToEid(eidNode):
	eid = re.search('LEXICON_[\d_]+', eidNode.group(0)).group(0)	
	# find the numeric value
	id = re.sub(r'(LEXICON_)([\d]+)([_\d]*)', stripZeros, eid)


	newnode = "<eid" + id + ">" + eid + "</eid>"

	if eid in dbpedia :
		newnode += "<dbpedia>" + dbpedia[eid] + "</dbpedia>"

	# add it as an attribute of the eid node

	return newnode


pattern = re.compile('<eid>LEXICON_[\d_]+</eid>')
xmlContent = pattern.sub(addIdToEid, xmlContent)


#print xmlContent

# open new file to write, put the content and close
newXmlFile = open("keywords_cleaned.xml", "w")
newXmlFile.write(xmlContent)
newXmlFile.close()