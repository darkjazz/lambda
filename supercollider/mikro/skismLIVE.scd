(
~decoder = FoaDecoder(decoderType: 'stereo', normalize: true);

//// LIVE INPUT
//~input = MikroFoaInput(~decoder);

// SAMPLES INPUT
~input = MikroFoaInput(~decoder, "/Users/alo/sounds/eclambone_samples/*");

~nCoef = 12;
~tDur = 5000;
~lRate = 0.1;
~dur = 12*60;
~isMono = true;

~bpm = 135;
~beatdur = (~bpm / 60).reciprocal;
~round = ~beatdur / 8;

~analyzer = MikroAnalyzer(
	maxdur: ~dur, 
	numcoef: ~nCoef, 
	recordInput: true, 
	isMono: ~isMono
);

~graphics = CinderApp();

~mikro = MikroLambda(
	input: ~input,
	graphics: ~graphics,
	analyzer: ~analyzer
);

)

(

~sections = [
	[
		\latchOnset -> (pattern: 19, amp: 0.5),
		nil,
		nil,	
		nil,
		nil	
	],
	[
		\latchOnset -> (pattern: 19, amp: 1.0),
		\fxGrain -> (pattern: 20, amp: 0.5),
		nil,	
		nil,
		nil
	],
	[
		\granularReverb -> (pattern: 16, amp: 0.7),
		\neuralFilter -> (pattern: 22, amp: 0.5),
		\fxGrain -> (pattern: 18, amp: 0.5),
		\cyclicWarp -> (pattern: 17, amp: 0.3),
		nil
	],	
	[
		\arhythmicGendy -> (pattern: 16, amp: 0.8),
		\flangingDecimator -> (pattern: 19, amp: 1.0),
		\granularReverb -> (pattern: 18, amp: 0.4),
		\latchOnset -> (pattern: 22, amp: 1.0),
		\fxGrain -> (pattern: 20, amp: 1.0)
	],	
	[
		\cliqSaw -> (pattern: 21, amp: 0.2),
		\feedbackSpectrum -> (pattern: 22, amp: 1.0),
		\neuralFilter -> (pattern: 23, amp: 0.5),
		\arhythmicGendy -> (pattern: 24, amp: 0.5),
		\flangingDecimator -> (pattern: 25, amp: 0.5)
	],
	[
		\cliqSaw -> (pattern: 22, amp: 1.0),
		nil,
		\neuralFilter -> (pattern: 21, amp: 1.0),
		nil,
		\cyclicWarp -> (pattern: 23, amp: 0.5)
	],	
	[
		nil,
		\neuralFilter -> (pattern: 21, amp: 0.5),
		\feedbackSpectrum -> (pattern: 22, amp: 1.0),
		\cliqSaw -> (pattern: 23, amp: 1.0),
		nil
	],	
	[
		\latchOnset -> (pattern: 24, amp: 0.8),
		\cyclicWarp -> (pattern: 20, amp: 0.5),
		\neuralFilter -> (pattern: 25, amp: 0.2),
		\fxGrain -> (pattern: 22, amp: 1.0),
		nil
	]
];

~defs = "/Users/alo/Development/skism/sc/defs.scd".load;

~recognizer = PatchRecognizer(~mikro).load("/Users/alo/Data/mikro/120330_153533.plib");

~composer = SkismLambda(~mikro, ~recognizer, ~defs, ~sections, 60).cleanup_({
	~mikro.stop;
	~composer.free;
	SystemClock.sched(1, { ~mikro.quit; nil });	
});

)

~mikro.initPerformance(0)

~graphics.initWorld(20, 20, 20, ~nCoef)

~graphics.initContinuous;

~graphics.setViewpoint(0.0, 0.0, 60.0, 0.0, 0.0, 0.0)

~mikro.start(-60.dbamp, 0.05, 20)

~recognizer.run

~composer.run

~rot = Rotation(30.0, 0.05, 20.0, 60.0, 0.0, 0.02, 0.0, 0.02);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera

~graphics.stopRotation


s.queryAllNodes


// QUIT

~mikro.stop

~composer.free

~mikro.quit



