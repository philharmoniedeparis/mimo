# mimo
MIMO linked open data tools

## SPARQL endpoint 
http://data.mimo-db.eu:9091/sparql


## MIMO Thesaurus
direct access to skos ConceptScheme description

http://data.mimo-db.eu:9091/InstrumentsKeywords


## Hornbostel & Sachs Classification
direct access to skos ConceptScheme description

http://data.mimo-db.eu:9091/hs


## Visualisation tool (work in progress)
http://data.mimo-db.eu

The tool provides **content negociation**, that is :
- accessing an URI with a browser (or any device requesting text/html) will serve the HTML page
- asking for one of the following mime types [application/rdf+xml, text/turtle, application/x-turtle, text/n3, text/rdf+n3, application/n3, application/n-triples, application/x-trig, application/trix, application/sparql-results+json, application/ld+json, application/rdf+json, application/json, application/xml] will send the data as requested

### Examples of curl commands
- `curl -H http://data.mimo-db.eu/InstrumentsKeywords/4360/Trombones`
- `curl -H "Accept: application/ld+json" http://data.mimo-db.eu/InstrumentsKeywords/4360/Trombones`
