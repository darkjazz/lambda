(
Server.default.record;
~ind1=57;
~buf1 = ~mesabufs[~ind1];
~loop1 = ~mesabufs.loopsAtBuf(~buf1);
~bpm1 = ~loop1.bpm;
~matrix.setBPM(~bpm1);
~rt0 = 1;
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
e.setPat('b06', 0.0, [0.1, 0.4], [2.0, 4.0], 0.0);
e.setPat('b07', 0.0, [0.2, 0.3], [0.05, 0.2], 0.1);
e.setPat('b08', 0.0, [0.2, 0.3], [0.05, 0.15], 0.1);
Tdef('seq', {
	(~matrix.beatdur * 16).wait;
	e.setPat('b07', 0.3, [0.2, 0.3], [0.05, 0.2], 0.1);
	e.setPat('b08', 0.3, [0.2, 0.3], [0.05, 0.15], 0.1);
	(~matrix.beatdur * 16).wait;
	e.setPat('b07', 0.4, [0.2, 0.3], [0.05, 0.2], 0.1);
	e.setPat('b08', 0.2, [0.2, 0.3], [0.05, 0.15], 0.1);
	(~matrix.beatdur * 16).wait;
	e.setPat('b07', 0.4, [0.2, 0.3], [0.05, 0.2], 0.1);
	e.setPat('b08', 0.2, [0.2, 0.3], [0.05, 0.15], 0.1);
	(~matrix.beatdur * 16).wait;
	e.setPat('b07', 0.1, [0.2, 0.3], [0.05, 0.2], 0.1);
	e.setPat('b08', 0.1, [0.2, 0.3], [0.05, 0.15], 0.1);
	(~matrix.beatdur * 16).wait;
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
	e.setPat('r00', 0.0, [0.2, 0.4], [0.07, 0.15], 0.1);
	e.setPat('r02', 0.0, [0.3, 0.3], [0.07, 0.15], 0.1);
	e.setPat('r05', 0.0, [0.2, 0.3], [0.01, 0.15], 0.1);
	e.setPat('b10', 0.0, [0.3, 0.7], [0.07, 0.15], 0.1);
	e.setPat('b11', 0.0, [0.3, 0.7], [0.07, 0.15], 0.1);
	e.setWarp('w0', ['amp', 0.2, 'wrp', 0.25]);
	e.setWarp('w1', ['amp', 0.2, 'wrp', 0.25, 'wamp', 0.1]);
	(~matrix.beatdur * 32).wait;
	e.setPat('r00', 0.3, [0.2, 0.4], [0.07, 0.15], 0.1);
	e.setPat('r02', 0.2, [0.3, 0.5], [0.07, 0.15], 0.1);
	e.setPat('r05', 0.2, [0.2, 0.5], [0.01, 0.15], 0.1);
	(~matrix.beatdur * 32).wait;
	e.setPat('r05', 0.3, [0.2, 0.3], [0.01, 0.15], 0.1);
	e.setPat('b10', 0.3, [0.3, 0.7], [0.07, 0.15], 0.1);
	e.setPat('b11', 0.3, [0.3, 0.7], [0.07, 0.15], 0.1);
	(~matrix.beatdur * 32).wait;
	e.setWarp('w0', ['amp', 0.2, 'wrp', 0.25]);
	e.setWarp('w1', ['amp', 0.2, 'wrp', 0.25, 'wamp', 0.2]);
	e.setPat('r00', 0.3, [0.2, 0.5], [0.07, 0.15], 0.1);
	e.setPat('r02', 0.2, [0.3, 0.5], [0.07, 0.15], 0.1);
	e.setPat('b10', 0.3, [0.3, 0.7], [0.07, 0.15], 0.1);
	e.setPat('b11', 0.3, [0.3, 0.7], [0.07, 0.15], 0.1);
	(~matrix.beatdur * 32).wait;
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
	e.freeWarp('w0');
	e.playParWarp('w0', 'wrprevm', ~mesabufs[~ind1], ~pw0, 1.0, ~rt0, false );
	e.setWarp('w0', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.3, 'iamp', 0.0, 'ramp', 0.0, 'rate', 1]);
	e.setPat('r00', 0.5, [0.2, 0.5], [0.07, 0.15], 0.1);
	e.setPat('r05', 0.1, [0.2, 0.3], [0.01, 0.15], 0.1);
	e.setPat('r02', 0.1, [0.3, 0.5], [0.07, 0.15], 0.1);
	e.setPat('b10', 0.1, [0.3, 0.7], [0.07, 0.2], 0.1);
	e.setPat('b11', 0.1, [0.3, 0.7], [0.07, 0.2], 0.1);
	(~matrix.beatdur * 64).wait;
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
	(~matrix.beatdur * 64).wait;
	e.setPat('r00', 0.5, [0.2, 0.5], [0.07, 0.15], 0.1);
	e.setPat('r02', 0.2, [0.3, 0.5], [0.07, 0.15], 0.1);
	e.setPat('r05', 0.3, [0.2, 0.3], [0.01, 0.15], 0.1);
	e.setPat('b10', 0.3, [0.3, 0.7], [0.07, 0.2], 0.1);
	e.setPat('b11', 0.3, [0.3, 0.7], [0.07, 0.2], 0.1);
	(~matrix.beatdur * 16).wait;
	e.setPat('r00', 0.5, [0.2, 0.5], [0.07, 0.15], 0.1);
	e.setPat('r02', 0.2, [0.3, 0.5], [0.07, 0.15], 0.1);
	e.setPat('r05', 0.3, [0.2, 0.3], [0.01, 0.15], 0.1);
	e.setPat('b10', 0.3, [0.3, 0.7], [0.07, 0.3], 0.1);
	e.setPat('b11', 0.3, [0.3, 0.7], [0.07, 0.3], 0.1);
	~pw0 = [
		[
			\rx, Prand(Array.series(17, 0, 2pi/17)-pi, inf),
			\ry, Prand(Array.series(17, 0, 2pi/17)-pi, inf),
			\rz, Prand(Array.series(17, 0, 2pi/17)-pi, inf),
			// \ramp, Pseq(((0 ! 24) ++ [1.0, 0.2, 0.3, 1.0, 0.2, 0.8, 0.1, 0.7]), inf),
			\ramp, Pseq(((0 ! 8) ++ [1.0, 0.2, 0.3, 1.0, 0.2, 0.8, 0.1, 0.7]*0.0), inf),
			\rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf ),
			\delta, ~matrix.beatdur / 2
		]
	];
	e.playParWarp('w0', 'wrprevm', ~mesabufs[~ind1], ~pw0, 0.0, ~rt0, false );
	(~matrix.beatdur * 16).wait;
	e.setPat('r00', 0.2, [0.2, 0.5], [0.07, 0.1], 0.1);
	e.setPat('r02', 0.1, [0.3, 0.5], [0.07, 0.1], 0.1);
	e.setPat('r05', 0.1, [0.2, 0.3], [0.01, 0.1], 0.1);
	e.setPat('b10', 0.2, [0.3, 0.7], [0.07, 0.2], 0.1);
	e.setPat('b11', 0.2, [0.3, 0.7], [0.07, 0.2], 0.1);
	(~matrix.beatdur * 16).wait;
	e.setPat('r00', 0.2, [0.2, 0.5], [0.07, 0.1], 0.1);
	e.setPat('r02', 0.1, [0.3, 0.5], [0.07, 0.1], 0.1);
	e.setPat('r05', 0.1, [0.2, 0.3], [0.01, 0.1], 0.1);
	e.setPat('b10', 0.2, [0.3, 0.7], [0.07, 0.2], 0.1);
	e.setPat('b11', 0.2, [0.3, 0.7], [0.07, 0.2], 0.1);
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
	e.freeWarp('w0');
	e.freeWarp('w1');
	e.playParWarp('w0', 'wrprevm', ~mesabufs[~ind1], ~pw0, 1.0, ~rt0, false );
	e.setWarp('w0', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.3, 'iamp', 0.0, 'ramp', 0.0, 'rate', 1]);
	e.setPat('r00', 0.5, [0.2, 0.5], [0.07, 0.15], 0.1);
	e.setPat('r05', 0.1, [0.2, 0.3], [0.01, 0.15], 0.1);
	e.setPat('r02', 0.1, [0.3, 0.5], [0.07, 0.15], 0.1);
	e.setPat('b10', 0.1, [0.3, 0.7], [0.07, 0.2], 0.1);
	e.setPat('b11', 0.1, [0.3, 0.7], [0.07, 0.2], 0.1);
	(~matrix.beatdur * 32).wait;
	e.setPat('r00', 0.1, [0.2, 0.5], [0.07, 0.1], 0.1);
	e.setPat('r02', 0.1, [0.3, 0.5], [0.07, 0.1], 0.1);
	e.setPat('r05', 0.1, [0.2, 0.3], [0.01, 0.1], 0.1);
	e.setPat('b10', 0.0, [0.3, 0.7], [0.07, 0.2], 0.1);
	e.setPat('b11', 0.0, [0.3, 0.7], [0.07, 0.2], 0.1);
	(~matrix.beatdur * 32).wait;
	e.setPat('r00', 0.0, [0.2, 0.5], [0.07, 0.1], 0.1);
	e.setPat('r02', 0.0, [0.3, 0.5], [0.07, 0.1], 0.1);
	e.setPat('r05', 0.0, [0.2, 0.3], [0.01, 0.1], 0.1);
	(~matrix.beatdur * 32).wait;
	e.freeWarp('w0');
	"the end".postln;
	Server.default.stopRecording;
}).play

)








s.queryAllNodes
s.sendMsg("/n_free", 2206)






















e.freeWarp('w0');
Pdef('mx08').stop
e.setPat('b06', 0.2, [0.1, 0.4], [2.0, 4.0], 0.0);
e.setPat('b07', 0.4, [0.2, 0.3], [0.05, 0.2], 0.1);
e.setPat('b08', 0.4, [0.2, 0.3], [0.05, 0.15], 0.1);
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
	1);
