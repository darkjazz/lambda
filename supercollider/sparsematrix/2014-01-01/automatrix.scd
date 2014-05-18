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

Routine({

	var pdefs, pnames, quant = 128;

	~intr = ();

	[1,2,4,8,16,32,64,128].do({|sclr|
		~intr[("m"++sclr).asSymbol] = { ~matrix.beatdur * sclr };
		~intr[("d"++sclr).asSymbol] = { ~matrix.beatdur / sclr };
	});

	pnames = ['r00', 'r01', 'b02', 'r02', 'r03', 'g00', 'r04',
		'g01', 'r05', 'g02', 'b03', 'r06', 'g03', 'r07'];

	pdefs = [ Pdef('c00') ];

	Pdef('matrix', Ppar(pdefs)).quant(quant);
	Pdef('matrix').play;
	~seconds = SystemClock.seconds;

	Routine({
		var incr, amp = -60.0, target = 6.0, time, delta;
		delta =  = ~intr['d4'].();
		time = ~intr['m64'].();
		incr = (target-amp) / (time/delta);
		(time/delta).do({
			amp = amp + incr;
			~matrix.defs.at('c00').setControls(1, amp.dbamp);
			delta.wait;
		});
		~matrix.defs.at('c00').setControls(1, target.dbamp);
	}).play;

	(~intr['m64'] * 2).wait;

	Post << (SystemClock.seconds - ~seconds).round(2) << " s: "

	pdefs = pdefs.add(Pdef('b01'));

	Pdef('matrix', Ppar(pdefs)).quant(quant);

	~matrix.defsAt('b01').setControls(
		{ [0, 1].wchoose([0.8, 0.2]) },
		{ exprand(0.2, 0.7) },
		{ rrand(0.03, 0.08) },
		0.1
	);

	Routine({
		var minamp=0.3, amprng=0.4, mindur=0.03, durrng=0.1;
		16.do({|i|
			~intr['m32'].wait;
			~matrix.defsAt('b01').setActives(
				{ exprand(0.2, 0.7) },
				{ rrand(0.03, 0.08) },
				0.1
			);

		})
	}).play;


}).play


