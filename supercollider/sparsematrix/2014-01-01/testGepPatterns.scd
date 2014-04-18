(
~ncoef = 20;
~mode = 0;
~rate = 20;
~headsize = 16;
~numgenes = 4;
~decoder = FoaDecoder(decoderType:'stereo');
~graphics = CinderApp(800, 600, mode: ~mode);

~matrix = SparseMatrix(~decoder, ~graphics, 2, ~ncoef);

~dfile = File.open(Document.current.dir +/+ "defnames00.scd", "r");
~defarray = ~dfile.readAllString.split(Char.nl).reject(_.isEmpty).collect(_.asSymbol);
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

)

~matrix.makeEfxProto;

~matrix.preparePatternDefs();

~matrix.addPatternGepDef('g00', ~data.keep(64), 8, 8, ['basikolo', 'diansa'], 3, "g00", 'r00' );
~matrix.addPatternGepDef('g01', ~data[(64..127)], 8, 8, ['kokou', 'macrou'], 3, "g01", 'r01' );
~matrix.addPatternGepDef('g02', ~data[(128..191)], 8, 8, ['mandiani', 'djakandi'], 3, "g02", 'r02' );
~matrix.addPatternGepDef('g03', ~data.drop(192), 8, 8, ['yole', 'tiriba'], 3, "g03", 'r03' );

~matrix.prepareAudio

Pdef('matrix', Ppar([ Pdef('g00'), Pdef('g01'), Pdef('g02') ])).quant(128)

Pdef('matrix').play


~matrix.defsAt('g00').setControls(
	{ [0, 1].wchoose([0.9, 0.1]) },
	{ exprand(0.3, 1.0) },
	{ rrand(0.05, 0.2) },
	{ rrand(0.1, 0.3) }
);
