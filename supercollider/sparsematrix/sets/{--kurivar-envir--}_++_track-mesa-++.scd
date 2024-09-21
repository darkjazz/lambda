(
~bpm = 143;
~matrix.setBPM(~bpm);

// e.freeWarp('w1');
// Pdef('mx10').clear;

~ind = 146; // 4
~buf = ~kvbufs[~ind];
~lbpm = ~kvbufs.loops[~buf.path.basename.asSymbol].bpm;

b = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pbrown(0, 2pi, 0.125pi, inf),
	\rz, Pbrown(0, 2pi, 0.125pi, inf),
	\ramp, Pseq(( (0.05 ! 24) ++ [1.0, 1.0, 0.1, 1.0, 0.0, 0.3, 0.1, 0.0] ) * 0.5, inf),
	\fnc, Pfunc({
		Pdef('r17').play;
		// Pdef('mx1',
		// 	Ppar(['r11', 'r15', 'r17'].collect({|nm| Pdef(nm) }))
		// ).play;
		1
	})
];
e.playWarp('w1', 'wrprevm', ~buf, b, ~matrix.beatdur*4, 1.0, (~lbpm*1.5) / ~bpm);
)


(
e.setWarp('w1', ['amp', 1, 'wrp', 0.25, 'wamp', 0.4])
)


e.setPwarp('w1', b, ~matrix.beatdur*4 )

e.freeWarp('w1')

Pdef('b04').play

e.setPat('b04', 0.3, [0.2, 0.4], [2.0, 4.0], 0.0);

Pdef('b04').stop


Pdef('mx1',
	Ppar(['r11', 'r15', 'r17'].collect({|nm| Pdef(nm) }))
).play

Pdef('mx1').play

e.setPat('r17', 1.0, [0.3, 0.3], nil, 0.1);

Pdef('r17').play

(
e.setPat('r09', 1.0, [0.2, 0.4], [0.07, 0.1], 0.1);
e.setPat('r10', 1.0, [0.2, 0.4], [0.07, 0.1], 0.1);
e.setPat('r11', 1.0, [0.2, 0.4], [0.07, 0.1], 0.1);
e.setPat('r15', 1.0, [0.2, 0.4], [0.07, 0.1], 0.1);
e.setPat('r16', 1.0, [0.2, 0.4], [0.07, 0.1], 0.1);
e.setPat('r17', 1.0, [0.2, 0.4], [0.07, 0.1], 0.1);

)







(
e.freeWarp('w1');
// e.freeWarp('w2');
// e.freeWarp('w2');
~ind1 = 1;
~buf1 = ~mesabufs[~ind1];
~loop1 = ~mesabufs.loopsAtBuf(~buf1);
~bpm1 = ~loop1.bpm;
~lrate1 = ~bpm / ~bpm1;
~ind2 = 72;
~buf2 = ~mesabufs[~ind2];
~loop2 = ~mesabufs.loopsAtBuf(~buf2);
~bpm2 = ~loop2.bpm;
~lrate2 = (~bpm*2) / ~bpm2;
~pw1 = [
	[
		\rx, Prand(Array.series(17, 0, 2pi/17), inf),
		\ry, Prand(Array.series(17, 0, 2pi/17), inf),
		\rz, Prand(Array.series(17, 0, 2pi/17), inf),
		\delta, Pn(~matrix.beatdur / 2)
	],
	[
		\buf, Pseq([~buf1, ~buf2, ~buf1, ~buf1, ~buf2], inf),
		\rate, Pfunc({|ev| if (ev.buf == ~buf1) {~lrate1} {~lrate2} }),
		\freq, Pseq(Scale.minor.ratios.keep(3).scramble.stutter(3).dup(3).flat, inf),
		\delta, Pn(~matrix.beatdur * 16)
	],
	[
		\wamp, Pseq(SparseMatrix.patterns16['Lolo'].keep(3).flat + 0.1 * 0.3, inf),
		\ramp, Pseq(SparseMatrix.patterns16['Sabar'].keep(3).flat + 0.1 * 0.3, inf),
		\delta, Pn(~matrix.beatdur * 2)
	]
];
e.playParWarp('w1', 'revwrpm', ~buf2, ~pw1, 0.5, 1, false );
Pdef('mx10',
	Ppar(
		['b00', 'b03', 'w1'].collect({|name|
			Pdef(name)
		})
	)
).play;

)

