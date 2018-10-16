#encoding
# -*- coding: utf8 -*-
from __future__ import unicode_literals
import clean_xml_initial


cleaner = clean_xml_initial.Cleaner("Export_Idesia_initial.xml", "Export_Idesia_clean.xml")
cleaner.cleanXml()
cleaner.save()
