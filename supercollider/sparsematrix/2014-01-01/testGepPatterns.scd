(
~ncoef = 20;
~mode = 0;
~rate = 20;
~headsize = 16;
~numgenes = 4;
~decoder = FoaDecoder(decoderType:'stereo');
~graphics = CinderApp(800, 600, mode: ~mode);

~matrix = SparseMatrix(~decoder, ~graphics, 2, ~ncoef);
)

(
~dfile = File.open("/home/alo/development/lambda/supercollider/sparsematrix/2014-01-01/defnames00.scd", "r");
~defarray = ~dfile.readAllString.split(Char.nl).reject(_.isEmpty).collect(_.asSymbol);
~dfile.close;
~dfile = nil;

~data = ~defarray.collect({|defname|
	var path, meta, data;
	path = Paths.gepArchDir +/+ defname.asString ++ "." ++ UGEP.fileExt;
	if (File.exists(path)) { data = UGEP.loadData(path) };
	meta = UGenExpressionTree.loadMetadata(defname);
	data['defname'] = defname;
	data['args'] = meta.args.args;
	data['stats'] = meta.stats;
	data
});
// ~foa = #[zoom,focus,push,press];
// ~player = GepPlayer(~data, ~decoder, ~graphics);

)

~matrix.setBPM(136)


s.queryAllNodes

~matrix.makeEfxProto;

~matrix.preparePatternDefs(~data);

~matrix.prepareAudio



Pdef('matrix', Ppar([ Pdef('g02'), Pdef('g03'), Pdef('g04'), Pdef('g05') ])).quant(128)

Pdef('matrix').play




~matrix.defsAt('g00').groups[0].do({|ctr|
	~matrix.defsAt('g00').ctrls[ctr].active = 0;
	~matrix.defsAt('g00').ctrls[ctr].dur = 1.0;
	~matrix.defsAt('g00').ctrls[ctr].amp = 1.0;
})




~matrix.addPatternGepDef('g01', ~data[(64..127)], 8, 8, ['kokou', 'macrou'], 3, "g01", 'r01' );
~matrix.addPatternGepDef('g02', ~data[(128..191)], 8, 8, ['mandiani', 'djakandi'], 3, "g02", 'r02' );
~matrix.addPatternGepDef('g03', ~data[(192..255)], 8, 8, ['yole', 'tiriba'], 3, "g03", 'r03' );
~matrix.addPatternGepDef('g04', ~data[(256..319)], 8, 8, ['soli', 'raboday'], 3, "g04", 'r04' );
~matrix.addPatternGepDef('g05', ~data[(320..383)], 8, 8, ['kpanilogo', 'kakilambe'], 3, "g05", 'r05' );

DjembeLib.patterns.keys(Array).scramble.keep(2)

~data.clump(64).select({|data| data.size == 64 }).size


Pdef('matrix', Ppar([ Pdef('g00'), Pdef('g01'), Pdef('g02') ])).quant(128)

Pdef('matrix').play


~matrix.defsAt('g01').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.5, 1.0) },
	{ rrand(0.04, 0.1) },
	{ rrand(0.1, 0.3) }
);

~matrix.defsAt('g00').recall(0)

~matrix.defsAt('g00').setControls(
	{ [0, 1].wchoose([0.6, 0.4]) },
	{ exprand(0.5, 1.0) },
	{ rrand(0.05, 0.2) },
	{ rrand(0.1, 0.3) }
);

~matrix.defsAt('g03').recall(0)

~matrix.defsAt('g03').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ rrand(0.05, 0.2) },
	{ rrand(0.1, 0.3) }
);


~matrix.defsAt('g04').setControls(
	{ [0, 1].wchoose([0.9, 0.1]) },
	{ exprand(0.5, 1.0) },
	{ rrand(0.01, 0.2) },
	{ rrand(0.1, 0.3) }
);


~matrix.defsAt('g05').setControls(
	{ [0, 1].wchoose([0.9, 0.1]) },
	{ exprand(0.5, 1.0) },
	{ rrand(0.05, 0.5) },
	{ rrand(0.1, 0.3) }
);


~matrix.defsAt('g02').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.5, 1.0) },
	{ rrand(0.1, 0.3) },
	{ rrand(0.1, 0.3) }
);



~player.start(~foa)

~player.setFoa('zoom', 1.0)
~player.setFoa('push', 1.0)
~player.setFoa('press', 1.0)
~player.setFoa('focus', 1.0)
~player.defStrings.do(_.postln)

~data[0].args

~ind0 = 0

~player.play(~ind0, 0, 'zoom', 0)

~player.set(~ind0, 1.0)


~player.free(~ind0)