e.setPat('b00', 0.0, [0.5, 1.0], [0.1, 0.4], 0.0);
e.setPat('b03', 0.0, [0.4, 1.0], [0.1, 0.2], 0.0);


e.setPwarp('w1', ~pw0, ~matrix.beatdur / 2)

e.setWarp('w1', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0, 'rate', 1, 'freq', 1])


e.freeWarp('w1');
Pdef('mx10').clear;


(
//hmm not sure
e.freeWarp('w1');
Pdef('mx10').clear;
~ind3 = 99;
~buf3 = ~mesabufs[~ind3];
~loop3 = ~mesabufs.loopsAtBuf(~buf3);
~bpm3 = ~loop3.bpm;
~lrate3 = ~bpm / ~bpm3;
~ind4 = 112;
~buf4 = ~mesabufs[~ind4];
~loop4 = ~mesabufs.loopsAtBuf(~buf4);
~bpm4 = ~loop4.bpm;
~lrate4 = ~bpm / ~bpm4;
~pw2 = [
	[
		\rx, Prand(Array.series(17, 0, 2pi/17), inf),
		\ry, Prand(Array.series(17, 0, 2pi/17), inf),
		\rz, Prand(Array.series(17, 0, 2pi/17), inf),
		\delta, Pn(~matrix.beatdur / 2)
	],
	[
		\buf, Pseq([~buf3, ~buf4, ~buf3, ~buf3, ~buf4, ~buf2], inf),
		\rate, Pfunc({|ev| if (ev.buf == ~buf3) {~lrate3} {~lrate4} }),
		\freq, Pseq(Scale.minor.ratios.keep(3).scramble.stutter(3).dup(3).flat, inf),
		\delta, Pn(~matrix.beatdur * 16)
	],
	[
		\wamp, Pseq(SparseMatrix.patterns16['Lolo'].keep(5).flat + 0.1 * 0.5, inf),
		\ramp, Pseq(SparseMatrix.patterns16['Sabar'].keep(5).flat + 0.1 * 0.5, inf),
		\delta, Pn(~matrix.beatdur)
	]
];
e.playParWarp('w2', 'wrprevm', ~buf3, ~pw2, 1, ~lrate3 );

)

e.freeWarp('w2');

Pdef('mx1').stop

//mechakucha in the ganglia





(
e.freeWarp('w2');
~bpm = 153;
~matrix.setBPM(~bpm);
~ind2=51;
~pw2 = [
	[
		\rx, Prand(Array.series(17, 0, 2pi/17), inf),
		\ry, Prand(Array.series(17, 0, 2pi/17), inf),
		\rz, Prand(Array.series(17, 0, 2pi/17), inf),
		\iamp, Pseq(([1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0].dup.flat ++ (0 ! 16)), inf),
		\ramp, Pseq([1, 0]*0.5, inf),
		\freq, Pseq(Scale.minor.ratios.scramble.keep(3), inf),
		\delta, ~matrix.beatdur/4
	],
	[
		\rate, Pseq(Scale.minor.ratios.keep(2), inf),
		\wrp, Pseq([0.25, 0.125], inf),
		\delta, ~matrix.beatdur*4
	],
	[
		\buf, Pseq([51, 51, 51, 136, 136, 51].collect({|ind| ~mesabufs[ind] }), inf),
		\delta, ~matrix.beatdur*8
	]
];
e.playParWarp('w2', 'revwrpm', ~mesabufs[~ind2], ~pw2, 0.0, 1, false );
e.setPat('r00', 0.2, [0.3, 0.5], [0.01, 0.2], 0.0);
e.setPat('r04', 0.1, [0.3, 0.5], [0.01, 0.1], 0.0);
e.setPat('r05', 0.2, [0.3, 0.5], [0.05, 0.1], 0.0);
Pdef('mx11',
	Ppar(
		['r00', 'r04', 'r05', 'w2'].collect({|name|
			Pdef(name)
		})
	)
).play
)



