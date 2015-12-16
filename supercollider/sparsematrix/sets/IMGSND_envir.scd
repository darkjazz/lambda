~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2, screenX: 1024, screenY: 768, mode: 1, ip: "192.168.1.100", decoderType: 'stereo', bpm: 140, channels: 2, foa: #[zoom,push], dbname: "ges_02", patdefs: "patternDefsAppend.scd", initPdefs: ['r00', 'r01', 'b00', 'b06'], worldDim: 23);

e = SpEnvir(~settings)

e.initGraphics(false)

s.queryAllNodes

s.quit

~sender.registerDocument(Document.current)

~matrix.setBPM(143)

Pdef('matrix', Ppar([ Pdef('r04'), Pdef('r06'), Pdef('r07'), Pdef('b04')]))

Pdef('matrix', Ppar([Pdef('r01'), Pdef('r00'), Pdef('b05')]))

Pdef('efx').play

~matrix.efxamps['efx5'] = 0.3

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


~defs['r04'].setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ exprand(1.0, 2.0) },
	{ exprand(0.01, 0.1) },
	0.1
);

~defs['r06'].setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(1.0, 2.0) },
	{ exprand(0.01, 0.2) },
	0.1
);


~defs['r07'].setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ exprand(0.4, 2.0) },
	{ exprand(0.01, 0.2) },
	0.1
);

~defs['b04'].setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ exprand(0.2, 0.8) },
	{ exprand(0.3, 0.6) },
	0.1
);

~defs['r00'].recall(0)

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
5
~matrix.setSkismAmp('latchOnset', 1.0)

~matrix.deactivateSkismSynth('latchOnset')


