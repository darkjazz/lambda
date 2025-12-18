(
~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2,
	screenX: 1024, screenY: 768, mode: 1, decoderType: 'binaural',
	'localDecoder': true, 'ambiOrder': 3,
	bpm: 136.7762208841, channels: 2, foa: #[zoom,push], dbname: "ges_ld_00",
	patdefs: "patternDefsMesa.scd", worldDim: 21, ip: "127.0.0.1"
);
e = SpEnvir(~settings)

)

MasterEQ(2)

Server.default.scope(2)

Server.killAll
s.queryAllNodes

(
~matrix.patterndefs.keys.select({|key| key.asString.contains("u")}).do({|name|
	var pat = e.getPat(name);
	pat.ctrls.keysValuesDo({|key, ctrl|
		var len, on;
		on = pat.patterns[key].select(_.odd).size;
		len = pat.patterns[key].size;
		ctrl.dur = (1.0 / on).linlin(1/len, 1, 0.07, 0.15);
	})
});
~matrix.patterndefs.keys.select({|key| key.asString.contains("d")}).do({|name|
	var pat = e.getPat(name);
	pat.ctrls.keysValuesDo({|key, ctrl|
		var len, on;
		on = pat.patterns[key].select(_.odd).size;
		len = pat.patterns[key].size;
		ctrl.dur = (1.0 / on).linlin(1/len, 1, 0.04, 0.1);
	})
})
)



(
	var cmd, result;
	cmd = "cd /Users/kurivari/dev/lambda/supercollider/analyze && /opt/anaconda3/envs/music-gen/bin/python generate.py 20 --pitch-temp 1.0 --rhythm-temp 1.0";
	result = cmd.unixCmdGetStdOut;
	~data = result.parseYAML;  // Parse JSON
	~data["notes"].postln;  // MIDI notes
	~data["ioi"].postln;    // Inter-onset intervals (at 120 BPM)
)


~kvbufs.loops.collect(_.dur).values

~bpm = 143;

((~bpm / 60).reciprocal * 16).reciprocal / ~loop0.dur.reciprocal


~kvbufs.searchDur(~loop0.dur, 0.02).do(_.postln)


(
~ddefs = ( {|i| ("d" ++ i.asString.padLeft(2, "0")).asSymbol } ! 89 );
~patterns = ~matrix.patterndefs.keys.select({|key| key.asString.contains("u") }).asArray.collect({|name|
	~matrix.patterndefs[name].patterns.values.select({|arr|
		(arr.occurrencesOf(1) > 13).and(arr.occurrencesOf(1) < 28)
	})
}).flatten(1);
~patchoice = Array.fill(8, {~patterns.choose});
~ind0 = 8;
~buf0 = ~kvbufs[~ind0];
~loop0 = ~kvbufs.loopsAtBuf(~buf0);
~rate0 = 1.3;
~bpm0 = 60 * 16 / (~loop0.dur / ~rate0);
~matrix.setBPM(~bpm0);
Post << "bpm: " << ~bpm0 << Char.nl;

~pw0 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\iamp, Pseq([1, 0, 0, 0] * 0.7, inf),
	\wamp, Pseq([1, 0] * 0.7, inf)
];
e.playWarp('w0', 'wrprevm', ~buf0, ~pw0, 1/8, 0, ~rate0);

~ind2 = 120;
~buf2 = ~kvbufs[~ind2];
~loop2 = ~kvbufs.loopsAtBuf(~buf2);
~rate2 = ~loop0.dur.reciprocal / ~loop2.dur.reciprocal;
~pw2 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\wamp, Pdefn('w2w', Pseq(~patchoice[0] * 0.5, inf)),
	\iamp, Pdefn('w2i', Pseq(~patchoice[1] * 0.5, inf))
];
e.playWarp('w2', 'wrprevm', ~buf2, ~pw2, 1/4, 0.0, ~rate2 / 2 );

Pdef('mxd',
	Ppar(~ddefs.drop(55).keep(11).collect({|nm| Pdef(nm) }))
).play;
)

