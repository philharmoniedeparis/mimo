#encoding
# -*- coding: utf8 -*-
from __future__ import unicode_literals
import clean_xml_02


cleaner = clean_xml_02.Cleaner("../01_idesia/hs_01.xml", "hs_02.xml")
cleaner.cleanXml()
cleaner.addIdAndDbpediaToEid()
cleaner.addFriendlyNameToLabel()
cleaner.replaceDbpediaLinks()
cleaner.save()