e.setPat('r00', 0.3, [0.3, 0.5], [0.01, 0.2], 0.0);
e.setPat('r04', 0.3, [0.3, 0.5], [0.01, 0.1], 0.0);
e.setPat('r05', 0.0, [0.3, 0.5], [0.05, 0.1], 0.0);


e.setPwarp('w2', ~pw1, ~matrix.beatdur)

e.setWarp('w2', ['buf',  ~mesabufs[51]])

e.setWarp('w2', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.5, 'iamp', 0.0, 'ramp', 0.6, 'rate', 1, 'freq', 1])


e.freeWarp('w2');
Pdef('mx11').clear;


//makaak

(
e.freeWarp('w2');
Pdef('mx11').clear;
~bpm = 131;
~matrix.setBPM(~bpm);

~ind = 47;
~buf = ~kvbufs[~ind];
~lbpm = ~kvbufs.loops[~buf.path.basename.asSymbol].bpm;
~rate = ~bpm/~lbpm;
~counter = 0;
~ampk = 0;
~amps = 0;
~amph = 0;
a = [
	\rx, Pbrown(-pi, pi, 0.125pi, inf),
	\ry, Pbrown(-pi, pi, 0.125pi, inf),
	\rz, Pbrown(-pi, pi, 0.125pi, inf),
	\buf, Pseq([47, 47, 47, 73, 73, 47, 47, 23, 23, 35, 35, 35 ].collect({|ind|
		~kvbufs[ind] }).mirror2, inf),
	\fnc, Pfunc({|ev|
		if (~counter % 8 == 0) {
			Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', ~ampk,
				'emp', 0.0, 'buf', ~matrix.buffers['evo'][19], 'dur', 0.5,
				'env', Env.perc, 'rotx', 2.0.rand, 'roty', 2.0.rand, 'rotz', 2.0.rand] );
		};
		if (~counter % 6 == 0) {
			Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', ~amps,
				'emp', 0.0, 'buf', ~matrix.buffers['evo'][22], 'dur', 0.5,
				'env', Env.perc, 'rotx', 2.0.rand, 'roty', 2.0.rand, 'rotz', 2.0.rand] );
		};
		if (~counter % 2 == 0) {
			Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', ~amph,
				'emp', 0.0, 'buf', ~matrix.buffers['evo'][24], 'dur', 0.1,
				'env', Env.perc, 'rotx', 2.0.rand, 'roty', 2.0.rand, 'rotz', 2.0.rand] );
		};
		~counter = ~counter + 1;
	})
];
e.playWarp('w0', 'revwrpm', ~buf, a, ~matrix.beatdur / 2, 1, ~rate);

)

Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', 0.5, 'emp', 0.0, 'buf', ~matrix.buffers['evo'][48], 'dur', 2.0, 'env', Env.sine] );

~amps = 1;
~ampk = 1;
~amph = 1


~matrix.activateSkismSynth('magFreeze')

~matrix.setSkismAmp('magFreeze', 0.4)

~matrix.deactivateSkismSynth('magFreeze')



