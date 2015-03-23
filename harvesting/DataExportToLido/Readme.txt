INFO:

This XSLT contains a mapping between ADLIB unstructured XML Export to LIDO, 
following MIMO constraints.

HOW TO USE:

   Export unstructured Adlib XML from Adlib – this creates XML with the same element names as the source data fields in Adlib (I’ve added some comments in the XSLT to show the data fields mapped).

a.      It’s OK to export complete records from Adlib, the XSLT will discard any unused elements

2.)    Open XML file in Oxygen, and parse through the XSLT (can also be done using command line or with something like http://kernowforsaxon.sourceforge.net/)

3.)    Check output file
