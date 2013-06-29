~graphics.open

~matrix.assignCodeWindow(Document.current);

~matrix.setBPM(138)

~matrix.preparePatternDefs;

~matrix.prepareAudio


Pdef('matrix', Ppar([ Pdef('r03'), Pdef('r04'), Pdef('r05'), Pdef('r06')]))

Pdef('matrix').play

~seconds = SystemClock.seconds;


~matrix.defsAt('b01').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ rrand(0.1, 0.3) },
	{ rrand(0.05, 0.2) }
);





~graphics.initWorld(20, 20, 20, ~ncoef);

~graphics.initGenerations([4,6,8], [3,5,7,9], 16);

//~graphics.resetWorld(5, 5, 5, 8, 8, 8)

~graphics.setSymmetry(11)


~graphics.setViewpoint(40.0, 40.0, 40.0, 0.0, 0.0, 0.0);


~graphics.sendPredefined3DRule(\brain6)

~graphics.sendPredefined3DRule(\cooties)

~graphics.sendPredefined3DRule(\nova)

~graphics.sendPredefined3DRule(\faders)

(
[	
	[5, 0, 0.2, 0, 0, 0.9, 0.1, 0.4],
	[6, 0, 0.5, 1, 1, 0.5, 0.9, 0.8],
	[7, 0, 1.0, 0, 0, 1.0, 1.0, 1.0],
	[8, 0, 0.2, 1, 1, 0.6, 0.7, 0.9],
	[9, 0, 0.5, 1, 1, 0.3, 0.7, 0.9],
	[10, 0, 1.0, 0, 0, 0.5, 0.8, 1.0],
	[11, 0, 1.0, 1, 1, 0.0, 0.3, 0.5],
	[12, 0, 0.3, 0, 0, 0.44, 0.32, 0.66],
	[13, 0, 0.7, 0, 0, 0.6, 0.8, 1.0],
	[14, 0, 1.0, 1, 1, 0.0, 0.5, 0.5],
	[15, 0, 1.0,0, 0, 0.0, 0.5, 0.7]
].do({|arglist|
	~graphics.setPattern(*arglist)
})
)

~graphics.fadeInPattern(6, 10, 1.0)

~graphics.xfadePatterns(12, 1.0, 6, 20)

~graphics.xfadePatterns(9, 1.0, 12, 20)

~graphics.xfadePatterns(14, 1.0, 9, 20)

~graphics.xfadePatterns(8, 1.0, 14, 20)



~graphics.mapCodePanel


(
Tdef(\autopilot, {
	var active, max=15, min=5;
	active = 6;
	~graphics.fadeInPattern(8, 10, 1.0);
	30.wait;
	loop({
		var newPattern, time, fade;
		fade = rrand(5, 10);
		time = rrand(20, 35);
		newPattern = rrand(min, max);
		~graphics.xfadePatterns(newPattern, 1.0, active, fade);
		(fade + time).wait;
		active = newPattern;
		if (0.3.coin) {
			~graphics.sendPredefined3DRule(
				[\nova, \briansbrain, \brain6, \cooties, \faders].choose;
			);
		}
	})
}).play
)
Tdef(\autopilot).clear

~rot = Rotation(140.0, 0.09, 60.0, 60.0, 0.0, 0.081, 0.0, 0.073);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera


Pdef('matrix', Ppar([Pdef('r00'), Pdef('r03'), Pdef('efx')]))

Pdef('matrix', Ppar([ Pdef('c00'), Pdef('b01'), Pdef('b03'), Pdef('b04')]))

Pdef('matrix', Ppar([ Pdef('c00'), Pdef('r01'), Pdef('b03'), Pdef('b04')]))

Pdef('matrix', Ppar([ Pdef('r01'), Pdef('r02'), Pdef('b02'), Pdef('efx') ]))

Pdef('matrix', Ppar([ Pdef('r02'), Pdef('b00'), Pdef('b03'), Pdef('b04') ]))

Pdef('matrix', Ppar([ Pdef('r00'), Pdef('r01'), Pdef('r02'), Pdef('r03'),Pdef('b03'), Pdef('b04'), Pdef('efx') ]))

Pdef('matrix', Ppar([ Pdef('r00'), pdef Pdef('r03'),Pdef('b03'), Pdef('b04'), Pdef('efx') ]))

Pdef('matrix', Ppar([ Pdef('r00'), Pdef('r03'), Pdef('efx') ]))




