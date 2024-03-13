(
~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2, screenX: 1024, screenY: 768, mode: 1, decoderType: 'binaural', 'localDecoder': true, bpm: 113, channels: 2, foa: #[zoom,push], dbname: "ges_ld_00", patdefs: "patternDefsMix.scd", initPdefs: ['r00', 'r01', 'r02', 'r03', 'b02', 'b06', 'b07', 'b10', 'b11', 'b12'], worldDim: 21, ip: "127.0.0.1");
e = SpEnvir(~settings)

)

Server.killAll

(

~gespaths = (Paths.soundDir +/+ "evolver/wrp/*").pathMatch;
~gespaths.size.postln;
~gesbufs = GESBufferLoader([]);
~gesbufs.loadByDate("220400", "220501");

)

~gesbufs.size

s.stopRecording

~matrix.setBPM(113)

// 1

(
a = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pbrown(0, 2pi, 0.125pi, inf),
	\rz, Pbrown(0, 2pi, 0.125pi, inf),
	\ramp, Pseq([0.0, 0.4, 0.0, 0.8, 0.0, 0.6], inf)
];
e.playWarp('w0', 'wrprevm', ~gesbufs[1], a, 4);
)

e.setWarp('w0', ['amp', 1.0, 'wamp', 0.0, 'iamp', 0.2, 'ramp', 0.0, 'rate', 0.5, 'freq', 0.25])

e.freeWarp('w0')



(
b = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pbrown(0, 2pi, 0.125pi, inf),
	\rz, Pbrown(0, 2pi, 0.125pi, inf)
];
e.playWarp('w1', 'revwrpm', ~gesbufs[15], b, 2);
)

e.setWarp('w1', ['amp', 1.0, 'wrp', 0.125, 'wamp', 0.4, 'iamp', 0.1, 'ramp', 0.1, 'rate', 1.0, 'freq', 1.0, 'randr', 0.01, 'wsize', 0.1, 'dens', 6])

e.freeWarp('w1')





(
c = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pbrown(0, 2pi, 0.125pi, inf),
	\rz, Pbrown(0, 2pi, 0.125pi, inf)
];
e.playWarp('w2', 'wrprevm', ~gesbufs[77], c, 2);
)

e.setWarp('w2', ['amp', 1.0, 'wrp', 0.125, 'wamp', 0.3, 'iamp', 0.1 , 'ramp', 0.0, 'rate', 1.0, 'freq', 1.0, 'randr', 0.01, 'wsize', 0.1, 'dens', 6])

e.freeWarp('w2')




(
d = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pbrown(0, 2pi, 0.125pi, inf),
	\rz, Pbrown(0, 2pi, 0.125pi, inf)
];
e.playWarp('w3', 'revwrpm', ~gesbufs[76], d, 2);
)

e.setWarp('w3', ['amp', 1.0, 'wrp', 0.125, 'wamp', 1.0, 'iamp', 0.4, 'ramp', 0.2, 'rate', 1.0, 'freq', 1.0, 'randr', 0.01, 'wsize', 0.1, 'dens', 6])

e.freeWarp('w3')


s.queryAllNodes


Pdef('efx').play

~matrix.efxamps['efx1'] = 0.2

~matrix.defsAt('r00').assignEfx(
	(efx1: (0..31))
)



~matrix.efxamps['efx0'] = 0.1

~matrix.defsAt('r01').assignEfx(
	(efx0: (0..31))
)



e.setPat('r00', [1.0, 0.0], [0.5, 0.8], [0.04, 0.09], 0.1);
e.setPat('r01', [1.0, 0.0], [0.5, 0.8], [0.04, 0.09], 0.1);
e.setPat('r02', [1.0, 0.0], [0.5, 0.8], [0.04, 0.09], 0.1);
e.setPat('r03', [1.0, 0.0], [0.5, 0.8], [0.04, 0.09], 0.1);
e.setPat('b10', [1.0, 0.0], [0.5, 0.8], [0.04, 0.09], 0.1);
e.setPat('b11', [1.0, 0.0], [0.5, 0.8], [0.04, 0.09], 0.1);








(

~matrix.defsAt('r00').setControls(
	{ [0, 1].wchoose([0.9, 0.1]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.04, 0.2) },
	0.2
);

~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 0.5) },
	{ exprand(0.04, 0.1) },
	0.1
);

~matrix.defsAt('r02').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.4, 0.6) },
	{ exprand(0.05, 0.1) },
	0.1
);

~matrix.defsAt('r03').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.4, 0.8) },
	{ exprand(0.04, 0.1 ) },
	0.1
);

)

s.stopRecording


