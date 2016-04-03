~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2, screenX: 1024, screenY: 768, mode: 1, ip: "127.0.0.1", decoderType: 'stereo', bpm: 140, channels: 2, foa: #[zoom,push], dbname: "ges_02", patdefs: "patternDefsAppend.scd", initPdefs: ['r02', 'r03', 'r04', 'r05'], worldDim: 23);

e = SpEnvir(~settings)

e.initGraphics(false)

s.queryAllNodes

s.quit

~sender.registerDocument(Document.current)

~matrix.setBPM(140)

Tdef('fuckbpm', {
	loop({
		~matrix.setBPM(rrand(60, 160));
		(~matrix.beatdur * rrand(0.5, 4)).wait
	})
}).play

Tdef('fuckbpm').stop


Pdef('matrix', Ppar([ Pdef('r05'), Pdef('r06'), Pdef('r07'), Pdef('b06')]))

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


~defs['r02'].setControls(
	{ [0, 1].wchoose([0.9, 0.1]) },
	{ exprand(0.3, 2.0) },
	{ exprand(0.1, 0.4) },
	0.1
);

~defs['r03'].setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.6, 2.0) },
	{ exprand(0.1, 0.2) },
	0.1
);


~defs['r00'].recall(0);

~defs['r01'].recall(0)

~defs['r04'].setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.4, 2.0) },
	{ exprand(0.07, 0.1) },
	0.1
);

~defs['r05'].setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ exprand(0.2, 2.0) },
	{ exprand(0.1, 0.03) },
	0.1
);

~defs['b00'].setControls(
	{ [0, 1].wchoose([0.5, 0.5]) },
	{ exprand(0.5, 2.0) },
	{ exprand(0.05, 0.2) },
	0.1
);


~defs['r01'].recall(0)

~defs['b06'].setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ exprand(0.5, 2.0) },
	{ exprand(0.2, 0.4) },
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

~matrix.activateSkismSynth('feedbackSpectrum')

~matrix.setSkismAmp('feedbackSpectrum', 0.5)

~matrix.deactivateSkismSynth('neuralFilter')

s.record

s.stopRecording

~matrix.buffers['evo'].collect(_.path).selectIndices({|item|
	item.find("_151228_").notNil.or(item.find("_151227_").notNil)
}).size

// added variable length recordings 27&28-12-15
[ 0, 5, 8, 10, 12, 14, 24, 28, 34, 35, 37, 38, 39, 41, 43, 47, 51, 54, 61, 63, 66,

	67, 71, 77, 82, 84, 86, 87, 91, 92, 93, 94, 95, 96, 97,

	98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127 ]


~wrp0 = Synth.tail(~matrix.group, 'wrprev', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 30, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][92], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])


~wrp0.set('amp', 0.0, 'wamp', 1.0, 'iamp', 0.7, 'ramp', 0.0, 'rate', 0.5, 'freq', 0.125, 'wrp', 0.1)

~wrp0.free

Pdef('swrp0',
	Pbind(
		\type, \set,
		\id, ~wrp0.nodeID,
		\rx, Pbrown(-pi, pi, pi/36),
		\ry, Pbrown(-pi, pi, pi/36),
		\rz, Pbrown(-pi, pi, pi/36),
		\args, #[rx, ry, rz]
	)
)

Pdef('swrp0').play

Pdef('swrp0').clear





~wrp1 = Synth.tail(~matrix.group, 'revwrp', ['out', ~decoder.bus, 'rate', 0.5, 'start', 0, 'wrp', 0.1, 'freq', 2.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 40, 'rtime', 12.0, 'ramp', 0.0, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][93], 'amp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])

~wrp1.set('amp', 0.0, 'iamp', 1.0, 'ramp', 0.0, 'freq', 1.0, 'rate', 0.5, 'wrp', 0.1)
~wrp1.free


Pdef('swrp1',
	Pbind(
		\type, \set,
		\id, ~wrp1.nodeID,
		\rx, Pwhite(-pi, pi, inf),
		\ry, Pwhite(-pi, pi, inf),
		\rz, Pwhite(-pi, pi, inf),
		\delta, 0.1,
		\args, #[rx, ry, rz]
	)
)

Pdef('swrp1').play

Pdef('swrp1').clear

//revwrp 56 + revwrp 63


~wrp2 = Synth('revwrp', ['out', 0, 'rate', 0.5, 'start', 0, 'wrp', 0.1, 'freq', 2.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 40, 'rtime', 12.0, 'ramp', 0.0, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][94], 'amp', 0.0])

~wrp2.set('iamp', 1.0, 'amp', 0.0, 'ramp', 0.01, 'rate', 1.0, 'freq', 1.0)
~wrp2.free

Pdef('swrp2',
	Pbind(
		\type, \set,
		\id, ~wrp2.nodeID,
		\rx, Pwhite(-pi, pi, inf),
		\ry, Pwhite(-pi, pi, inf),
		\rz, Pwhite(-pi, pi, inf),
		\args, #[rx, ry, rz]
	)
)


~wrp3 = Synth('wrprev', ['out', 0, 'rate', 0.5, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 80, 'rtime', 8.0, 'ramp', 0.0, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][63], 'amp', 0.0])

~wrp3.set('iamp', 0.0, 'wamp', 0.0, 'amp', 0.2, 'rate', 0.5, 'freq', 0.5, 'rx', 0, 'rz', 0)
~wrp3.free


s.queryAllNodes

s.sendMsg("/n_free", 1018)