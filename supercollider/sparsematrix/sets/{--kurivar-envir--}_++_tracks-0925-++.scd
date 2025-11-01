(
~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2,
	screenX: 1024, screenY: 768, mode: 1, decoderType: 'binaural',
	'localDecoder': true, 'ambiOrder': 3,
	bpm: 136.7762208841, channels: 2, foa: #[zoom,push], dbname: "ges_ld_00",
	patdefs: "patternDefsMesa.scd", worldDim: 21, ip: "127.0.0.1"
);
e = SpEnvir(~settings)

)


SparseMatrix

Server.killAll
s.queryAllNodes


(
~matrix.patterndefs.keys.select({|key| key.asString.contains("u")}).do({|name|
	var pat = e.getPat(name);
	pat.ctrls.keysValuesDo({|key, ctrl|
		var len, on;
		on = pat.patterns[key].select(_.odd).size;
		len = pat.patterns[key].size;
		ctrl.dur = (1.0 / on).linlin(1/len, 1, 0.04, 0.15);
	})
});
~matrix.patterndefs.keys.select({|key| key.asString.contains("d")}).do({|name|
	var pat = e.getPat(name);
	pat.ctrls.keysValuesDo({|key, ctrl|
		var len, on;
		on = pat.patterns[key].select(_.odd).size;
		len = pat.patterns[key].size;
		ctrl.dur = (1.0 / on).linlin(1/len, 1, 0.04, 0.15);
	})
})
)



(

// --------- vaskeresi i  ----------//
~zone0.();
~ind = 146; // 4
~buf = ~kvbufs[~ind];
~loop = ~kvbufs.loopsAtBuf(~buf);

~bpm = 60 * 16 / (~loop.dur / 1.5);
~matrix.setBPM(~bpm);

~pw = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pbrown(0, 2pi, 0.125pi, inf),
	\rz, Pbrown(0, 2pi, 0.125pi, inf),
	\ramp, Pseq(( (0.05 ! 24) ++ [1.0, 1.0, 0.1, 1.0, 0.0, 0.3, 0.1, 0.0] ) * 0.3, inf)
	// \fnc, Pfunc({|ev|
	// })
];
e.playWarp('w0', 'wrprevm', ~buf, ~pw, 1/2, 0.5, 1.5);

// x = {Impulse.ar(~matrix.bps).dup}.play;

// ~ind1 = 188; // 23, 13, 188
// ~buf1 = ~kvbufs[~ind1];
// ~loop1 = ~kvbufs.loopsAtBuf(~buf1);
// ~bpm1 = 60 / ~loop1.dur * (2**4) * 1.5;
// ~rate1 = ~loop.dur.reciprocal * 1.5 / ~loop1.dur.reciprocal;
//
// ~pw1 = [
// 	\rx, Pwhite(-pi, pi, inf),
// 	\ry, Pbrown(0, 2pi, 0.125pi, inf),
// 	\rz, Pbrown(0, 2pi, 0.125pi, inf),
// 	\iamp, Pseq([1, 0, 0, 0, 0, 1, 0, 0] * 0.5, inf)
// ];
// e.playWarp('w1', 'wrprevm', ~buf1, ~pw1, 8, 0, ~rate1);

~ind2 = 205;
~buf2 = ~kvbufs[~ind2];
~loop2 = ~kvbufs.loopsAtBuf(~buf2);

~rate2 = (~loop2.dur*2).reciprocal/(~loop.dur * 1.5.reciprocal).reciprocal;
~pw2 =  [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pbrown(0, 2pi, 0.125pi, inf),
	\rz, Pbrown(0, 2pi, 0.125pi, inf),
	\ramp, Pseq(( (0.05 ! 24) ++ [1.0, 1.0, 0.1, 1.0, 0.0, 0.3, 0.1, 0.0] ) * 0.3, inf)
];
e.playWarp('w2', 'wrprevm', ~buf2, ~pw2, 1/2, 0.0, ~rate2);
Pdef('mx11',
	Ppar(['d01', 'd02', 'd03', 'd04'].collect({|name|
		Pdef(name)
	}))
).play;

)

x.free


Pdef('mx11').clear

