from rdflib import Graph
from os import listdir
from os.path import isfile, join
import uuid, json, couchdb

FILE_QUERY = """
SELECT ?path WHERE { ?path a mo:AudioFile }
"""

EVENT_QUERY = """
SELECT ?time ?duration ?feature WHERE {
    ?event_type rdfs:subClassOf event:Event .
    ?ev_id a ?event_type ;
        event:time ?time_id ;
        af:feature ?feature .
    ?time_id tl:beginsAt ?time ;
        tl:duration ?duration .
}
"""

SEGMENT_QUERY = """
SELECT ?time ?duration ?feature WHERE {
    ?ev_id a af:StructuralSegment ;
        event:time ?time_id ;
        af:feature ?feature .
    ?time_id tl:beginsAt ?time ;
        tl:duration ?duration .
}
"""

class FeatureCollector:
    def __init__(self, dir):
        self.dir = dir
        self.json = {}
        self.context = {
            "mo": "http://purl.org/ontology/mo/",
            "afo": "https://w3id.org/afo/onto/1.1#",
            "tl": "http://purl.org/NET/c4dm/timeline.owl#",
            "event": "http://purl.org/NET/c4dm/event.owl#"
        }
        self.server = couchdb.Server()

    def run(self):
        files = [ f for f in listdir(self.dir) if isfile(join(self.dir, f)) ]
        for filename in files:
            self.json = {}
            self.addContext()
            self.processTrack(filename)
            self.writeToDB("aafrika")

    def getFirstValue(self, query_result, triple_index=0):
        return list(query_result)[0][triple_index]

    def processTrack(self, filename):
        path = join(self.dir, filename)
        self.graph = Graph().parse(path, format="n3")
        tl_id = self.addHeader()
        self.addEvents(tl_id)
        self.addSegments(join(self.dir, "segments", filename), tl_id)

    def addContext(self):
        self.json["@context"] = self.context
        self.json["@graph"] = []

    def addHeader(self):
        tl_id = str(uuid.uuid4())
        sf_id = self.getFirstValue(self.graph.query(FILE_QUERY))
        self.json["@graph"].append({
            "@type": "mo:AudioFile",
            "@id": str(sf_id),
            "mo:encodes": {
                "@type": "mo:Signal",
                "mo:time": {
                    "@type": "tl:Interval",
                    "tl:timeline": { "@type": "tl:Timeline", "@id": tl_id }
                }
            }
        })
        return tl_id

    def addEvents(self, tl_id):
        for event in self.graph.query(EVENT_QUERY):
            self.json["@graph"].append({
                "@type": "afo:Note",
                "afo:value": float(event.feature),
                "event:time": {
                    "@type": "tl:Interval",
                    "tl:at": event.time,
                    "tl:duration": event.duration,
                    "tl:timeline": tl_id
                }
            })

    def addSegments(self, path, tl_id):
        segment_graph = Graph().parse(path, format="n3")
        for segment in segment_graph.query(SEGMENT_QUERY):
            self.json["@graph"].append({
                "@type": "afo:Segment",
                "afo:value": int(segment.feature),
                "event:time": {
                    "@type": "tl:Interval",
                    "tl:at": segment.time,
                    "tl:duration": segment.duration,
                    "tl:timeline": tl_id
                }
            })


    def printJSON(self):
        print json.dumps(self.json)

    def writeToFile(self, write_path):
        with open(write_path, "w") as write_file:
            write_file.write(json.dumps(self.json))
            write_file.close()

    def writeToDB(self, db_name):
        db = self.server[db_name]
        doc, rev = db.save(self.json)
        print "Wrote %s to %s" % (doc, db_name)

fc = FeatureCollector("/Users/alo/Data/sonic-annotator/rdf/aafrika/")
fc.run()
#fc.addContext()
#fc.processTrack("01 Soubour.n3")
#fc.writeToFile(join(fc.dir, "json", "01 Soubour.json"))
