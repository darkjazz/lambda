(
~ncoef = 20;
~rate = 20;
~headsize = 16;
~numgenes = 4;

~meta = UGenExpressionTree.loadMetadataFromDir.select({|data| data.args.isKindOf(Event) });
~data = ~meta.collect({|meta|
	var data, path = UGEP.archDir +/+ meta.defname.asString ++ "." ++ UGEP.fileExt;
	if (File.exists(path)) { 
		data = UGEP.loadData(path) 
	};
	data['defname'] = meta.defname;
	data['args'] = meta.args.args;
	data['stats'] = meta.stats;
	data
});
~inds = ~data.selectIndices({|data| data.header.headsize == ~headsize  });
~meta = ~inds.collect({|index| ~meta[index] });
~data = ~inds.collect({|index| ~data[index] });
~list = ~data.collect(_.code);
)

~indices=[1,4,5,8,9,10,11,12,14,15,16,18,21,22,23,24,25,26,28,32,34,36,37,38,40,41,42,
44,45,46,48,49,50,51,54,55,58,59,60,63,64,66,67,68,69,70,71,72,73,74,75,77,78,79,81,
82,83,85,86,87,89,90,92,93,95,96,97,100,101,102,103,104,105,107,108,109,111,112,113,115,
116,117,118,120,123,124,126,127,128,129,130,131,132,133,134,138,139];
~means = KMeans(4);

~indices.do({|ind|
	~means.add(~data[ind].stats.mfcc.collect(_.mean) ++ ~data[ind].stats.mfcc.collect(_.stdDev))
})

~means.update

~assignments = ();

(0..3).do({|key| ~assignments[key] = [] })

~means.assignments.do({|assign, i|
	~assignments[assign] = ~assignments[assign].add(~indices[i])
})

~assignments.do({|nums|
	nums.size.postln
})

~indices.size