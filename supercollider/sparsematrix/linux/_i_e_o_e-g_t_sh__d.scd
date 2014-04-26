(
~ncoef = 20;
~decoder = FoaDecoder(decoderType:'stereo');
//~graphics = CinderApp(ciAddr: NetAddr("192.168.1.100", 7000));
~graphics = CinderApp(ciAddr: NetAddr("192.168.0.6", 7000));

~matrix = SparseMatrix(~decoder, ~graphics, 2, ~ncoef);
)

MasterEQ(2)

// ~sparsedata = UGepLoader(headsize: 12, numgenes: 2).load;

(
~ncoef = 20;
~rate = 20;
~headsize = 16;
~numgenes = 4;

~dfile = File.open("/home/alo/development/lambda/supercollider/sparsematrix/2014-01-01/defnames00.scd", "r");
~defarray = ~dfile.readAllString.split(Char.nl).reject(_.isEmpty).collect(_.asSymbol);
~dfile.close;
~dfile = nil;

~data = ~defarray.collect({|defname|
	var path, meta, data;
	path = Paths.gepArchDir +/+ defname.asString ++ "." ++ UGEP.fileExt;
	if (File.exists(path)) { data = UGEP.loadData(path) };
	meta = UGenExpressionTree.loadMetadata(defname);
	data['defname'] = defname;
	data['args'] = meta.args.args;
	data['stats'] = meta.stats;
	data
});
 ~foa = #[zoom,focus,push,press];
 ~player = GepPlayer(~data, ~decoder, ~graphics);

)

//~graphics.open

//~matrix.assignCodeWindow(Document.current);

~matrix.setBPM(135)

~matrix.makeEfxProto;

~matrix.preparePatternDefs(~data);


/// WAAAIIIIIITTTT !!!!!

~matrix.prepareAudio

//~graphics.sendCodeTitle("live.code")

//s.queryAllNodes


Pdef('matrix', Ppar([ Pdef('g00'), Pdef('g01'), Pdef('b02'), Pdef('c00') ])).quant(128)

Pdef('matrix').play


~seconds = SystemClock.seconds;



~matrix.defsAt('g00').assignEfx(
	(efx0: [0, 1, 2], efx1: [3, 4, 5], efx3: [6, 7, 8])
)

~matrix.defsAt('r01').assignEfx(
	(efx0: [3, 13, 23, 33], efx1: [4, 14, 24, 44], efx3: [6, 16, 26, 56], efx4: [8, 18, 28, 60], efx5: [10, 20, 30, 40])
)


~matrix.efxamps['efx0'] = 0.2

~matrix.efxamps['efx1'] = 0.2

~matrix.efxamps['efx3'] = 0.2

~matrix.efxamps['efx4'] = 0.2

~matrix.efxamps['efx5'] = 0.2


Routine({
	var amp = 2.0;
	20.do({
		amp = amp - 0.1;
		~matrix.defsAt('c00').setControls(1, amp, ~matrix.beatdur, 0.0);
		(~matrix.beatdur * 4).wait;
	})
}).play




~graphics.initWorld(24, 20, 16, ~ncoef);

~graphics.initGenerations([4,6,8], [3,5,7,9], 16);

//~graphics.resetWorld(5, 5, 5, 8, 8, 8)

~graphics.setSymmetry(11)

//~graphics.showCodePanel

~graphics.setViewpoint(70.0, 80.0, 60.0, 0.0, 0.0, 0.0);


~graphics.sendPredefined3DRule(\nova)

~graphics.setPattern(30, 1, 1.0, 1, 1, 1.0, 1.0, 1.0);



~matrix.defsAt('b01').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.1, 1.0) },
	{ rrand(0.05, 0.1) },
	0.1
);


~graphics.setPattern(26, 1, 1.0, 1, 1, 0.6, 0.9, 1.0);


~matrix.defsAt('b00').setGroups((0..7), 1, 1.0, {arg name;
	~matrix.defsAt('b00').buffers[name]
		.duration.round(~matrix.beatdur).clip(0, ~matrix.beatdur) * 4;
}, 0.0)


