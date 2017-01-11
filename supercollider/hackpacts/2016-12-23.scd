~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2, screenX: 1024, screenY: 768, mode: 1, decoderType: 'stereo', bpm: 140, channels: 2, foa: #[zoom,push], dbname: "ges_ld_00", patdefs: "patternDefsAppendLnx.scd", initPdefs: ['b03', 'b05', 'b06'], worldDim: 21, ip: "127.0.0.1");

e = SpEnvir(~settings)

e.initGraphics(true)

~matrix.setBPM(133)


~wrp0 = Synth.tail(~matrix.group, 'wrprev', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][69], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])


~wrp0.set('amp', 0.4, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.5)

~wrp0.free

~wrp1 = Synth.tail(~matrix.group, 'revwrp', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][105], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])


~wrp1.set('amp', 0.7, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.8, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.5)


~wrp1.free


~wrp2 = Synth.tail(~matrix.group, 'wrprev', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][30], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])


~wrp2.set('amp', 0.4, 'wamp', 0.0, 'iamp', 1.0, 'ramp', 0.5, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.5)

~wrp2.free

s.queryAllNodes



~matrix.defsAt('m02').assignEfx(
	( efx1: (0..31))
)

~matrix.defsAt('m03').assignEfx(
	( efx5: (0..31))
)


~matrix.efxamps['efx1'] = 0.1

~matrix.defsAt('r03').assignEfx(
	(efx1: (0..31))
)

~matrix.efxamps['efx0'] = 0.1


~matrix.defsAt('b03').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.3, 0.7) },
	{ exprand(2.0, 4.0) },
	0.1
);

~matrix.defsAt('b05').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.1, 0.5) },
	{ exprand(1.0, 3.0) },
	0.0
);

~matrix.defsAt('b06').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.1, 0.4) },
	{ exprand(4.0, 6.0) },
	0.0
);

~matrix.defsAt('b03').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.1, 1.0) },
	{ exprand(0.2, 0.4) },
	0.1
);

~matrix.defsAt('b05').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.1, 0.4) },
	0.1
);

s.queryAllNodes

Server.killAll

~matrix.defsAt('r06').recall(0);

~matrix.defsAt('r00').recall(0);
~matrix.defsAt('r01').recall(0);

~matrix.defsAt('b03').recall(0);


~matrix.setBPM(140)

Pdef('matrix', Ppar([ Pdef('r05'), Pdef('r06'), Pdef('b04'), Pdef('m02'), Pdef('m03'), Pdef('efx')]))



['flangingDecimator', 'granularReverb', 'feedbackSpectrum', 'cyclicWarp', 'latchOnset', 'cliqSaw', 'fxGrain', 'arhythmicGendy']

~matrix.activateSkismSynth('latchOnset')

~matrix.setSkismAmp('latchOnset', 1.0)

~matrix.deactivateSkismSynth('latchOnset')




~graphics = CinderApp(800, 450)
~graphics.open
~graphics.initWorld(13, 13, 13, 20);
~graphics.initContinuous;
~graphics.setAdd(0.01);
~graphics.setSymmetry(11)


(
Tdef(\sendVector, {
	loop({
		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		[ 0.0625, 0.125, 0.25].choose.wait;
	});
}).play;
)

~rot = Rotation(60.0, 0.0, 60.0, 0.0, 0.0, 0.0, 0.0, 0.01);

~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera

~graphics.setPattern(0, 0, 1.0, 0, 0, 1.0, 0.0, 0.6);

~graphics.setPattern(10, 0, 1.0, 0, 0, 1.0, 1.0, 0.0);
~graphics.setPattern(17, 0, 1.0, 1, 1, 0.7, 1.0, 0.4);
~graphics.setPattern(22, 1, 1.0, 1, 1, 0.4, 0.8, 1.0);
~graphics.setPattern(25, 0, 1.0, 1, 1, 1.0, 1.0, 1.0);