(
a = [
	\rx, Pbrown(-pi, pi, 0.125pi, inf),
	\ry, Pbrown(-pi, pi, 0.125pi, inf),
	\rz, Pbrown(-pi, pi, 0.125pi, inf),
	\buf, Pseq([10, 10, 10, 11, 11, 10, 10, 145, 145, 46, 46, 46 ].collect({|ind|
		~kvbufs[ind] }).mirror2, inf),
	\fnc, Pfunc({|ev|
		if (~counter % 8 == 0) {
			Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', ~ampk,
				'emp', 0.0, 'buf', ~matrix.buffers['evo'][19], 'dur', 0.5,
				'env', Env.perc, 'rotx', 2.0.rand, 'roty', 2.0.rand, 'rotz', 2.0.rand] );
		};
		if (~counter % 6 == 0) {
			Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', ~amps,
				'emp', 0.0, 'buf', ~matrix.buffers['evo'][22], 'dur', 0.5,
				'env', Env.perc, 'rotx', 2.0.rand, 'roty', 2.0.rand, 'rotz', 2.0.rand] );
		};
		if (~counter % 2 == 0) {
			Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', ~amph,
				'emp', 0.0, 'buf', ~matrix.buffers['evo'][24], 'dur', 0.1,
				'env', Env.perc, 'rotx', 2.0.rand, 'roty', 2.0.rand, 'rotz', 2.0.rand] );
		};
		~counter = ~counter + 1;
	})
];
e.setPwarp('w0', a, ~matrix.beatdur / 2)
)



~matrix.activateSkismSynth('primeTam')

~matrix.setSkismAmp('primeTam', 0.1 )

~matrix.deactivateSkismSynth('primeTam')

~matrix.activateSkismSynth('roosaBufWrp')

~matrix.setSkismAmp('roosaBufWrp', 0.3)

~matrix.deactivateSkismSynth('roosaBufWrp')



e.freeWarp('w0')





(
[ 'd08', 'd09', 'd10', 'd12'].do({|name|
	var pat = e.getPat(name);
	pat.ctrls.keysValuesDo({|key, ctrl|
		var on = pat.patterns[key].select(_.odd).size;
		ctrl.dur = 1.0 / on;
	})

});
e.freeWarp('w1');
Pdef('mx11').clear;
~ind0 = 118;
~buf0 = ~mesabufs[~ind0];
~loop0 = ~mesabufs.loopsAtBuf(~buf0);
~bpm0 = ~loop0.bpm;
~matrix.setBPM(~bpm0);
~pw0 = [
	[
		\rx, Pbrown(-pi, pi, pi/45, inf),
		\ry, Pbrown(-pi, pi, pi/45, inf),
		\rz, Pbrown(-pi, pi, pi/45, inf),
		\delta, Pn(~matrix.beatdur / 4)
	],
	[
		\iamp, Pseq(SparseMatrix.patterns16['Sabar'].keep(3).flat * 0.5, inf),
		\delta, Pn(~matrix.beatdur * 2)
	]
];
e.playParWarp('w0', 'revwrpm', ~buf0, ~pw0, 0.0, 1, false );
e.setPat('d08', 0.0, [0.7, 0.7], nil, 0.0);
e.setPat('d09', 0.0, [0.5, 0.7], nil, 0.0);
e.setPat('d10', 0.0, [0.3, 0.7], nil, 0.0);
e.setPat('d12', 0.0, [0.1, 0.4], nil, 0.0);
Pdef('mx10',
	Ppar(
		['d08', 'd09', 'd10', 'd12', 'w0'].collect({|name|
			Pdef(name)
		})
	)
).play;
e.setWarp('w0', ['wamp', 0.3, 'ramp', 0.33]);

)

e.setWarp('w0', ['iamp', 1.0, 'wamp', 0.0, 'ramp', 0.6]);


e.freeWarp('w0');
Pdef('mx10').stop;



e.setPat('d08', 0.0, [0.2, 0.4], nil, 0.0);
e.setPat('d09', 0.0, [0.1, 0.3], nil, 0.0);
e.setPat('d10', 0.0, [0.3, 0.3], nil, 0.0);
e.setPat('d12', 0.0, [0.1, 0.5], nil, 0.0);




