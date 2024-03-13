(
~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2, screenX: 1024, screenY: 768, mode: 1, decoderType: 'binaural', 'localDecoder': true, bpm: 113, channels: 2, foa: #[zoom,push], dbname: "ges_ld_00", patdefs: "patternDefsMix.scd", initPdefs: ['r00', 'r01', 'r02', 'r03', 'b00', 'b01', 'b02', 'b03', 'b04', 'b05', 'b06', 'b07', 'b08', 'b09', 'b10', 'b11', 'b12'], worldDim: 21, ip: "127.0.0.1");
e = SpEnvir(~settings)

)

Server.killAll

~matrix

FoaDecoder
~gesbufs.size

s.stopRecording

~matrix.setBPM(123)

~matrix.beatdur/2

s.scope(2)

s.record

~decoder.synth.set('amp', 0.8)


Pseq(([0.1, 0.4, 0.1, 0.4, 0.2, 0.3, 0.1, 0.3] ++ (0 ! 24))*4, inf)
Pseq(((0 ! 16) ++ [0.1, 0.4, 0.1, 0.4, 0.2, 0.3, 0.1, 0.3] ++ (0 ! 8))*4, inf)
Pseq(((0 ! 8) ++ [0.1, 0.4, 0.1, 0.4, 0.2, 0.3, 0.1, 0.3] ++ (0 ! 16))*4, inf)
Pseq(((0 ! 24) ++ [0.1, 0.4, 0.1, 0.4, 0.2, 0.3, 0.1, 0.3])*4, inf)




// 1

(
a = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\iamp, Pseq(((0 ! 24) ++ [0.1, 0.4, 0.1, 0.4, 0.2, 0.3, 0.1, 0.3])*4, inf),
	\rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w0', 'wrprevm', ~gesbufs[13], a, ~matrix.beatdur);
)

e.setPwarp('w0', a, ~matrix.beatdur / 2)

e.setWarp('w0', ['amp', 1.0, 'wrp', 0.25, 'wamp', 1.0, 'iamp', 1.0, 'ramp', 0.0, 'rate', 1, 'freq', 0.25])

e.freeWarp('w0')




(
b = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pbrown(0, 2pi, 0.125pi, inf),
	\rz, Pbrown(0, 2pi, 0.125pi, inf),
	\ramp, Pseq(( (0 ! 8) ++ [0.1, 0.4, 0.1, 0.4, 0.2, 0.3, 0.1, 0.3] ), inf),
	\freq, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w1', 'revwrpm', ~gesbufs[427], b, ~matrix.beatdur);
)

e.setWarp('w1', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.0, 'iamp', 0.1, 'ramp', 0.0, 'rate', 1, 'freq', 1.0, 'randr', 0.01, 'wsize', 0.1, 'dens', 6])

e.freeWarp('w1')
n

s.scope(17)


// 1, 6, 13, 14, 15, 17, 18, 21, 22, 23

Pseq(Array.series(12, 0, 2pi/12), inf)
Prand(Array.series(17, 0, 2pi/17), inf)

(
c = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf)
];
e.playWarp('w2', 'wrprevm', ~gesbufs[~gesbufs.size.rand], c, ~matrix.beatdur);
)

e.setPwarp('w2', c, ~matrix.beatdur)

e.setWarp('w2', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.1, 'iamp', 0.3, 'ramp', 0.0, 'rate', 0.25, 'freq', 1.0, 'randr', 0.04, 'wsize', 0.1, 'dens', 6])

e.freeWarp('w2')




// 64, 67, 68, 70, 71, 74, 76, 77, 79, 87

(
d = [
	\rx, Pbrown(-pi, pi, 0.125pi, inf),
	\ry, Pbrown(0, 2pi, 0.125pi, inf),
	\rz, Pbrown(0, 2pi, 0.125pi, inf)
	// \iamp, Pseq(([0.1, 0.4, 0.1, 0.4, 0.2, 0.3, 0.1, 0.3] ++ (0 ! 24))*4, inf)
];
e.playWarp('w3', 'wrprevm', ~gesbufs[~gesbufs.size.rand], d, ~matrix.beatdur/2);
)

e.setPwarp('w3', d, ~matrix.beatdur/2)

e.setWarp('w3', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.0, 'iamp', 1.0, 'ramp', 0.2, 'rate', 1.0, 'freq', 1, 'randr', 0.1, 'wsize', 0.1, 'dens', 6])

e.freeWarp('w3')

s.scope(2)

s.sendMsg("/n_free", 1014)



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
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.04, 0.06) },
	0.2
);

~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([9,8, 0.2]) },
	{ exprand(0.1, 0.4) },
	{ exprand(0.04, 0.2) },
	0.1
);

~matrix.defsAt('r02').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.1, 0.3) },
	{ exprand(0.01, 0.2) },
	0.1
);

~matrix.defsAt('r03').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.2, 0.8) },
	{ exprand(0.02, 0.1 ) },
	0.1
);

)

s.stopRecording


~matrix.defsAt('r01').recall(0);
~matrix.defsAt('r00').recall(0);

~matrix.defsAt('r02').recall(0);
~matrix.defsAt('r03').recall(0);


~matrix.defsAt('r00').setActives(nil, { rrand(0.01, 0.02) });
~matrix.defsAt('r01').setActives(nil, { rrand(0.01, 0.02) });
~matrix.defsAt('r02').setActives(nil, { rrand(0.01, 0.02) });
~matrix.defsAt('r03').setActives(nil, { rrand(0.01, 0.02) });



~matrix.defsAt('b02').recall(0);
~matrix.defsAt('b09').recall(0);



(
~matrix.defsAt('b11').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.4, 1.0) },
	{ exprand(0.05, 0.3) },
	0.1
);

~matrix.defsAt('b10').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.1, 0.8) },
	{ exprand(0.1, 0.3) },
	0.1
);

~matrix.defsAt('b04').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.3, 0.5) },
	{ exprand(4.0, 6.0) },
	0.1
);

~matrix.defsAt('b09').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.3, 0.3) },
	{ exprand(0.1, 0.2) },
	0.1
);

)


MasterEQ(2)

SparseMatrix

~matrix.defsAt('d01').setActives(nil, { rrand(0.1, 0.01) });


~matrix.defsAt('r00').recall(0);
~matrix.defsAt('d01').recall(0);


~matrix.defsAt('b11').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.4, 1.0) },
	{ exprand(0.3, 0.6) },
	0.1
);


~matrix.defsAt('b12').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.2, 0.4) },
	{ exprand(0.5, 2.0) },
	0.1
);

~matrix.defsAt('b07').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.23, 0.6) },
	{ exprand(0.2, 0.5) },
	0.1
);


~matrix.defsAt('b').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.2, 0.4) },
	0.1
);



~drnbufs = "/Users/alo/snd/drn/poni/*.wav".pathMatch.collect({|path|
	Buffer.read(s, path)
})


(
~selected = ~drnbufs.select({|buf| buf.duration > 0.0 });
~avgdur = ~matrix.beatdur*8;
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
		rrand(~avgdur*0.7, ~avgdur*1.3).wait;
	})
}).play

)


Tdef('drone').clear





['flangingDecimator', 'granularReverb', 'feedbackSpectrum', 'cyclicWarp', 'latchOnset', 'cliqSaw', 'fxGrain', 'arhythmicGendy']

~matrix.activateSkismSynth('latchOnset')

~matrix.setSkismAmp('latchOnset', 1.0)

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

