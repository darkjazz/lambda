~loader = JsonLDLoader("ges_ld_00");

~headers = ~loader.getDefNamesByHeader(14, 4)

~headers

~headers.do({|ev|
	Server.default.loadSynthDef(ev['value'], dir: "Users/alo/Data/gep/synthdefs")
})

~nclusters = (~headers.size * 0.5).sqrt.asInt;

~db = CouchDB(NetAddr("127.0.0.1", 5984), "ges_ld_00");

result = db.get("docByDefName?key=\"#\"".replace("#", defname));
		doc = result.subStr((result.find("\"value\":") + 8), result.size - 7)
			.replace(${.asString, $(.asString).replace($}.asString, $).asString).replace("\n", "").replace("\"", "'")
			.interpret;


~headsize = 10;
~numgenes = 4;
~resp = ~db.get("mfccByHeader?key=\"#\"".replace("#", ~headsize.asString ++ ~numgenes.asString));

~str = ~resp.subStr((~resp.find("\"value\":") + 8), ~resp.size - 7);

~str1 = ~resp.replace("{", "(")

~str2 = ~str1.replace("}", ")")

~str3 = ~str2.replace("\"", "'")

~str4 = ~str3.replace("\n", "");

~str.size

~doc = ~str4.interpret;



~nc = (~doc['rows'].size * 0.5).sqrt.asInt;
~means = MikroMeans(~nc)

~doc['rows'].do({|row|
	~means.add(row['value']['ges:mfcc']['ges:mean'])
})

~defnames = ~doc['rows'].collect({|row| row['value']['ges:defname'] })

~defnames.size
~means.assignments.size

~means.update

~means.assignments

~means.saveData

~rows.do({|data|
	Server.default.loadSynthDef(data['ges:defname'], dir: Paths.gepDefDir )
});


~str = ~db.get("defnamesByHeader?key=\"#\"".replace("#", ~headsize.asString ++ ~numgenes.asString));

~str.size

Server.killAll

Quarks.gui

