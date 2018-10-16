#encoding
# -*- coding: utf8 -*-
from __future__ import unicode_literals
import clean_xml_02


cleaner = clean_xml_02.Cleaner("../01_idesia/keywords_01.xml", "keywords_02.xml")
cleaner.cleanXml()
cleaner.addIdAndDbpediaToEid()
cleaner.addFriendlyNameToLabel()
cleaner.replaceDbpediaLinks()
cleaner.save()
