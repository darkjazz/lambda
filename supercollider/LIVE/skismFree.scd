(

~nCoef = 20;
~tDur = 5000;
~lRate = 0.1;
~dur = 12*60;
~isMono = true;
~rate = 20;
~headsize = 16;
~numgenes = 4;

~bpm = 135;
~beatdur = (~bpm / 60).reciprocal;
~round = ~beatdur / 8;

~decoder = FoaDecoder(decoderType: 'stereo');
~graphics = CinderApp(1024, 768, mode: 0);

~input = MikroFoaInput(~decoder);

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
~data = UGepLoader(~headsize, ~numgenes).load;

~foa = #[zoom,push];
~player = GepPlayer(~data, ~decoder, ~graphics);

~player.setBPM(140);

)



(

~sections = [
	[
		\latchOnset -> (pattern: 19, amp: 0.5),
		nil,
		nil,	
		nil,
		nil	
	]
];

~defs = (Document.current.dir +/+ "defs.scd").load;

~recognizer = PatchRecognizer(~mikro).load("/Users/alo/Data/mikro/120330_153533.plib");

~composer = SkismLambda(~mikro, ~recognizer, ~defs, ~sections, 60).cleanup_({
	~mikro.stop;
	~composer.free;
	SystemClock.sched(1, { ~mikro.quit; nil });	
});

)


~mikro.initPerformance(0)


~input.mainamp = 0

~graphics.initWorld(20, 20, 20, ~nCoef)

~graphics.initContinuous;

~graphics.setViewpoint(0.0, 0.0, 60.0, 0.0, 0.0, 0.0)

~mikro.start(-60.dbamp, 0.05, 20)

~graphics.resetWorld(9, 9, 9, 4, 4, 4)

~graphics.setAdd(0.1)


~graphics.setPattern(1, 1, 1.0, 1, 1, 0.2, 0.9, 0.77);

~graphics.setPattern(19, 0, 1.0, 0, 0, 0.0, 0.9, 0.2);

~graphics.setPattern(20, 0, 1.0, 0, 0, 0.0, 0.9, 0.2);

~graphics.setPattern(21, 0, 1.0, 1, 1, 0.6, 0.7, 0.9);

~graphics.setPattern(22, 0, 1.0, 0, 0, 0.6, 0.7, 0.9);

~graphics.setPattern(23, 0, 1.0, 1, 1, 0.6, 0.7, 0.9);

~graphics.setPattern(24, 1, 1.0, 0, 0, 0.6, 0.7, 0.9);

~graphics.setPattern(25, 1, 1.0, 1, 1, 0.9, 0.1, 0.4);


~rot = Rotation(50.0, 0.03, -60.0, 60.0, 0.0, 0.035, 0.0, 0.045);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera

~graphics.stopRotation


\latchOnset
\fxGrain
\granularReverb
\neuralFilter
\cyclicWarp
\arhythmicGendy
\flangingDecimator
\feedbackSpectrum


~composer.activateSynth('cyclicWarp')


~composer.synths['cyclicWarp'].set(\amp, 0.0)


~composer.deactivateSynth('neuralFilter')



~composer.activateSynth('feedbackSpectrum')

~composer.synths['feedbackSpectrum'].set(\amp, 0.2)

~composer.deactivateSynth('feedbackSpectrum')



~composer.activateSynth('arhythmicGendy')


~composer.activateSynth('neuralFilter')

~composer.synths



~composer.deactivateSynth('arhythmicGendy')



~composer.synths['fxGrain'].set(\amp, 0.1)

s.queryAllNodes



~input.free


~player.start(~foa)

~player.setFoa('zoom', 1.0);
~player.setFoa('push', 1.0)


// zoom 0 // 7, 9, 10, 11, 13, 14, 15, 19, 22, 25, 26, 35, 36, 38, 39
// **** 10, 26, 29, 33, 34, 37, 91
~ind0 = 91


~player.play(~ind0, 0, 'zoom', 0)

~player.set(~ind0, 0.01)

~player.setWithPattern(~ind0,
	Pseq([0.1, 0, 0.1, 0.05, 0.15, 0.5, 0.1, 0, 0.2, 0, 0.6, 0.2].mirror2, inf), ~matrix.beatdur/2)

~player.setWithPattern(~ind0,
	Pseq([0, 0, 0, 0, 0, 0, 0, 0, 0.6, 0.1, 0.6, 0, 0.6, 0.0, 0.6, 0], inf), ~matrix.beatdur/2)


~player.setWithPattern(~ind0, Pwhite(0.001, 0.01, inf), Pbrown(0.03125, 0.25, 0.03125, inf))

~player.setWithPattern(~ind0, Pseq(Array.rand(16, 0.0, 0.3).round(0.1).mirror2, inf), ~matrix.beatdur/2)


~player.free(~ind0)

s.queryAllNodes


// push 1 //
~ind1 = 49

~player.play(~ind1, 0, 'push', 0)

~player.set(~ind1, 0.2)

~player.setWithPattern(~ind1,
	Pseq([0.1, 0, 0.1, 0.05, 0.15, 0.4, 0.1, 0, 0.2, 0, 0.5, 0.2], inf), ~matrix.beatdur/4)

~player.setWithPattern(~ind1, Pwhite(0.001, 0.7, inf), Pbrown(0.03125, 0.25, 0.03125, inf))

~player.setWithPattern(~ind1, Pseq(Array.rand(8, 0.0, 1.0).round(0.1), inf), 0.125)

~player.free(~ind1)













/////////// GEP ROUTINE /////////////



// 56-60, 61-62

~indZoom00 = 61;
~indPush00 = 62;


~player.playRoutine(~indZoom00, Pseq([0.5, 0, 0.5, 0, 0, 0.5] * 2, inf), Pseq([0.5, 0.25, 0.25, 0.5, 0.25, 0.25], inf), 'zoom');
~player.playRoutine(~indPush00, Pseq([0, 0.5, 0, 0.5, 0.5, 0] * 2, inf), Pseq([0.5, 0.25, 0.25, 0.5, 0.25, 0.25], inf), 'push');

~player.stopRoutine(~indZoom00);
~player.stopRoutine(~indPush00);


// 38-40, 42-43, 44-45, 50-49

~indZoom = 42;
~indPush = 43;

~player.playRoutine(~indZoom, Pseq([0.5, 0, 0.5, 0, 0, 0.5], inf), Pseq([0.5, 0.25, 0.25, 0.5, 0.25, 0.25], inf), 'zoom');
~player.playRoutine(~indPush, Pseq([0, 0.5, 0, 0.5, 0.5, 0], inf), Pseq([0.5, 0.25, 0.25, 0.5, 0.25, 0.25], inf), 'push');


~player.playRoutine(~indZoom, Pseq([1.0, 0, 1.0, 0, 0, 1]*0.3, inf), Pseq([1, 2, 2, 1, 2, 1], inf), 'zoom');
~player.playRoutine(~indPush, Pseq([0, 1.0, 0, 1.0, 0.5,1]*0.3, inf), Pseq([2, 1, 1, 2, 1, 2], inf), 'push');

~player.stopRoutine(~indZoom);
~player.stopRoutine(~indPush);


s.queryAllNodes

s.sendMsg("/n_free", 1024)

