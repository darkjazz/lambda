(~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2, screenX: 1024, screenY: 768, mode: 1, decoderType: 'stereo', 'localDecoder': true, bpm: 127, channels: 2, foa: #[zoom,push], dbname: "ges_ld_00", patdefs: "patternDefsAppendLnx.scd", initPdefs: ['r00', 'r08', 'b02', 'b06', 'b07', 'b08', 'b10', 'b11', 'b12'], worldDim: 21, ip: "127.0.0.1");

e = SpEnvir(~settings, InEnvir(nRecs: 23, bufmul:Prand([1, 2, 3, 4], inf)).initFunc))


['flangingDecimator', 'granularReverb', 'feedbackSpectrum', 'cyclicWarp', 'latchOnset', 'cliqSaw', 'fxGrain', 'arhythmicGendy']

s.record

FoaDecoder
s.queryAllNodes

s.stopRecording

Server.killAll

~ins.ins[0].set('amp', 1.0, 'revamp', 0.4, 'revtime', 5.1)

~ins.startEfx('cyclicWarp', 0)

~ins.setEfx('cyclicWarp', ['amp', 0.1, 'iwrp', 2.0, 'ibufscale', 0.25, 'wsz', 0.01, 'dns', 6, 'rnd', 0.2, 'rev', 0.1])

~ins.stopEfx('cyclicWarp')


~matrix.addPatternSynthDef('r00', (0..31), 8, 4,
	['kpanilogo', 'yole', 'kpanilogo', 'yole'], 2, "r0", 'r00', false);


~key = 'r110'

(
~matrix.defsAt('r01').ctrls[~key]['amp'] = 0.8;
~matrix.defsAt('r01').ctrls[~key]['dur'] = 0.2;
~matrix.defsAt('r01').ctrls[~key]['active'] = 0
)



~ins.startEfx('granularReverb', 0)
~ins.setEfx('granularReverb', ['amp', 0.4])
~ins.stopEfx('granularReverb')

~ins.startEfx('feedbackSpectrum', 0)
~ins.setEfx('feedbackSpectrum', ['amp', 0.4])
~ins.stopEfx('feedbackSpectrum')

~ins.startEfx('cliqSaw', 0)
~ins.setEfx('cliqSaw', ['amp', 0.4])
~ins.stopEfx('cliqSaw')

s.scope(2)

~ins.startRecording

~ins.stopRecording

~ins.startShift(1.0, -0.5, 1.0)
~ins.setShift(0, ['shift', 1.0, 'rate', -1.0, 'amp', 0.7])

~ins.stopShift(0)


~ins.startShift(1.0, 1.0, 1.0)
~ins.setShift(1, ['amp', 1.0, 'shift', 1.0, 'rate', -1.0])

~ins.stopShift(1)


(
Tdef(\playshift, {
	loop({
		~ins.shifts.choose.set('buffer', ~ins.recBufs.choose);
		rrand(8*~matrix.beatdur, 16*~matrix.beatdur).wait;
	})
}).play
)

Tdef(\playshift).clear


(
Pdef('playsamp',
	Pbind('instrument', 'playSample',
		'group', ~matrix.group, 'addAction', 'addToTail',
		'out', ~decoder.bus, 'rate', Prand([1.0, 0.5, 0.25, 0.125, -0.5, -1.0], inf),
		'buffer', Pxrand(~ins.recBufs, inf), 'amp', Pwhite(0.8, 1.0),
		'rx', Pwhite(-pi, pi), 'ry', Pwhite(-pi, pi), 'rz', Pwhite(-pi, pi),
		'delta', Pfunc({|ev| ev.buffer.duration * ev.rate.abs.reciprocal })
	)
).play
)


Pdef('playsamp').clear




