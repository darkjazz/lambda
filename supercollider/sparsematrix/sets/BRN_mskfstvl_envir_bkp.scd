~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2, screenX: 1024, screenY: 768, mode: 1, ip: "127.0.0.1", decoderType: 'stereo', bpm: 140, channels: 2, foa: #[zoom,push], dbname: "ges_02", patdefs: "patternDefsAppend.scd", initPdefs: ['g02', 'g03', 'b03', 'b04'], worldDim: 17);

e = SpEnvir(~settings)

e.initGraphics(false)

s.queryAllNodes

s.quit

~sender.registerDocument(Document.current)

~matrix.setBPM(113)

Pdef('matrix', Ppar([ Pdef('g02'), Pdef('g03'), Pdef('b03'), Pdef('b04')]))

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


(0..31).do({|index|
	var efxkeys = ['efx1'].select({ 0.3.coin });
	~matrix.defsAt('b03').setEfx(index, efxkeys)
})


~defs['g02'].setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.2, 0.8) },
	{ exprand(0.5, 2.0) },
	0.1
);

~defs['g03'].setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.2, 1.0) },
	{ exprand(0.8, 2.0) },
	0.1
);

~defs['b03'].setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.3, 0.8) },
	0.1
);

~defs['b04'].setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 0.8) },
	{ exprand(0.4, 1.0) },
	0.1
)

13*60

~defs['b03'].recall(0)

~defs['b03'].setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ exprand(0.1, 2.0) },
	{ exprand(0.3, 0.8) },
	0.1
)


~matrix.buffers.evo

Pdef('efx').play

Pdef('efx').stop

s.scope

e.automateGraphics

e.clearAutoGraphics

~matrix.prepareGepDefs(~defnames, ~loader);




~player.start(~foa)

~player.setFoa('zoom', 1.0)
~player.setFoa('push', 1.0)


~ind1 = 0


~player.play(~ind1, 0, 'zoom', 0)

~player.set(~ind1, 0.4)


~player.free(~ind1)


~ind2 = 1

~player.play(~ind2, 0, 'push', 0)

~player.set(~ind2, 0.2)

~player.free(~ind2)



[neuralFilter,granularReverb,latchOnset,cliqSaw,flangingDecimator,feedbackSpectrum,cyclicWarp,fxGrain,arhythmicGendy]

~matrix.activateSkismSynth('latchOnset')

~matrix.setSkismAmp('latchOnset', 0.1)

~matrix.deactivateSkismSynth('latchOnset')