(
e.setPat('d55', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('d56', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('d57', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('d58', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('d59', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('d60', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('d61', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('d62', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('d63', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('d64', 0.0, [0.2, 0.3], nil, 0.1);
e.setPat('d65', 0.0, [0.2, 0.3], nil, 0.1);

)

(
// 37, 225, 186, 200
~buf1 = ~kvbufs[3];
~loop1 = ~kvbufs.loopsAtBuf(~buf1);
~rate1 = ~loop1.dur.reciprocal / ~loop0.dur.reciprocal;
e.setWarp('w0', ['buf', ~buf1, 'rate', ~rate1, 'ramp', 0.0]);
)


(

~buf2 = ~kvbufs[82];
~loop2 = ~kvbufs.loopsAtBuf(~buf2);
~rate2 = ~loop0.dur.reciprocal / ~loop2.dur.reciprocal;
e.setWarp('w2', ['buf', ~buf2, 'rate', ~rate2, 'ramp', 0.0]);
)


Pdef('mx01').clear

Pdef('r01').stop



e.setPwarp('w0', ~pw0, ~matrix.beatdur / 2)

e.setWarp('w0', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.4, 'iamp', 1.0, 'ramp', 0.0, 'rate', 1.0, 'freq', 1.0])

e.freeWarp('w2')

~lp0 = ~kvbufs.loopsAtBuf(~buf0)
~lp0.dur
~lp1 = ~kvbufs.loopsAtBuf(~buf1)
~lp1.dur




~mesabufs.searchDur(~loop0.dur).do(_.postln)


(
~ind0 = 5; // 4
~buf0 = ~mesabufs[~ind0];
~loop0 = ~mesabufs.loopsAtBuf(~buf0);
~rate0 = 1;
~bpm0 = 60 * 16 / (~loop0.dur / ~rate0);
~matrix.setBPM(~bpm0);
Post << "bpm: " << ~bpm0 << Char.nl;

~pw0 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	// \iamp, Pseq([1, 1, 0] * 0.5, inf),
	// \wamp, Pseq([0.5, 0.5, 0.5, 0.0, 0.5, 0.0], inf),
	\freq, Prand(Scale.minor.ratios.scramble.keep(3), inf),
	\wamp, Pseq( [0.05, 0.4, 0.05, 0.4, 0.2, 0.3, 0.05, 0.3], inf),
	// \rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w0', 'revwrpm', ~buf0, ~pw0, 1, 1, ~rate0);

~ind1 = 103; // 103, 18
~buf1 = ~mesabufs[~ind1];
~loop1 = ~mesabufs.loopsAtBuf(~buf1);
~rate1 = ~loop1.dur.reciprocal / ~loop0.dur.reciprocal;

~ind2 = 105;
~buf2 = ~mesabufs[~ind2];

~pw1 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\buf, Pseq([~buf1, ~buf1, ~buf1, ~buf1, ~buf2, ~buf2, ~buf2, ~buf2], inf),
	// \iamp, Pseq([1, 1, 0] * 0.5, inf),
	\wamp, Pseq([0.0, 0.5, 0.5, 0.0, 0.5, 0.0], inf),
	\freq, Prand(Scale.minor.ratios.scramble.keep(3), inf)
	// // \wamp, Pseq( [0.05, 0.4, 0.05, 0.4, 0.2, 0.3, 0.05, 0.3]*2, inf),
	// \rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w1', 'wrprevm', ~buf1, ~pw1, 1, 0.0, ~rate1);

Pdef('mxd',
	Ppar(~ddefs.drop(55).keep(11).collect({|nm| Pdef(nm) }))
).play;
e.setWarp('w0', ['ramp', 0.0]);
e.setWarp('w1', ['ramp', 0.0]);
)

e.setWarp('w0', ['iamp', 0.0]);



Pdef('mx01').clear

Pdef('r01').stop

e.setPat('r00', 0.0, [0.2, 0.4], [0.07, 0.1], 0.1);
e.setPat('r02', 0.0, [0.2, 0.4], [0.07, 0.1], 0.1);



e.setPwarp('w0', ~pw0, ~matrix.beatdur / 2)

e.setWarp('w0', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.0, 'iamp', 1.0, 'ramp', 0.0, 'rate', 1.0, 'freq', 1.0])


e.freeWarp('w0');
e.freeWarp('w1')



SparseMatrix.patterns16['Kpanlogo'].do(_.postln)


(
~ind0 = 237; // 4
~buf0 = ~kvbufs[~ind0];
~loop0 = ~kvbufs.loopsAtBuf(~buf0);
~rate0 = 1;
~loop0.postln;

~bpm0 = 60 * 16 / (~loop0.dur / ~rate0);
~matrix.setBPM(~bpm0);
Post << "bpm: " << ~bpm0 << Char.nl;

~pw0 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\iamp, Pseq(SparseMatrix.patterns16['Kpanlogo'][1] * 0.5, inf),
	\wamp, Pseq(SparseMatrix.patterns16['Kpanlogo'][4] * 0.5, inf),
	\freq, Prand(Scale.minor.ratios.scramble.keep(3), inf)
	// // \wamp, Pseq( [0.05, 0.4, 0.05, 0.4, 0.2, 0.3, 0.05, 0.3]*2, inf),
	// \rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w0', 'revwrpm', ~buf0, ~pw0, 1/4, 0, 1);

~ind1 = 236; // 4
~buf1 = ~kvbufs[~ind1];
~loop1 = ~kvbufs.loopsAtBuf(~buf1);
~rate1 = 1;
~loop1.postln;

~pw1 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\iamp, Pseq(SparseMatrix.patterns16['Kpanlogo'][2] * 0.5, inf),
	\wamp, Pseq(SparseMatrix.patterns16['Kpanlogo'][3] * 0.5, inf),
	\freq, Prand(Scale.minor.ratios.scramble.keep(3), inf)
	// // \wamp, Pseq( [0.05, 0.4, 0.05, 0.4, 0.2, 0.3, 0.05, 0.3]*2, inf),
	// \rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w1', 'revwrpm', ~buf1, ~pw1, 1/4, 0, 1);


Pdef('mx01', Ppar([
	Pdef('r00'),
	Pdef('r02')
])).play;
)


e.setPat('r00', 0.0, [0.2, 0.5], [0.07, 0.1], 0.1);
e.setPat('r02', 0.0, [0.2, 0.4], [0.07, 0.1], 0.1);


e.freeWarp('w0')

e.freeWarp('w1')


(
~ind0 = 235; // 4
~buf0 = ~kvbufs[~ind0];
~loop0 = ~kvbufs.loopsAtBuf(~buf0);
~rate0 = 1.5;
~loop0.postln;

~bpm0 = 60 * 16 / (~loop0.dur / ~rate0);
~matrix.setBPM(~bpm0);
Post << "bpm: " << ~bpm0 << Char.nl;

~pw0 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\iamp, Pseq([1, 1, 0, 0, 1, 1, 1, 0], inf),
	\wamp, Pseq([0.5, 0.5, 0.5, 0.0, 0.5, 0.0], inf),
	\freq, Prand(Scale.minor.ratios.scramble.keep(3), inf)
	// // \wamp, Pseq( [0.05, 0.4, 0.05, 0.4, 0.2, 0.3, 0.05, 0.3]*2, inf),
	// \rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w0', 'revwrpm', ~buf0, ~pw0, 1, 0, ~rate0);
Pdef('mx01', Ppar([
	Pdef('r00'),
	Pdef('r02'),
	Pdef('r06'),
	Pdef('b01')
])).play;
e.setPat('r00', 0.1, [0.2, 0.4], [0.07, 0.1], 0.1);
e.setPat('r02', 0.1, [0.2, 0.4], [0.07, 0.1], 0.1);
e.setPat('r06', 0.2, [0.2, 0.4], [0.07, 0.1], 0.1);
e.setPat('b00', 0.2, [0.2, 0.4], [0.07, 0.1], 0.1);
)

e.setPat('r00', 0.2, [0.2, 1.0], [0.07, 0.1], 0.1);
e.setPat('b01', 1.0, [0.2, 1.0], [0.07, 0.3], 0.1);


Pdef('mx01').clear

e.freeWarp('w0')


~kvbufs.searchDur(~loop0.dur, 0.02).do(_.postln)


( 'dur': 6.3, 'ratio': 1.0174603174603, 'index': 180 )
( 'dur': 6.29, 'ratio': 1.0190779014308, 'index': 206 )
( 'dur': 6.41, 'ratio': 1.0, 'index': 59 )
( 'dur': 6.3, 'ratio': 1.0174603174603, 'index': 17 )
( 'dur': 6.36, 'ratio': 1.0078616352201, 'index': 212 )
( 'dur': 6.46, 'ratio': 0.9922600619195, 'index': 141 )
( 'dur': 6.51, 'ratio': 0.98463901689708, 'index': 44 )

(
~ind0 = 44; //180,
~buf0 = ~kvbufs[~ind0];
~loop0 = ~kvbufs.loopsAtBuf(~buf0);
~rate0 = 1.0;
~loop0.postln;

~bpm0 = 60 * 16 / (~loop0.dur / ~rate0);
~matrix.setBPM(~bpm0);
Post << "bpm: " << ~bpm0 << Char.nl;

~pw0 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\iamp, Pseq([1, 0, 0] * 0.7, inf),
	\wamp, Pseq([1, 1, 1, 0.0, 1, 0.0] * 0.7, inf),
	\freq, Prand(Scale.minor.ratios.scramble.keep(3), inf)
	// // \wamp, Pseq( [0.05, 0.4, 0.05, 0.4, 0.2, 0.3, 0.05, 0.3]*2, inf),
	// \rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w0', 'revwrpm', ~buf0, ~pw0, 1, 0, 1);
Pdef('mx01', Ppar([
	Pdef('u03'),
	Pdef('u02')
])).play;
e.setPat('u03', 0.5, [0.5, 0.9], nil, 0.1);
e.setPat('u02', 0.5, [0.4, 0.7], nil, 0.1);
e.setWarp('w0', ['ramp', 0.1]);
)

e.setWarp('w0', ['ramp', 0.1]);


(
~ind0 = 17;
~buf0 = ~kvbufs[~ind0];
~loop0 = ~kvbufs.loopsAtBuf(~buf0);
~rate0 = 1.0;
~loop0.postln;

~bpm0 = 60 * 16 / (~loop0.dur / ~rate0);
~matrix.setBPM(~bpm0);
Post << "bpm: " << ~bpm0 << Char.nl;
e.setWarp('w0', ['buf', ~buf0]);
)


Pdef('mx01').clear

Pdef('r01').stop

e.setPat('r00', 0.0, [0.2, 0.4], [0.07, 0.1], 0.1);
e.setPat('r02', 0.0, [0.2, 0.4], [0.07, 0.1], 0.1);


e.setPwarp('w0', ~pw0, ~matrix.beatdur / 2)


e.freeWarp('w0')

Pdef('mx01').clear



22, 37, 52, 76/81, 84, 91, 98, 102, 105, 172, (179), 182, 188, 199, 215, 217, 219, 235, 256 (u10),

257 (d05/6) \rate: [ 1.4983070768743, 1.7817974362766, 1.1224620483089 ]

259 (b10/11/12)

263 to finish


(
~ind1=91;
~buf1 = ~kvbufs[~ind1];
~loop1= ~kvbufs.loopsAtBuf(~buf1);
~rate1 = 1;
~bpm1 = 60 * 16 / (~loop1.dur / ~rate1);
~matrix.setBPM(~bpm1);
Post << "BPM: " << ~bpm1 << Char.nl;

~pw1 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf)
	// \wamp, Pseq((0.7 ! 16) ++ (0.1 ! 16), inf),
	// \iamp, Pseq((0.0 ! 16) ++ (0.8 ! 16), inf),
	// \freq, Prand(Scale.minor.ratios.scramble.keep(3), inf),
	// \ramp, Pseq( [0.05, 0.4, 0.05, 0.4, 0.2, 0.3, 0.05, 0.3] ++ (0 ! 8) * 2, inf),
	// \rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w1', 'wrprevm', ~buf1, ~pw1, 4, 1.0, ~rate1 );
Pdef('mx01', Ppar([
	Pdef('b08'),
	Pdef('b09')
])
).play;
e.setPat('b08', 0.0, [0.5, 1.0], [0.08, 0.1], 0.1);
e.setPat('b09', 0.0, [0.5, 1.0], [0.05, 0.1], 0.1);

)

Pdef('mx01').clear


e.setWarp('w1', ['wamp', 0.8]);




Pdef('mx01', Ppar([
	Pdef('u08'),
	Pdef('u09'),
	Pdef('b10'),
	Pdef('b11'),
	Pdef('b12')
])).play;
e.setPat('u08', 0.0, [0.15, 0.3], nil, 0.1);
e.setPat('b09', 0.0, [0.5, 1.0], [0.08, 0.1], 0.1);
e.setPat('b08', 0.0, [0.5, 1.0], [0.05, 0.2], 0.1);


e.setPat('u08', 0.0, [0.15, 0.3], nil, 0.1);
e.setPat('u09', 0.0, [0.2, 0.4], nil, 0.1);



e.setPat('b10', 0.0, [0.5, 2.0], [0.08, 0.3], 0.1);
e.setPat('b11', 0.0, [0.5, 1.0], [0.05, 0.3], 0.1);
e.setPat('b12', 0.0, [0.5, 1.0], [0.05, 0.2], 0.1);

e.freeWarp('w1')



~kvbufs.searchDur(~loop1.dur, 0.1).do(_.postln)

245, 250

(
~ind1=257;
~buf1 = ~kvbufs[~ind1];
~loop1= ~kvbufs.loopsAtBuf(~buf1);
~rate1 = 1;
~bpm1 = 60 * 16 / (~loop1.dur / ~rate1);
~matrix.setBPM(~bpm1);
Post << "BPM: " << ~bpm1 << Char.nl;

~ratepat = [ 1.4983070768743, 1.7817974362766, 1.1224620483089 ];
// ~ratepat = Scale.minor.ratios.scramble.keep(3);

~pw1 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	// \wamp, Pseq((0.7 ! 16) ++ (0.1 ! 16), inf),
	// \iamp, Pseq((0.0 ! 16) ++ (0.8 ! 16), inf),
	// \freq, Prand(Scale.minor.ratios.scramble.keep(3), inf),
	// \ramp, Pseq( [0.05, 0.4, 0.05, 0.4, 0.2, 0.3, 0.05, 0.3] ++ (0 ! 8) * 2, inf),
	\rate, Pseq(~ratepat, inf )
];
e.playWarp('w1', 'wrprevm', ~buf1, ~pw1, 4, 0.0, ~rate1 );
// 192, 138, 44
~ind0=192;
~buf0 = ~kvbufs[~ind0];
~loop0= ~kvbufs.loopsAtBuf(~buf0);
~rate0 = ~loop0.dur/~loop1.dur;

~upats = ~matrix.patterndefs.keys.select({|key| key.asString.contains("u") }).asArray.collect({|name|
	~matrix.patterndefs[name].patterns.values.select({|arr|
		(arr.occurrencesOf(1) >= 16).and(arr.occurrencesOf(1) <= 32)
	})
}).flatten(1);

~pw0 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\iamp, Pseq(~upats[5]*0.3, inf),
	\wamp, Pseq(~upats[3]*0.3, inf),
	\freq, 0.5
];
e.playWarp('w0', 'wrprevm', ~buf0, ~pw0, 0.5, 0.0, ~rate0 );

~ind2=84;
~buf2 = ~kvbufs[~ind2];
~loop2= ~kvbufs.loopsAtBuf(~buf2);
~rate2 = ~loop2.dur/(~loop1.dur*1.5);

~pw2 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf)
];
e.playWarp('w2', 'wrprevm', ~buf2, ~pw2, 1, 0.7, ~rate2 );

Pdef('mx01', Ppar([
	Pdef('u08'),
	Pdef('u13'),
	Pdef('b08'),
	Pdef('b10'),
	Pdef('b11')
])).play;

)


e.setPat('u13', 0.0, [0.1, 0.3], nil, 0.1);
e.setPat('b08', 0.0, [0.3, 0.6], [0.08, 0.3], 0.1);
e.setPat('b10', 0.0, [0.5, 1.0], [0.08, 0.3], 0.1);
e.setPat('b11', 0.0, [0.5, 1.0], [0.05, 0.2], 0.1);
e.setWarp('w1', ['iamp', 0.0, 'wamp', 0.0, 'freq', 0.5, 'ramp', 0.0]);
e.freeWarp('w1');




e.setPat('b10', 0.0, [0.5, 0.7], [0.08, 0.3], 0.1);
e.setPat('b11', 0.0, [0.5, 0.7], [0.05, 0.3], 0.1);


e.setPat('u08', 0.0, [0.15, 0.3], nil, 0.0);
e.setPat('u09', 0.0, [0.3, 0.5], nil, 0.1);



e.setPat('b10', 0.0, [0.5, 1.0], [0.08, 0.3], 0.1);
e.setPat('b11', 0.0, [0.5, 1.0], [0.05, 0.2], 0.1);
e.setPat('b12', 0.0, [0.5, 1.0], [0.05, 0.2], 0.1);


~pw1.last.list

~matrix.patterndefs['b11'].recall(0)

e.setPat('u08', 0.3, [0.2, 0.4], nil, 0.1);
e.setPat('b08', 0.2, [0.3, 0.5], [0.05, 0.1], 0.1);
e.setWarp('w1', ['iamp', 0.0, 'wamp', 0.0, 'freq', 0.5, 'ramp', 0.0]);


e.setWarp('w0', ['iamp', 0.0, 'wamp', 0.0, 'freq', 1, 'ramp', 0.0]);


e.setPat('d06', 0.0, [0.2, 0.4], nil, 0.1);
e.setPat('d07', 0.0, [0.3, 0.5], nil, 0.1);


e.setPat('u10', 0.0, [0.2, 1.0], nil, 0.1);
e.setPat('b05', 0.0, [0.3, 0.6], [0.02, 0.2], 0.1);


e.setPat('b14', 0.0, [0.3, 0.6], [0.08, 0.2], 0.1);


e.setWarp('w1', ['iamp', 0.0, 'wamp', 0.7, 'freq', 1, 'ramp', 0.4]);
e.setPat('b10', 0.0, [0.5, 2.0], [0.08, 0.2], 0.1);
e.setPat('b11', 0.3, [0.5, 2.0], [0.05, 0.2], 0.1);
e.setPat('b12', 0.0, [0.5, 2.0], [0.05, 0.2], 0.1);



e.setPat('b02', 0.0, [0.2, 1.0], [0.05, 0.2], 0.1);
e.setPat('b16', 0.0, [0.3, 0.7], [0.05, 0.1], 0.1);
e.setPat('b17', 0.0, [0.3, 0.7], [0.05, 0.2], 0.1);


e.setWarp('w1', ['iamp', 0.0, 'wamp', 0.0, 'freq', 1, 'ramp', 0.0]);


e.setPwarp('w1', ~pw1, ~matrix.beatdur / 2)

e.setWarp('w1', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.0, 'iamp', 0.8, 'ramp', 0.0, 'rate', 1.0, 'freq', 1])


e.freeWarp('w0');
e.freeWarp('w1');
e.freeWarp('w2');

Pdef('mx01').clear;
e.setWarp('w1', ['iamp', 0.0, 'wamp', 0.0, 'freq', 1, 'ramp', 0.6]);





~matrix.activateSkismSynth('primeTam')

~matrix.setSkismAmp('primeTam', 0.3)

~matrix.deactivateSkismSynth('primeTam')



~matrix.activateSkismSynth('feedbackSpectrum')

~matrix.setSkismAmp('feedbackSpectrum', 0.1)

~matrix.deactivateSkismSynth('feedbackSpectrum')


~matrix.activateSkismSynth('magFreeze')

~matrix.setSkismAmp('magFreeze', 0.7)

~matrix.deactivateSkismSynth('magFreeze')



~kvbufs.loops.select({|loop| loop.dur == 0 }).size



(
~ind2=217;
~buf2 = ~kvbufs[~ind2];
~loop2 = ~kvbufs.loopsAtBuf(~buf2);
~rate2 = 1.2;

~bpm2 = 60 * 16 / (~loop2.dur / ~rate2);
~matrix.setBPM(~bpm2);

~ind3=219;
~buf3 = ~kvbufs[~ind3];
~loop3 = ~kvbufs.loopsAtBuf(~buf3);
~rate3 = (~loop2.dur / ~rate2).reciprocal / ~loop3.dur.reciprocal;


Post << "bpm: " << ~bpm2 << Char.nl;

~pw2 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\buf, Pseq([~buf3, ~buf2, ~buf3], inf)
	// \wamp, Pseq((0.7 ! 16) ++ (0.1 ! 16), inf),
	// \iamp, Pseq((0.1 ! 16) ++ (0.8 ! 16), inf),
	// \freq, Prand(Scale.minor.ratios.scramble.keep(3), inf),
	// // \wamp, Pseq( [0.05, 0.4, 0.05, 0.4, 0.2, 0.3, 0.05, 0.3]*2, inf),
	// \rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w2', 'wrprevm', ~buf2, ~pw2, 4, 0.7, ~rate2);
e.setWarp('w2', ['wamp', 0.6, 'iamp', 0.4]);


// ~bpm2 = 60 * 16 / ~loop2.dur;
// ~matrix.setBPM(~bpm2);

// Post << "bpm: " << ~bpm0 << Char.nl;

Pdef('mx01', Ppar([
	Pdef('u10'),
	Pdef('u11')
])).play;

e.setPat('u10', 1.0, [0.1, 1.0], nil, 0.1);
e.setPat('u11', 0.0, [0.1, 0.9], nil, 0.1);

)

e.setPwarp('w2', ~pw2, ~matrix.beatdur / 2)

e.setWarp('w2', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.0, 'iamp', 1.0, 'ramp', 0.1, 'rate', 1.0, 'freq', 1.0])

