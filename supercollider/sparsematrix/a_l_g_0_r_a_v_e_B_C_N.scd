~ncoef = 20;
~mode = 1;
~decoder = FoaDecoder(decoderType:'stereo');
~graphics = CinderApp(1024, 768, mode: ~mode);

~matrix = SparseMatrix(~decoder, ~graphics, 2, ~ncoef);

MasterEQ(2)

(
~defnames = ();
[
	\gep_gen000_005_130501_180743,
	\gep_gen000_007_130501_180759,
	\gep_gen000_058_130502_145351,
	\gep_gen001_020_130503_003936,
	\gep_gen001_036_130501_181549,
	\gep_gen002_003_130501_182402,
	\gep_gen002_019_130501_182433,
	\gep_gen002_054_130501_182539,
	\gep_gen002_086_130503_105839,
	\gep_gen002_089_130503_105844,
	\gep_gen003_059_130503_113248,
	\gep_gen003_060_130501_183556,
	\gep_gen003_099_130503_113253,
	\gep_gen004_066_130503_121740,
	\gep_gen005_033_130501_202804,
	\gep_gen005_051_130501_202839,
	\gep_gen005_054_130503_124142,
	\gep_gen005_120_130503_124232,
	\gep_gen006_010_130503_131939,
	\gep_gen006_026_130503_131949,
	\gep_gen006_046_130501_205504,
	\gep_gen006_064_130503_132019,
	\gep_gen006_076_130503_132030,
	\gep_gen006_114_130503_132050,
	\gep_gen007_014_130503_142546,
	\gep_gen007_018_130503_142556,
	\gep_gen007_094_130503_142636,
	\gep_gen007_100_130503_142642,
	\gep_gen008_007_130501_211737,
	\gep_gen008_010_130501_211747,
	\gep_gen008_010_130503_144321,
	\gep_gen008_016_130501_211757,
	\gep_gen008_024_130501_211817,
	\gep_gen008_055_130501_211832,
	\gep_gen009_021_130503_145825,
	\gep_gen009_022_130503_145830,
	\gep_gen009_051_130503_145851,
	\gep_gen009_095_130503_145906,
	\gep_gen010_022_130501_215138,
	\gep_gen010_029_130503_151002,
	\gep_gen010_033_130503_151012,
	\gep_gen010_061_130501_215239,
	\gep_gen010_111_130503_151052,
	\gep_gen011_001_130501_220738,
	\gep_gen011_001_130503_153102,
	\gep_gen011_004_130503_153108,
	\gep_gen011_023_130501_220834,
	\gep_gen011_036_130501_220849,
	\gep_gen011_114_130503_153149
].do({|defname, i|
	~defnames[i.asString.padLeft(3, "0").asSymbol] = defname
});

~defnames
)




~graphics.open

~matrix.assignCodeWindow(Document.current);

~matrix.setBPM(138)

~matrix.preparePatternDefs;

~matrix.prepareAudio

~graphics.sendCodeTitle("algorave.barcelona")



Pdef('matrix', Ppar([ Pdef('r00'), Pdef('b02'), Pdef('r02'), Pdef('efx')])).quant(128)

Pdef('matrix').play

~seconds = SystemClock.seconds;


~matrix.defsAt('b01').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.1, 0.3) },
	{ rrand(0.05, 0.3) }
);

~matrix.defsAt('b02').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.3, 1.0) },
	{ rrand(0.05, 0.2) }
);

~matrix.defsAt('r02').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.3, 1.0) },
	{ rrand(0.05, 0.1) }
);

~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([0.6, 0.4]) },
	{ exprand(0.3, 1.0) },
	{ rrand(0.04, 0.1) }
);



~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ rrand(0.1, 1.0) },
	{ rrand(0.05, 0.3) }
);


~matrix.defsAt('r00').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ rrand(0.1, 1.0) },
	{ rrand(0.05, 0.2) }
);

~matrix.defsAt('r03').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ rrand(0.3, 1.0) },
	{ rrand(0.04, 0.1) }
);

~matrix.defsAt('r04').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ rrand(0.3, 1.0) },
	{ rrand(0.001, 0.01) }
);


~matrix.defsAt('r05').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ rrand(0.3, 1.0) },
	{ rrand(0.005, 0.01) }
);

~matrix.defsAt('r06').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ rrand(0.3, 1.0) },
	{ rrand(0.005, 0.01) }
);


