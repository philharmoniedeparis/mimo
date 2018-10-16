#encoding
# -*- coding: utf8 -*-
from __future__ import unicode_literals
import re
import csv
import unicodedata


class Cleaner:


	def __init__(self,sourceFileName, cleanedFileName):

		self.sourceFile = sourceFileName
		self.cleanedFile = cleanedFileName

		# open the file, read it then close it
		xmlFile = open(self.sourceFile, "r")
		self.xmlContent = xmlFile.read().decode('utf8')
		xmlFile.close()

		self.readDbpediaLinks()


	def cleanXml(self):

		#remove remaining "(to be translated)" phrases
		self.xmlContent = re.sub(r'([ ]*)\(to be translated\)', '', self.xmlContent)


	def readDbpediaLinks(self):

		# open cvs file with wikipedia links
		# in the future these links will be stored in the database and be part of the export
		cr = csv.reader(open("../01_Idesia/MIMOwikipedia.csv","rU"),  delimiter=b';')

		self.exactDbpedia = {};
		self.closeDbpedia = {};

		for row in cr:
			if row[7] and row[8] :
				self.closeDbpedia[row[0].decode('utf8')] = row[7].decode('utf8')
			elif row[7] :
				self.exactDbpedia[row[0].decode('utf8')] = row[7].decode('utf8')


	def replaceDbpediaLinks(self):

		# transform all wikipedia in dbpedia links
		pattern = re.compile('en.wikipedia.org/wiki/')
		self.xmlContent = pattern.sub('dbpedia.org/resource/', self.xmlContent)


	def stripZeros(self, eidPart):

		# find the id and return it
		# - as an id if it's a concept
		# - as a referent if it's an alternative label
		numericValue = int(eidPart.group(2))
		if eidPart.group(3) :
			return " referent='" + str(numericValue) + "'"
		else :
			return " id='" + str(numericValue) + "'"


	def getIdAndDbpedia(self, eidNode):

		# add the id to the eid node
		eid = re.search('LEXICON_[\d_]+', eidNode.group(0)).group(0)	

		# find the numeric value
		id = re.sub(r'(LEXICON_)([\d]+)([_\d]*)', self.stripZeros, eid)

		newnode = "<eid" + id + ">" + eid + "</eid>"

		if eid in self.closeDbpedia :
			newnode += "<dbpedia>" + self.closeDbpedia[eid] + "</dbpedia>"
		elif eid in self.exactDbpedia :
			newnode += "<dbpedia exact='true'>" + self.exactDbpedia[eid] + "</dbpedia>"

		# add it as an attribute of the eid node
		return newnode


	def addIdAndDbpediaToEid(self):

		pattern = re.compile('<eid>LEXICON_[\d_]+</eid>')
		self.xmlContent = pattern.sub(self.getIdAndDbpedia, self.xmlContent)


	def friendlyName(self, labelGroup):

		# find the id and return it 
		# - as an id if it's a concept
		# - as a referent if it's an alternative label
		label = labelGroup.group(0)

	  	# label = unicodedata.normalize('NFKD', label).encode('ASCII', 'ignore').decode('ASCII')
	  	label = re.sub(r"[\s\/,!°‘‛’:';]", "-", label)
	  	label = re.sub(r"[+]", "-and-", label)
	  	label = re.sub(r'[\)\(/“”‟"˝″]', "", label)
	  	label = re.sub(r'(-){2,}', "-", label)
		return label


	def getFriendlyNameWithLabel(self, labelNode):

		# add friendly name to the label node
		label = labelNode.group(2).strip()

		# find the friendly name 
		name = re.sub(r'([\w.,/\(\)\s\'\-:+;’]*)', self.friendlyName, label)
		replacement = "<label friendly='" + name + "'>" + label + "</label>"

		# print replacement.encode('utf8')
		# add it as an attribute of the label node
		return replacement


	def addFriendlyNameToLabel(self):

		#self.xmlContent = unicodedata.normalize('NFKD', self.xmlContent).encode('ASCII', 'ignore').decode('ASCII')
		pattern = re.compile(r'(<label>)([\w.()/,:‘‛“”‟"˝″°!’\'\-\s+;]*)(</label>)')
		self.xmlContent = pattern.sub(self.getFriendlyNameWithLabel, self.xmlContent)


	def save(self):

		# open new file to write, put the content and close
		newXmlFile = open(self.cleanedFile, "w")
		newXmlFile.write(self.xmlContent.encode('utf8'))
		newXmlFile.close()