e.freeWarp('w2')

e.freeWarp('w3')

Pdef('mx01').clear


(
Tdef('randsurf', {
	loop({
		['w0', 'w1', 'w2'].scramble.do({|name|
			var rx, ry, rz, buf, pw, ind, amp, num, buflib;
			buflib = [~kvbufs, ~mesabufs].choose;
			ind = buflib.size.rand;
			buf = buflib[ind];
			Post << buflib << " index " << ind << " buffer " << buf << Char.nl;
			amp = rrand(0.1, 0.6);
			num = rrand(6, 23);
			rx = [Pbrown(-pi, pi, 0.125pi, inf), Prand(Array.series(num, 0, 2pi/num) - pi, inf), Pwhite(-pi, pi, inf)].choose;
			ry = [Pbrown(-pi, pi, 0.125pi, inf), Prand(Array.series(num, 0, 2pi/num) - pi, inf), Pwhite(-pi, pi, inf)].choose;
			rz = [Pbrown(-pi, pi, 0.125pi, inf), Prand(Array.series(num, 0, 2pi/num) - pi, inf), Pwhite(-pi, pi, inf)].choose;
			pw = [\rx, rx, \ry, ry, \rz, rz];
			e.playWarp(name, ['wrprevm', 'revwrpm'].choose, buf, pw, ~matrix.beatdur*2, amp);
			e.setWarp(name, ['wamp', rrand(0.05, 0.2), 'iamp', rrand(0.3, 0.6), 'ramp', rrand(0.01, 0.04)]);
			rrand(12, 24).wait
		})
	})
}).play
)


