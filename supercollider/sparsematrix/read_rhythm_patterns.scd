~txt = "/Users/alo/dev/lambda/supercollider/sparsematrix/rhythm_patterns.scd".load
~arr = ~txt.split(Char.nl)

~clumpIndices = ~arr.collect({|str, i| if (str.size == 0) { i } }).select(_.notNil);

~clumpGroups = ~clumpIndices.first.bubble;
~clumpIndices.doAdjacentPairs({|a, b|
	~clumpGroups = ~clumpGroups.add(b - a)
})

~patarr = ~arr.clumps(~clumpGroups);

~patarr.do({ |arr|
	if (arr.first.size == 0) {
		arr.removeAt(0)
	}
})

~patarr.collect(_.size)

~patterns = ~patarr.collect({|pat|
	('name': pat[0], 'sign': pat[1], 'pattern_strings': pat.drop(2))
})

~instrMap = ($-: 0);
~patterns.do({|ev|
	var patlen = ev['sign'].size;
	ev['pattern_strings'].collect({|str|
		var start;
		start = str.find("\t");
		str.subStr(start+1, start+patlen).postln;
		str.subStr(start+1, start+patlen).collectAs(_.(), Array).collect({|it|
			if (~instrMap.includesKey(it).not) {
				~instrMap[it] = ~instrMap.values.maxItem + 1;
			};
			~instrMap[it]
		});
	}).postln
});


