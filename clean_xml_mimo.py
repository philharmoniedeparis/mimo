# CLEANING THE XML EXPORT FROM IDESIA

import re



# open the file, read it then close it
xmlFile = open("keywords.xml", "r")
xmlContent = xmlFile.read()
xmlFile.close()


# mend the closing tag (replaces <keywords/> with </keywords>)
xmlContent = xmlContent.replace("<keywords/>", "</keywords>")


# remove all Idesia nodes (but not their content)
xmlContent = xmlContent.replace("<Idesia>", "")
xmlContent = xmlContent.replace("</Idesia>", "")


# remove all Thesaurus nodes (with their content)
xmlContent = re.sub('<thesaurus>.*?</thesaurus>', '', xmlContent)

# remove all declarations in keywords tag
xmlContent = re.sub('<keywords.*?>', '<keywords>', xmlContent)


def stripZeros(eidPart):
	numericValue = int(eidPart.group(0))
	return str(numericValue)

def addIdToEid(eidNode):
	eid = re.search('LEXICON_[\d_]+', eidNode.group(0)).group(0)	
	# find the numeric value
	id = re.sub(r'\d+', stripZeros, eid)

	# add it as an attribute of the eid node
	return "<eid id='" + id + "'>" + eid + "</eid>" 

pattern = re.compile('<eid>LEXICON_[\d_]+</eid>')
xmlContent = pattern.sub(addIdToEid, xmlContent)


#print xmlContent

# open new file to write, put the content and close
newXmlFile = open("keywords_cleaned.xml", "w")
newXmlFile.write(xmlContent)
newXmlFile.close()