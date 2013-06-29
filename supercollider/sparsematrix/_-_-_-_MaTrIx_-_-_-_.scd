~graphics = CinderApp(800, 600, mode: 0)
~decoder = FoaDecoder(decoderType: 'stereo');
~matrix = SparseMatrix(~decoder, ~graphics).assignCodeWindow(Document.current);

~matrix.prepareAudio

~decoder.test
~decoder.stopTest
s.queryAllNodes


~graphics.initWorld(20, 20, 20, 8);

~graphics.initGenerations([4,6,8], [3,5,7,9], 16);

~graphics.setSymmetry(11)

~matrix.preparePatternDefs;

~matrix.setBPM(135)

~matrix.collectPatternKeys

Pdef('matrix', Ppar([Pdef('r00'), Pdef('r03'), Pdef('efx')]))

Pdef('matrix').play

~matrix.defsAt('r00').setControls(
	{ [0, 1].wchoose([0.5, 0.5]) },
	{ rrand(0.1, 0.7) },
	{ rrand(0.01, 0.2) }
)

~matrix.defsAt('r00').recall(0)

~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([0.4, 0.6]) },
	{ rrand(0.1, 0.7) },
	{ rrand(0.01, 0.2) }
)

~matrix.defsAt('r01').recall(0)


~matrix.defsAt('r02').setControls(
	{ [0, 1].wchoose([0.5, 0.5]) },
	{ rrand(0.1, 0.7) },
	{ rrand(0.01, 0.1) }
)

~matrix.defsAt('r02').recall(0)



~matrix.defsAt('r03').setControls(
	{ [0, 1].wchoose([0.4, 0.6]) },
	{ exprand(0.1, 0.7) },
	{ exprand(0.04, 0.2) }
)

~matrix.defsAt('r03').recall(0)

s.queryAllNodes

~matrix.efxamps['rev00'] = 0.4
~matrix.efxamps['rev01'] = 1.0
~matrix.efxamps['del00'] = 0.0
~matrix.efxamps['del01'] = 0.0


~matrix.activateSkismSynth('granularReverb')

~matrix.setSkismAmp('granularReverb', 0.3)

~matrix.deactivateSkismSynth('granularReverb')


~matrix.activateSkismSynth('flangingDecimator')

~matrix.setSkismAmp('flangingDecimator', 0.3)

~matrix.deactivateSkismSynth('flangingDecimator')


~matrix.activateSkismSynth('neuralFilter')

~matrix.setSkismAmp('neuralFilter', 0.1)

~matrix.deactivateSkismSynth('neuralFilter')


~matrix.activateSkismSynth('feedbackSpectrum')

~matrix.setSkismAmp('feedbackSpectrum', 0.2)

~matrix.deactivateSkismSynth('feedbackSpectrum')


~matrix.activateSkismSynth('cyclicWarp')

~matrix.setSkismAmp('cyclicWarp', 0.3)

~matrix.deactivateSkismSynth('cyclicWarp')


~matrix.activateSkismSynth('latchOnset')

~matrix.setSkismAmp('latchOnset', 0.6)

~matrix.deactivateSkismSynth('latchOnset')


~matrix.activateSkismSynth('cliqSaw')

~matrix.setSkismAmp('cliqSaw', 0.2)

~matrix.deactivateSkismSynth('cliqSaw')


~matrix.activateSkismSynth('fxGrain')

~matrix.setSkismAmp('fxGrain', 0.6)

~matrix.deactivateSkismSynth('fxGrain')


~matrix.activateSkismSynth('arhythmicGendy')

~matrix.setSkismAmp('arhythmicGendy', 0.6)

~matrix.deactivateSkismSynth('arhythmicGendy')


~graphics.setViewpoint(40.0, 40.0, 0.0, 0.0, 0.0, 0.0);

~graphics.setPattern(9, 1, 1.0, 0, 0, 0.6, 0.7, 0.9);



~rot = Rotation(40.0, 0.01, 20.0, 60.0, 0.0, 0.02, 0.0, 0.02);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);

~graphics.rotateCamera;

Pdef('matrix').stop
