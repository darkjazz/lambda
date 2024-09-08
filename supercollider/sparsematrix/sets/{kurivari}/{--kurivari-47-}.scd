(
~ind = 47;
~buf = ~kvbufs[~ind];
~lbpm = ~kvbufs.loops[~buf.path.basename.asSymbol].bpm;
~rate = ~bpm/~lbpm;
~counter = 0;
~ampk = 1;
~amps = 1;
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
				'env', Env.perc] );
		};
		if (~counter % 6 == 0) {
			Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', ~amps,
				'emp', 0.0, 'buf', ~matrix.buffers['evo'][22], 'dur', 0.5,
				'env', Env.perc] );
		};
		if (~counter % 2 == 0) {
			Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', 1.0,
				'emp', 0.0, 'buf', ~matrix.buffers['evo'][24], 'dur', 0.1,
				'env', Env.perc] );
		};
		~counter = ~counter + 1;
	})
];
e.playWarp('w0', 'revwrpm', ~buf, a, ~matrix.beatdur / 2, 1, ~rate);

)

Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', 0.5, 'emp', 0.0, 'buf', ~matrix.buffers['evo'][48], 'dur', 2.0, 'env', Env.sine] );

~amps = 1;
~ampk = 1

e.freeWarp('w0')