~graphics.setPattern(6, 1, 1.0, 1, 1, 0.5, 0.9, 0.8);






Pdef('matrix', Ppar([ Pdef('b00'), Pdef('b01'), Pdef('c00') ])).quant(128)

Pdef('matrix', Ppar([ Pdef('r02'), Pdef('g01'), Pdef('b01'), Pdef('g02') ])).quant(128)




~matrix.defsAt('g00').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.4, 2.0) },
	{ exprand(0.07, 0.3) },
	0.1
);

~matrix.defsAt('g01').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ exprand(0.5, 2.0) },
	{ rrand(0.05, 0.3) },
	0.1
);

~matrix.defsAt('g03').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.1, 1.0) },
	{ exprand(0.04, 0.2) },
	0.1
);


~matrix.defsAt('g02').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ exprand(0.5, 2.0) },
	{ exprand(0.04, 0.1) },
	0.1
);

~matrix.defsAt('g01').recall(2);

~matrix.defsAt('r02').recall(0);

~matrix.defsAt('b02').recall(0);



~matrix.defsAt('b02').setControls(
	{ [0, 1].wchoose([0.9, 0.1]) },
	{ exprand(0.3, 1.6) },
	{ rrand(0.2, 0.5) },
	0.1
);

~matrix.defsAt('b01').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.3, 2.0) },
	{ rrand(0.05, 0.2) },
	0.1
);



~matrix.defsAt('r02').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.3, 2.0) },
	{ rrand(0.04, 0.1) },
	{ rrand(0.1, 0.3) }
);



~matrix.defsAt('r07').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.3, 1.0) },
	{ rrand(0.05, 0.3) },
	{ rrand(0.1, 0.3) }
);




~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ rrand(0.1, 1.0) },
	{ rrand(0.1, 0.2) },
	0
);


~matrix.defsAt('r02').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ rrand(0.1, 1.0) },
	{ rrand(0.1, 0.2) },
	0
);


~matrix.defsAt('r00').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ rrand(0.3, 2.0) },
	{ exprand(0.01, 0.2) },
	{ rrand(0.3, 0.5) }
);

~matrix.defsAt('r07').setControls(
	{ [0, 1].wchoose([0.5, 0.5]) },
	{ rrand(0.5, 1.0) },
	{ exprand(0.05, 0.1) },
	{ rrand(0.1, 0.4) }
);


~matrix.defsAt('r03').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ rrand(0.3, 1.0) },
	{ rrand(0.04, 0.15) },
	0
);

~matrix.defsAt('r04').setControls(
	{ [0, 1].wchoose([0.9, 0.1]) },
	{ rrand(0.3, 1.0) },
	{ rrand(0.01, 0.2) },
	0
);


~matrix.defsAt('r05').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ rrand(0.3, 1.0) },
	{ rrand(0.05, 0.2) },
	0
);

~matrix.defsAt('r06').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ rrand(0.3, 1.0) },
	{ rrand(0.005, 0.01) }
);


Pdef('matrix', Ppar([ Pdef('r05'), Pdef('r04'), Pdef('r06')])).quant(128)


~matrix.defsAt('r00').recall(1);





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



////////// GEP PLAYER /////////////

~player.start(~foa)

~player.setFoa('zoom', 1.0)
~player.setFoa('push', 1.0)
~player.setFoa('press', 1.0)
~player.setFoa('focus', 1.0)


// zoom 0 // 7, 9, 10, 11, 13, 14, 15, 19, 22, 25, 26, 35, 36, 38, 39
// **** 10, 26, 29, 33, 34, 37
~ind0 = 88

~player.play(~ind0, 0, 'zoom', 0)

~player.set(~ind0, 1.0)

~player.setWithPattern(~ind0,
	Pseq([0.1, 0, 0.1, 0.05, 0.15, 0.5, 0.1, 0, 0.2, 0, 0.6, 0.2].mirror2, inf), ~matrix.beatdur/2)