Pdef('matrix', Ppar([ Pdef('r05'), Pdef('r04'), Pdef('r06')])).quant(128)


~matrix.defsAt('r06').recall(0);


~graphics.initWorld(20, 20, 20, ~ncoef);

~graphics.initGenerations([4,6,8], [3,5,7,9], 16);

//~graphics.resetWorld(5, 5, 5, 8, 8, 8)

~graphics.setSymmetry(11)

~graphics.showCodePanel

~graphics.setViewpoint(70.0, 0.0, 0.0, 0.0, 0.0, 0.0);


~graphics.sendPredefined3DRule(\nova)



Tdef(\background, {
	loop({
//		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		if (0.66.coin) {
			~graphics.setBackground(*[0.0, 0.1, 0.2].choose.dup(3).round(0.1));
		};
		0.125.wait;
	});
});

Tdef(\background).play


(
Tdef(\autopilot, {
	var actives, max=10, min=5, patterns;
	~graphics.patternLib.select({|pat| pat.active == 1 }).do({|pat|
		pat.active = 0;
		~graphics.sendPattern(pat.index)
	});
	~patterns = (5..15);
	actives = [~patterns.choose];
	~graphics.fadeInPattern(actives.first, 10, 1.0);
	rrand(8.0, 12.0).wait;
	actives = actives ++ ~patterns.choose;
	~graphics.fadeInPattern(actives.last, 5, 1.0);
	rrand(6.0, 12.0).wait;
	loop({
		var newPattern, remove, time, fade;
		~patterns.collect({|patnum|
			var pole, active;
			pole = 2.rand;
			active = actives.includes(patnum).asInt;
			[patnum, active, 1.0, pole, pole, 1.0.rand, 1.0.rand, 1.0.rand]
		}).do({|arglist|
			~graphics.setPattern(*arglist)
		});
		fade = rrand(2, 5);
		time = rrand(5, 15);
		newPattern = ~patterns.reject({|pnum| actives.includes(pnum) }).choose;
		remove = actives.remove(actives.choose);
		~graphics.xfadePatterns(newPattern, 1.0, remove, fade);
		(fade + time).wait;
		actives = actives ++ newPattern;
		~graphics.sendPredefined3DRule(
			[
			\flamingstarbow, \chenille, \belzhab, \glissergy,
			\cooties, \faders, \frozenspirals, \glisserati,
			\nova, \orthogo, \rainzha, \rake, \sedimental,
			\snake, \starwars, \sticks, \thrillgrill,
			\transers, \wanderers, \worms, \xtasy
			].choose;
		);
		if (0.3.coin) {
			~graphics.stopRotation;
			~graphics.setViewpoint(
				rrand(30.0, 60.0)*[1.0,-1.0].choose,
				rrand(30.0, 60.0)*[1.0,-1.0].choose,
				rrand(30.0, 60.0)*[1.0,-1.0].choose,
				0.0, 0.0, 0.0
			);
			~graphics.unmapCodePanel;
		}{
			~rot = Rotation(rrand(-60.0, 60.0), rrand(0.005, 0.05), rrand(-20.0, 20.0),
				rrand(-120.0, 120.0),
				rrand(-pi, pi), rrand(0.01, 0.08), rrand(-pi, pi), rrand(0.01, 0.07));
			~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
			~graphics.rotateCamera;
			~graphics.mapCodePanel;
		};
	})
}).play
)

Tdef(\autopilot).stop

~matrix.defsAt('r02').recall(0);

~matrix.defsAt('b02').recall(0);

~matrix.defsAt('r05').recall(0)

~matrix.defsAt('r04').recall(0)

~matrix.defsAt('r03').recall(0)


// 019 (cool drive), 018 (bass), 017 (like 018, not as cool), 016 (drive, nice), 015 & 014(dry)
// 013 (dry+drive+a bit lo), 012 (low undulation), 011 (high noise), 010 (async tremble)


(
~gep00 = '019';
~matrix.playGepSynth(~gep00, ~defnames[~gep00], 0.0, 2, 3, 4)
)

~matrix.gepsynths[~gep00].set('amp', 0.4)

~matrix.gepsynths[~gep00].set('amp', 0.0)

~matrix.setWithPattern(~gep00, Pseq(Array.rand(16, 0.001, 0.2), inf),
	Pfunc({ ~matrix.beatdur / 4 })
)

