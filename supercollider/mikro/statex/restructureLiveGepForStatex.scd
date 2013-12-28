~indices.collect({|index, i|
	~data[index].defname
}).do(_.postln)


~defname = ~data.first.defname
~path = UGEP.archDir +/+ ~defname.asString ++ "." ++ UGEP.fileExt;
if (File.exists(~path)) { ~data = UGEP.loadData(~path) }
~meta = UGenExpressionTree.loadMetadata(~defname)
~data['defname'] = ~defname;
~data['args'] = ~meta.args.args;
~data['stats'] = ~meta.stats;
~data

~data.defname

~file = File.open(Document.current.dir +/+ "defnames.scd", "r")
~defarray = ~file.readAllString.split(Char.nl).collect(_.asSymbol)
~file.close
~file = nil;