Pdef('efx').play

~matrix.efxamps['efx3'] = 0.4

~matrix.defsAt('b12').assignEfx(
	(efx3: (0..15))
)


~matrix.efxamps['efx2'] = 0.4

~matrix.defsAt('b11').assignEfx(
	(efx2: (0..15))
)


~matrix.efxamps['efx1'] = 0.1

~matrix.defsAt('b10').assignEfx(
	(efx1: (0..15))
)



Pdef('mx3',
	Ppar(~bdefs.drop(6).keep(8).collect({|nm| Pdef(nm) }))
).play




(
e.setPat('b07', 0.3, [0.1, 0.4], [0.01, 0.1], 0.0);
e.setPat('b08', 0.0, [0.2, 0.6], [0.01, 0.1], 0.0);
e.setPat('b09', 0.2, [0.3, 0.5], [0.01, 0.3], 0.0);
e.setPat('b10', 0.2, [0.7, 1.0], [0.01, 0.2], 0.4);
e.setPat('b11', 0.2, [0.7, 1.0], [0.05, 0.2], 0.1);
e.setPat('b12', 0.0, [0.7, 1.0], [0.1, 0.2], 0.2);
e.setPat('b13', 0.0, [0.3, 0.7], [0.1, 0.2], 0.0);
e.setPat('b14', 0.2, [0.3, 0.6], [0.1, 0.2], 0.0);
)






( 'rate': 0.9945, 'bpm': 76.923076923077, 'index': 4 )
( 'rate': 1.0455, 'bpm': 73.170731707317, 'index': 84 )
( 'rate': 0.9945, 'bpm': 76.923076923077, 'index': 120 )
( 'rate': 0.969, 'bpm': 78.947368421053, 'index': 98 )
( 'rate': 1.0455, 'bpm': 73.170731707317, 'index': 57 )
( 'rate': 0.9945, 'bpm': 76.923076923077, 'index': 33 )
( 'rate': 0.9945, 'bpm': 76.923076923077, 'index': 45 )
( 'rate': 0.969, 'bpm': 78.947368421053, 'index': 76 )
( 'rate': 1.02, 'bpm': 75, 'index': 19 )
( 'rate': 0.9945, 'bpm': 76.923076923077, 'index': 12 )
( 'rate': 1.0455, 'bpm': 73.170731707317, 'index': 6 )
( 'rate': 1.02, 'bpm': 75, 'index': 109 )
( 'rate': 0.969, 'bpm': 78.947368421053, 'index': 81 )
( 'rate': 0.9945, 'bpm': 76.923076923077, 'index': 93 )
( 'rate': 0.969, 'bpm': 78.947368421053, 'index': 158 )
( 'rate': 0.9945, 'bpm': 76.923076923077, 'index': 151 )
( 'rate': 1.02, 'bpm': 75, 'index': 28 )


~matrix.setBPM(76.5)

Pdef('mx1', Ppar([Pdef('r05'), Pdef('r02'), Pdef('r03'), Pdef('r06'), Pdef('r07')])).play