(
Tdef('randsurf').stop;
e.freeWarp('w0');
e.freeWarp('w1');
e.freeWarp('w2');
)


e.setPat('m03', 0.1, [0.2, 0.3], [0.5, 1.0], 0.0);


Pdef('mx01').clear







(
e.freeWarp('w0');
e.freeWarp('w1');
e.freeWarp('w2');

Pdef('mx08').clear;

~ind = 146; // 4
~buf = ~kvbufs[~ind];
~loop = ~kvbufs.loopsAtBuf(~buf);

~bpm = 60 * 16 / (~loop.dur / 1.5);
~matrix.setBPM(~bpm);

~ind = 47;
~buf = ~kvbufs[~ind];
~gamp = 0.4;
~ampk = 0;
~amps = 0;
~amph = 0;
~ampo = 0;
~ampx = 0;
~kpt = Pseq([ 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0 ], inf).asStream;
~spt = Pseq([ 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 ], inf).asStream;
~hpt = Pseq([ 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0 ], inf).asStream;
~opt = Pseq([ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1 ], inf).asStream;
~xpt = Pseq([ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ], inf).asStream;
~p1 = [
	\rx, Pbrown(-pi, pi, 0.125pi, inf),
	\ry, Pbrown(-pi, pi, 0.125pi, inf),
	\rz, Pbrown(-pi, pi, 0.125pi, inf),
	\buf, Pseq([47, 47, 47, 73, 73, 47, 47, 23, 23, 35, 35, 35 ].collect({|ind|
		~kvbufs[ind] }).mirror2, inf),
	\fnc, Pfunc({|ev|
		if (~kpt.next == 1) {
			Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', ~ampk * ~gamp * rrand(0.9, 1.1),
				'emp', 0.0, 'buf', ~matrix.buffers['evo'][19], 'dur', 0.5,
			'env', Env.perc, 'rotx', 2.0.rand, 'roty', 2.0.rand, 'rotz', 2.0.rand] );
		};
		if (~spt.next == 1) {
			Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', ~amps * ~gamp * rrand(0.9, 1.1),
				'emp', 0.0, 'buf', ~matrix.buffers['evo'][22], 'dur', 0.5,
			'env', Env.perc, 'rotx', 2.0.rand, 'roty', 2.0.rand, 'rotz', 2.0.rand] );
		};
		if (~hpt.next == 1) {
			Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', ~amph * ~gamp * rrand(0.9, 1.1),
				'emp', 0.0, 'buf', ~matrix.buffers['evo'][24], 'dur', 0.1,
			'env', Env.perc, 'rotx', 2.0.rand, 'roty', 2.0.rand, 'rotz', 2.0.rand] );
		};
		if (~opt.next == 1) {
			Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', ~ampo * ~gamp * rrand(0.9, 1.1),
				'emp', 0.0, 'buf', ~matrix.buffers['evo'][7], 'dur', 0.5,
			'env', Env.perc, 'rotx', 2.0.rand, 'roty', 2.0.rand, 'rotz', 2.0.rand] );
		};
		if (~xpt.next == 1) {
			Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', ~ampx * ~gamp * rrand(0.9, 1.1),
				'emp', 0.0, 'buf', ~matrix.buffers['evo'][57], 'dur', 0.3,
			'env', Env.perc, 'rotx', 2.0.rand, 'roty', 2.0.rand, 'rotz', 2.0.rand] );
		};
		1
	})
];