(
~wrpv0 = Synth.tail(~matrix.group, 'wrprevm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~ins.recBufs.first, 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

Pdef('swrp0',
	Pbind(
		\type, \set, \id, ~wrpv0.nodeID, \delta, Pn(0.2, inf),
		\rx, Pbrown(-0.5pi, 0.5pi, 0.125pi, inf),
		\ry, Pbrown(0, 2pi, 0.125pi, inf),
		\rz, Pbrown(0, 2pi, 0.125pi, inf),
		\args, #[rx, ry, rz]
	)
).play
)

(
~wrpv0.set('amp', 1.0, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0, 'rate', 2.0, 'freq', 1.0, 'wrp', 0.25,
	'buf', ~ins.recBufs.choose
)
)

~wrpv0.free; Pdef('swrp0').clear


(
~wrpv1 = Synth.tail(~matrix.group, 'wrprevm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~ins.recBufs.choose, 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

Pdef('swrp1',
	Pbind(
		\type, \set, \id, ~wrpv1.nodeID, \delta, Pn(0.2, inf),
		\rx, Pbrown(-0.5pi, 0.5pi, 0.125pi, inf),
		\ry, Pbrown(0, 2pi, 0.125pi, inf),
		\rz, Pbrown(0, 2pi, 0.125pi, inf),
		\args, #[rx, ry, rz]
	)
).play
)

(
~wrpv1.set('amp', 1.0, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0, 'rate', 1.0, 'freq', 2.0, 'buf', ~ins.recBufs.choose)
)

~wrpv1.free; Pdef('swrp1').clear

s.queryAllNodes


Tdef('warploop', {
	loop({
		~wrp1.set('amp', 0.6, 'wamp', 0.9, 'iamp', 0.5, 'ramp', 0.7, 'rate', 0.5, 'freq', 1.0, 'wrp', 0.125, 'buf', ~ins.recBufs.choose);
		rrand(3, 8).wait
	})
}).play

Tdef('warploop').clear



s.stopRecording


~matrix.addPatternBufferDef('p00', (0..~ins.recBufs.size), 4, 4,
	['Yanvalou', 'Wolosodon', 'Toro', 'Timiny', 'Soli', 'Soboniko'],
	2, "p0", 'bufproto', ~ins.recBufs, 'bit01', true
);

~matrix.addPatternBufferDef('p01', (0..~ins.recBufs.size), 4, 4,
	['Sinte', 'Sabar', 'Madan', 'Lolo', 'Kpatsia', 'Kpanlogo', 'Kononwulen', 'Konkoba'],
	2, "p1", 'bufproto', ~ins.recBufs, 'bit00', true
);


Pdef('matrix', Ppar([ Pdef('b08'), Pdef('r01'), Pdef('b07'), Pdef('b02'), Pdef('b06'), Pdef('p00'), Pdef('p01'), Pdef('b11'), Pdef('b12') ]))


Pdef('matrix', Ppar( [Pdef('p00'), Pdef('p01') ]))

~matrix.defsAt('p00').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.2, 0.7) },
	{ exprand(0.5, 1.0) },
	0.1
);

~matrix.defsAt('p01').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.3, 0.6) },
	{ exprand(0.5, 2.0) },
	0.1
);

SparseMatrix
Pdef('matrix').clear




s.record


s.queryAllNodes

Server.killAll

FoaDecoder

SparseMatrix

s.record

s.stopRecording


(
~gespaths = (Paths.soundDir +/+ "evolver/wrp/*").pathMatch;
~gesbufs = GESBufferLoader(~gespaths);
)

~gesbufs.size

s.scope(2)

~matrix.setBPM(127)

(
~freqs = Array.twinPrimes(47, 1001).select({|it, i| it.odd });
~ranges = ~freqs.clump((~freqs.size/3).floor);

SynthDef('prsine', {|out, efx, freq, amp, dur, ang|
	var sig, bf;
	sig = SinOsc.ar([freq, freq + 2]) *
	EnvGen.kr(Env.perc, timeScale: dur, doneAction: 2);
	bf = FoaEncode.ar(Mix(sig), FoaEncoderMatrix.newDirection);
	bf = FoaRotate.ar(bf, ang);
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
}).play(~matrix.decoder.synth, ['out', ~matrix.decoder.bus, 'in'], \addBefore)

)

~rev.free


(
~matrix.onsetFunc_({
	if (0.3.coin) {
		Synth.before(~rev, 'prsine', ['out', ~decoder.bus, 'efx', ~sinebuss, 'freq', ~ranges[0].choose, 'amp', 0.1.rand, 'dur', 0.3, 'ang', rrand(-pi, pi)]);
	};
	if (0.3.coin) {
		Synth.before(~rev, 'prsine', ['out', ~decoder.bus, 'efx', ~sinebus, 'freq', ~ranges[1].choose, 'amp', 0.1.rand, 'dur', 0.2, 'ang', rrand(-pi, pi)]);
	};
	if (0.1.coin) {
		Synth.before(~rev, 'prsine', ['out', ~decoder.bus, 'efx', ~sinebuss, 'freq', ~ranges[2].choose, 'amp', 0.1.rand, 'dur', 0.1, 'ang', rrand(-pi, pi)]);
	};
});
)

