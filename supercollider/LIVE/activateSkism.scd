Routine({	
	
	"Initializing skism...".postln;
	
//	~skismDecoder = FoaDecoder(decoderType: 'quad', normalize: true);
	~skismDecoder = FoaDecoder(false, normalize: true);

	~skismInput = MikroFoaInput(~decoder, inputBus: 1);
		
	~skismCoef = 12;
	~tDur = 5000;
	~lRate = 0.1;
	~dur = 8*60;
	~isMono = true;
	
	~bpm = 135;
	~beatdur = (~bpm / 60).reciprocal;
	~round = ~beatdur / 8;
	
	~skismAnalyzer = MikroAnalyzer(
		maxdur: ~dur, 
		numcoef: ~skismCoef, 
		recordInput: true, 
		isMono: ~isMono
	);
	
	~mikroLambda = MikroLambda(
		input: ~skismInput,
		graphics: ~graphics,
		analyzer: ~skismAnalyzer
	);
	
	3.wait;
	
	"Activating skism sections...".postln;
		
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
	
	~recognizer = PatchRecognizer(~mikroLambda).load("/Users/alo/Data/mikro/120330_153533.plib");
	
	~composer = SkismLambda(~mikroLambda, ~recognizer, ~defs, ~sections, 60).cleanup_({
		~skismAnalyzer.free;
		~composer.free;
		SystemClock.sched(1, { 
			~mikroLambda.group.free;
			~skismAnalyzer = nil;
			~mikro = nil;
			~skismInput = nil;
			nil	
		});	
	});
	
	"Skism initialization complete..".postln
	
}).play