(
e.setPat('d04', 0.0, [0.1, 0.2]);
e.setPat('d03', 0.0, [0.1, 0.2]);
e.setPat('d01', 0.0, [0.1, 0.2]);
e.setPat('d02', 0.0, [0.1, 0.2]);
)


e.setWarp('w2', ['iamp', 0.0, 'wamp', 0.0])

e.setWarp('w0', ['amp', 1.0, 'wrp', 0.0, 'wamp', 0.0])




(
e.setWarp('w0', ['amp', 1, 'wrp', 0.25, 'wamp', 0.0])
)

x.free

e.freeWarp('w0');
e.freeWarp('w1');
e.freeWarp('w2');

Pdef('mx11').clear;






// --------- unelangva ----------//

(
~zone1.();
~ind0 = 206; // 17, 180, 206, 212
~buf0 = ~kvbufs[~ind0];
~loop0 = ~kvbufs.loopsAtBuf(~buf0);
// ~rate0 = 1.0;
// ~loop0.postln;
//
// ~bpm0 = 60 * 16 / (~loop0.dur / ~rate0);
// ~matrix.setBPM(~bpm0);
// Post << "bpm: " << ~bpm0 << Char.nl;

~pw0 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\iamp, Pseq([1, 0, 0] * 0.3, inf),
	\wamp, Pseq([1, 1, 1, 0.0, 1, 0.0] * 0.3, inf),
	\freq, Prand(Scale.minor.ratios.scramble.keep(5), inf)
	// // \wamp, Pseq( [0.05, 0.4, 0.05, 0.4, 0.2, 0.3, 0.05, 0.3]*2, inf),
	// \rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w0', 'revwrpm', ~buf0, ~pw0, 1, 0, 1);
Pdef('mx01', Ppar([
	Pdef('u01'),
	Pdef('u03'),
	Pdef('u02'),
	Pdef('u04'),
	Pdef('r16')
])).play;
e.setWarp('w0', ['ramp', 0.1]);
)


(
e.setPat('u04', 0.0, [0.1, 0.3], nil, 0.1);
e.setPat('u03', 0.0, [0.1, 0.3], nil, 0.1);
e.setPat('u02', 0.3, [0.1, 0.3], nil, 0.1);
e.setPat('u01', 1.0, [0.1, 0.3], nil, 0.1);
)



(
~ind0 = 17;
~buf0 = ~kvbufs[~ind0];
~loop0 = ~kvbufs.loopsAtBuf(~buf0);
~rate0 = 1.0;
~loop0.postln;

// ~bpm0 = 60 * 16 / (~loop0.dur / ~rate0);
// ~matrix.setBPM(~bpm0);
// Post << "bpm: " << ~bpm0 << Char.nl;
e.setWarp('w0', ['buf', ~buf0]);

)


Pdef('mx01').clear

e.freeWarp('w0');

(
~ind0 = 237; // 4
~buf0 = ~kvbufs[~ind0];
~loop0 = ~kvbufs.loopsAtBuf(~buf0);
// ~rate0 = 1;
// ~loop0.postln;
//
// ~bpm0 = 60 * 16 / (~loop0.dur / ~rate0);
// ~matrix.setBPM(~bpm0);
// Post << "bpm: " << ~bpm0 << Char.nl;

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
	Pdef('u01'),
	Pdef('u03'),
	Pdef('u02'),
	Pdef('u04')
])).play;

)


e.freeWarp('w1');



e.setWarp('w0', ['ramp', 0.0]);
e.setWarp('w1', ['ramp', 0.05]);







