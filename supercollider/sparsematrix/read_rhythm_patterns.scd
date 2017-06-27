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

~patterns = ~patarr.collect({|pat|
	('name': pat[0], 'sign': pat[1], 'pattern_strings': pat.drop(2))
})

~instrMap = ($-: 0);
~patterns.do({|ev|
	var patlen = ev['sign'].size;
	ev['pattern_array'] = ev['pattern_strings'].collect({|str|
		var start;
		start = str.find("\t");
		str.subStr(start+1, start+patlen).postln;
		str.subStr(start+1, start+patlen).collectAs(_.(), Array).collect({|it|
			if (~instrMap.includesKey(it).not) {
				~instrMap[it] = ~instrMap.values.maxItem + 1;
			};
			~instrMap[it]
		});
	});
	ev['unraveled_pattern'] = Array();
	ev['pattern_array'].do({|subarr|
		ev['unraveled_pattern'] = ev['unraveled_pattern'].addAll(
			subarr.asSet.remove(0).asArray.sort.collect({|it|
				var arr = (0 ! subarr.size);
				subarr.selectIndices({|instr| instr == it }).do({|ind|
					arr[ind] = 1
				});
				arr
			})
		)
	})
});

~db = CouchDB(NetAddr(JsonLoader.localIP, JsonLoader.localPort), "rhythm_patterns");

~writePattern = {|content|
	var json, collect;
	json = "";
	json = json ++ JsonUtils.wrap('name', content.name);
	json = json ++ JsonUtils.wrap('signature', content.sign);
	collect = "";
	content.pattern_strings.do({|str|
		var safe = str.collect({|char| if (char.isFileSafe) { char } { Char.space } });
		collect = collect ++ JsonUtils.wrapQuotes(safe);
		collect = collect ++ ", ";
	});
	json = json ++ JsonUtils.wrapLiteral('pattern_strings',
		JsonUtils.wrapList(JsonUtils.terminate(collect)));

	collect = "";
	content.pattern_array.do({|arr|
		collect = collect ++ arr.asString ++ ", ";
	});
	json = json ++ JsonUtils.wrapLiteral('pattern_array',
		JsonUtils.wrapList(JsonUtils.terminate(collect)));

	collect = "";
	content.unraveled_pattern.do({|arr|
		collect = collect ++ arr.asString ++ ", ";
	});
	json = json ++ JsonUtils.wrapLiteral('unraveled_pattern',
		JsonUtils.wrapList(JsonUtils.terminate(collect)), true);

	JsonUtils.wrapSingleQuotes(JsonUtils.wrapJson(json));
}

~patterns.keep(~patterns.size - 1).do({|pattern|
	// ~writePattern.(pattern).postln
	~db.put(~writePattern.(pattern))
})

~patterns[4].postcs

Post << ~writePattern.(~patterns[0]) << Char.nl

Post << ~patterns[4].unraveled_pattern.asString << Char.nl




/// WRITE DJEMBELIB

~db = CouchDB(NetAddr(JsonLoader.localIP, JsonLoader.localPort), "rhythm_patterns");

~patterns = [];

DjembeLib.patterns.keysValuesDo({|key, pat|
	var sign;
	sign = "";
	(pat[0].size / 2).do({|i| sign = sign ++ (i+1).asString  });
	sign = sign ++ sign;
	~patterns = ~patterns.add(
		( 'name': key, 'sign': sign, 'pattern_array': pat,
			'unraveled_pattern': DjembeLib.convert(key) )
	)
})

~writePattern = {|content|
	var json, collect;
	json = "";
	json = json ++ JsonUtils.wrap('name', content.name);
	json = json ++ JsonUtils.wrap('signature', content.sign);
	json = json ++ JsonUtils.wrap('origin', "DjembeLib");
	collect = "";
	content.pattern_array.do({|arr|
		if (arr[0].isSymbolWS) {
			collect = collect ++ arr.collect({|str| JsonUtils.wrapQuotes(str) }) ++ ", ";
		}
		{
			collect = collect ++ arr.asString ++ ", ";
		}
	});
	json = json ++ JsonUtils.wrapLiteral('pattern_array',
		JsonUtils.wrapList(JsonUtils.terminate(collect)));

	collect = "";
	content.unraveled_pattern.do({|arr|
		collect = collect ++ arr.asString ++ ", ";
	});
	json = json ++ JsonUtils.wrapLiteral('unraveled_pattern',
		JsonUtils.wrapList(JsonUtils.terminate(collect)), true);

	JsonUtils.wrapSingleQuotes(JsonUtils.wrapJson(json));
}


~patterns.do({|pattern|
	//~writePattern.(pattern).postln
	~db.put(~writePattern.(pattern))
})