~matrix.defsAt('r00').recall(0);
~matrix.defsAt('r01').recall(0);


~matrix.defsAt('r00').setActives(nil, { rrand(0.01, 0.02) });
~matrix.defsAt('r01').setActives(nil, { rrand(0.01, 0.02) });
~matrix.defsAt('r02').setActives(nil, { rrand(0.01, 0.02) });
~matrix.defsAt('r03').setActives(nil, { rrand(0.01, 0.02) });



~matrix.defsAt('r02').recall(0);
~matrix.defsAt('r03').recall(0);



(
~matrix.defsAt('b02').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.4, 0.6) },
	{ exprand(0.05, 0.2) },
	0.1
);

~matrix.defsAt('b07').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.1, 0.2) },
	0.1
);

~matrix.defsAt('b09').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.6, 0.6) },
	{ exprand(0.01, 0.3) },
	0.1
);

~matrix.defsAt('d06').setControls(
	{ [0, 1].wchoose([0.5, 0.5]) },
	{ exprand(0.4, 0.4) },
	{ exprand(0.01, 0.05) },
	0.1
);

)

SparseMatrix

~matrix.defsAt('d01').setActives(nil, { rrand(0.1, 0.01) });


~matrix.defsAt('r00').recall(0);
~matrix.defsAt('d01').recall(0);


~matrix.defsAt('b11').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.2, 0.8) },
	{ exprand(0.05, 0.1) },
	0.1
);


~matrix.defsAt('b06').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.2, 0.4) },
	{ exprand(2.0, 4.0) },
	0.1
);

~matrix.defsAt('b07').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.05, 0.1) },
	0.1
);


~matrix.defsAt('b12').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.1, 0.3) },
	0.1
);



~drnbufs = "/Users/alo/snd/drn/poni/*.wav".pathMatch.collect({|path|
	Buffer.read(s, path)
})


(
~selected = ~drnbufs.select({|buf| buf.duration > 0.0 });
~avgdur = ~matrix.beatdur*4;
Tdef('drone', {
	loop({
		~args = [
			'out', ~decoder.bus, 'buf', ~selected.choose,
			'wrp', rrand(0.33, 1.0),
			'freq', [0.5, 1.0, 2.0].choose, 'wsize', rrand(0.05, 0.2),
			'dens', rrand(3, 15), 'randr', rrand(0.01, 0.2),
			'room', rrand(20, 300), 'rtime', rrand(2.0, 10.0),
			'ramp', rrand(0.3, 1.0), 'eamp', rrand(0.5, 1.0),
			'wamp', rrand(0.2, 0.7), 'dur', ~avgdur * rrand(1.0, 4.0),
			'rx', rrand(0.01, 0.3), 'ry', rrand(0.01, 0.3), 'rz', rrand(0.01, 0.3),
			'rng', 1
		];
		Synth.before(~decoder.synth, 'wrpdrn', ~args);
		~avgdur.wait;
	})
}).play

)


Tdef('drone').clear





['flangingDecimator', 'granularReverb', 'feedbackSpectrum', 'cyclicWarp', 'latchOnset', 'cliqSaw', 'fxGrain', 'arhythmicGendy']

~matrix.activateSkismSynth('latchOnset')

~matrix.setSkismAmp('latchOnset', 0.4)

~matrix.deactivateSkismSynth('latchOnset')



~matrix.activateSkismSynth('cliqSaw')

~matrix.setSkismAmp('cliqSaw', 0.2)

~matrix.deactivateSkismSynth('cliqSaw')



~matrix.activateSkismSynth('granularReverb')

~matrix.setSkismAmp('granularReverb', 0.2)

~matrix.deactivateSkismSynth('granularReverb')


~matrix.buffers['evo'].size

SynthDef(\bitSt2, {|out, efx, amp, emp, buf, dur|
	var sig;
	sig = Normalizer.ar(
		PlayBuf.ar(2, buf, BufRateScale.ir(buf) * 1.neg, 1, BufFrames.kr(buf)),
		amp) * EnvGen.kr(\env.kr(Env.newClear(8).asArray), timeScale: dur, doneAction: 2);
	Out.ar(efx, sig * emp);
	Out.ar(out, sig * amp)
}).add;

Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.4, 0.7), 'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(26, 29)], 'dur', exprand(0.7, 3.0), 'env', [Env.perc, Env.sine].choose] );


(
Tdef('tex', {
	loop({
		Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.4, 0.7), 'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(100, 104)], 'dur', exprand(0.4, 0.9), 'env', [Env.perc, Env.sine].choose] );
		rrand(0.1, 0.4).wait
	})
})
.play
)

