(
~ncoef = 20;
~decoder = FoaDecoder(decoderType:'stereo');
~graphics = CinderApp();

~matrix = SparseMatrix(~decoder, ~graphics, 2, ~ncoef);
)




(
~ncoef = 20;
~rate = 20;
~headsize = 16;
~numgenes = 4;

~data = UGepLoader(~headsize, ~numgenes).load;

~sparsedata = UGepLoader().loadFromFile(Paths.devdir +/+ "lambda/supercollider/sparsematrix/2014-01-01/defnames00.scd");

~foa = #[zoom,focus,push,press];
~player = GepPlayer(~data, ~decoder, ~graphics);

)



(
~matrix.setBPM(135);

~matrix.makeEfxProto;

~matrix.preparePatternDefs(~sparsedata);
)




(
~matrix.prepareAudio;

// ~longbufs = "/Users/alo/sounds/wfsfx/*".pathMatch.collect({|path|
// 	Buffer.read(s, path)
// });

MasterEQ(2)

)



(
~selectN = {|n=1, array|
	var indices, pdefs = Array();
	indices = (0..array.size-1);
	indices = indices.scramble;
	n.do({
		pdefs = pdefs.add(Pdef(array[indices.pop]));
	});
	pdefs
};

Routine({

	~intrM = {|sclr| ~matrix.beatdur * sclr };
	~intrD = {|sclr| ~matrix.beatdur / sclr };
	~quant = 128;

	~rnames = ['r00', 'r01', 'r02', 'r03', 'r04', 'r05', 'r06', 'r07'];
	~bnames = ['b00', 'b01', 'b02', 'b03'];
	~gnames = ['g00', 'g01', 'g02', 'g03', 'g04', 'g05'];

	~pdefs = ~selectN.(2, ~rnames) ++ ~selectN.(1, ~bnames) ++ ~selectN.(1, ~gnames);

	~pdefs.postln;

	Pdef('matrix', Ppar(~pdefs)).quant(~quant);
	Pdef('matrix').play;
	~seconds = SystemClock.seconds;

	loop({
		var removed;

		~matrix.defsAt(~pdefs.collect(_.key).choose).setControls(
			{ [0, 1].wchoose([0.9, 0.1]) },
			{ exprand(0.1, 1.0) },
			{ rrand(0.01, 0.08) },
			0.0
		);

		64.do({|i|
			var key, sc, weights, off, durmin, durmax;
			sc = sin(i/64*pi);
			key = ~pdefs.collect(_.key).choose;
			if (key.asString.contains("r"))
			{
				off = sc.linlin(0, 1, 0.9, 0.75);
				durmin = sc.linlin(0, 1, 0.005, 0.05);
				durmax = sc.linlin(0, 1, 0.08, 0.2);
			};
			if (key.asString.contains("b"))
			{
				off = sc.linlin(0, 1, 0.9, 0.6);
				durmin = sc.linlin(0, 1, 0.04, 0.1);
				durmax = sc.linlin(0, 1, 0.1, 0.4);
			};
			if (key.asString.contains("g"))
			{
				off = sc.linlin(0, 1, 0.8, 0.7);
				durmin = sc.linlin(0, 1, 0.02, 0.08);
				durmax = sc.linlin(0, 1, 0.08, 0.4);
			};
			weights = [off, 1-off];
			~matrix.defsAt(key).setControls(
				{ [0, 1].wchoose(weights) },
				{ exprand(0.1, 1.0) },
				{ rrand(durmin, durmax) },
				0.0
			);
			// if (0.75.coin) {
			// 	key = ~pdefs.collect(_.key).choose;
			// 	~matrix.defsAt(key).recall(0);
			// };
			~intrM.([8, 12, 16].choose).wait;
		});

		2.do({
			var removed, key;
			removed = ~pdefs.removeAt(~pdefs.size.rand);
			key = removed.key.asString;
			if (key.contains("r")) {
				~pdefs = ~pdefs ++ ~selectN.(1, ~rnames.select({|it| it != key }));
			};
			if (key.contains("b")) {
				~pdefs = ~pdefs ++ ~selectN.(1, ~bnames.select({|it| it != key }));
			};
			if (key.contains("g")) {
				~pdefs = ~pdefs ++ ~selectN.(1, ~gnames.select({|it| it != key }));
			};
		});

		Pdef('matrix', Ppar(~pdefs)).quant(~quant);

		Post << (SystemClock.seconds - ~seconds).round(2) << " s: " << ~pdefs << Char.nl;

	});


}).play


)