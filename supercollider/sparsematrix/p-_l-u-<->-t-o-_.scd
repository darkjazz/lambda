~nano = NanoKONTROL();
(
~geen = MikroGeen();
~graphics = CinderApp(1024, 768, mode: 0);
~decoder = FoaDecoder(decoderType:'stereo');
)

~graphics.open

~graphics.quit

~matrix = SparseMatrix(~decoder, ~graphics).assignCodeWindow(Document.current);

~fx = FxLambda(~decoder, ~graphics, ~geen, ~nano)

// f(x) start > button opens the graphics

MasterEQ(~decoder.numChannels)

s.queryAllNodes

~matrix.prepareAudio

~matrix.preparePatternDefs;

//~graphics.initWorld(20, 20, 20, 8);

~graphics.initGenerations([4,6,8], [3,5,7,9], 18);

~graphics.setSymmetry(11)

~graphics.setViewpoint(0.0, 60.0, 50.0, 0.0, 0.0, 0.0);

~matrix.setBPM(135); 
~fx.bpm = ~matrix.bpm;

~graphics.initContinuous;
~graphics.setAdd(0.05);
~graphics.resetWorld(9, 9, 9, 4, 4, 4);



Pdef('matrix', Ppar([ Pdef('c00'), Pdef('b01'), Pdef('b03'), Pdef('b04')]))

Pdef('matrix', Ppar([ Pdef('c00'), Pdef('r01'), Pdef('b03'), Pdef('b04')]))

Pdef('matrix', Ppar([ Pdef('r01'), Pdef('r02'), Pdef('b02'), Pdef('efx') ]))

Pdef('matrix', Ppar([ Pdef('r02'), Pdef('b00'), Pdef('b03'), Pdef('b04') ]))

Pdef('matrix', Ppar([ Pdef('r00'), Pdef('r03'), Pdef('efx') ]))


Pdef('matrix').play

///// HIT THIS TO ENABLE TIME CHECK //////////

~seconds = SystemClock.seconds;


~matrix.defsAt('b01').setControls(
	{ [0, 1].wchoose([0.5, 0.5]) },
	{ rrand(0.1, 0.5) },
	{ rrand(0.05, 0.2) }
);

~matrix.defsAt('c00').ctrls['c000'].amp = 0.2;
~matrix.defsAt('c00').ctrls['c000'].active = 1

~matrix.defsAt('c00').ctrls['c001'].amp = 0.4;
~matrix.defsAt('c00').ctrls['c001'].active = 0

~matrix.defsAt('c00').ctrls['c002'].amp = 0.4;
~matrix.defsAt('c00').ctrls['c002'].active = 1

~matrix.defsAt('c00').ctrls['c003'].amp = 0.4;
~matrix.defsAt('c00').ctrls['c003'].active = 1


~matrix.defsAt('b03').setControls(
	{ [0, 1].wchoose([0.5, 0.5]) },
	{ rrand(0.01, 0.6) },
	{ rrand(0.05, 0.2) }
);

~matrix.defsAt('b04').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ rrand(0.1, 0.6) },
	{ rrand(0.05, 0.4) }
);


~matrix.defsAt('b02').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ rrand(0.1, 0.7) },
	{ rrand(0.05, 0.4) }
);

~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([0.5, 0.5]) },
	{ rrand(0.4, 1.0) },
	{ rrand(0.01, 0.05) }
);

~matrix.defsAt('r02').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ rrand(0.4, 1.0) },
	{ rrand(0.05, 0.01) }
)


~matrix.defsAt('r01').recall(0);

~matrix.defsAt('r02').recall(0)

~matrix.defsAt('b02').recall(0)


~matrix.defsAt('r00').setControls(
	{ [0, 1].wchoose([0.6, 0.4]) },
	{ rrand(0.2, 0.5) },
	{ rrand(0.005, 0.01) }
)

~matrix.defsAt('r03').setControls(
	{ [0, 1].wchoose([0.4, 0.6]) },
	{ exprand(0.2, 0.7) },
	{ exprand(0.003, 0.02) }
)


~matrix.defsAt('r00').recall(0);
~matrix.defsAt('r03').recall(0)



~matrix.defsAt('b01').setControls(
	{ [0, 1].wchoose([0.5, 0.5]) },
	{ rrand(0.1, 0.5) },
	{ rrand(0.05, 0.4) }
);


//////////////// GRAPHICS //////////////////////

~graphics.setPattern(5, 1, 1.0, 0, 0, 0.9, 0.1, 0.4);

~graphics.setPattern(6, 0, 1.0, 1, 1, 0.5, 0.9, 0.8);

~graphics.setPattern(7, 0, 1.0, 0, 0, 1.0, 1.0, 1.0);

~graphics.setPattern(8, 1, 0.5, 1, 1, 0.6, 0.7, 0.9);

~graphics.setPattern(8, 0, 0.2, 1, 1, 0.6, 0.7, 0.9);

~graphics.setPattern(9, 0, 1.0, 1, 1, 0.3, 0.7, 0.9);

~graphics.setPattern(10, 0, 1.0, 0, 0, 0.5, 0.8, 1.0);

~graphics.setPattern(11, 0, 1.0, 0, 0, 0.0, 0.3, 0.5);

~graphics.setPattern(12, 1, 1.0, 1, 1, 0.44, 0.32, 0.66);

~graphics.setPattern(13, 0, 0.7, 0, 0, 0.6, 0.8, 1.0);

~graphics.setPattern(14, 0, 1.0, 1, 1, 0.0, 0.5, 0.5);

~graphics.setPattern(15, 0, 1.0,0, 0, 0.0, 0.5, 0.7);



~rot = Rotation(40.0, 0.01, 20.0, 100.0, 0.0, 0.02, 0.0, 0.02);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera

~graphics.stopRotation


////////// SKISM PATCHES /////////////////


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

~matrix.setSkismAmp('cyclicWarp', 0.0)

~matrix.deactivateSkismSynth('cyclicWarp')


~matrix.activateSkismSynth('latchOnset')

~matrix.setSkismAmp('latchOnset', 0.2)

~matrix.deactivateSkismSynth('latchOnset')


~matrix.activateSkismSynth('cliqSaw')

~matrix.setSkismAmp('cliqSaw', 0.2)

~matrix.deactivateSkismSynth('cliqSaw')


~matrix.activateSkismSynth('fxGrain')

~matrix.setSkismAmp('fxGrain', 0.6)

~matrix.deactivateSkismSynth('fxGrain')


~matrix.activateSkismSynth('arhythmicGendy')

~matrix.setSkismAmp('arhythmicGendy', 0.4)


~matrix.deactivateSkismSynth('arhythmicGendy')


////////// EFX ///////////////


~matrix.efxamps['rev00'] = 0.0
~matrix.efxamps['rev01'] = 0.0
~matrix.efxamps['del00'] = 0.0
~matrix.efxamps['del01'] = 0.0

SystemClock.seconds - ~seconds / 60


Pdef('matrix').stop
