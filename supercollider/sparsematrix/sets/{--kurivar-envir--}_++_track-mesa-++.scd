~bpm = 173;
~matrix.setBPM(~bpm)

(

~ind5=111;
~bufstream = Pseq(
	[3, 3, 3, 6, 3, 3, 3, 12, 3, 3, 6, 6, 3, 3, 12, 3].collect({|num|
		~matrix.buffers['evo'][num]
	}),
	inf
).asStream;
~pw5 = [
	[
		\rx, Prand(Array.series(17, 0, 2pi/17), inf),
		\ry, Prand(Array.series(17, 0, 2pi/17), inf),
		\rz, Prand(Array.series(17, 0, 2pi/17), inf),
		\delta, ~matrix.beatdur/2
	// \wamp, Pseq(((0.1 ! 24) ++ [0.1, 0.4, 0.1, 0.4, 0.2, 0.3, 0.1, 0.3])*4, inf),
	// \rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
	],
	[
		\func, Pfunc({
			Synth.tail(~matrix.group, \bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(1.0, 1.5),
				'emp', 0.0, 'buf', ~bufstream.next,
				'dur', exprand(0.5, 0.7), 'rotx', 2pi.rand, 'roty', 2pi.rand, 'rotz', 2pi.rand,
				'env', Env.perc
			] );
		}),
		\delta, ~matrix.beatdur*2
	],
	[
		\freq, Pseq([1, 1, 1, Scale.minor.ratios[1] ], inf),
		\delta, ~matrix.beatdur*8
	]
];
e.playParWarp('w5', 'wrprevm', ~mesabufs[~ind5], ~pw5 );
e.setWarp('w5', ['wamp', 0.4, 'ramp', 0.4]);
)

e.setPwarp('w5', ~pw0, ~matrix.beatdur / 2)

e.setWarp('w5', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.0, 'iamp', 0.5, 'ramp', 0.5, 'rate', 1, 'freq', 1])

e.freeWarp('w5')



(
~ind0 = 118;
~buf0 = ~mesabufs[~ind0];
~loop0 = ~mesabufs.loopsAtBuf(~buf0);
~bpm0 = ~loop0.bpm;
~lrate0 = ~bpm / ~bpm0;

~pw0 = [
	[
		\rx, Pbrown(-pi, pi, pi/45, inf),
		\ry, Pbrown(-pi, pi, pi/45, inf),
		\rz, Pbrown(-pi, pi, pi/45, inf),
		\delta, Pn(~matrix.beatdur / 4)
	],
	[
		\iamp, Pseq(SparseMatrix.patterns16['Sabar'].keep(3).flat + 0.4 * 0.3, inf),
		\delta, Pn(~matrix.beatdur * 2)
	]
];
e.playParWarp('w0', 'revwrpm', ~buf0, ~pw0, 0.0 );
e.setWarp('w0', ['wamp', 1.0, 'ramp', 0.7]);

)

e.setWarp('w0', ['iamp', 1.0, 'wamp', 0.0, 'ramp', 0.0]);

e.freeWarp('w0');

(
e.freeWarp('w0');
// e.freeWarp('w5');
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
e.playParWarp('w1', 'revwrpm', ~buf2, ~pw1, 1 );

)

e.setPwarp('w1', ~pw0, ~matrix.beatdur / 2)

e.setWarp('w1', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0, 'rate', 1, 'freq', 1])


e.freeWarp('w1');



(
e.freeWarp('w1');
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

//mechakucha in the ganglia




(
~ind2=111;
~pw2 = [
	[
		\rx, Prand(Array.series(17, 0, 2pi/17), inf),
		\ry, Prand(Array.series(17, 0, 2pi/17), inf),
		\rz, Prand(Array.series(17, 0, 2pi/17), inf),
		\iamp, Pseq(([1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0].dup.flat ++ (0 ! 16)) * 0.3, inf),
		\wamp, Pseq([1, 0]*0.2, inf),
		\freq, Pseq(Scale.minor.ratios.scramble.keep(3), inf),
		\delta, ~matrix.beatdur/4
	],
	[
		\rate, Pseq(Scale.minor.ratios.keep(2), inf),
		\wrp, Pseq([0.25, 0.125], inf),
		\delta, ~matrix.beatdur*4
	]
];
e.playParWarp('w2', 'revwrpm', ~mesabufs[~ind2], ~pw2, 0.0, 1, false );
e.setPat('r04', 0.3, [0.3, 0.5], [0.01, 0.1], 0.0);
e.setPat('r05', 0.3, [0.3, 0.5], [0.05, 0.1], 0.0);
Pdef('mx11',
	Ppar(
		['r04', 'r05', 'w2'].collect({|name|
			Pdef(name)
		})
	)
).play
)


e.setPwarp('w2', ~pw1, ~matrix.beatdur)

e.setWarp('w2', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0, 'rate', 0.5, 'freq', 1])

e.freeWarp('w2');
Pdef('mx11').stop;