~matrix.setWithPattern(~gep00, Pseq([0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0]*0.2, inf),
	Pfunc({ ~matrix.beatdur / 8 })
)


~matrix.stopPattern(~gep00)

~matrix.freeGepSynth(~gep00)

s.queryAllNodes

(
~gep01 = '013';
~matrix.playGepSynth(~gep01, ~defnames[~gep01], 0.0, 2, 3, 4)
)


~matrix.gepsynths[~gep01].set('amp', 0.8)

~matrix.gepsynths[~gep01].set('amp', 0.0)

~matrix.setWithPattern(~gep01, Pseq(Array.rand(16, 0.001, 0.1), inf),
	Pfunc({ ~matrix.beatdur / 4 })
)

~matrix.setWithPattern(~gep01, Pseq([0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0]*0.2, inf),
	Pfunc({ ~matrix.beatdur / 4 })
)


~matrix.stopPattern(~gep01)

~matrix.freeGepSynth(~gep01)


////////// SKISM PATCHES /////////////////


~matrix.activateSkismSynth('granularReverb')

~matrix.setSkismAmp('granularReverb', 0.2)

~matrix.deactivateSkismSynth('granularReverb')


~matrix.activateSkismSynth('flangingDecimator')

~matrix.setSkismAmp('flangingDecimator', 0.2)

~matrix.deactivateSkismSynth('flangingDecimator')


~matrix.activateSkismSynth('neuralFilter')

~matrix.setSkismAmp('neuralFilter', 0.1)

~matrix.deactivateSkismSynth('neuralFilter')


~matrix.activateSkismSynth('feedbackSpectrum')

~matrix.setSkismAmp('feedbackSpectrum', 0.1)

~matrix.deactivateSkismSynth('feedbackSpectrum')


~matrix.activateSkismSynth('cyclicWarp')

~matrix.setSkismAmp('cyclicWarp', 0.1)

~matrix.deactivateSkismSynth('cyclicWarp')


~matrix.activateSkismSynth('latchOnset')

~matrix.setSkismAmp('latchOnset',0.7)

~matrix.deactivateSkismSynth('latchOnset')


~matrix.activateSkismSynth('cliqSaw')

~matrix.setSkismAmp('cliqSaw', 0.5)

~matrix.deactivateSkismSynth('cliqSaw')


~matrix.activateSkismSynth('fxGrain')

~matrix.setSkismAmp('fxGrain', 0.4)

~matrix.deactivateSkismSynth('fxGrain')


~matrix.activateSkismSynth('arhythmicGendy')

~matrix.setSkismAmp('arhythmicGendy', 0.2)

~matrix.deactivateSkismSynth('arhythmicGendy')


////////// EFX ///////////////


~matrix.efxamps['rev00'] = 0.1
~matrix.efxamps['rev01'] = 0.1
~matrix.efxamps['del00'] = 0.1
~matrix.efxamps['del01'] = 0.1

SystemClock.seconds - ~seconds / 60


Pdef('matrix').stop


//////////////// GRAPHICS //////////////////////

~graphics.setPattern(5, 0, 1.0, 1, 1, 0.9, 0.1, 0.4);

~graphics.setPattern(6, 0, 1.0, 0, 0, 0.5, 0.9, 0.8);

~graphics.setPattern(7, 0, 1.0, 0, 0, 1.0, 1.0, 1.0);

~graphics.setPattern(8, 1, 1.0, 1, 1, 0.6, 0.7, 0.9);

~graphics.setPattern(8, 0, 0.2, 1, 1, 0.6, 0.7, 0.9);

~graphics.setPattern(9, 1, 1.0, 1, 1, 0.3, 0.7, 0.9);

~graphics.setPattern(10, 0, 1.0, 0, 0, 0.5, 0.8, 1.0);

~graphics.setPattern(11, 0, 1.0, 0, 0, 0.0, 0.3, 0.5);

~graphics.setPattern(12, 1, 1.0, 1, 1, 0.44, 0.32, 0.66);

~graphics.setPattern(13, 0, 0.7, 0, 0, 0.6, 0.8, 1.0);

~graphics.setPattern(14, 0, 1.0, 1, 1, 0.0, 0.5, 0.5);

~graphics.setPattern(15, 0, 1.0,0, 0, 0.0, 0.5, 0.7);
