(

~bpm = 143;
~matrix.setBPM(~bpm);

~ind = 146; // 4
~buf = ~kvbufs[~ind];
~lbpm = ~kvbufs.loops[~buf.path.basename.asSymbol].bpm;


b = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pbrown(0, 2pi, 0.125pi, inf),
	\rz, Pbrown(0, 2pi, 0.125pi, inf),
	\ramp, Pseq(( (0.05 ! 24) ++ [1.0, 1.0, 0.1, 1.0, 0.0, 0.3, 0.1, 0.0] ) * 0.7, inf),
	\fnc, Pfunc({
		Pdef('r17').play;
		1
	})

];
e.playWarp('w0', 'wrprevm', ~buf, b, ~matrix.beatdur, 1.0, 1);
)

(
e.setWarp('w0', ['amp', 1, 'wrp', 0.25, 'wamp', 0.2])
)


e.freeWarp('w0')

(
e.setPat('r11', 0.0, [0.2, 0.4], [0.07, 0.1], 0.1);
e.setPat('r15', 1.0, [0.3, 0.6], [0.07, 0.1], 0.1);
e.setPat('r17', 0.0, [0.3, 0.6], [0.07, 0.1], 0.1);

)





(
~sy.free;
~ind1 = 5;
~buf1 = ~mesabufs[~ind1];
~ind2 = 3;
~buf2 = ~mesabufs[~ind2];

~sy = Synth.tail(~matrix.group, 'pvmrevwrpm', ['out', ~decoder.bus, 'amp', 1.0, 'iamp', 0.3, 'buf1', ~buf1, 'buf2', ~buf2])

)

~sy.set('iamp', 1.0, 'wamp', 1.0, 'ramp', 0.0, 'freq', 1.0)




(
// e.freeWarp('w0');
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
		\wamp, Pseq(SparseMatrix.patterns16['Lolo'].keep(3).flat + 0.1 * 0.7, inf),
		\ramp, Pseq(SparseMatrix.patterns16['Sabar'].keep(3).flat + 0.1 * 0.7, inf),
		\delta, Pn(~matrix.beatdur * 2)
	]
];
e.playParWarp('w1', 'revwrpm', ~buf2, ~pw1, 1.0, 1, false );
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




(
[ 'd08', 'd09', 'd10', 'd12'].do({|name|
	var pat = e.getPat(name);
	pat.ctrls.keysValuesDo({|key, ctrl|
		var on = pat.patterns[key].select(_.odd).size;
		ctrl.dur = 1.0 / on;
	})

});
// e.freeWarp('w1');
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
e.setPat('d08', 0.0, [0.2, 0.4], nil, 0.0);
e.setPat('d09', 0.0, [0.2, 0.4], nil, 0.0);
e.setPat('d10', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('d12', 0.0, [0.2, 0.4], nil, 0.0);
Pdef('mx10',
	Ppar(
		['d08', 'd09', 'd10', 'd12', 'w0'].collect({|name|
			Pdef(name)
		})
	)
).play;
e.setWarp('w0', ['wamp', 0.3, 'ramp', 0.33]);

)

e.setWarp('w0', ['iamp', 1.0, 'iamp', 1.0, 'wamp', 0.7, 'ramp', 0.0]);


e.freeWarp('w0');
Pdef('mx10').stop;



e.setPat('d08', 0.0, [0.2, 0.5], nil, 0.0);
e.setPat('d09', 0.0, [0.1, 0.3], nil, 0.0);
e.setPat('d10', 0.0, [0.3, 0.3], nil, 0.0);
e.setPat('d12', 0.0, [0.1, 0.5], nil, 0.0);






(
e.freeWarp('w0');
Pdef('mx10').stop;
// Pdef('mx3').stop;
// e.freeWarp('w0');

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
		\ramp, Pseq(((0 ! 8) ++ [1.0, 0.2, 0.3, 1.0, 0.2, 0.8, 0.1, 0.7]), inf),
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
e.setPat('r00', 0.0, [0.2, 0.3], [0.07, 0.15], 0.1);
e.setPat('r05', 0.0, [0.2, 0.3], [0.01, 0.15], 0.1);
e.setPat('r02', 0.0, [0.3, 0.3], [0.07, 0.15], 0.1);
e.setPat('b10', 0.0, [0.3, 0.7], [0.07, 0.15], 0.1);
e.setPat('b11', 0.0, [0.3, 0.7], [0.07, 0.15], 0.1);
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

e.setWarp('w1', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.1, 'iamp', 0.0, 'ramp', 0.3])

e.freeWarp('w0');
e.freeWarp('w1');
Pdef('mx07').clear


(
e.setPat('r00', 0.1, [0.2, 0.3], [0.07, 0.15], 0.1);
e.setPat('r05', 0.2, [0.2, 0.3], [0.01, 0.15], 0.1);
e.setPat('r02', 0.2, [0.3, 0.3], [0.07, 0.15], 0.1);
e.setPat('b10', 0.2, [0.3, 0.7], [0.07, 0.15], 0.1);
e.setPat('b11', 0.2, [0.3, 0.7], [0.07, 0.15], 0.1);
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
e.setPat('b06', 0.1, [0.1, 0.4], [2.0, 4.0], 0.0);
e.setPat('b07', 0.3, [0.2, 0.3], [0.05, 0.2], 0.0);
e.setPat('b08', 0.2, [0.2, 0.3], [0.05, 0.15], 0.0);
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

e.setWarp('w0', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0, 'rate', 1]);

e.setPat('b06', 0.2, [0.1, 0.4], [2.0, 4.0], 0.0);
e.setPat('b07', 0.3, [0.2, 0.3], [0.05, 0.2], 0.1);
e.setPat('b08', 0.2, [0.2, 0.3], [0.05, 0.15], 0.1);

