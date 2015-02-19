# CLEANING THE XML EXPORT FROM IDESIA

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
import re
xmlContent = re.sub('<thesaurus>.*?</thesaurus>', '', xmlContent)

# opens new file to write, puts the content and closes
newXmlFile = open("keywords_transformed.xml", "w")
newXmlFile.write(xmlContent)
newXmlFile.close()