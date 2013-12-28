(
~nCoef = 20;
~dur = 5*60;
~decoder = FoaDecoder(decoderType: 'stereo');
~input = MikroFoaInput(~decoder, "/Users/alo/sounds/eclambone_samples/*");
~analyzer = MikroAnalyzer(maxdur: ~dur, numcoef: ~nCoef);
~graphics = MikroGraphics(
	width: 800,
	height: 600,
	sizeX: 30,
	sizeY: 30,
	frameRate: 36,
	remoteAddr: NetAddr("127.0.0.1", 7770),
	vectorSize: ~nCoef,
	trainDur: 5000,
	lRate: 0.1
);

~mikro = Mikro(
	input: ~input,
	graphics: ~graphics,
	analyzer: ~analyzer,
	duration: ~dur,
	nCoef: ~nCoef
);

~recognizer = PatchRecognizer(~mikro)

)

~mikro.initPerformance;

~mikro.start(-80.dbamp, 0.05, 30);

~recognizer.train

~recognizer.weightDict.do({|patch| patch.hits.postln })

~recognizer.weightDict.collect(_.hits).values.mean

~recognizer.weightDict.select({|patch| patch['weights'].sum == 0 }).size

~mikro.analyzer.removeEventResponderFunction(\patchRec)

~recognizer.save

~recognizer.load("/Users/alo/Data/mikro/110802_112556.plib");

~mikro.stop;

~mikro.graphics.quit

(
// TEST

~weightDict = ();
f = File("/Users/alo/Data/mikro/110526_160045.plib", "rb");
32.do({
	var key = "";
	Array.fill(6, { f.getChar }).do({|chr| key = key ++ chr });
	f.getFloat;
	~weightDict[key.asSymbol] = Array.fill(~nCoef, { f.getFloat });
	f.getChar
});
f.close;

~weightDict.keysValuesDo({|key, val| [key, val.round(0.001)].flat.postln });

~bestMatch = {|input|
	var lowest=999, guess;
	~weightDict.keysValuesDo({|key, weights|
		var diff = (weights - input).squared.sum.sqrt;
		if (diff < lowest) { guess = key; lowest = diff };
	});
	guess
};

~mikro.analyzer.putEventResponderFunction(\patchRec, {|time, re, ms|
	var weights;
	if (ms[2] == 3) {
		weights = ms[3..~nCoef+2];
		~currentGuess = ~bestMatch.value(weights);
		[~mikro.currentPatch, ~currentGuess].postln
	}
});


)

~ecdict.keysValuesDo({|key, ev|
	[key, ev.hits, ev.weights.round(0.001)].flat.postln
})

f = File("/Users/alo/Data/mikro/" ++ Date.getDate.stamp ++ ".plib", "wb");

~ecdict.keysValuesDo({|key, ev|
	f.putString(key.asString);
	f.putFloat(ev.hits);
	ev.weights.do({|val|
		f.putFloat(val)
	});
	f.putChar($\n)
})
f.close

~ecdict.select({|ev| ev.hits == 0 }).size


(
// TRAIN

~ecdict = Event();

32.do({|i| 
	var str = "";
	i.asBinaryDigits(5).do({|dg| str = str ++ dg.asString });
	str = str.insert(2, "_");
	~ecdict[str.asSymbol] = (hits: 0, weights: (0 ! ~nCoef));
});

~mikro.analyzer.putEventResponderFunction(\patchRec, {|time, re, ms|
	var weights, key;
	if (ms[2] == 3) {
		weights = ms[3..~nCoef+2];
		key = ~mikro.currentPatch;
		~ecdict[key].weights = ~ecdict[key].weights * ~ecdict[key].hits + weights / (~ecdict[key].hits + 1);
		~ecdict[key].hits = ~ecdict[key].hits + 1
	}
})

)