(
// e.freeWarp('w0');
// Pdef('mx10').stop;
// Pdef('mx3').stop;
// e.freeWarp('w0');
e.freeWarp('w0');
Pdef('mx08').stop;

~ind1=57;
~buf1 = ~mesabufs[~ind1];
~loop1 = ~mesabufs.loopsAtBuf(~buf1);
~bpm1 = ~loop1.bpm;
~matrix.setBPM(~bpm1);
~pw0 = [
	[
		\rx, Prand(Array.series(17, 0, 2pi/17)-pi, inf),
		\ry, Prand(Array.series(17, 0, 2pi/17)-pi, inf),
		\rz, Prand(Array.series(17, 0, 2pi/17)-pi, inf),
		// \ramp, Pseq(((0 ! 24) ++ [1.0, 0.2, 0.3, 1.0, 0.2, 0.8, 0.1, 0.7]), inf),
		\ramp, Pseq(((0 ! 8) ++ [1.0, 0.2, 0.3, 1.0, 0.2, 0.8, 0.1, 0.7]*0.4), inf),
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
	Ppar(
		['r00', 'r02', 'r05', 'b10', 'b11', 'w0', 'w1'].collect({|name|
			Pdef(name)
		})
	)
).play;
e.setWarp('w0', ['amp', 0.2, 'wrp', 0.25]);
e.setWarp('w1', ['amp', 0.2, 'wrp', 0.25, 'wamp', 0.1]);
)



e.setPwarp('w0', ~pw0, ~matrix.beatdur / 2)

e.setWarp('w1', ['amp', 1.0, 'wrp', 0.25, 'wamp', 1.0, 'iamp', 0.0, 'ramp', 0.3])

e.freeWarp('w0');
e.freeWarp('w1');
Pdef('mx07').clear


(
e.setPat('r00', 0.4, [0.2, 0.3], [0.07, 0.15], 0.1);
e.setPat('r05', 0.3, [0.2, 0.3], [0.01, 0.15], 0.1);
e.setPat('r02', 0.3, [0.3, 0.3], [0.07, 0.15], 0.1);
e.setPat('b10', 0.2, [0.3, 0.7], [0.07, 0.15], 0.1);
e.setPat('b11', 0.4, [0.3, 0.7], [0.07, 0.15], 0.1);
)


(
e.freeWarp('w0');
e.freeWarp('w1');
Pdef('mx07').clear;

~ind1=57;
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
e.playParWarp('w0', 'wrprevm', ~mesabufs[~ind1], ~pw0, 1.0, ~rt0, false );
e.setWarp('w0', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.3, 'iamp', 0.0, 'ramp', 0.0, 'rate', 1]);
Pdef('mx08',
	Ppar(
		['b07', 'b08', 'b06', 'w0'].collect({|name|
			Pdef(name)
		})
	)
).play;

)

e.freeWarp('w0');
Pdef('mx08').stop
e.setPat('b06', 0.2, [0.1, 0.4], [2.0, 4.0], 0.0);
e.setPat('b07', 0.4, [0.2, 0.3], [0.05, 0.2], 0.1);
e.setPat('b08', 0.4, [0.2, 0.3], [0.05, 0.15], 0.1);



(

e.freeWarp('w0');
Pdef('mx08').stop;
~ind1=72;
~buf1 = ~mesabufs[~ind1];
~loop1 = ~mesabufs.loopsAtBuf(~buf1);
~bpm1 = ~loop1.bpm;
~matrix.setBPM(~bpm1);

~pw1 = [
	[
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\iamp, Pseq(((0 ! 8) ++ [0.3, 1.0, 0.3, 1.0, 0.3, 0.6, 0.3, 1.0]), inf),
	\delta, ~matrix.beatdur
	]
];
e.playParWarp('w0', 'wrprevm', ~mesabufs[~ind1], ~pw1, 0.5, 1, false );

Pdef('mx08',
	Ppar(
		['b10', 'r02', 'r03', 'b11', 'b12'].collect({|name|
			Pdef(name)
		})
	)
).play;
)

e.setWarp('w0', ['iamp', 1.0, 'wamp', 0.5])

e.setPat('r03', 0.3, [0.3, 1.0], [0.05, 0.3], 0.1);
e.setPat('r02', 0.3, [0.3, 1.0], [0.05, 0.3], 0.1);
e.setPat('b10', 0.3, [0.3, 1.0], [0.05, 0.3], 0.1);
e.setPat('b11', 0.3, [0.3, 1.0], [0.05, 0.3], 0.1);

e.freeWarp('w0');
Pdef('mx08').stop



