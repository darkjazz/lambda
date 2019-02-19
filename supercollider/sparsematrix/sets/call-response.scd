(~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2, screenX: 1024, screenY: 768, mode: 1, decoderType: 'c&r', 'localDecoder': true, bpm: 140, channels: 2, foa: #[zoom,push], dbname: "ges_ld_00", patdefs: "patternDefsAppendLnx.scd", initPdefs: ['r01', 'r02', 'b02', 'b06', 'b07', 'b08', 'b10', 'b11', 'b12'], worldDim: 21, ip: "127.0.0.1");


e = SpEnvir(~settings))

Server.killAll

SparseMatrix

~decoder.test

~decoder.stopTest

~decoder.synth.set('loamp', 0.5)
~decoder.synth.set('amp', 0.2)


(
~gespaths = (Paths.soundDir +/+ "evolver/wrp/*").pathMatch;
~gesbufs = GESBufferLoader(~gespaths);

)


~gesbufs.size

s.scope(2)


~matrix.setBPM(70)


(
~freqs = Array.twinPrimes(47, 1001).select({|it, i| it.odd });
~ranges = ~freqs.clump((~freqs.size/3).floor);

SynthDef('prsine', {|out, efx, freq, amp, dur, rot, til, tum|
	var sig, bf;
	sig = SinOsc.ar([freq, freq + 2]) *
	EnvGen.kr(Env.perc, timeScale: dur, doneAction: 2);
	bf = FoaEncode.ar(Mix(sig), FoaEncoderMatrix.newDirection);
	bf = FoaRTT.ar(bf, rot, til, tum);
	Out.ar(efx, bf[1] * amp);
	Out.ar(out, bf * amp)
}).add;
~sinebus = Bus.audio(Server.default);
)

(
~rev = SynthDef('reverb', {arg out, in, revamp=0.05, dry=0.0, revtime=3.1;
	var sig, bf;
	sig = In.ar(in);
	sig = GVerb.ar(sig, 150, revtime, drylevel: dry, earlyreflevel: revamp);
	sig = sig.dup.flat;
	bf = FoaEncode.ar(Array.fill(4, { |i|
			IFFT( PV_Diffuser( FFT( LocalBuf(1024), sig[i]), Dust.kr(200.0) ))
	}), FoaEncoderMatrix.newAtoB('fud'));
	Out.ar(out, bf)
}).play(~matrix.decoder.synth, ['out', ~matrix.decoder.bus, 'in', ~sinebus], \addBefore)

)

~rev.free


(
~matrix.onsetFunc_({
	if (0.1.coin) {
		Synth.before(~rev, 'prsine', ['out', ~decoder.bus, 'efx', ~sinebuss, 'freq', ~ranges[0].choose, 'amp', 0.3.rand, 'dur', 0.3, 'rot', rrand(-pi, pi), 'til', rrand(-pi, pi), 'tum', rrand(-pi, pi)]);
	};
	if (0.1.coin) {
		Synth.before(~rev, 'prsine', ['out', ~decoder.bus, 'efx', ~sinebus, 'freq', ~ranges[1].choose, 'amp', 0.4.rand, 'dur', 0.2, 'rot', rrand(-pi, pi), 'til', rrand(-pi, pi), 'tum', rrand(-pi, pi)]);
	};
	if (0.1.coin) {
		Synth.before(~rev, 'prsine', ['out', ~decoder.bus, 'efx', ~sinebuss, 'freq', ~ranges[2].choose, 'amp', 0.4.rand, 'dur', 0.1, 'rot', rrand(-pi, pi), 'til', rrand(-pi, pi), 'tum', rrand(-pi, pi)]);
	};
});
)

~matrix.onsetFunc_({})