// --------- viookileel  ----------//
(
~zone3.();
e.freeWarp('w0');
e.freeWarp('w1');
e.freeWarp('w2');

Pdef('mx01').clear;

~matrix.patterndefs.keys.select({|key| key.asString.contains("d")}).do({|name|
	var pat = e.getPat(name);
	pat.ctrls.keysValuesDo({|key, ctrl|
		var len, on;
		on = pat.patterns[key].select(_.odd).size;
		len = pat.patterns[key].size;
		ctrl.dur = (1.0 / on).linlin(1/len, 1, 0.05, 0.2);
	})
});
e.freeWarp('w0');
~ind = 146; // 4
~buf = ~kvbufs[~ind];
~loop = ~kvbufs.loopsAtBuf(~buf);

~bpm = 60 * 16 / (~loop.dur / 1.5);
~matrix.setBPM(~bpm);

~ind0 = 116;
~buf0 = ~mesabufs[~ind0];
~loop0 = ~mesabufs.loopsAtBuf(~buf0);
~rate0 =  (~loop.dur / 1.5).reciprocal / ~loop0.dur.reciprocal;

~ind1=71;
~buf1 = ~mesabufs[~ind1];
~loop1 = ~mesabufs.loopsAtBuf(~buf1);
~rate1 = (~loop.dur / 1.5).reciprocal / ~loop1.dur.reciprocal;

~ind2 = 252;
~buf2 = ~kvbufs[~ind2];
~loop2 = ~kvbufs.loopsAtBuf(~buf2);
~rate2 = (~loop.dur / 1.5).reciprocal / ~loop2.dur.reciprocal;

~pw0 = [
	[
		\rx, Pbrown(-pi, pi, pi/45, inf),
		\ry, Pbrown(-pi, pi, pi/45, inf),
		\rz, Pbrown(-pi, pi, pi/45, inf),
		\delta, Pn(~matrix.beatdur / 4)
	],
	[
		\freq, Pseq([1, 1, 15/16], inf), //Pseq(SparseMatrix.patternsDnB['Offbeat_0006'].keep(3).flat, inf),
		\buf, Pseq([~buf0, ~buf2, ~buf0, ~buf1], inf),
		\rate, Pseq([~rate0, ~rate2, ~rate0, ~rate1], inf),
		// \iamp, Pseq([0.7, 0.2, 0.7, 0.4], inf),
		\wamp, Pseq([0.5, 1.0, 0.5, 0.5], inf),
		\delta, Pn(~matrix.beatdur * 4)
	]
];
e.playParWarp('w0', 'wrprevm', ~buf0, ~pw0, 0.0, ~rate0, false );
e.setPat('r03', 0.0, [0.5, 1.0], [0.1, 0.2], 0.0);
e.setPat('b10', 0.1, [0.5, 1.0], [0.1, 0.2], 0.0);
e.setPat('b11', 0.1, [0.5, 1.0], [0.1, 0.2], 0.0);
e.setPat('b12', 0.2, [0.4, 1.0], [0.1, 0.2], 0.0);
Pdef('mx10',
	Ppar(
		['b04', 'b10', 'b11', 'b12', 'r03', 'w0'].collect({|name|
			Pdef(name)
		})
	)
).play;
e.setWarp('w0', ['iamp', 0.0, 'wrp', 0.5, 'ramp', 0.1]);

)

(
e.setPat('r03', 0.5, [0.3, 0.5], [0.01, 0.1], 0.0);
e.setPat('b10', 0.0, [0.5, 1.0], [0.1, 0.2], 0.0);
e.setPat('b11', 0.0, [0.5, 1.0], [0.1, 0.1], 0.0);
e.setPat('b12', 0.3, [0.4, 1.0], [0.1, 0.1], 0.0);
)

e.setPat('b04', 0.3, [0.2, 0.4], [2.0, 4.0], 0.0);



e.setWarp('w0', ['iamp', 0.0, 'wamp', 0.3, 'ramp', 0.1]);
e.setWarp('w2', ['iamp', 0.0, 'wamp', 0.2, 'ramp', 0.1]);


e.freeWarp('w2');
Pdef('mx10').clear;

e.setWarp('w0', ['iamp', 0.0, 'wrp', 0.5, 'ramp', 0.1]);






// --------- tekaniim  ----------//

(
~zone2.();
e.freeWarp('w0');
e.freeWarp('w2');
Pdef('mx11').clear;


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
e.setPat('u26', 1.0, [0.2, 0.3], nil, 0.0);
e.setPat('u31', 1.0, [0.2, 0.35], nil, 0.0);
)


Pdef('mx00').clear


