#encoding
# -*- coding: utf8 -*-
from __future__ import unicode_literals

import re
import csv

cr = csv.reader(open("../01_idesia/MIMO_Thesaurus.csv","rU"),  delimiter=b';')

last = 0
for index, row in enumerate(cr):
	if row[1] :
		print (index)
		if(last )
		print ("1--" + row[1].decode('utf8'))
	elif row[2] :
		if index >0 and cr[index-1] and cr[index-1][1]:
			print "------------- début"
		print ("2----" + row[2].decode('utf8'))

	#elif row[3] :
		#print ("3--------" + row[3].decode('utf8'))
		