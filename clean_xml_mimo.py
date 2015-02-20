# CLEANING THE XML EXPORT FROM IDESIA

import re



# opens the file, reads it then close it
xmlFile = open("keywords.xml", "r")
xmlContent = xmlFile.read()
xmlFile.close()

# mends the closing tag (replaces <keywords/> with </keywords>)
xmlContent = xmlContent.replace("<keywords/>", "</keywords>")

# removes all Idesia nodes (but not their content)
xmlContent = xmlContent.replace("<Idesia>", "")
xmlContent = xmlContent.replace("</Idesia>", "")

# removes all Thesaurus nodes (with their content)
xmlContent = re.sub('<thesaurus>.*?</thesaurus>', '', xmlContent)




#for each eid node
eidNodes = re.findall('<eid>.*?</eid>', xmlContent)
for eidNode in eidNodes:
	print eidNode
	# finds the numeric value
	numericValue = eidNode.replace("<eid>LEXICON_", "")
	numericValue = numericValue.replace("</eid>", "")
	numericValue = int(numericValue)
	# adds it as an attribute of the eid node
	print numericValue
	xmlContent = eidNode.replace(eidNode, "<eid id='" + str(numericValue) + "'>")
	print eidNode
	break

print eidNodes

# opens new file to write, puts the content and closes
newXmlFile = open("keywords_cleaned.xml", "w")
newXmlFile.write(xmlContent)
newXmlFile.close()