(
e.setWarp('w0', ['wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0]);
e.setWarp('w1', ['wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0]);
e.setWarp('w2', ['wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0]);
e.setPat('u31', 0.0, [0.2, 0.4], nil, 0.0);
e.setPat('u26', 0.0, [0.2, 0.4], nil, 0.0);
)



(
e.setPat('u09', 0.0, [0.2, 0.5], nil, 0.0);
e.setPat('u08', 0.0, [0.1, 0.3], nil, 0.0);
e.setWarp('w0', ['wamp', 0.0, 'iamp', 0.0, 'ramp', 0.2]);
e.setWarp('w1', ['wamp', 0.0, 'iamp', 0.0, 'ramp', 0.4]);
e.setWarp('w2', ['wamp', 0.0, 'iamp', 0.0, 'ramp', 0.2]);
)


(
e.setWarp('w0', ['wamp', 0.4, 'iamp', 0.4, 'ramp', 0.0]);
e.setWarp('w1', ['wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0]);
e.setWarp('w2', ['wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0]);
e.setPat('u26', 1.0, [0.2, 0.4], nil, 0.0);
e.setPat('u31', 0.0, [0.2, 0.35], nil, 0.0);

)



e.freeWarp('w0');
e.freeWarp('w1');
e.freeWarp('w2');

Pdef('mx00').clear





// --------- givusina  ----------//

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
	\buf, Pseq([~buf3, ~buf2, ~buf3], inf),
	\iamp, Pseq(~matrix.patterndefs['u11'].patterns.values[2] * 0.4, inf)
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
e.setPat('u11', 1.0, [0.1, 0.9], nil, 0.1);

)

e.freeWarp('w2');
Pdef('mx01').clear;


e.setPat('u10', 0.0, [0.1, 1.0], nil, 0.1);
e.setPat('u11', 0.0, [0.1, 0.9], nil, 0.1);




// --------- tuurrõukut  ----------//


(
e.freeWarp('w0');
e.freeWarp('w1');
e.freeWarp('w2');

Pdef('mx00').clear;

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
	\freq, Prand(Scale.minor.ratios.scramble.keep(3), inf),
	// \ramp, Pseq( [0.05, 0.4, 0.05, 0.4, 0.2, 0.3, 0.05, 0.3] ++ (0 ! 8) * 2, inf),
	\rate, Pseq(~ratepat, inf )
];
e.playWarp('w1', 'wrprevm', ~buf1, ~pw1, 4, 0.6, ~rate1 );
Pdef('mx01', Ppar([
	Pdef('u08'),
	Pdef('u09'),
	Pdef('b10'),
	Pdef('b11'),
	Pdef('b12')
])).play;
e.setPat('u08', 0.0, [0.15, 0.3], nil, 0.1);
e.setPat('b10', 0.0, [0.5, 2.0], [0.08, 0.3], 0.1);
e.setPat('b11', 0.0, [0.5, 2.0], [0.05, 0.3], 0.1);

)


e.setPat('u08', 0.0, [0.1, 0.3], nil, 0.1);
e.setPat('u09', 0.0, [0.2, 0.4], nil, 0.1);



e.setPat('b10', 0.0, [0.5, 1.0], [0.08, 0.3], 0.1);
e.setPat('b11', 0.0, [0.5, 1.0], [0.05, 0.3], 0.1);
e.setPat('b12', 0.0, [0.5, 1.0], [0.05, 0.2], 0.1);








// --------- rasvekesi ii  ----------//

(
~zone4.();
// e.freeWarp('w0');
// Pdef('mx10').clear;

e.freeWarp('w0');
e.freeWarp('w1');
e.freeWarp('w2');

Pdef('mx00').clear;
Pdef('mx01').clear;


~ind1=56;
~buf1 = ~kvbufs[~ind1];
~loop1 = ~kvbufs.loopsAtBuf(~buf1);
~bpm1 = ~loop1.bpm;
~matrix.setBPM(~bpm1);
~pw0 = [
	[
		\rx, Prand(Array.series(17, 0, 2pi/17)-pi, inf),
		\ry, Prand(Array.series(17, 0, 2pi/17)-pi, inf),
		\rz, Prand(Array.series(17, 0, 2pi/17)-pi, inf),
		// \ramp, Pseq(((0 ! 24) ++ [1.0, 0.2, 0.3, 1.0, 0.2, 0.8, 0.1, 0.7]), inf),
		\ramp, Pseq(((0 ! 8) ++ [1.0, 0.2, 0.3, 1.0, 0.2, 0.8, 0.1, 0.7]*0.7), inf),
		\rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf ),
		\delta, ~matrix.beatdur / 2
	]
];
e.playParWarp('w0', 'wrprevm', ~mesabufs[~ind1], ~pw0, 0.0, ~rt0, false );
~pw1 = [
	[
		\rx, Prand(Array.series(17, 0, 2pi/17)-pi, inf),
		\ry, Prand(Array.series(17, 0, 2pi/17)-pi, inf),
		\rz, Prand(Array.series(17, 0, 2pi/17)-pi, inf),
		\delta, ~matrix.beatdur
	],
	[
		\freq, Pseq(Scale.minor.ratios.keep(3).scramble.add(1.0), inf ),
		\delta, ~matrix.beatdur * 8
	],
	[
		\buf, Pseq([120, 4, 84].collect({|ind| ~mesabufs[ind] }), inf),
		\delta, ~matrix.beatdur * 32
	]
];
e.playParWarp('w1', 'wrprevm', ~mesabufs[~ind1], ~pw1, 0.0, 1, false );

Pdef('mx07',
	Ppar(['d01', 'd02', 'd03', 'd04', 'w0', 'w1'].collect({|name|
		Pdef(name)
	}))
).play;


e.setWarp('w0', ['amp', 1.0, 'iamp', 0.0, 'wamp', 0.0]);
e.setWarp('w1', ['amp', 1.0, 'iamp', 0.0, 'wamp', 0.0]);
)



e.setPwarp('w0', ~pw0, ~matrix.beatdur / 2)


e.setWarp('w0', ['amp', 1.0, 'wamp', 0.5, 'iamp', 0.3, 'ramp', 0]);

e.setWarp('w1', ['amp', 1.0, 'wamp', 0.4, 'iamp', 0.5, 'ramp', 0])

e.freeWarp('w0');
e.freeWarp('w1');

Pdef('mx07').clear


(
e.setPat('d04', 0.0, [0.1, 0.4], nil, 0.1);
e.setPat('d01', 0.0, [0.1, 0.4], nil, 0.1);
e.setPat('d02', 0.0, [0.1, 0.3], nil, 0.1);
e.setPat('b10', 0.0, [0.3, 0.7], [0.07, 0.15], 0.1);
e.setPat('b11', 0.0, [0.3, 0.7], [0.07, 0.15], 0.1);
)


(
e.setPat('d04', 0.0, [0.04, 0.1]);
e.setPat('d03', 0.0, [0.2, 0.3]);
e.setPat('d01', 0.0, [0.2, 0.3]);
e.setPat('d02', 0.0, [0.2, 0.3]);
)




// --------- surmasurd  ----------//

(
~zone5.();
e.freeWarp('w0');
e.freeWarp('w1');
Pdef('mx07').clear;

~ind1=56;
~buf1 = ~mesabufs[~ind1];
~loop1 = ~mesabufs.loopsAtBuf(~buf1);
~bpm1 = ~loop1.bpm;
~matrix.setBPM(~bpm1);
~pw0 = [
	[
		\rx, Prand(Array.series(17, 0, 2pi/17), inf),
		\ry, Prand(Array.series(17, 0, 2pi/17), inf),
		\rz, Prand(Array.series(17, 0, 2pi/17), inf),
		\freq, Pseq(Scale.minor.ratios.scramble, inf ),
		\delta, ~matrix.beatdur * 8
	]
];
e.playParWarp('w0', 'wrprevm', ~mesabufs[~ind1], ~pw0, 0.7, ~rt0, false );
e.setWarp('w0', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.7, 'iamp', 0.0, 'ramp', 0.0, 'rate', 1]);
Pdef('mx08',
	Ppar(
		['b07', 'b08', 'b06', 'w0'].collect({|name|
			Pdef(name)
		})
	)
).play;

)


e.setWarp('w0', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.8, 'iamp', 0.0, 'ramp', 0.0, 'rate', 1]);

e.setWarp('w1', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.8, 'iamp', 0.0, 'ramp', 0.0, 'rate', 1]);

e.setPat('b07', 0.0, [0.1, 0.4], [0.05, 0.3], 0.0);
e.setPat('b08', 1.0, [0.1, 0.5], [0.04, 0.3], 0.0);


e.freeWarp('w0');



(
Pdef('mx08',
	Ppar(
		['r05', 'r06', 'r07', 'r08', 'b02', 'b03', 'b05', 'b07'].collect({|name|
			Pdef(name)
		})
	)
).play;

)


Pdef('mx08').clear


(
e.setPat('r05', 0.0, [0.3, 0.6], [0.05, 0.1], 0.1);
e.setPat('r06', 0.0, [0.3, 0.6], [0.04, 0.2], 0.0);
e.setPat('r07', 0.0, [0.4, 0.7], [0.05, 0.1], 0.0);
e.setPat('r08', 0.0, [0.4, 0.7], [0.01, 0.1], 0.0);

e.setPat('b02', 0.0, [0.3, 0.6], [0.05, 0.1], 0.1);
e.setPat('b03', 0.0, [0.3, 0.6], [0.04, 0.2], 0.0);
e.setPat('b05', 0.0, [0.4, 0.7], [0.05, 0.1], 0.0);
e.setPat('b07', 0.0, [0.4, 0.7], [0.01, 0.1], 0.0);
)












// --------- kamaak  ----------//

(
~zone6.();
e.freeWarp('w0');
Pdef('mx08').clear;
e.freeWarp('w1');
e.freeWarp('w2');

// Pdef('mx08').clear;

~ind = 146; // 4
~buf = ~kvbufs[~ind];
~loop = ~kvbufs.loopsAtBuf(~buf);

~bpm = 60 * 16 / (~loop.dur / 1.5);
~matrix.setBPM(~bpm);

~rhystreams = [8, 6, 2].collect({|div|
	Pseq(24.collect({|i| if (i%div == 0) {1} {0} }), inf).asStream
}) ++ ~matrix.patterndefs['u35'].patterns.values.collect({|pat|
	Pseq(pat, inf).asStream
}) ++ ~matrix.patterndefs['u37'].patterns.values.collect({|pat|
	Pseq(pat, inf).asStream
});

~rhydev = 0.3;
~rhyamps = (0.0 ! ~rhystreams.size);
~rhybufs = ([19, 22, 24] ++ (0..~rhystreams.size)).collect({|i|
	~matrix.buffers['evo'][i]
});


~rhydurs = [0.4, 0.3, 0.1] ++ ~matrix.patterndefs['u35'].patterns.values.collect({|pat|
	(1 / pat.occurrencesOf(1)).linexp(0.1, 0.5, 0.05, 0.3)
}) ++ ~matrix.patterndefs['u37'].patterns.values.collect({|pat|
	(1 / pat.occurrencesOf(1)).linexp(0.1, 0.5, 0.05, 0.3)
});

~ind = 47;
~buf = ~kvbufs[~ind];
~gamp = 0.4;
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


~rhyamps[0] = 1;
~rhyamps[1] = 1
~rhyamps[2] = 1


~rhyamps = Array.fill(~rhystreams.size, {
	[1.0, 0.0].wchoose([1.0, 0.0])
})


(
Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp',  0.4,
	'emp', 0.0, 'buf', ~matrix.buffers['evo'][57], 'dur', 0.5,
	'env', Env.perc, 'rotx', 2.0.rand, 'roty', 2.0.rand, 'rotz', 2.0.rand] );
)

~matrix.activateSkismSynth('magFreeze')

~matrix.setSkismAmp('magFreeze', 0.3)

~matrix.deactivateSkismSynth('magFreeze')



(
a = [
	\rx, Pbrown(-pi, pi, 0.125pi, inf),
	\ry, Pbrown(-pi, pi, 0.125pi, inf),
	\rz, Pbrown(-pi, pi, 0.125pi, inf),
	\buf, Pseq([10, 10, 10, 11, 11, 10, 10, 145, 145, 46, 46, 46 ].collect({|ind|
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
e.setPwarp('w0', a, 1 / 4);
~rhyamps = Array.fill(~rhystreams.size, {
	[1.0, 0.0].wchoose([1.0, 0.0])
})

)


e.setWarp('w0', ['wamp', 0.4, 'ramp', 0.1])


(
a = [
	\rx, Pbrown(-pi, pi, 0.125pi, inf),
	\ry, Pbrown(-pi, pi, 0.125pi, inf),
	\rz, Pbrown(-pi, pi, 0.125pi, inf),
	\buf, Pseq([52, 197, 199, 60, 202, 212 ].stutter(3).collect({|ind|
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
e.setPwarp('w0', a, 1 / 4);
~rhyamps = Array.fill(~rhystreams.size, {
	[1.0, 0.0].wchoose([1.0, 0.0])
})

)




e.freeWarp('w0')


~matrix.activateSkismSynth('primeTam')

~matrix.setSkismAmp('primeTam', 0.5 )

~matrix.deactivateSkismSynth('primeTam')



~matrix.activateSkismSynth('roosaBufWrp')

~matrix.setSkismAmp('roosaBufWrp', 0.9 )

~matrix.deactivateSkismSynth('roosaBufWrp')












(
~streams = ~matrix.patterndefs['u11'].patterns.keys(Array).sort.collect({|key|
	~matrix.patterndefs['u11'].patterns[key].postln;
	Pseq(~matrix.patterndefs['u11'].patterns[key], inf).asStream
});

~grps = [
	[52, 197, 199, 60, 202, 212],
	[52, 12, 13, 20, 21, 25]
];

~bufnums = ~grps.collect(_.mirror2).do({|arr| arr.swap(7, 10); arr.swap(8, 9) }).flat;
~rhybufs = [19, 22, 7, 24, 57, 53];
~rhydurs = [0.13, 0.13, 0.13, 0.05, 0.13, 0.3];
~rhyamps = (0.4 ! 6);
~rhydev = 0.3;

~p1 = [
	\rx, Pbrown(-pi, pi, 0.125pi, inf),
	\ry, Pbrown(-pi, pi, 0.125pi, inf),
	\rz, Pbrown(-pi, pi, 0.125pi, inf),
	\buf, Pseq(~bufnums.collect({|ind|
		~kvbufs[ind] }).mirror2.stutter(16), inf),
	\fnc, Pfunc({|ev|
		~streams.do({|stream, i|
			var on = stream.next;
			if (on == 1) {
				Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', ~rhyamps[i] + (~rhyamps[i] * ~rhydev).rand2,
					'emp', 0.0, 'buf', ~matrix.buffers['evo'][~rhybufs[i]], 'dur', ~rhydurs[i] + (~rhydurs[i] * ~rhydev).rand2,
					'env', Env.perc, 'rotx', 2.0.rand, 'roty', 2.0.rand, 'rotz', 2.0.rand] );
			}
		});
		1
	})
];

e.playWarp('w1', 'revwrpm', ~kvbufs[~bufnums.first], ~p1, 1/4, 1.0, 1.0);


)




e.setWarp('w1', ['amp', 1.0, 'wrp', 0.5, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0]);


~rhyamps = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0];
~rhyamps = (0.0 ! 6);


e.freeWarp('w1');





(
~ind0 = 234; // 4
~buf0 = ~kvbufs[~ind0];
~loop0 = ~kvbufs.loopsAtBuf(~buf0);
~rate0 = 1.3;
~loop0.postln;

~bpm0 = 60 * 16 / (~loop0.dur / ~rate0);
~matrix.setBPM(~bpm0);
Post << "bpm: " << ~bpm0 << Char.nl;

~pw0 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\iamp, Pseq([1, 1, 0], inf),
	\wamp, Pseq([0.5, 0.5, 0.5, 0.0, 0.5, 0.0], inf),
	\freq, Prand(Scale.minor.ratios.scramble.keep(3), inf)
	// // \wamp, Pseq( [0.05, 0.4, 0.05, 0.4, 0.2, 0.3, 0.05, 0.3]*2, inf),
	// \rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w0', 'revwrpm', ~buf0, ~pw0, 1, 0, 1);
Pdef('mx01', Ppar([
	Pdef('u00'),
	Pdef('u02')
])).play;
e.setPat('u00', 0.8, [0.2, 0.4], [0.07, 0.1], 0.1);
e.setPat('u02', 0.2, [0.2, 0.4], [0.07, 0.1], 0.1);
)




e.freeWarp('w0');
Pdef('mx01').clear

Pdef('r01').stop

e.setPat('r00', 0.0, [0.2, 0.4], [0.07, 0.1], 0.1);
e.setPat('r02', 0.0, [0.2, 0.4], [0.07, 0.1], 0.1);


e.setPwarp('w0', ~pw0, ~matrix.beatdur / 2)

e.setWarp('w0', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.9, 'iamp', 0.0, 'ramp', 0.07, 'rate', 1.0, 'freq', 1.0])


Pdef('mx01').clear
