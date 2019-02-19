(~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 1, screenX: 1024, screenY: 768, mode: 1, decoderType: 'stereo', 'localDecoder': true, bpm: 140, channels: 4, foa: #[zoom,push], dbname: "ges_ld_00", patdefs: "patternDefsOto.scd", initPdefs: ['b03', 'b04', 'b05', 'b06'], worldDim: 21, ip: "127.0.0.1");

e = SpEnvir(~settings))

Server.killAll

~gesbufs = GESBufferLoader().loadByDate("161224")
~gesbufs.preload

~matrix.setBPM(143)

SynthDef('addsin', {|out, amp, dur, rx, ry, rz|
	var sig, freqs, amps, env, n = 5, bf;
	freqs = ArrayControl.kr('freqs', n, 1);
	amps = ArrayControl.kr('amps', n, 0);
	env = EnvControl.kr;
	sig = Mix.fill(freqs.size, {|i|
		DelayC.ar(SinOsc.ar(freqs[i], 0, amps[i]), 0.05, Rand(0.01, 0.05))
		* EnvGen.kr(env, timeScale: dur * Rand(0.8, 0.95), doneAction: 2);
	});
	Line.kr(dur: dur, doneAction: 2);
	bf = FoaTransform.ar(
		FoaEncode.ar(sig * amp, FoaEncoderMatrix.newDirection),
		'rtt', rx, ry, rz
	);
	Out.ar(out, bf)
}).add;

~seq = [ [ 479, 599, 701, 823, 941 ], [ 653, 769, 883, 1013, 1117 ], [ 419, 521, 631, 743, 859 ], [ 709, 827, 947, 1061, 1187 ], [ 463, 587, 683, 811, 929 ] ];

~seq = ~seq.collect({|chord| chord.collect({|freq| Array.primeSeries(2, freq, 43).last }) })

~envs = [Env.perc, Env.sine, Env([0.001, 1.0, 1.0, 0.001], [0.8, 0.1, 0.1], [3])].collect(_.bubble);

Pdef('c00',
	Pbind('instrument', 'addsin', 'out', ~matrix.decoder.bus, 'target', ~matrix.group,
		'amp', Pwhite(0.3, 0.5), 'dur', Pwhite(0.4, 1.0) , 'amps', Array.geom(5, 1.0, 13/21).bubble,
		'freqs', Pseq(~seq.collect(_.bubble), inf), 'env', Pwrand(~envs, [1.0, 0.0, 0.0], inf),
		'delta', Pwrand([0.4, 0.8, 1.6] * 2.0, [0.3, 0.2, 0.5], inf),
		'rx', Pwhite(0, 2pi, inf), 'ry', Pwhite(0, 2pi, inf), 'rz', Pwhite(0, 2pi, inf)
	)
)

Pdef('c00').play

Pdef('c00').clear

~rev = SynthDef('reverb', {arg revamp=0.01, dry=0.8, revtime=0.5;
	var sig;
	sig = In.ar(0, ~matrix.decoder.numChannels);
	ReplaceOut.ar(0, GVerb.ar(sig, 150, revtime, drylevel: dry, earlyreflevel: revamp))
}).play(~matrix.decoder.synth, nil, \addAfter)

~rev.free

~rev.set('revamp', 1.0, 'revtime', 1.9, 'dry', 0.4)


// 0, 2, 3 (high), 5, 7, 8 (sub), 9, 12, 13 (cool upwards glissando bleeps)


