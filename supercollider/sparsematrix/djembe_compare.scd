JsonLoader.viewDir = "views";
~loader = JsonLDLoader("rhythm_patterns")

~unraveled = ~loader.db.getParsed("unraveled_by_name")

~pattern_dict = ();

~unraveled["rows"].do({|dict, i|
	~pattern_dict[dict["key"].toLower.asSymbol] = dict["value"];
})

~dlib = DjembeLib.convertAll();

~dlib['doudoumba']
~pattern_dict['doudoumba']

//~sparse = DjembeLib.convertAll().collect(SparsePattern(_)).collect(_.makeSparse).collect(_.patterns);

(
~dlib.keysValuesDo({|key, pat|
	var size, src, trg, len, pct = 0;
	if (~pattern_dict.includesKey(key)) {
		src = pat; trg = ~pattern_dict[key];
		if (pat.size < ~pattern_dict[key].size) { src = ~pattern_dict[key]; trg = pat };
		size = [~dlib[key].size, ~pattern_dict[key].size].minItem;
		len = src.collect(_.size).minItem;
		src.keep(size).do({|sub, i|
			var subpct;
			sub.keep(len).postln;
			trg[i].keep(len).postln;
			subpct = (len - (sub.keep(len).collect(_.asInt) - trg[i].keep(len).collect(_.asInt)).abs.sum) / len.asFloat;
			subpct.postln;
			"__".postln;
			pct = pct + subpct;
		});
		Post << key << ": " << (pct / size.asFloat).round(0.01) << Char.nl
	}
})
)