Pdef('matrix', Ppar([ Pdef('r00'), Pdef('r02'), Pdef('r03'),Pdef('b03'), Pdef('b04'), Pdef('efx') ]))


~matrix.defsAt('b01').setControls(
	{ [0, 1].wchoose([0.5, 0.5]) },
	{ rrand(0.1, 0.5) },
	{ rrand(0.05, 0.2) }
);

~matrix.defsAt('c00').ctrls['c000'].amp = 0.2;
~matrix.defsAt('c00').ctrls['c000'].active = 1

~matrix.defsAt('c00').ctrls['c001'].amp = 0.4;
~matrix.defsAt('c00').ctrls['c001'].active = 1

~matrix.defsAt('c00').ctrls['c002'].amp = 0.4;
~matrix.defsAt('c00').ctrls['c002'].active = 1

~matrix.defsAt('c00').ctrls['c003'].amp = 0.4;
~matrix.defsAt('c00').ctrls['c003'].active = 1


~matrix.defsAt('b03').setControls(
	{ [0, 1].wchoose([0.6, 0.4]) },
	{ rrand(0.1, 0.7) },
	{ rrand(0.05, 0.3) }
);

~matrix.defsAt('b04').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ rrand(0.1, 0.7) },
	{ rrand(0.05, 0.2) }
);


~matrix.defsAt('b02').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ rrand(0.1, 0.7) },
	{ rrand(0.05, 0.3) }
);

~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ rrand(0.2, 0.6) },
	{ exprand(0.01, 0.1) }
);

~matrix.defsAt('r02').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ rrand(0.2, 1.0) },
	{ exprand(0.01, 0.2) }
);

/// ---> start here


~matrix.defsAt('r04').setControls(
	{ [0, 1].wchoose([0.9, 0.1]) },
	{ rrand(0.1, 0.9) },
	{ exprand(0.001, 0.1) }
);

~matrix.defsAt('r05').setControls(
	{ [0, 1].wchoose([0.9, 0.1]) },
	{ rrand(0.2, 1.0) },
	{ exprand(0.05, 0.1) }
);

~matrix.defsAt('r06').setControls(
	{ [0, 1].wchoose([0.9, 0.1]) },
	{ rrand(0.2, 1.0) },
	{ exprand(0.001, 0.1) }
);

~matrix.defsAt('r03').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ rrand(0.4, 1.0) },
	{ rrand(0.01, 0.2) }
)



~matrix.defsAt('r06').recall(0);

~matrix.defsAt('r05').recall(0)

~matrix.defsAt('r04').recall(0)

~matrix.defsAt('r03').recall(0)


~matrix.defsAt('b02').recall(0)


~matrix.defsAt('r00').setControls(
	{ [0, 1].wchoose([0.3, 0.7]) },
	{ rrand(0.2, 1.0) },
	{ rrand(0.05, 0.02) }
)

~matrix.defsAt('r03').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.2, 1.0) },
	{ exprand(0.03, 0.2) }
)


~matrix.defsAt('r00').recall(1);
~matrix.defsAt('r03').recall(0)



~matrix.defsAt('b01').setControls(
	{ [0, 1].wchoose([0.5, 0.5]) },
	{ rrand(0.1, 0.5) },
	{ rrand(0.05, 0.4) }
);


~matrix.defsAt('b03').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ rrand(0.01, 0.6) },
	{ rrand(0.05, 0.01) }
);

~matrix.defsAt('b04').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ rrand(0.1, 0.4) },
	{ rrand(0.05, 0.01) }
);

(
// 019 (cool drive), 018 (bass), 017 (like 018, not as cool), 016 (drive, nice), 015 & 014(dry)
// 013 (dry+drive+a bit lo), 012 (low undulation), 011 (high noise), 010 (async tremble)
~gep00 = '019';
~matrix.playGepSynth(~gep00, ~defnames[~gep00], 0.0, 2, 3, 4)
)

~matrix.gepsynths[~gep00].set('amp', 0.2)

~matrix.gepsynths[~gep00].set('amp', 0.0)


~matrix.freeGepSynth(~gep00)

s.queryAllNodes

(
~gep01 = '018';
~matrix.playGepSynth(~gep01, ~defnames[~gep01], 0.0, 2, 3, 4)
)

~matrix.gepsynths[~gep01].set('amp', 0.2)

~matrix.freeGepSynth(~gep01)


~graphics.showCodePanel

~graphics.hideCodePanel


//////////////// GRAPHICS //////////////////////