~matrix.onsetFunc_({})


(
~wrp0 = Synth.tail(~matrix.group, 'wrprevm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[70], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

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

~wrp0.set('amp', 1.0, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.3, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.125)

~wrp0.free; Pdef('swrp0').clear



(
~wrp1 = Synth.tail(~matrix.group, 'wrprevm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[77], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

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

~wrp1.set('amp', 1.0, 'wamp', 0.2, 'iamp', 0.0, 'ramp', 0.3, 'rate', 0.25, 'freq', 1, 'wrp', 0.125)


~wrp1.free; Pdef('swrp1').clear



(
~wrp2 = Synth.tail(~matrix.group, 'revwrpm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[76], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

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

~wrp2.set('amp', 1.0, 'wamp', 0.0, 'iamp', 0.3, 'ramp', 0.0, 'rate', 0.25, 'freq', 0.25, 'wrp', 0.125)

~wrp2.free; Pdef('swrp2').clear

// for hackpact 10, 12, 13, 15

// 10 & 24 & 15
// 27, 30, 35, 39, 40, 44

(
~ind = 69;
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

~wrp3.set('amp', 1.0, 'wamp', 0.0, 'iamp', 0.1, 'ramp', 0.0, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.125)

~wrp3.free; Pdef('swrp3').clear

s.queryAllNodes


Pdef('matrix', Ppar([ Pdef('b02'), Pdef('r02'), Pdef('b04'), Pdef('b07'), Pdef('b08'), Pdef('b12'), Pdef('b10'), Pdef('b11') ]))


Pdef('matrix', Ppar([ Pdef('r01'), Pdef('r02') ]))




~matrix.defsAt('b07').setActives(nil, { rrand(0.1, 0.01) });
~matrix.defsAt('b10').setActives(nil, { rrand(0.1, 0.01) });
~matrix.defsAt('b11').setActives(nil, { rrand(0.1, 0.01) });
~matrix.defsAt('b12').setActives(nil, { rrand(0.1, 0.01) });
~matrix.defsAt('b08').setActives(nil, { rrand(0.1, 0.01) });
~matrix.defsAt('r01').setActives(nil, { rrand(0.1, 0.01) });
~matrix.defsAt('b02').setActives(nil, { rrand(0.1, 0.01) });


['p00'].do({|name|
	~matrix.defsAt(name).setActives(nil, { rrand(0.05, 0.01) });
})


['p00'].do({|name|
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


~matrix.defsAt('r06').recall(0);

~matrix.defsAt('b02').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.3, 1.0) },
	{ exprand(0.05, 0.3) },
	0.1
);

~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([0.85, 0.15]) },
	{ exprand(0.2, 0.5) },
	{ exprand(0.05, 0.1) },
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
	{ exprand(0.3, 0.8) },
	{ exprand(0.1, 0.3) },
	0.1
);
)



~matrix.defsAt('b12').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.3, 1.0) },
	{ exprand(0.1, 0.2) },
	0.1
);

~matrix.defsAt('b11').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 0.9) },
	{ exprand(0.1, 0.3) },
	0.1
);


~matrix.defsAt('b10').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.3, 0.9) },
	{ exprand(0.1, 0.3) },
	0.1
);


~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.3, 1.0) },
	{ exprand(0.01, 0.1) },
	0.1
);

~matrix.defsAt('r04').setControls(
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


~matrix.defsAt('b04').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.2, 0.6) },
	{ exprand(2.0, 4.0) },
	0.1
);


~matrix.hold



~matrix.defsAt('b06').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(2.0, 4.0) },
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


~matrix.addPatternBufferDef('b02', (64..127), 8, 4,
		['kpanilogo', 'yole', 'diansa', 'kokou', 'kakilambe', 'soli', 'mandiani'].reverse,
		2, "b2", 'bufproto', ~matrix.buffers.bits, 'bit01', true
	);

ctrls.select({|ctr| ctr.active == 1 }).postcs

s.record

s.stopRecording

~graphics = CinderApp(800, 600, mode: 0, path:"/Users/alo/dev/lambda/xcode/DerivedData/lambdaApp/Build/Products/Debug/lambda.app")

