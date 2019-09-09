
# MIMO ( Musical Instruments Museum Online ) 
http://www.mimo-international.com

This section provides tools, data and information about MIMO and how new museums can join MIMO ( see "harvesting" folder )


Below you'll find specific information on the linked open data access to MIMO Vocabulary (Instrument Keywords and Sachs & Hornbostel Classification).

## SPARQL endpoint of the MIMO Thesaurus 
http://data.mimo-db.eu

## Browse the MIMO Thesaurus ( Using Skosmos )
http://194.254.239.28/skosmos/InstrumentsKeywords/en/

## Visualisation tool (using Vizskos)
http://www.mimo-db.eu/InstrumentsKeywords

The tool provides **content negociation**, that is :
- accessing an URI with a browser (or any device requesting text/html) will serve the HTML page
- asking for one of the following mime types `[application/rdf+xml, text/turtle, application/x-turtle, text/n3, text/rdf+n3, application/n3, application/n-triples, application/x-trig, application/trix, application/sparql-results+json, application/ld+json, application/rdf+json, application/json, application/xml]` will send the data as requested

### Shortcuts to concept schemes
####MIMO Thesaurus
http://www.mimo-db.eu/InstrumentsKeywords

`curl -H "Accept: application/ld+json" http://www.mimo-db.eu/InstrumentsKeywords`

####Hornbostel & Sachs Classification
http://www.mimo-db.eu/HornbostelAndSachs

`curl -H "Accept: application/ld+json" http://www.mimo-db.eu/HornbostelAndSachs`

### Shortcuts to concepts
http://www.mimo-db.eu/InstrumentsKeywords/4360

`curl -H "Accept: application/ld+json" http://www.mimo-db.eu/InstrumentsKeywords/4360`