~graphics.setPattern(5, 0, 1.0, 0, 0, 0.9, 0.1, 0.4);

~graphics.setPattern(6, 0, 1.0, 0, 0, 0.5, 0.9, 0.8);

~graphics.setPattern(7, 0, 1.0, 0, 0, 1.0, 1.0, 1.0);

~graphics.setPattern(8, 0, 1.0, 1, 1, 0.6, 0.7, 0.9);

~graphics.setPattern(8, 0, 0.2, 1, 1, 0.6, 0.7, 0.9);

~graphics.setPattern(9, 0, 1.0, 1, 1, 0.3, 0.7, 0.9);

~graphics.setPattern(10, 0, 1.0, 0, 0, 0.5, 0.8, 1.0);

~graphics.setPattern(11, 0, 1.0, 0, 0, 0.0, 0.3, 0.5);

~graphics.setPattern(12, 0, 1.0, 1, 1, 0.44, 0.32, 0.66);

~graphics.setPattern(13, 0, 0.7, 0, 0, 0.6, 0.8, 1.0);

~graphics.setPattern(14, 0, 1.0, 1, 1, 0.0, 0.5, 0.5);

~graphics.setPattern(15, 0, 1.0,0, 0, 0.0, 0.5, 0.7);

SATOSHI!!!!

~rot = Rotation(40.0, 0.01, 20.0, 100.0, 0.0, 0.02, 0.0, 0.02);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera

~graphics.stopRotation

Server.killAll
////////// SKISM PATCHES /////////////////


~matrix.activateSkismSynth('granularReverb')

~matrix.setSkismAmp('granularReverb', 0.3)

~matrix.deactivateSkismSynth('granularReverb')


~matrix.activateSkismSynth('flangingDecimator')

~matrix.setSkismAmp('flangingDecimator', 0.4)

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

~matrix.setSkismAmp('latchOnset',0.6)

~matrix.deactivateSkismSynth('latchOnset')


~matrix.activateSkismSynth('cliqSaw')

~matrix.setSkismAmp('cliqSaw', 0.2)

~matrix.deactivateSkismSynth('cliqSaw')


~matrix.activateSkismSynth('fxGrain')

~matrix.setSkismAmp('fxGrain', 0.4)

~matrix.deactivateSkismSynth('fxGrain')


~matrix.activateSkismSynth('arhythmicGendy')

~matrix.setSkismAmp('arhythmicGendy', 0.2)

~matrix.deactivateSkismSynth('arhythmicGendy')


////////// EFX ///////////////


~matrix.efxamps['rev00'] = 0.2
~matrix.efxamps['rev01'] = 0.1
~matrix.efxamps['del00'] = 0.1
~matrix.efxamps['del01'] = 0.1

SystemClock.seconds - ~seconds / 60


Pdef('matrix').stop

~matrix.quit(false)


s.queryAllNodes


(
~def00 = '000_000';
~genetic.play(~def00, 8.0, 4.0, 7.0);
~genetic.fade(~def00, 0.0, 0.2, 10)
)

~genetic.fade(~def00, 0.4, 0.0, 20)

~genetic.set(~def00, 0.5)

~genetic.free(~def00)

s.queryAllNodes


(
~def02 = '000_001';
~genetic.play(~def02, 8.0, 4.0, 7.0);
~genetic.fade(~def02, 0.0, 0.2, 8)
)

~genetic.fade(~def02, 0.2, 0.0, 15)

~genetic.set(~def02, 0.3)

~genetic.free(~def02)


s.queryAllNodes


(
~def03 = '000_002';
~genetic.play(~def03, 3.0, 1.5, 4.0);
~genetic.fade(~def03, 0.0, 0.4, 10)
)

~genetic.fade(~def03, 0.4, 0.0, 20)

~genetic.set(~def03, 0.1)

~genetic.free(~def03)


s.queryAllNodes


(
~def04 = '000_004';
~genetic.play(~def04, 2.0, 5.0, 4.0);
~genetic.fade(~def04, 0.0, 0.4, 8)
)

~genetic.fade(~def04, 0.4, 0.0, 1)

~genetic.set(~def04, 0.5)

~genetic.free(~def04)

s.stopRecording

s.queryAllNodes


(
~def05 = '000_051';
~genetic.play(~def05, 2.0, 5.0, 4.0);
~genetic.fade(~def05, 0.0, 0.3, 8)
)

~genetic.fade(~def05, 0.3, 0.0, 10)

~genetic.set(~def05, 0.0)

~genetic.free(~def05)

