#encoding
# -*- coding: utf8 -*-
from __future__ import unicode_literals

import clean_xml

cleaner = clean_xml.Cleaner("hs.xml", "hs_cleaned.xml")
cleaner.cleanXml()
cleaner.addIdAndDbpediaToEid()
cleaner.addFriendlyNameToLabel()
cleaner.save()