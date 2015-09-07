~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2, screenX: 1024, screenY: 768, mode: 1, ip: "192.168.0.7", decoderType: 'stereo', bpm: 140, channels: 2, foa: #[zoom,push], dbname: "ges_02", patdefs: "patternDefsAppend.scd", initPdefs: ['r00', 'r01', 'r02', 'b02'], worldDim: 17);


e = SpEnvir(~settings)

e.initGraphics(false)

s.queryAllNodes

s.scope

s.quit

~matrix.setBPM(149)

Pdef('matrix', Ppar([ Pdef('g00'), Pdef('g01'), Pdef('b01'), Pdef('b02')]))


~defs['r00'].setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ exprand(0.5, 2.0) },
	{ exprand(0.01, 0.2) },
	0.1
);

~defs['r01'].setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ exprand(0.5, 2.0) },
	{ exprand(0.05, 0.1) },
	0.1
)

~defs['r01'].recall(0)

~defs['b02'].setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ exprand(0.1, 2.0) },
	{ exprand(0.2, 0.5) },
	0.1
)


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

~matrix.activateSkismSynth('granularReverb')

~matrix.setSkismAmp('granularReverb', 0.1)

~matrix.deactivateSkismSynth('granularReverb')


