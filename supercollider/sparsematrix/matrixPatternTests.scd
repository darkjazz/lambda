(
~ncoef = 20;
~mode = 0;
~rate = 20;
~headsize = 16;
~numgenes = 4;
~decoder = FoaDecoder(decoderType:'stereo');
~graphics = CinderApp(800, 600, mode: ~mode);

~matrix = SparseMatrix(~decoder, ~graphics, 2, ~ncoef);

~sparsedata = UGepLoader(headsize: 12, numgenes: 2).load;

~dfile = File.open(Document.current.dir +/+ "2014-01-01/defnames.scd", "r");
~defarray = ~dfile.readAllString.split(Char.nl).collect(_.asSymbol);
~dfile.close;
~dfile = nil;

~data = ~defarray.collect({|defname|
	var path, meta, data;
	path = UGEP.archDir +/+ defname.asString ++ "." ++ UGEP.fileExt;
	if (File.exists(path)) { data = UGEP.loadData(path) };
	meta = UGenExpressionTree.loadMetadata(defname);
	data['defname'] = defname;
	data['args'] = meta.args.args;
	data['stats'] = meta.stats;
	data
});
~foa = #[zoom,focus,push,press];
~player = GepPlayer(~data, ~decoder, ~graphics);

)

(
~matrix.setBPM(135);

~matrix.makeEfxProto;

~matrix.preparePatternDefs(~sparsedata);

~matrix.prepareAudio;

~longbufs = "/Users/alo/sounds/wfsfx/*".pathMatch.collect({|path|
	Buffer.read(s, path)
})

)


Pdef('matrix', Ppar([ Pdef('r03'), Pdef('r04'), Pdef('r05'), Pdef('r06'), Pdef('r07') ])).quant(128)



Pdef('matrix').play


~matrix.defsAt('b00').setControls(
	{ [0, 1].wchoose([0.9, 0.1]) },
	{ exprand(0.5, 1.0) },
	{ rrand(0.5, 2.0) },
	0.1
);

~matrix.defsAt('b00').ctrls.select({|ctr| ctr.active.booleanValue.not }).do({|ctr|
	ctr.active =  [0, 1].wchoose([0.9, 0.1])
})

~matrix.defsAt('b00').ctrls.select({|ctr| ctr.active.booleanValue }).size

~matrix.defsAt('b00').recall(0)

~matrix.defsAt('b00').ctrls.do(_.postln)

~matrix.defsAt('b00').ctrls.select({|ctr| ctr.active == 1 }).keysValuesDo({|name, ctr|
	Post << name << ": " << ctr << Char.nl
})

~matrix.defsAt('b01').setControls(
	{ [0, 1].wchoose([0.9, 0.1]) },
	{ exprand(0.5, 1.0) },
	{ rrand(0.5, 1.0) },
	0.1
);


~matrix.defsAt('b02').setControls(
	{ [0, 1].wchoose([0.9, 0.1]) },
	{ exprand(0.2, 1.0) },
	{ rrand(0.05, 0.2) },
	0.1
);


~matrix.defsAt('b03').setControls(
	{ [0, 1].wchoose([0.9, 0.1]) },
	{ exprand(0.2, 1.0) },
	{ rrand(0.05, 0.1) },
	0.1
);


~matrix.defsAt('b04').setControls(
	{ [0, 1].wchoose([0.9, 0.1]) },
	{ exprand(0.2, 1.0) },
	{ rrand(0.05, 0.1) },
	0.1
);


~matrix.defsAt('r04').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.2, 0.8) },
	{ rrand(0.1, 0.3) },
	0.1
);

~matrix.defsAt('r03').recall(0)

Pdef('matrix').stop
