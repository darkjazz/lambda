~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2, screenX: 1024, screenY: 768, mode: 1, ip: "127.0.0.1", decoderType: 'stereo', bpm: 140, channels: 2, foa: #[zoom,push], dbname: "ges_02", patdefs: "patternDefsAppend.scd", initPdefs: ['r00', 'r01', 'b00', 'b06'], worldDim: 23);

e = SpEnvir(~settings)

e.initGraphics(false)

s.queryAllNodes

s.quit

~sender.registerDocument(Document.current)

~matrix.setBPM(143)


Pdef('matrix', Ppar([ Pdef('r02'), Pdef('r03'), Pdef('r04'), Pdef('b05'), Pdef('b04')]))

Pdef('matrix', Ppar([Pdef('r00')]))

Pdef('efx').stop

~matrix.efxamps['efx0'] = 0.01

s.record

s.stopRecording


(0..31).do({|index|
	var efxkeys = ['efx3'].select({ 0.3.coin });
	~matrix.defsAt('r00').setEfx(index, efxkeys)
})


(0..31).do({|index|
	var efxkeys = ['efx5'].select({ 0.3.coin });
	~matrix.defsAt('r01').setEfx(index, efxkeys)
})


(0..31).do({|index|neuralFilter
	var efxkeys = ['efx1'].select({ 0.3.coin });
	~matrix.defsAt('b03').setEfx(index, efxkeys)
})


~defs['r00'].ctrls['r001'].active = 1
~defs['r00'].ctrls['r001'].amp = 2
~defs['r00'].ctrls['r001'].dur = 0.1


~defs['r01'].ctrls['r101'].active = 1
~defs['r01'].ctrls['r101'].amp = 1.3
~defs['r01'].ctrls['r101'].dur = 0.2


~defs['r00'].setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.4, 2.0) },
	{ exprand(0.01, 0.1) },
	0.1
);

~defs['r01'].setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.3, 2.0) },
	{ exprand(0.04, 0.1) },
	0.1
);


~defs['b05'].setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.4, 2.0) },
	{ exprand(0.2, 0.6) },
	0.1
);

~defs['b04'].setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.2, 1.4) },
	{ exprand(0.1, 0.6) },
	0.1
);

~defs['r04'].setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.2, 1.4) },
	{ exprand(0.05, 0.1) },
	0.1
);


~defs['r03'].recall(0)

~defs['b06'].setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ exprand(0.5, 2.0) },
	{ exprand(1.0, 3.0) },
	0.1
)

~defs['b04'].setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.3, 1.0) },
	{ exprand(1.0, 4.0) },
	0.1
)


~matrix.buffers.evo

Pdef('efx').play

Pdef('efx').stop

s.scope

e.automateGraphics


e.clearAutoGraphics

~defnames.size

~matrix.prepareGepDefs(~defnames.keep(192), ~loader);

~defnames.do(_.postln)


~player.start(~foa)

~player.setFoa('zoom', 1.0)
~player.setFoa('push', 1.0)


~ind1 = 0


~player.play(~ind1, 0, 'zoom', 0)

~player.set(~ind1, 0.5)


~player.free(~ind1)


~ind2 = 1

~player.play(~ind2, 0, 'push', 0)

~player.set(~ind2, 0.3)

~player.free(~ind2)



~ind3 = 5

~player.play(~ind3, 0, 'zoom', 0)

~player.set(~ind2, 0.2)

~player.free(~ind2)


[neuralFilter,granularReverb,latchOnset,cliqSaw,flangingDecimator,feedbackSpectrum,cyclicWarp,fxGrain,arhythmicGendy]

~matrix.activateSkismSynth('latchOnset')

~matrix.setSkismAmp('latchOnset', 1.0)

~matrix.deactivateSkismSynth('latchOnset')



~wrp0 = Synth('wrprev', ['out', 0, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 30, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][0], 'amp', 0.0])

Pdef('swrp0',
	Pbind(
		\type, \set,
		\id, ~wrp0.nodeID,
		\amp, Pseq([0.3, 0.1, 0.3, 0.2, 0.1], inf),
		\iamp, Pseq([0.1, 0.2, 0.0, 0.2, 0.1]),
		\rate, Pseq([0.25, 2.0, 0.5], inf),
		\freq, Pfunc({|ev| ev.rate.reciprocal }),
		\delta, Pseq([5, 7, 3, 5, 3, 7] * ~matrix.beatdur, inf),
		\args, #[amp, iamp, rate, freq]
	)
)

Pdef('swrp0').play


~wrp0.set('amp', 0.3, 'iamp', 0.0, 'rate', 1.0, 'freq', 1.0)

~wrp0.free

~wrp1 = Synth('revwrp', ['out', 0, 'rate', 0.5, 'start', 0, 'wrp', 0.1, 'freq', 2.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 40, 'rtime', 12.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][9], 'amp', 0.0])

~wrp1.set('amp', 0.4, 'iamp', 0.5, 'freq', 1.0, 'rate', 0.5, 'wrp', 0.1)
~wrp1.free



~wrp2 = Synth('revwrp', ['out', 0, 'rate', 0.5, 'start', 0, 'wrp', 0.1, 'freq', 2.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 40, 'rtime', 12.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][33], 'amp', 0.0])

~wrp2.set('iamp', 0.0, 'amp', 0.05, 'rate', 1.0, 'freq', 0.5)
~wrp2.free


~wrp3 = Synth('wrprev', ['out', 0, 'rate', 0.5, 'start', 0, 'wrp', 0.1, 'freq', 2.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 40, 'rtime', 12.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][11], 'amp', 0.0])

~wrp3.set('iamp', 0.0, 'amp', 0.0, 'rate', 0.5, 'freq', 0.5)
~wrp3.free
