(
~ncoef = 20;
~rate = 20;
~headsize = 14;
~numgenes = 4;

~decoder = FoaDecoder(decoderType:'stereo');
~graphics = CinderApp(1024, 768, mode: 1);

~matrix = SparseMatrix(~decoder, ~graphics, 2, ~ncoef);
)



MasterEQ(2)

(

~foa = #[zoom,push];
~player = JGepPlayer(~decoder, dbname: "ges_00");
~player.getDefNamesByHeader(~headsize, ~numgenes);
)


~matrix.setBPM(142);
~player.setBPM(142);

~matrix.loadPatternDefs("patternDefs.scd");


~loader = JsonLoader("ges_00");
~defnames = ~loader.getDefNamesByHeader(16, 1).collect({|def| def['value'] });
~matrix.prepareGepDefs(~defnames, ~loader);

~matrix.prepareAudio



Pdef('matrix', Ppar([ Pdef('g00'), Pdef('g01') ])).quant(64)


Pdef('matrix').play


~buf = Buffer.read(s, Paths.soundDir +/+ "tehishing/tehishing_ch1-2_stereo.aif")

~tbus = Bus.control;

~pos = Pstutter(
	Pwrand([1, 2, 4, 6, 8], [1, 2, 3, 1, 1].normalizeSum, inf), 
	Pwhite(0, ~buf.numFrames, inf)
).asStream;

Ndef('meander', {|pos|
	var trig = InTrig.kr(~tbus);
	PlayBuf.ar(2, ~buf, 1.0, trig, trig, loop: 1);
})

~matrix.onsetFunc = { ~tbus.value = ~pos.next; }

(

Routine({
	Ndef('meander').play;
	~tbus.value = 0;
	(~matrix.beatdur * 16).wait;
	~matrix.defsAt('g00').setControls(
		{ [0, 1].wchoose([0.9, 0.1]) },
		{ exprand(0.3, 1.0) },
		{ exprand(0.1, 0.4) },
		0.1
	);
	(~matrix.beatdur * 16).wait;	
	~matrix.defsAt('g01').setControls(
		{ [0, 1].wchoose([0.8, 0.2]) },
		{ exprand(0.2, 0.8) },
		{ exprand(0.07, 0.2) },
		0.1
	);	
	(~matrix.beatdur * 16).wait;	
	~matrix.defsAt('g00').setControls(
		{ [0, 1].wchoose([0.8, 0.2]) },
		{ exprand(0.5, 1.0) },
		{ exprand(0.1, 0.2) },
		0.1
	);
	(~matrix.beatdur * 8).wait;	
	~matrix.defsAt('g01').setControls(
		{ [0, 1].wchoose([0.8, 0.2]) },
		{ exprand(0.2, 0.8) },
		{ exprand(0.07, 0.4) },
		0.1
	);
	(~matrix.beatdur * 8).wait;
	['g00', 'g01', 'g01', 'g00', 'g00'].do({|name|
		~matrix.defsAt(name).recall(0);
		(~matrix.beatdur * 8).wait;
	});
	(~matrix.beatdur * 16).wait;
	~matrix.defsAt('g00').setControls(
		{ [0, 1].wchoose([0.9, 0.1]) },
		{ exprand(0.3, 1.0) },
		{ exprand(0.1, 0.4) },
		0.1
	);
	(~matrix.beatdur * 16).wait;	
	~matrix.defsAt('g01').setControls(
		{ [0, 1].wchoose([0.8, 0.2]) },
		{ exprand(0.2, 0.8) },
		{ exprand(0.07, 0.2) },
		0.1
	);	
	(~matrix.beatdur * 16).wait;	
	~matrix.defsAt('g01').setControls(
		{ [0, 1].wchoose([0.8, 0.2]) },
		{ exprand(0.2, 0.8) },
		{ exprand(0.07, 0.2) },
		0.1
	);	
	~matrix.defsAt('g00').setControls(
		{ [0, 1].wchoose([1.0, 0.0]) },
		{ exprand(0.2, 0.8) },
		{ exprand(0.07, 0.2) },
		0.1
	);	
	(~matrix.beatdur * 16).wait;	
	~matrix.defsAt('g01').setControls(
		{ [0, 1].wchoose([0.9, 0.1]) },
		{ exprand(0.2, 0.8) },
		{ exprand(0.1, 0.4) },
		0.1
	);
	~matrix.onsetFunc = { };
	~tbus.value = ~buf.numFrames - (~buf.sampleRate * ~matrix.beatdur * 32);
	(~matrix.beatdur * 16).wait;	
	~matrix.defsAt('g01').setControls(
		{ [0, 1].wchoose([1.0, 0.0]) },
		{ exprand(0.2, 0.8) },
		{ exprand(0.1, 0.4) },
		0.1
	);
	(~matrix.beatdur * 16).wait;	
	Ndef('meander').clear;	
}).play

)