(
~wrp0 = Synth.tail(~matrix.group, 'wrprevm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[10], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

Pdef('swrp0',
	Pbind(
		\type, \set, \id, ~wrp0.nodeID, \delta, Pn(0.2, inf),
		\rx, Pbrown(-0.5pi, 0.5pi, 0.125pi, inf),
		\ry, Pbrown(0, 2pi, 0.125pi, inf),
		\rz, Pbrown(0, 2pi, 0.125pi, inf),
		\args, #[rx, ry, rz]
	)
).play
)

~wrp0.set('amp', 1.0, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.2, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.125)

~wrp0.free; Pdef('swrp0').clear



(
~wrp1 = Synth.tail(~matrix.group, 'wrprevm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[56], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

Pdef('swrp1',
	Pbind(
		\type, \set, \id, ~wrp1.nodeID, \delta, Pn(0.2, inf),
		\rx, Pbrown(-0.5pi, 0.5pi, 0.125pi, inf),
		\ry, Pbrown(0, 2pi, 0.125pi, inf),
		\rz, Pbrown(0, 2pi, 0.125pi, inf),
		\args, #[rx, ry, rz]
	)
).play
)

~wrp1.set('amp', 1.0, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.1, 'rate', 1.0, 'freq', 0.25, 'wrp', 0.125)


~wrp1.free; Pdef('swrp1').clear



(
~wrp2 = Synth.tail(~matrix.group, 'revwrpm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[59], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

Pdef('swrp2',
	Pbind(
		\type, \set, \id, ~wrp2.nodeID, \delta, Pn(0.2, inf),
		\rx, Pbrown(-0.5pi, 0.5pi, 0.125pi, inf),
		\ry, Pbrown(0, 2pi, 2pi/16, inf),
		\rz, Pbrown(0, 2pi, 2pi/16, inf),
		\args, #[rx, ry, rz]
	)
).play
)

~wrp2.set('amp', 1.0, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0, 'rate', 0.25, 'freq', 0.25, 'wrp', 0.125)

~wrp2.free; Pdef('swrp2').clear

// for hackpact 10, 12, 13, 15

// 10 & 24 & 15
// 27, 30, 35, 39, 40, 44

(
~ind = 58;
~wrp3 = Synth.tail(~matrix.group, 'wrprevm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[~ind], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

Pdef('swrp3',
	Pbind(
		\type, \set, \id, ~wrp3.nodeID, \delta, Pn(0.2, inf),
		\rx, Pbrown(-0.5pi, 0.5pi, 0.0125pi, inf),
		\ry, Pbrown(0, 2pi, 0.125pi, inf),
		\rz, Pbrown(0, 2pi, 0.125pi, inf),
		\args, #[rx, ry, rz]
	)
).play;

)

~wrp3.set('amp', 1.0, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.125)

~wrp3.free; Pdef('swrp3').clear

s.queryAllNodes


Pdef('matrix', Ppar([Pdef('b04'), Pdef('b07'), Pdef('b08'), Pdef('b12'), Pdef('b10'), Pdef('b11') ]))


Pdef('matrix', Ppar([ Pdef('r01'), Pdef('r02') ]))




~matrix.defsAt('b07').setActives(nil, { rrand(0.1, 0.01) });
~matrix.defsAt('b10').setActives(nil, { rrand(0.1, 0.01) });
~matrix.defsAt('b11').setActives(nil, { rrand(0.1, 0.01) });
~matrix.defsAt('b12').setActives(nil, { rrand(0.1, 0.01) });
~matrix.defsAt('b08').setActives(nil, { rrand(0.1, 0.01) });
~matrix.defsAt('r01').setActives(nil, { rrand(0.1, 0.01) });


['b11'].do({|name|
	~matrix.defsAt(name).setActives(nil, { rrand(0.05, 0.01) });
})


['r03', 'r04', 'r05', 'r06'].do({|name|
	~matrix.defsAt(name).recall(0)
})


['b07', 'b10', 'b11', 'b12', 'b08', 'r01'].do({|name|
	~matrix.defsAt(name).recall(0)
})


['b10', 'b11', 'b12', 'b08', 'r01'].do({|name|
	~matrix.defsAt(name).setActives(nil, { rrand(0.01, 0.1) });
})


['b10', 'b11', 'b12', 'b08', 'r01'].do({|name|
	~matrix.defsAt(name).setControls({ [0, 1].wchoose([0.8, 0.2]) }, { rrand(0.04, 0.2) });
})


(
Tdef('check', {
	var keys = ~matrix.defsAt('r02').ctrls.keys(Array);
	keys.do({|key|
		key.postln;
		~matrix.defsAt('r02').ctrls[key]['amp'] = 0.5;
		~matrix.defsAt('r02').ctrls[key]['dur'] = 0.1;
		~matrix.defsAt('r02').ctrls[key]['active'] = 1;
		(~matrix.beatdur * 16).wait;
		~matrix.defsAt('r02').ctrls[key]['active'] = 0;
	})
}).play
)

~matrix.defsAt('r02').ctrls[~key]['amp'] = 0.5;
~matrix.defsAt('r02').ctrls[~key]['dur'] = 0.1;
~matrix.defsAt('r02').ctrls[~key]['active'] = 0


~matrix.defsAt('b11').recall(0);

~matrix.defsAt('b02').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.1, 0.4) },
	0.1
);

~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.01, 0.1) },
	0.1
);