e.playWarp('w0', 'revwrpm', ~buf, ~p1, 1/4, 0.7, 1.3);

)


(
Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp',  0.4,
	'emp', 0.0, 'buf', ~matrix.buffers['evo'][57], 'dur', 0.5,
	'env', Env.perc, 'rotx', 2.0.rand, 'roty', 2.0.rand, 'rotz', 2.0.rand] );
)

~ampk = 0;
~amps = 0;
~amph = 0;
~ampo = 0;
~ampx = 0;

~matrix.activateSkismSynth('magFreeze')

~matrix.setSkismAmp('magFreeze', 0.7)

~matrix.deactivateSkismSynth('magFreeze')



(
a = [
	\rx, Pbrown(-pi, pi, 0.125pi, inf),
	\ry, Pbrown(-pi, pi, 0.125pi, inf),
	\rz, Pbrown(-pi, pi, 0.125pi, inf),
	\buf, Pseq([10, 10, 10, 11, 11, 10, 10, 145, 145, 46, 46, 46 ].collect({|ind|
		~kvbufs[ind] }).mirror2, inf),
	\fnc, Pfunc({|ev|
		if (~kpt.next == 1) {
			Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', ~ampk * ~gamp * rrand(0.9, 1.1),
				'emp', 0.0, 'buf', ~matrix.buffers['evo'][19], 'dur', 0.5,
			'env', Env.perc, 'rotx', 2.0.rand, 'roty', 2.0.rand, 'rotz', 2.0.rand] );
		};
		if (~spt.next == 1) {
			Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', ~amps * ~gamp * rrand(0.9, 1.1),
				'emp', 0.0, 'buf', ~matrix.buffers['evo'][22], 'dur', 0.5,
			'env', Env.perc, 'rotx', 2.0.rand, 'roty', 2.0.rand, 'rotz', 2.0.rand] );
		};
		if (~hpt.next == 1) {
			Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', ~amph * ~gamp * rrand(0.9, 1.1),
				'emp', 0.0, 'buf', ~matrix.buffers['evo'][24], 'dur', 0.1,
			'env', Env.perc, 'rotx', 2.0.rand, 'roty', 2.0.rand, 'rotz', 2.0.rand] );
		};
		if (~opt.next == 1) {
			Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', ~ampo * ~gamp * rrand(0.9, 1.1),
				'emp', 0.0, 'buf', ~matrix.buffers['evo'][7], 'dur', 0.5,
			'env', Env.perc, 'rotx', 2.0.rand, 'roty', 2.0.rand, 'rotz', 2.0.rand] );
		};
		if (~xpt.next == 1) {
			Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', ~ampx * ~gamp * rrand(0.9, 1.1),
				'emp', 0.0, 'buf', ~matrix.buffers['evo'][57], 'dur', 0.5,
			'env', Env.perc, 'rotx', 2.0.rand, 'roty', 2.0.rand, 'rotz', 2.0.rand] );
		};
		1
	})
];
e.setPwarp('w0', a, 1 / 4);
)





(
// e.freeWarp('w0');
// e.freeWarp('w1');
// e.freeWarp('w2');

// Pdef('mx08').clear;

~ind = 146; // 4
~buf = ~kvbufs[~ind];
~loop = ~kvbufs.loopsAtBuf(~buf);

~bpm = 60 * 16 / (~loop.dur / 1.5);
~matrix.setBPM(~bpm);

~rhystreams = ~matrix.patterndefs['d04'].patterns.values.collect({|pat| Pseq(pat, inf).asStream});
~rhydev = 0.1;
~rhyamps = (0.4 ! ~matrix.patterndefs['d04'].patterns.size);
~rhybufs = ~matrix.patterndefs['d04'].patterns.size.collect({|i|
	~matrix.buffers['evo'][i]
});
~rhydurs = ~matrix.patterndefs['d04'].patterns.values.collect({|pat|
	(1 / pat.occurrencesOf(1)).linexp(0.01, 1.0, 0.01, 0.3)
});

~ind = 47;
~buf = ~kvbufs[~ind];
~gamp = 0.7;
~p1 = [
	\rx, Pbrown(-pi, pi, 0.125pi, inf),
	\ry, Pbrown(-pi, pi, 0.125pi, inf),
	\rz, Pbrown(-pi, pi, 0.125pi, inf),
	\buf, Pseq([47, 47, 47, 73, 73, 47, 47, 23, 23, 35, 35, 35 ].collect({|ind|
		~kvbufs[ind] }).mirror2, inf),
	\fnc, Pfunc({|ev|
		~rhystreams.do({|stream, i|
			var on;
			on = stream.next;
			if (on == 1) {
				Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', ~rhyamps[i] + (~rhyamps[i] * ~rhydev).rand2 * ~gamp,
					'emp', 0.0, 'buf', ~rhybufs[i], 'dur', ~rhydurs[i] + (~rhydurs[i] * ~rhydev).rand2,
					'env', Env.perc, 'rotx', 2.0.rand, 'roty', 2.0.rand, 'rotz', 2.0.rand] );

			}
		});
		1
	})
];

e.playWarp('w0', 'revwrpm', ~buf, ~p1, 1/4, 0.7, 1.3);

)

~rhyamps = Array.fill(~matrix.patterndefs['d04'].patterns.size, {
	[1.0, 0.0].wchoose([0.5, 0.5])
})


Pdef('mx00').clear




~occs = ~matrix.patterndefs.keys.select({|key| key.asString.contains("u") }).asArray.collect({|name|
	~matrix.patterndefs[name].patterns.values.collect({|arr|
		arr.occurrencesOf(1)
	})
})


~occs.flat.sort.asSet.asArray.sort

Pdef('mx00',).clear