(
~wrp0 = Synth.tail(~matrix.group, 'wrprevm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[39], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

Pdef('swrp0',
	Pbind(
		\type, \set, \id, ~wrp0.nodeID, \delta, Pn(0.2, inf),
		\rx, Pbrown(0, 2pi, 0.125pi, inf),
		\ry, Pbrown(0, 2pi, 0.125pi, inf),
		\rz, Pbrown(0, 2pi, 0.125pi, inf),
		\args, #[rx, ry, rz]
	)
).play
)

~wrp0.set('amp', 1.0, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 1.0, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.1)

~wrp0.free; Pdef('swrp0').clear


(
~wrp1 = Synth.tail(~matrix.group, 'wrprevm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[16], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

Pdef('swrp1',
	Pbind(
		\type, \set, \id, ~wrp1.nodeID, \delta, Pn(0.2, inf),
		\rx, Pbrown(0, 2pi, 0.125pi, inf),
		\ry, Pbrown(0, 2pi, 0.125pi, inf),
		\rz, Pbrown(0, 2pi, 0.125pi, inf),
		\args, #[rx, ry, rz]
	)
).play
)

~wrp1.set('amp', 1.0, 'wamp', 0.0, 'iamp', 1.0, 'ramp', 0.0, 'rate', 0.25, 'freq', 0.5, 'wrp', 0.1)

~wrp1.free; Pdef('swrp1').clear



(
~wrp2 = Synth.tail(~matrix.group, 'revwrpm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[20], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

Pdef('swrp2',
	Pbind(
		\type, \set, \id, ~wrp2.nodeID, \delta, Pn(0.2, inf),
		\rx, Pbrown(0, 2pi, 2pi/16, inf),
		\ry, Pbrown(0, 2pi, 2pi/16, inf),
		\rz, Pbrown(0, 2pi, 2pi/16, inf),
		\args, #[rx, ry, rz]
	)
).play
)

~wrp2.set('amp', 1.0, 'wamp', 0.0, 'iamp', 1.0, 'ramp', 0.0, 'rate', 0.25, 'freq', 0.25, 'wrp', 0.25)

~wrp2.free; Pdef('swrp2').clear

(
~ind = 19;
~wrp3 = Synth.tail(~matrix.group, 'wrprevm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[~ind], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

Pdef('swrp3',
	Pbind(
		\type, \set, \id, ~wrp3.nodeID, \delta, Pn(0.2, inf),
		\rx, 0,
		\ry, 0,
		\rz, 0,
		\args, #[rx, ry, rz]
	)
).play;

)

~wrp3.set('amp', 1.0, 'wamp', 0.0, 'iamp', 0.2, 'ramp', 0.0, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.4)

~wrp3.free; Pdef('swrp3').clear


Pdef('matrix', Ppar([ Pdef('r02'), Pdef('r03'), Pdef('r07'), Pdef('b06')]))



~matrix.defsAt('r02').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 2.0) },
	{ exprand(0.01, 0.05) },
	0.1
);

~matrix.defsAt('r03').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.01, 0.05) },
	0.1
);

~matrix.defsAt('r07').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.8, 1.0) },
	{ exprand(0.2, 0.5) },
	0.1
);

Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.4, 0.7), 'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(50, 45)], 'dur', exprand(0.7, 3.0), 'env', [Env.perc, Env.sine].choose] );

s.record

s.stopRecording

~matrix.defsAt('b03').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.6, 0.8) },
	{ exprand(0.2, 0.4) },
	0.1
);

~matrix.defsAt('b04').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.1, 0.4) },
	{ exprand(3.0, 6.0) },
	0.1
);

~matrix.defsAt('b06').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.4, 0.8) },
	{ exprand(1.0, 4.0) },
	0.1
);


~matrix.defsAt('b05').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.6, 0.9) },
	{ exprand(0.1, 0.4) },
	0.1
);

~matrix.defsAt('b04').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.7, 1.0) },
	{ exprand(2.0, 3.0) },
	0.1
);

~matrix.defsAt('r02').recall(0);

~matrix.defsAt('r03').recall(0)

ctrls.select({|ctr| ctr.active == 1 }).postcs

s.record

s.stopRecording

~graphics = CinderApp(800, 600, mode: 1, path:"/Users/alo/dev/lambda/xcode/DerivedData/lambdaApp/Build/Products/Debug/lambda.app")

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

~matrix.setSkismAmp('latchOnset', 1.0)

~matrix.deactivateSkismSynth('latchOnset')



~matrix.activateSkismSynth('arhythmicGendy')

~matrix.setSkismAmp('arhythmicGendy', 0.6)

~matrix.deactivateSkismSynth('arhythmicGendy')



~matrix.activateSkismSynth('cliqSaw')

~matrix.setSkismAmp('cliqSaw', 0.3)

~matrix.deactivateSkismSynth('cliqSaw')




SynthDef(\bitSt2, {|out, efx, amp, emp, buf, dur|
	var sig;
	sig = Normalizer.ar(
		PlayBuf.ar(2, buf, BufRateScale.ir(buf) * 1.neg, 1, BufFrames.kr(buf)),
		amp) * EnvGen.kr(\env.kr(Env.newClear(8).asArray), timeScale: dur, doneAction: 2);
	Out.ar(efx, sig * emp);
	Out.ar(out, sig * amp)
}).add;

Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.3, 0.5), 'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(50, 65)], 'dur', exprand(0.7, 3.0), 'env', [Env.perc, Env.sine].choose] );


Tdef('tex').clear

, {
	loop({
		Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.4, 0.8), 'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(50, 45)], 'dur', exprand(0.3, 0.7), 'env', [Env.perc, Env.sine].choose] );
		rrand(0.1, 0.4).wait
	})
})
.play


Server.killAll


Quarks.gui

x=SynthDef('test', { Out.ar(0, Dust.ar(30)) }).play
x.free


o=SynthDef('out34', {|amp=0.3| Out.ar([2, 3], SoundIn.ar([0, 1]) * amp) }).play
o.set('amp', 0.03)
o.free


SparseMatrix.allPatterns['Dalah']