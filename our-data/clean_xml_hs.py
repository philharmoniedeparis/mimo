#encoding
# -*- coding: utf8 -*-
from __future__ import unicode_literals

import clean_xml

cleaner = clean_xml.Cleaner("01_idesia/hs.xml", "02_cleaned/hs.xml")
cleaner.cleanXml()
cleaner.addIdAndDbpediaToEid()
cleaner.addFriendlyNameToLabel()
cleaner.save()