(
~ind = 146; // 4
~buf = ~kvbufs[~ind];
~loop = ~kvbufs.loopsAtBuf(~buf);

~bpm = 60 * 16 / (~loop.dur / 1.5);
~matrix.setBPM(~bpm);

~rkeys = ~matrix.patterndefs.keys.select({|key| key.asString.contains("u")}).asArray.scramble.keep(8);

// Pdef('mx00',
// 	Ppar(~rkeys.collect({|name|
// 		Pdef(name)
// 	}))
// ).play;

// Pdef('mx00',
// 	Ppar(['b07', 'b08', 'b09', 'b10'].collect({|name|
// 		Pdef(name)
// 	}))
// ).play;

~patterns = ~matrix.patterndefs.keys.select({|key| key.asString.contains("u") }).asArray.collect({|name|
	~matrix.patterndefs[name].patterns.values.select({|arr|
		(arr.occurrencesOf(1) > 13).and(arr.occurrencesOf(1) < 28)
	})
}).flatten(1);
~ratios = Scale.minor.ratios.mirror * ((1 ! 7) ++ (0.6 ! 6));

~ind0 = 111; ~ind1 = 60; ~ind2 = 42; ~ind3 = 16;
~ratios = Array.geom(7, 0.5, 6/5);

~ind0 = ~mesabufs.size.rand;
~buf0 = ~mesabufs[~ind0];
~loop0 = ~mesabufs.loopsAtBuf(~buf0);
~rate0 = (~loop.dur / 1.5).reciprocal / ~loop0.dur.reciprocal;
~patchoice = Array.fill(8, { ~patterns.choose });
~pw0 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\wamp, Pdefn('w0w', Pseq(~patchoice[0] * 0.4, inf)),
	\iamp, Pdefn('w0i', Pseq([0], inf)),
	\freq, Pseq(~ratios.scramble.keep(4.rand + 1), inf)
];
// // e.playWarp('w0', 'wrprevm', ~buf0, ~pw0, 1/2, 0.0, ~rate0 );
e.playWarp('w0', 'revwrpm', ~buf0, ~pw0, 1/4, 0.0, ~rate0 );

~ind1=~mesabufs.size.rand;
~buf1 = ~mesabufs[~ind1];
~loop1 = ~mesabufs.loopsAtBuf(~buf1);
~rate1 = (~loop.dur / 1.5).reciprocal / ~loop1.dur.reciprocal;
~pw1 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\wamp, Pdefn('w1w', Pseq(~patchoice[2] * 0.4, inf)),
	\iamp, Pdefn('w1i', Pseq([0], inf)),
	\freq, Pseq(~ratios.scramble.keep(4.rand + 1), inf)
];
e.playWarp('w1', 'wrprevm', ~buf1, ~pw1, 1/4, 0.0, ~rate1 );

~ind2=~mesabufs.size.rand;
~buf2 = ~mesabufs[~ind2];
~loop2 = ~mesabufs.loopsAtBuf(~buf2);
~rate2 = (~loop.dur / 1.5).reciprocal / ~loop2.dur.reciprocal;
~pw2 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\wamp, Pdefn('w2w', Pseq([0], inf)),
	\iamp, Pdefn('w2i', Pseq(~patchoice[5] * 0.4, inf)),
	\freq, Pseq(~ratios.scramble.keep(4.rand + 1), inf)
];
e.playWarp('w2', 'wrprevm', ~buf2, ~pw2, 1/4, 0.0, ~rate2 );

~ind3=~mesabufs.size.rand;
~buf3 = ~mesabufs[~ind3];
~loop3 = ~mesabufs.loopsAtBuf(~buf3);
~rate3 = (~loop.dur / 1.5).reciprocal / ~loop3.dur.reciprocal;
~pw3 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\wamp, Pdefn('w3w', Pseq([0], inf)),
	\iamp, Pdefn('w3i', Pseq(~patchoice[7] * 0.4, inf)),
	\freq, Pseq(~ratios.scramble.keep(4.rand + 1), inf),

];
e.playWarp('w3', 'wrprevm', ~buf3, ~pw3, 1/2, 0.0, ~rate3 );
Post << "~ind0 = " << ~ind0 << "; ~ind1 = " << ~ind1 << "; ~ind2 = " << ~ind2 << "; ~ind3 = " << ~ind3 << Char.nl;

)

~mesabufs.choose


e.setWarp('w0', ['buf', ~mesabufs.choose]);
Pdefn('w0w', Pseq(~patterns.choose * 0.4, inf));
Pdefn('w0i', Pseq(~patterns.choose * 0.4, inf));


e.setWarp('w1', ['buf', ~mesabufs.choose]);
Pdefn('w1w', Pseq(~patterns.choose * 0.4, inf));
Pdefn('w1i', Pseq(~patterns.choose * 0.4, inf));


e.setWarp('w2', ['buf', ~mesabufs.choose]);
Pdefn('w2w', Pseq(~patterns.choose * 0.4, inf));
Pdefn('w2i', Pseq(~patterns.choose * 0.4, inf));


e.setWarp('w3', ['buf', ~mesabufs.choose]);
Pdefn('w3w', Pseq(~patterns.choose * 0.4, inf));
Pdefn('w3i', Pseq(~patterns.choose * 0.4, inf));






e.setWarp('w0', ['buf', ~mesabufs.choose]);
Pdefn('w0w', Pseq(~patchoice[0] * 0.4, inf));
Pdefn('w0i', Pseq(~patchoice[1] * 0.4, inf));


e.setWarp('w1', ['buf', ~mesabufs.choose]);
Pdefn('w1w', Pseq(~patchoice[2] * 0.4, inf));
Pdefn('w1i', Pseq(~patchoice[3] * 0.4, inf));


e.setWarp('w2', ['buf', ~mesabufs.choose]);
Pdefn('w2w', Pseq(~patchoice[4] * 0.4, inf));
Pdefn('w2i', Pseq(~patchoice[5] * 0.4, inf));


e.setWarp('w3', ['buf', ~mesabufs.choose]);
Pdefn('w3w', Pseq(~patchoice[6] * 0.4, inf));
Pdefn('w3i', Pseq(~patchoice[7] * 0.4, inf));



Pdefn('w3w', Pseq(~patters * 0.4, inf));
Pdefn('w3i', Pseq(~patterns.choose * 0.2, inf));


Pdefn('w2w', Pseq([0], inf));





Pseq([0], inf)
Pseq(~patterns.choose * 0.4)


e.setWarp('w0', ['ramp', 0.0]);
e.setWarp('w1', ['ramp', 0.0]);
e.setWarp('w2', ['ramp', 0.1]);
e.setWarp('w3', ['ramp', 0.0]);



e.freeWarp('w0');
e.freeWarp('w1');
e.freeWarp('w2');
e.freeWarp('w3');


(
e.setPat(~rkeys[0], 0.0, [0.3, 0.5], nil, 0.0);
e.setPat(~rkeys[1], 0.0, [0.2, 0.4], nil, 0.0);
e.setPat(~rkeys[2], 0.0, [0.3, 0.5], nil, 0.0);
e.setPat(~rkeys[3], 0.0, [0.2, 0.35], nil, 0.0);
e.setPat(~rkeys[4], 0.0, [0.2, 0.35], nil, 0.0);
e.setPat(~rkeys[5], 0.0, [0.2, 0.35], nil, 0.0);
e.setPat(~rkeys[6], 0.0, [0.2, 0.35], nil, 0.0);
e.setPat(~rkeys[7], 0.0, [0.2, 0.35], nil, 0.0);
)