(
~matrix.patterndefs.do({|def| def.setActives(0) });
~hold = Synth.before(~decoder.synth, \hold, ['out', ~decoder.bus, 'buf', ~holdbufs.choose, 'amp', 1.0])
)

(
~matrix.patterndefs.do({|def| def.recall(0)  });
~hold.free; ~hold = nil;
)

(

~matrix.defsAt('b08').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.1, 0.4) },
	{ exprand(0.1, 0.3) },
	0.1
);

~matrix.defsAt('b07').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.2, 0.6) },
	{ exprand(0.1, 0.3) },
	0.1
);
)



~matrix.defsAt('b04').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.3, 0.6) },
	{ exprand(2.0, 4.0) },
	0.1
);

~matrix.defsAt('b11').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.1, 0.5) },
	{ exprand(0.5, 1.0) },
	0.1
);


~matrix.defsAt('b10').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.4, 0.6) },
	{ exprand(0.1, 0.3) },
	0.1
);


~matrix.defsAt('b12').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.3, 0.5) },
	{ exprand(0.1, 0.3) },
	0.1
);

~matrix.defsAt('b04').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.3, 0.6) },
	{ exprand(0.1, 0.3) },
	0.1
);


~matrix.defsAt('r05').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.3, 1.0) },
	{ exprand(0.05, 0.1) },
	0.1
);


~matrix.defsAt('r06').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.3, 0.7) },
	{ exprand(0.01, 0.1) },
	0.1
);


~matrix.hold



~matrix.defsAt('b06').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.1, 0.5) },
	{ exprand(3.0, 6.0) },
	0.1
);


~matrix.defsAt('b07').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 0.7) },
	{ exprand(0.1, 0.2) },
	0.1
);


~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([0.9, 0.1]) },
	{ exprand(0.2, 1.0) },
	{ exprand(0.02, 0.2) },
	0.1
);

~matrix.defsAt('b02').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ exprand(0.6, 1.0) },
	{ exprand(0.1, 0.2) },
	0.1
);

~matrix.defsAt('b11').recall(0);
~matrix.defsAt('b02').recall(0);

~matrix.defsAt('b06').recall(0);

// ~matrix.defsAt('b08').recall(0);


~matrix.defsAt('r01').recall(0);

s.queryAllNodes

Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.4, 0.7), 'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(50, 45)], 'dur', exprand(0.7, 3.0), 'env', [Env.perc, Env.sine].choose] );


~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.1, 0.5) },
	{ exprand(0.05, 0.1) },
	0.1
);

~matrix.defsAt('b10').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.1, 0.3) },
	0.1
);

~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.3, 0.6) },
	{ exprand(0.1, 0.4) },
	0.1
);

~matrix.defsAt('b04').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.3, 0.8) },
	{ exprand(0.3, 0.6) },
	0.1
);

~matrix.defsAt('b06').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.2, 0.5) },
	{ exprand(2.0, 4.0) },
	0.1
);

~matrix.defsAt('b12').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.3, 0.8) },
	{ exprand(0.1, 0.3) },
	0.1
);

~matrix.defsAt('b12').recall(0);

~matrix.defsAt('b11').recall(0);


~matrix.defsAt('b05').recall(0)



['flangingDecimator', 'granularReverb', 'feedbackSpectrum', 'cyclicWarp', 'latchOnset', 'cliqSaw', 'fxGrain', 'arhythmicGendy']

~matrix.activateSkismSynth('latchOnset')

~matrix.setSkismAmp('latchOnset', 1.0)

~matrix.deactivateSkismSynth('latchOnset')



~matrix.activateSkismSynth('flangingDecimator')

~matrix.setSkismAmp('flangingDecimator', 0.4)

~matrix.deactivateSkismSynth('flangingDecimator')



~matrix.activateSkismSynth('cyclicWarp')

~matrix.setSkismAmp('cyclicWarp', 0.1)

~matrix.deactivateSkismSynth('cyclicWarp')


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







s.queryAllNodes