~player.setWithPattern(~ind0,
	Pseq([0, 0, 0, 0, 0, 0, 0, 0, 0.6, 0.1, 0.6, 0, 0.6, 0.0, 0.6, 0], inf), ~matrix.beatdur/2)


~player.setWithPattern(~ind0, Pwhite(0.05, 0.2, inf), Pbrown(0.03125, 0.25, 0.03125, inf))

~player.setWithPattern(~ind0, Pseq(Array.rand(16, 0.0, 0.3).round(0.1).mirror2, inf), ~matrix.beatdur/2)

~player.free(~ind0)



// push 1 //
~ind1 = 75

~player.play(~ind1, 0, 'push', 0)

~player.set(~ind1, 1.0)

~player.setWithPattern(~ind1,
	Pseq([0.1, 0, 0.1, 0.05, 0.15, 0.4, 0.1, 0, 0.2, 0, 0.5, 0.2], inf), ~matrix.beatdur/4)

~player.setWithPattern(~ind1, Pwhite(0.001, 0.01, inf), Pbrown(0.03125, 0.25, 0.03125, inf))

~player.setWithPattern(~ind1, Pseq(Array.rand(8, 0.0, 1.0).round(0.1), inf), 0.125)

~player.free(~ind1)



// press 2 //
~ind2 = 26

~player.play(~ind2, 0, 'press', 0)


~player.set(~ind2, 1.0)

~player.setWithPattern(~ind2,
	Pseq([0.1, 0, 0.1, 0.05, 0.15, 0.4, 0.1, 0, 0.2, 0, 0.7, 0.2, 0.1, 0.1, 0.8], inf), 0.125)

~player.setWithPattern(~ind2, Pwhite(0.05, 0.4, inf), Pbrown(0.03125, 0.25, 0.03125, inf))

~player.setWithPattern(~ind2, Pseq(Array.rand(8, 0.0, 1.0).round(0.1), inf), 0.125)

~player.free(~ind2)



// focus 3 //
~ind3 = 35

~player.play(~ind3, 0, 'focus', 0)

~player.set(~ind3, 1.0)

~player.setWithPattern(~ind3,
	Pseq([0.1, 0, 0.1, 1.0, 1.0, 0.4, 0.1, 0, 1.0, 0, 1.0, 0.2, 0.1, 0.6], inf), 0.125)

~player.setWithPattern(~ind3, Pwhite(0.01, 0.4, inf), Pbrown(0.03125, 0.25, 0.03125, inf))

~player.setWithPattern(~ind3, Pseq(Array.rand(8, 0.0, 1.0).round(0.1), inf), 0.125)

~player.free(~ind3)


s.queryAllNodes

s.sendMsg("/n_free", 1021)



////////// SKISM PATCHES /////////////////


~matrix.activateSkismSynth('granularReverb')

~matrix.setSkismAmp('granularReverb', 0.4)

~matrix.deactivateSkismSynth('granularReverb')



~matrix.activateSkismSynth('neuralFilter')

~matrix.setSkismAmp('neuralFilter', 0.2)

~matrix.deactivateSkismSynth('neuralFilter')



~matrix.activateSkismSynth('latchOnset')

~matrix.setSkismAmp('latchOnset',0.8)

~matrix.deactivateSkismSynth('latchOnset')



~matrix.activateSkismSynth('cliqSaw')

~matrix.setSkismAmp('cliqSaw', 0.5)

~matrix.deactivateSkismSynth('cliqSaw')









~matrix.activateSkismSynth('flangingDecimator')

~matrix.setSkismAmp('flangingDecimator', 0.2)

~matrix.deactivateSkismSynth('flangingDecimator')




~matrix.activateSkismSynth('feedbackSpectrum')

~matrix.setSkismAmp('feedbackSpectrum', 0.1)

~matrix.deactivateSkismSynth('feedbackSpectrum')


~matrix.activateSkismSynth('cyclicWarp')

~matrix.setSkismAmp('cyclicWarp', 0.05)

~matrix.deactivateSkismSynth('cyclicWarp')




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

~graphics.setPattern(6, 1, 1.0, 1, 1, 0.5, 0.9, 0.8);

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