(
~ind0 = ~mesabufs.size.rand;
~buf0 = ~mesabufs[~ind0];
~loop0 = ~mesabufs.loopsAtBuf(~buf0);
~rate0 = (~loop.dur / 1.5).reciprocal / ~loop0.dur.reciprocal;
e.setWarp('w0', ['buf', ~buf0, 'rate', ~rate0]);


~ind1 = ~mesabufs.size.rand;
~buf1 = ~mesabufs[~ind1];
~loop1 = ~mesabufs.loopsAtBuf(~buf1);
~rate0 = (~loop.dur / 1.5).reciprocal / ~loop1.dur.reciprocal;
e.setWarp('w1', ['buf', ~buf1, 'rate', ~rate1]);

)


(
~ind2 = ~mesabufs.size.rand;
~buf2 = ~mesabufs[~ind2];
~loop2 = ~mesabufs.loopsAtBuf(~buf2);
~rate2 = (~loop.dur / 1.5).reciprocal / ~loop2.dur.reciprocal;
e.setWarp('w2', ['buf', ~buf2, 'rate', ~rate2]);

~ind3 = ~mesabufs.size.rand;
~buf3 = ~mesabufs[~ind3];
~loop3 = ~mesabufs.loopsAtBuf(~buf3);
~rate3 = (~loop.dur / 1.5).reciprocal / ~loop3.dur.reciprocal;
e.setWarp('w3', ['buf', ~buf3, 'rate', ~rate3]);

)




~ind0 = 5; ~ind1 = 121; ~ind2 = 32;
~ind0 = 50; ~ind1 = 37; ~ind2 = 58; ~ind3 = 114;
~ind0 = 74; ~ind1 = 22; ~ind2 = 124; ~ind3 = 151;
~ind0 = 136; ~ind1 = 52; ~ind2 = 77; ~ind3 = 55;
~ind0 = 91; ~ind1 = 103; ~ind2 = 124; ~ind3 = 41;
~ind0 = 159; ~ind1 = 130; ~ind2 = 61; ~ind3 = 132;
~ind0 = 111; ~ind1 = 60; ~ind2 = 42; ~ind3 = 16
~ind0 = 160; ~ind1 = 57; ~ind2 = 1; ~ind3 = 60
~ind0 = 118; ~ind1 = 115; ~ind2 = 110; ~ind3 = 11;
~ind0 = 38; ~ind1 = 49; ~ind2 = 133; ~ind3 = 152;
~ind0 = 67; ~ind1 = 139; ~ind2 = 118; ~ind3 = 148
~ind0 = 59; ~ind1 = 64; ~ind2 = 117; ~ind3 = 51;
~ind0 = 91; ~ind1 = 98; ~ind2 = 90; ~ind3 = 68;
~ind0 = 144; ~ind1 = 12; ~ind2 = 160; ~ind3 = 118;
~ind0 = 134; ~ind1 = 110; ~ind2 = 13; ~ind3 = 131;





(
e.setWarp('w0', ['ramp', 0.0]);
e.setWarp('w1', ['ramp', 0.0]);
e.setWarp('w2', ['ramp', 0.0]);
e.setWarp('w3', ['ramp', 0.0]);

e.setPat('u25', 0.0, [0.2, 0.4], nil, 0.0);
e.setPat('u26', 0.0, [0.2, 0.35], nil, 0.0);
e.setPat('u27', 0.0, [0.2, 0.4], nil, 0.0);
e.setPat('u37', 0.0, [0.2, 0.35], nil, 0.0);
)



e.setPat('b07', 0.0, [0.2, 0.4], [0.05, 0.1], 0.0);
e.setPat('b08', 0.0, [0.2, 0.4], [0.05, 0.1], 0.0);
e.setPat('b09', 0.0, [0.2, 0.35], [0.05, 0.1], 0.0);
e.setPat('b10', 0.0, [0.2, 0.8], [0.1, 0.4], 0.0);



e.setPat('u27', 0.0, [0.2, 0.4], nil, 0.0);
e.setPat('u37', 0.0, [0.2, 0.35], nil, 0.0);



(
~zone2.();
e.freeWarp('w0');
e.freeWarp('w1');

~ind = 146; // 4
~buf = ~kvbufs[~ind];
~loop = ~kvbufs.loopsAtBuf(~buf);

~bpm = 60 * 16 / (~loop.dur / 1.5);
~matrix.setBPM(~bpm);

Pdef('mx00',
	Ppar(['u26', 'u31'].collect({|name|
		Pdef(name)
	}))
).play;

~ind0=13;
~buf0 = ~mesabufs[~ind0];
~loop0 = ~mesabufs.loopsAtBuf(~buf0);
~rate0 = (~loop.dur / 1.5).reciprocal / ~loop0.dur.reciprocal;
~pw0 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\wamp, Pseq(~matrix.patterndefs['u19'].patterns.values[3] * 0.4, inf),
	\iamp, Pseq(~matrix.patterndefs['u19'].patterns.values[0] * 0.4, inf)
];
e.playWarp('w0', 'wrprevm', ~buf0, ~pw0, 1/4, 0.4, ~rate0 );

~ind1=71;
~buf1 = ~mesabufs[~ind1];
~loop1 = ~mesabufs.loopsAtBuf(~buf1);
~rate1 = (~loop.dur / 1.5).reciprocal / ~loop1.dur.reciprocal;
~pw1 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\wamp, Pseq(~matrix.patterndefs['u19'].patterns.values[5] * 0.4, inf),
	\iamp, Pseq(~matrix.patterndefs['u19'].patterns.values[2] * 0.4, inf)
];
e.playWarp('w1', 'wrprevm', ~buf1, ~pw1, 1/2, 0.0, ~rate1 );

~ind2=41;
~buf2 = ~mesabufs[~ind2];
~loop2 = ~mesabufs.loopsAtBuf(~buf2);
~rate2 = (~loop.dur / 1.5).reciprocal / ~loop2.dur.reciprocal;
~pw2 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\wamp, Pseq(~matrix.patterndefs['u20'].patterns.values[2] * 0.4, inf),
	\iamp, Pseq(~matrix.patterndefs['u20'].patterns.values[3] * 0.4, inf)
];
e.playWarp('w2', 'wrprevm', ~buf2, ~pw2, 1/4, 0.0, ~rate2 );

)

(
e.setPat('u26', 0.0, [0.2, 0.4], nil, 0.0);
e.setPat('u31', 0.0, [0.2, 0.35], nil, 0.0);
)



SynthDef("pmosc", {|amp, frq, mod, ind, mph|
	var sig;
	sig = PMOsc.ar(frq, mod, ind, mph, amp);
	sig = BPF.ar(sig, frq, LFNoise2.kr(0.1).range(0.1, 0.3));
	Out.ar(0, Pan2.ar(sig))
}).add

~sy = Synth('pmosc', ['amp', 0, 'frq', 201, 'mod', 1001, 'ind', 13, 'mph', 0])



~freqs = ~ratios = Scale.minor.ratios.mirror * ((1 ! 7) ++ (0.6 ! 6)) * 201;


~mesabufs.searchDur(~loop1.dur).do(_.postln)

(
~ind0 = 0;
~buf0 = ~kvbufs[~ind0];
~loop0 = ~kvbufs.loopsAtBuf(~buf0);
~rate0 = 1.3;
~bpm0 = 60 * 16 / (~loop0.dur / ~rate0);
~matrix.setBPM(~bpm0);
Post << "bpm: " << ~bpm0 << Char.nl;

~pw0 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf)
];
e.playWarp('w0', 'revwrpm', ~buf0, ~pw0, 1, 0.7, ~rate0);

