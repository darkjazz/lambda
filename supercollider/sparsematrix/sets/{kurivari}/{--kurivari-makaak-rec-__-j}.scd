//makaak

(
Server.default.record;
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
~p1 = [
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
			Post << "BEAT " << ~counter << Char.nl;
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
e.playWarp('w0', 'revwrpm', ~buf, ~p1, ~matrix.beatdur / 2, 1, ~rate);

Tdef('seq', {
	(~matrix.beatdur * 16).wait;
	~amph = 1;
	(~matrix.beatdur * 16).wait;
	~ampk = 1;
	~amps = 1;
	~p2 = [
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
		});
	];
	e.setPwarp('w0', ~p2, ~matrix.beatdur / 2);
	(~matrix.beatdur * 64).wait;
	~amph = 0;
	~amps = 0;
	e.setPwarp('w0', ~p1, ~matrix.beatdur / 2);
	(~matrix.beatdur * 16).wait;
	~amps = 1;
	~ampk = 0;
	(~matrix.beatdur * 16).wait;
	~amps = 0;
	~amph = 1;
	~matrix.activateSkismSynth('magFreeze');
	~matrix.setSkismAmp('magFreeze', 0.3);
	(~matrix.beatdur * 16).wait;
	~ampk = 1;
	~amps = 1;
	e.setPwarp('w0', ~p2, ~matrix.beatdur / 2);
	(~matrix.beatdur * 64).wait;
	~ampk = 0;
	~amps = 0;
	e.setPwarp('w0', ~p1, ~matrix.beatdur / 2);
	(~matrix.beatdur * 16).wait;
	~ampk = 1;
	~amps = 1;
	~matrix.deactivateSkismSynth('magFreeze');
	~matrix.activateSkismSynth('cliqSaw');
	~matrix.setSkismAmp('cliqSaw', 0.1);
	(~matrix.beatdur * 32).wait;
	e.setPwarp('w0', ~p2, ~matrix.beatdur / 2);
	~matrix.deactivateSkismSynth('cliqSaw');
	~matrix.activateSkismSynth('primeTam');
	~matrix.setSkismAmp('primeTam', 0.2);
	(~matrix.beatdur * 32).wait;
	e.setPwarp('w0', ~p1, ~matrix.beatdur / 2);
	~ampk = 0;
	~amps = 0;
	~amph = 0;
	(~matrix.beatdur * 16).wait;
	~ampk = 1;
	(~matrix.beatdur * 8).wait;
	~amps = 1;
	~amph = 1;
	e.setPwarp('w0', ~p2, ~matrix.beatdur / 2);
	(~matrix.beatdur * 32).wait;
	~matrix.deactivateSkismSynth('primeTam');
	e.setPwarp('w0', ~p1, ~matrix.beatdur / 2);
	~ampk = 0;
	~amps = 0;
	~amph = 0;
	~matrix.activateSkismSynth('magFreeze');
	~matrix.setSkismAmp('magFreeze', 0.3);
	(~matrix.beatdur * 32).wait;
	~amph = 1;
	(~matrix.beatdur * 8).wait;
	~amps = 1;
	~ampk = 1;
	(~matrix.beatdur * 64).wait;
	~ampk = 0;
	~amps = 0;
	~amph = 0;
	e.setPwarp('w0', ~p2, ~matrix.beatdur / 2);
	~matrix.activateSkismSynth('latchOnset');
	~matrix.setSkismAmp('latchOnset', 0.1);
	(~matrix.beatdur * 16).wait;
	e.setPwarp('w0', ~p1, ~matrix.beatdur / 2);
	(~matrix.beatdur * 16).wait;
	e.freeWarp('w0');
	(~matrix.beatdur * 8).wait;
	~matrix.deactivateSkismSynth('magFreeze');
	~matrix.deactivateSkismSynth('latchOnset');
	~counter.postln;
	"finished".postln;
	Server.default.stopRecording;
}).play

)



~bpm
~matrix.beatdur *

Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', 0.5, 'emp', 0.0, 'buf', ~matrix.buffers['evo'][48], 'dur', 2.0, 'env', Env.sine] );

~amps = 1;
~ampk = 1;
~amph = 1


~matrix.activateSkismSynth('magFreeze')

~matrix.setSkismAmp('magFreeze', 0.1)

~matrix.deactivateSkismSynth('magFreeze')



(
~amps = 0;
~ampk = 0;
~amph = 1;
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

~matrix.setSkismAmp('primeTam', 0.07 )

~matrix.deactivateSkismSynth('primeTam')

~matrix.activateSkismSynth('roosaBufWrp')

~matrix.setSkismAmp('roosaBufWrp', 0.1)

~matrix.deactivateSkismSynth('roosaBufWrp')


s.queryAllNodes


e.freeWarp('w0')
