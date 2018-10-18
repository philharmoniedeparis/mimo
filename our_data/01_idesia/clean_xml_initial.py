#encoding
# -*- coding: utf8 -*-
from __future__ import unicode_literals
import re
import csv
import unicodedata


class Cleaner:


        def __init__(self, sourceFileName, cleanedFileName):

		self.sourceFile = sourceFileName
		self.cleanedFile = cleanedFileName

		# open the source file, read it then close it
		xmlFile = open(self.sourceFile, "r")
		self.xmlContent = xmlFile.read().decode('utf8')
		xmlFile.close()


	def cleanXml(self):

		# remove all empty tags
		self.xmlContent = re.sub(r'<[a-zA-Z ]+/>', '', self.xmlContent)

		# remove all nodes with no valuable content
		self.xmlContent = re.sub(r'<forms>(.*?)</forms>', '', self.xmlContent)
		self.xmlContent = re.sub(r'<relationtypes>(.*?)</relationtypes>', '', self.xmlContent)
		self.xmlContent = re.sub(r'<lexicontypes>(.*?)</lexicontypes>', '', self.xmlContent)
		self.xmlContent = re.sub(r'<propertytypes>(.*?)</propertytypes>', '', self.xmlContent)
		self.xmlContent = re.sub(r'<relationsets>(.*?)</relationsets>', '', self.xmlContent)
		self.xmlContent = re.sub(r'<parameters>(.*?)</parameters>', '', self.xmlContent)
		self.xmlContent = re.sub(r'<thesaurus (.*?)>(.*?)</thesaurus>', '', self.xmlContent)
		self.xmlContent = re.sub(r'<createdDate>(.*?)</createdDate>', '', self.xmlContent)
		self.xmlContent = re.sub(r'<createdBy>(.*?)</createdBy>', '', self.xmlContent)
		self.xmlContent = re.sub(r'<status>(.*?)</status>', '', self.xmlContent)
		self.xmlContent = re.sub(r'<reference>(.*?)</reference>', '', self.xmlContent)
		self.xmlContent = re.sub(r'<source>(.*?)</source>', '', self.xmlContent)
		self.xmlContent = re.sub(r'<externalLinksCount>(.*?)</externalLinksCount>', '', self.xmlContent)
		self.xmlContent = re.sub(r'<extraproperties>(.*?)</extraproperties>', '', self.xmlContent)
		self.xmlContent = re.sub(r'<history>(.*?)</history>', '', self.xmlContent)

		# clean labels
		self.xmlContent = re.sub(r'<label>([ ]*)', '<label>', self.xmlContent)
		self.xmlContent = re.sub(r'([ ]*)</label>', '</label>', self.xmlContent)

		# transform all language specifications
		self.xmlContent = re.sub(r'<language>DEFAULT_FORM</language>', '<language>0</language>', self.xmlContent)
		self.xmlContent = re.sub(r'<language>EN</language>', '<language>1</language>', self.xmlContent)
		self.xmlContent = re.sub(r'<language>FR</language>', '<language>2</language>', self.xmlContent)
		self.xmlContent = re.sub(r'<language>IT</language>', '<language>3</language>', self.xmlContent)
		self.xmlContent = re.sub(r'<language>DE</language>', '<language>4</language>', self.xmlContent)
		self.xmlContent = re.sub(r'<language>NL</language>', '<language>5</language>', self.xmlContent)
		self.xmlContent = re.sub(r'<language>SV</language>', '<language>6</language>', self.xmlContent)
		self.xmlContent = re.sub(r'<language>CA</language>', '<language>7</language>', self.xmlContent)
		self.xmlContent = re.sub(r'<language>PL</language>', '<language>8</language>', self.xmlContent)
		self.xmlContent = re.sub(r'<language>ZH</language>', '<language>9</language>', self.xmlContent)
		self.xmlContent = re.sub(r'<language>ES</language>', '<language>10</language>', self.xmlContent)
		self.xmlContent = re.sub(r'<language>EU</language>', '<language>11</language>', self.xmlContent)
		self.xmlContent = re.sub(r'<form>0</form>', '<language>0</language>', self.xmlContent)
		self.xmlContent = re.sub(r'<form>1</form>', '<language>1</language>', self.xmlContent)
		self.xmlContent = re.sub(r'<form>2</form>', '<language>2</language>', self.xmlContent)
		self.xmlContent = re.sub(r'<form>3</form>', '<language>3</language>', self.xmlContent)
		self.xmlContent = re.sub(r'<form>4</form>', '<language>4</language>', self.xmlContent)
		self.xmlContent = re.sub(r'<form>5</form>', '<language>5</language>', self.xmlContent)
		self.xmlContent = re.sub(r'<form>6</form>', '<language>6</language>', self.xmlContent)
		self.xmlContent = re.sub(r'<form>7</form>', '<language>7</language>', self.xmlContent)
		self.xmlContent = re.sub(r'<form>8</form>', '<language>8</language>', self.xmlContent)
		self.xmlContent = re.sub(r'<form>9</form>', '<language>9</language>', self.xmlContent)
		self.xmlContent = re.sub(r'<form>10</form>', '<language>10</language>', self.xmlContent)
		self.xmlContent = re.sub(r'<form>11</form>', '<language>11</language>', self.xmlContent)

		# remove all declarations in relation tag
		self.xmlContent = re.sub(r'<relation(.*?)>', '<relation>', self.xmlContent)

		# transform relation type USE to UF
		self.xmlContent = re.sub(r'<type>USE</type>', '<type>UF</type>', self.xmlContent)


	def save(self):

		# open destination file, write the content and close
		newXmlFile = open(self.cleanedFile, "w")
		newXmlFile.write(self.xmlContent.encode('utf8'))
		newXmlFile.close()