~ind1 = 5;
~buf1 = ~mesabufs[~ind1];
~loop1 = ~mesabufs.loopsAtBuf(~buf1);
~rate1 = ~loop1.dur / (~loop0.dur / ~rate0);

~pw1 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf)
];
e.playWarp('w1', 'revwrpm', ~buf1, ~pw1, 1, 1, ~rate1);

~ind2 = 13;
~buf2 = ~mesabufs[~ind2];
~loop2 = ~mesabufs.loopsAtBuf(~buf2);
~rate2 = ~loop2.dur / (~loop0.dur / ~rate0);

~pw2 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf)
];
e.playWarp('w2', 'revwrpm', ~buf2, ~pw2, 1, 0.7, ~rate2);

Pdef('mx01', Ppar([
	Pdef('r00'),
	Pdef('r02'),
	Pdef('r06')
])).play;
e.setPat('r00', 0.2, [0.2, 0.4], [0.07, 0.1], 0.1);
e.setPat('r02', 0.2, [0.2, 0.4], [0.07, 0.1], 0.1);
)

Pdef('mx01').clear

Pdef('r01').stop



e.setPat('r00', 0.2, [0.2, 0.4], [0.07, 0.1], 0.1);
e.setPat('r02', 0.0, [0.2, 0.4], [0.07, 0.1], 0.1);
e.setPat('r06', 0.1, [0.1, 0.4], [0.07, 0.1], 0.1);



e.setPwarp('w0', ~pw0, ~matrix.beatdur / 2)

e.setWarp('w0', ['wamp', 0.0, 'iamp', 0.4, 'ramp', 0.0]);
e.setWarp('w1', ['wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0]);
e.setWarp('w2', ['wamp', 0.0, 'iamp', 0.4, 'ramp', 0.0])


(
e.freeWarp('w0');
e.freeWarp('w1');
e.freeWarp('w2');
Pdef('mx01').clear;
e.setPat('r00', 0.0, [0.2, 0.4], [0.07, 0.1], 0.1);
e.setPat('r02', 0.0, [0.2, 0.4], [0.07, 0.1], 0.1);
e.setPat('r06', 0.0, [0.1, 0.4], [0.07, 0.1], 0.1);
)


~lp0 = ~kvbufs.loopsAtBuf(~buf0)
~lp0.dur
~lp1 = ~kvbufs.loopsAtBuf(~buf1)
~lp1.dur




~mesabufs.searchDur(~loop1.dur).do(_.postln)


(
~ind0 = 13; // 4
~buf0 = ~mesabufs[~ind0];
~loop0 = ~mesabufs.loopsAtBuf(~buf0);
~rate0 = 1;
~bpm0 = 60 * 16 / (~loop0.dur / ~rate0);
~matrix.setBPM(~bpm0);
Post << "bpm: " << ~bpm0 << Char.nl;

~pw0 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf)
	// \iamp, Pseq([1, 1, 0] * 0.5, inf),
	// \wamp, Pseq([0.5, 0.5, 0.5, 0.0, 0.5, 0.0], inf),
	// \freq, Prand(Scale.minor.ratios.scramble.keep(3), inf)
	// // \wamp, Pseq( [0.05, 0.4, 0.05, 0.4, 0.2, 0.3, 0.05, 0.3]*2, inf),
	// \rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w0', 'wrprevm', ~buf0, ~pw0, 1, 1, ~rate0);

~ind1 = 1; // 4
~buf1 = ~mesabufs[~ind1];
~loop1 = ~mesabufs.loopsAtBuf(~buf1);
~rate1 = ~loop1.dur.reciprocal / ~loop0.dur.reciprocal;

~pw0 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf)
	// \iamp, Pseq([1, 1, 0] * 0.5, inf),
	// \wamp, Pseq([0.5, 0.5, 0.5, 0.0, 0.5, 0.0], inf),
	// \freq, Prand(Scale.minor.ratios.scramble.keep(3), inf)
	// // \wamp, Pseq( [0.05, 0.4, 0.05, 0.4, 0.2, 0.3, 0.05, 0.3]*2, inf),
	// \rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w1', 'wrprevm', ~buf1, ~pw1, 1, 1, ~rate1);
Pdef('mx01', Ppar([
	Pdef('b16'),
	Pdef('b17')
])).play;

)

~matrix.patterndefs['b17'].ctrls['b1722']

(
[
	[ 'b1617', 0.3350798150615, 0.21154130244024 ],
	[ 'b1623', 0.21649539460438, 0.22501815401866 ],
	[ 'b1630', 0.20647043385056, 0.34722324222462 ],
	[ 'b1605', 0.28198236332029, 0.32081471591999 ],
	[ 'b1621', 0.20829764420246, 0.21144534772633 ],
	[ 'b1705', 0.21411641519958, 0.29974852533787 ]
].do({|arr|
	var args, pkey;
	pkey = arr.first.asString.keep(3).asSymbol;
	args = arr.insert(1, 1) ++ 0.1;
	args.postln;
	~matrix.defsAt(pkey).setControl(*args)
})
)

~matrix.defsAt('b16').setActives({rrand(0.2, 0.4)}, {rrand(0.1, 0.3)}, 0.1)


(
e.setPat('b16', 0.3, [0.2, 0.5], [0.02, 0.1], 0.1);
e.setPat('b17', 0.3, [0.2, 0.5], [0.02, 0.1], 0.1);
)


e.setWarp('w0', ['wamp', 0.5, 'iamp', 1.0, 'ramp', 0.1]);

e.setWarp('w1', ['wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0]);

~ind0 = 114;
e.setWarp('w0', ['buf', ~mesabufs[ ~ind0]]);


~mesabufs.searchDur(~loop0.dur).do(_.postln)

(
~ind2 = 127; //103, 113, 150, 114, 76, 127
~buf2 = ~mesabufs[~ind2];
~loop2 = ~mesabufs.loopsAtBuf(~buf2);
~rate2 = ~loop2.dur.reciprocal / ~loop0.dur.reciprocal;

~pw2 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf)
	// \iamp, Pseq([1, 1, 0] * 0.5, inf),
	// \wamp, Pseq([0.5, 0.5, 0.5, 0.0, 0.5, 0.0], inf),
	// \freq, Prand(Scale.minor.ratios.scramble.keep(3), inf)
	// // \wamp, Pseq( [0.05, 0.4, 0.05, 0.4, 0.2, 0.3, 0.05, 0.3]*2, inf),
	// \rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w2', 'wrprevm', ~buf2, ~pw2, 1, 0.5, ~rate2);
)


~matrix.defsAt('b16').ctrls.select({|it| it.active.booleanValue }).keysValuesDo({|key, val|
	[key, val.dur, val.amp].postln
})
~matrix.defsAt('b17').ctrls.select({|it| it.active.booleanValue }).keysValuesDo({|key, val|
	[key, val.dur, val.amp].postln
})

e.setWarp('w0', ['wamp', 0.5, 'iamp', 1.0, 'ramp', 0.1]);

e.freeWarp('w0');

e.setWarp('w1', ['wamp', 0.5, 'iamp', 1.0, 'ramp', 0.1, 'freq', 15/16]);

e.setWarp('w2', ['wamp', 0.0, 'iamp', 1.0, 'ramp', 0.0, 'freq', 15/16]);


e.freeWarp('w2');

Pdef('mx01').clear