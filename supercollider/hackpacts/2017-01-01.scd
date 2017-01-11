~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2, screenX: 1024, screenY: 768, mode: 1, decoderType: 'stereo', bpm: 140, channels: 2, foa: #[zoom,push], dbname: "ges_ld_00", patdefs: "patternDefsAppendLnx.scd", initPdefs: ['r04', 'r05', 'r06', 'r07', 'b02'], worldDim: 21, ip: "127.0.0.1");

e = SpEnvir(~settings)

e.initGraphics(true)

~matrix.setBPM(167)

Tdef('fuckbpm').clear

Tdef('fuckbpm', {
	loop({
		~matrix.setBPM(rrand(30, 200).round(30));
		rrand(0.1, 2.0).wait
	})
}).play


s.queryAllNodes

~matrix.defsAt('b02').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.5) },
	{ exprand(0.1, 0.3) },
	0.1
);

~matrix.defsAt('b02').recall(0)

~matrix.defsAt('r04').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.3, 1.0) },
	{ exprand(0.05, 0.1) },
	0.1
);

~matrix.defsAt('r04').recall(0)

~matrix.defsAt('r05').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.1, 1.0) },
	{ exprand(0.02, 0.1) },
	0.1
);

~matrix.defsAt('r05').recall(0)

~matrix.defsAt('r06').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.04, 0.1) },
	0.1

);

~matrix.defsAt('r06').recall(0)

~matrix.defsAt('r07').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.04, 0.1) },
	0.1

);

~matrix.defsAt('r07').recall(0)

s.queryAllNodes


Pdef('matrix', Ppar([ Pdef('r04'), Pdef('r05'), Pdef('r06'), Pdef('r07'), Pdef('b02')]))


s.record

s.stopRecording

s.scope(2)

['flangingDecimator', 'granularReverb', 'feedbackSpectrum', 'cyclicWarp', 'latchOnset', 'cliqSaw', 'fxGrain', 'arhythmicGendy']

~matrix.activateSkismSynth('latchOnset')

~matrix.setSkismAmp('latchOnset', 0.7)

~matrix.deactivateSkismSynth('latchOnset')



~matrix.activateSkismSynth('arhythmicGendy')

~matrix.setSkismAmp('arhythmicGendy', 0.2)

~matrix.deactivateSkismSynth('arhythmicGendy')



~matrix.activateSkismSynth('cliqSaw')

~matrix.setSkismAmp('cliqSaw', 0.0)

~matrix.deactivateSkismSynth('cliqSaw')


~graphics = CinderApp(800, 450, mode: 0, path:"/Users/alo/dev/lambda/xcode/DerivedData/lambdaApp/Build/Products/Debug/lambda.app")


~graphics.open
~graphics.initWorld(17, 17, 17, 20);
~graphics.initGenerations([4,6],[4,6],16);
~graphics.setSymmetry(11)
~graphics.setViewpoint(80.0, 80.0, 80.0, 0.0, 0.0, 0.0)

Tdef(\sendVector).clear

, {
	loop({
		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		[ 0.25, 0.125, 0.5].choose.wait;
	});
}).play;

~graphics.setFrameRate(13.0)


s.queryAllNodes

s.record


s.stopRecording

~wrp0 = Synth.tail(~matrix.group, 'wrprev', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][69], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])


~wrp0.set('amp', 0.4, 'wamp', 0.3, 'iamp', 0.9, 'ramp', 0.0, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.1)


~wrp0.free

(
Pdef('swrp0',
	Pbind(
		\type, \set,
		\id, ~wrp0.nodeID,
		\wamp, Pseq([0.5, 0.0, 0.2, 0.0], inf),
		\iamp, Pseq([0.0, 0.4, 0.0, 0.0, 0.0], inf),
		\freq, Pseq([0.5, 0.25], inf),
		\wrp, Pseq([0.1, 0.2], inf),
		\delta, Prand([1, 2, 4] * ~matrix.beatdur, inf),
		\args, #[wamp, iamp, freq, wrp]
	)
)
)

Pdef('swrp0').play

Pdef('swrp0').stop

Server.killAll

~wrp1 = Synth.tail(~matrix.group, 'revwrp', ['out', ~decoder.bus, 'rate', 0.5, 'start', 0, 'wrp', 0.1, 'freq', 2.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 40, 'rtime', 12.0, 'ramp', 0.5, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][17], 'amp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])

~wrp1.set('amp', 0.2, 'wamp', 0.5, 'iamp', 0.5, 'ramp', 0.4, 'freq', 1.0, 'rate', 1.0, 'wrp', 0.1)

~wrp1.free


~wrp2 = Synth.tail(~matrix.group, 'revwrp', ['out', ~decoder.bus, 'rate', 0.5, 'start', 0, 'wrp', 0.1, 'freq', 2.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 40, 'rtime', 12.0, 'ramp', 0.0, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][14], 'amp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])

~wrp2.set('amp', 0.0, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.5, 'freq', 1.0, 'rate', 1.0, 'wrp', 0.1)

~wrp2.free



~wrp3 = Synth.tail(~matrix.group, 'wrprev', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 30, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][13], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])


~wrp3.set('amp', 0.0, 'wamp', 0.1, 'iamp', 0.0, 'ramp', 0.3, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.1)

~wrp3.free


Server.default.queryAllNodes

Server.killAll