~graphics.open
~graphics.initWorld(19, 19, 19, 20);
~graphics.initGenerations([4,6],[4,6],17);

~graphics.setViewpoint(0.0, -100.0, 0.0, 0.0, 0.0, -20.0)

~graphics.setSymmetry(11)

~graphics.setPattern(6, 1, 1.0, 1, 1, 0.5, 0.9, 0.8);

~graphics.setPattern(22, 1, 0.7, 0, 0, 1.0, 0.0, 1.0);

~graphics.setPattern(12, 1, 0.7, 1, 1, 0.2, 0.4, 0.6);



~graphics.setPattern(9, 1, 1.0, 1, 1, 0.2, 0.9, 1.0);

// ~graphics.setPattern(10, 0, 1.0, 1, 1, 0.2, 0.2, 0.0);


~graphics.setPattern(13, 0, 1.0, 1, 1, 0.6, 0.7, 1.0);

~graphics.setPattern(14, 0, 1.0, 0, 1, 0.0, 1.0, 1.0);

~graphics.setPattern(19, 1, 1.0, 1, 0, 0.3, 0.4, 0.2);

~graphics.setPattern(20, 0, 0.3, 0, 0, 0.5, 0.9, 0.8);



(
~graphics.setViewpoint(0.0, 30.0, 0.0, 0.0, 0.0, 0.0);

~graphics.setPattern(2, 1, 1.0, 0, 0, 1.0, 1.0, 1.0);
)

~graphics.sendPredefined3DRule(\worms)

~graphics.sendPredefined3DRule(\sedimental)



(
Tdef(\sendVector, {
	loop({
		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		[ 0.0625, 0.125, 0.25].choose.wait;
	});
}).play;
)


['flangingDecimator', 'granularReverb', 'feedbackSpectrum', 'cyclicWarp', 'latchOnset', 'cliqSaw', 'fxGrain', 'arhythmicGendy']

~matrix.activateSkismSynth('latchOnset')

~matrix.setSkismAmp('latchOnset', 0.7)

~matrix.deactivateSkismSynth('latchOnset')



~matrix.activateSkismSynth('flangingDecimator')

~matrix.setSkismAmp('flangingDecimator', 0.4)

~matrix.deactivateSkismSynth('flangingDecimator')



~matrix.activateSkismSynth('cyclicWarp')

~matrix.setSkismAmp('cyclicWarp', 0.3)

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

Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.3, 0.7), 'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(20, 30)], 'dur', exprand(0.7, 3.0), 'env', [Env.perc, Env.sine].choose] );


(
Tdef('tex', {
	loop({
		Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.4, 0.7), 'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(100, 104)], 'dur', exprand(0.4, 0.9), 'env', [Env.perc, Env.sine].choose] );
		rrand(0.1, 0.4).wait
	})
})
.play
)

Tdef('tex').clear

Server.killAll

~matrix.buffers['evo'].size

Quarks.gui

x=SynthDef('test', { Out.ar(0, Dust.ar(30)) }).play
x.free


o=SynthDef('out34', {|amp=0.3| Out.ar([2, 3], SoundIn.ar([0, 1]) * amp) }).play
o.set('amp', 0.03)
o.free


SparseMatrix.allPatterns['Dalah']


Archive.global[\matrix][\presets]



~player.defnames.size.rand

~player.start(~foa)


~player.setFoa('zoom', 1.0)
~player.setFoa('push', 1.0)


// 38 niice

// 30

~ind0 = 70

~player.loadData(~ind0)

~player.play(~ind0, 0, ['zoom', 'push'].choose, 0)

~player.set(~ind0, 1.0);

~player.free(~ind0)



// 53 fuck yeah!!!!

// 271

~ind1 = 111

~player.loadData(~ind1)

~player.play(~ind1, 0, ['zoom', 'push'].choose, 0)

~player.set(~ind1, 1.0)

~player.free(~ind1)


// 249 sick!

~ind2 = 249

~player.loadData(~ind2)

~player.play(~ind2, 0, ['zoom', 'push'].choose, 0)

~player.set(~ind2, 0.0);

~player.free(~ind2)



// 32 whoop! pulse

~ind3 = 32

~player.loadData(~ind3)

~player.play(~ind3, 0, ['zoom', 'push'].choose, 0)

~player.set(~ind3, 0.1)

~player.free(~ind3)






s.queryAllNodes