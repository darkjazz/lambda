(
~isLIVE = true;
~decoderType = 'stereo';

~ncoef = 20;
~dur = 8 * 60;
~dim = 20;
~tDur = 5000;
~lRate = 0.1;
~isMono = true;

~decoder = FoaDecoder(decoderType: ~decoderType);
if (~isLIVE) {
	~input = MikroFoaInput(~decoder);
}
{
	~input = MikroFoaInput(~decoder, "/Users/alo/sounds/eclambone_samples/*");
};
~graphics = CinderApp(1024, 768, mode: 1);
~analyzer = MikroAnalyzer(maxdur: ~dur, numcoef: ~ncoef, recordInput: true, isMono: ~isMono);

~mikro = Mikro(~input, ~graphics, ~analyzer);
~geenLambda = GeenLambda(~mikro, ~decoder, ~dur);

~geenLambda.prepare

)


~mikro.initPerformance(1);

~geenLambda.start

~composer = ~geenLambda.composer;

s.queryAllNodes

~names = #[ fbgverb, cliq, grains, arhythmic, latch, fbgverb, streamverb ];

~live00 = ~composer.play('fbgverb', argstream: Pn(0.25, inf).asStream);
~composer.releaseSynth(~live00, 20);

s.sendMsg("/n_free", 1005)

~live01 = ~composer.play('cliq', argstream: Pn(0.25, inf).asStream);
~composer.releaseSynth(~live01, 5);

~live02 = ~composer.play('grains', argstream: Pn(0.25, inf).asStream);
~composer.releaseSynth(~live02, 10);

~live03 = ~composer.play('arhythmic', argstream: Pn(0.25, inf).asStream);
~composer.releaseSynth(~live03, 3);

~live04 = ~composer.play('latch', argstream: Pn(0.25, inf).asStream);
~composer.releaseSynth(~live04, 5);

~live05 = ~composer.play('streamverb', argstream: Pn(0.25, inf).asStream);
~composer.releaseSynth(~live05, 20);

(
~analyzer.addMFCCResponderFunction({|ti, re, ms, an|
	var argstr = Pseq(ms[3..mikro.analyzer.numcoef+2].clip(0.0, 1.0), inf).asStream;
	composer.activeSynths.do({|synth|
		var args;
		args = composer.descLib[synth.defName.asSymbol].metadata.specs
			.collect(_.map(argstr.next));
		synth.set(*args.asKeyValuePairs)
	});

});
)


~graphics.setBoidCam(true, true);


~graphics.setBoidCam(false, false);

~graphics.stopRotation;
~graphics.stopMove;
~graphics.setViewpoint(80.0, 80.0, 60.0, 0.0, 0.0, 0.0);




(
~analyzer.onsetAction = {};
~graphics.boidPatternLib.do({|pat, i|
	~graphics.sendBoidPattern(i, 0, 0)
});
~graphics.sendBoidPattern(2, 1, 0);
)

//// clear GEEN ////
~geenLambda.clear







//// prepare SKISM /////
(Document.current.dir +/+ "activateSkism.scd").load


//// SKISM ////

~graphics.stopRotation

~graphics.initWorld(20, 20, 20, ~ncoef)

~graphics.initContinuous;

~graphics.setAdd(0.01);


~graphics.setViewpoint(0.0, 10.0, 100.0, 0.0, 0.0, 0.0);

~graphics.setViewpoint(90.0, 0.0, 0.0, 0.0, 0.0, 0.0);

~graphics.setViewpoint(-60.0, 40.0, 40.0, 0.0, 0.0, 0.0);


~skismDecoder.start;

(
~mikroLambda.group = Group.before(~skismDecoder.synth);

~skismInput.prepare(~mikroLambda.group);
)

//// START SKISM
~mikroLambda.start(-60.dbamp, 0.05, 30);

~recognizer.run

~composer.run



~skismrot = Rotation(30.0, 0.02, 20.0, 80.0, 0.0, 0.01, 0.0, 0.02);
~graphics.setCameraRotation(~skismrot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera

~graphics.stopRotation

s.queryAllNodes

~graphics.setFrameRate(32.0)

~graphics.setInterpolation(1, 2)





// start livecode improv

(
~ncoef = 20;
~rate = 20;
~headsize = 16;
~numgenes = 4;

~dfile = File.open(Document.current.dir +/+ "defnames.scd", "r");
~defarray = ~dfile.readAllString.split(Char.nl).collect(_.asSymbol);
~dfile.close;
~dfile = nil;

~data = ~defarray.collect({|defname|
	var path, meta, data;
	path = UGEP.archDir +/+ defname.asString ++ "." ++ UGEP.fileExt;
	if (File.exists(path)) { data = UGEP.loadData(path) };
	meta = UGenExpressionTree.loadMetadata(defname);
	data['defname'] = defname;
	data['args'] = meta.args.args;
	data['stats'] = meta.stats;
	data
})

)

(
~means = KMeans(4);
~dmeans = KMeans(4);

~data.do({|defdata|
	~means.add(defdata.stats.mfcc.collect(_.stdDev));
	~dmeans.add(defdata.stats.mfcc.collect(_.mean))
});

~means.update;
~dmeans.update;

~foa = #[zoom,focus,push,press];

~assignments = ();

~foa.do({|key| ~assignments[key] = [] });

~means.assignments.do({|assign, i|
	~assignments[~foa[assign]] = ~assignments[~foa[assign]].add(i)
});

~assignments.keys(Array).do({ |key|
	~assignments[key] = ~assignments[key].scramble
});

~foaActive = ~assignments.collect({()});

~sections = #[00,01,02,03];

~sectionAssignments = ();

~sections.do({|key| ~sectionAssignments[key] = [] });

~dmeans.assignments.do({|assign, i|
	~sectionAssignments[~sections[assign]] = ~sectionAssignments[~sections[assign]].add(i)
});

~sectionAssignments.keys(Array).do({ |key|
	~sectionAssignments[key] = ~sectionAssignments[key].scramble
});

~sectionActive = ~sectionAssignments.collect({()})
)

~graphics = CinderApp(800, 600, ciAddr: NetAddr("192.168.0.6", 7000), mode: 0);

~graphics.open

~graphics.sendCodeTitle("statex.newforms")

~ncoef = 20;


~analyzer = MikroAnalyzer(numcoef:~ncoef,recordInput:false,isMono:false);

~decoder = FoaDecoder(decoderType:'quad');




~input = MikroFoaInput(~decoder);

~inputAnalyzer = MikroAnalyzer(numcoef: ~ncoef,recordInput:false,isMono:true);


~player = GepPlayer(~data, ~decoder, ~graphics)

~player.sendEnabled = true

~player.assignCodeWindow(Document.current, "alo$ ")

~graphics.showCodePanel


~graphics.unmapCodePanel


~decoder.start

~graphics.initWorld(20, 20, 20, ~ncoef);

~graphics.initContinuous;

~graphics.setAdd(0.1);


~input.prepare


~analyzer.start(~decoder.bus, ~decoder.synth, \addBefore, 0.01)

~inputAnalyzer.start(~input.bus, ~input.synth, \addBefore, 0.01)


~amparray = Array.fill(30, 0.0)
~peakarray = Array.fill(30, 0.0)

~analyzer.addMFCCResponderFunction({|ti, re, ms, an|
	~graphics.sendSOMVector(ms[3..~ncoef+2])
});


~graphics.setViewpoint(0.0, 130.0, 0.0, 0.0, 0.0, 0.0)

~analyzer.runningOnsetAction = {
	var indx;
	if (~amparray.mean.coin) {
		~rot = Rotation(rrand(20.0, 80.0), rrand(0.001, 0.1), rrand(5.0, 30.0),
			rrand(30.0, 60.0), pi.rand, rrand(0.005, 0.1), pi.rand, rrand(0.005, 0.1));
		~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
		~graphics.rotateCamera
	};
	if (~graphics.patternLib.select({|pat| pat.index > 17 }).collect(_.active).sum > 1) {
		indx = ~graphics.patternLib.select({|pat| pat.index > 17 })
			.collect(_.active).selectIndices({|it| it == 1 }).choose;
		~graphics.setPattern(indx+18, 0, 0.0, 2.rand, 2.rand,
			rrand(0.0, 1.0), rrand(0.0, 1.0), rrand(0.0, 1.0))
	};
	if (~amparray.mean.coin) {
		~graphics.setPattern((18..25).choose, 1, 1.0, 2.rand, 2.rand,
			rrand(0.0, 1.0), rrand(0.0, 1.0), rrand(0.0, 1.0));
		~graphics.setAdd([~amparray.mean, 1.0 - ~amparray.mean].choose);
	}
};

~activeInputPattern = nil;

~inputAnalyzer.runningOnsetAction = {}
~inputAnalyzer.runningOnsetAction = {
	var indx;
	if (~amparray.mean.coin) {
		~rot = Rotation(rrand(20.0, 80.0), rrand(0.001, 0.1), rrand(5.0, 30.0),
			rrand(30.0, 60.0), pi.rand, rrand(0.005, 0.1), pi.rand, rrand(0.005, 0.1));
		~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
		~graphics.rotateCamera
	};
	if (~activeInputPattern.notNil) {
		indx = ~graphics.patternLib.collect(_.active).selectIndices({|it| it == 1 }).first;
		~graphics.setPattern(indx, 0, 0.0, 2.rand, 2.rand,
			rrand(0.0, 1.0), rrand(0.0, 1.0), rrand(0.0, 1.0));
		~activeInputPattern = nil;
	};
	if (~amparray.mean.coin) {
		~graphics.setPattern(5.rand, 1, 1.0, 2.rand, 2.rand,
			rrand(0.0, 1.0), rrand(0.0, 1.0), rrand(0.0, 1.0));
	}
}

~analyzer.putEventResponderFunction(\grphx, {|ti, re, ms, an|
	if (ms[2] == 2) {
		if (ms[3].isNaN.not) {
			~amparray.pop;
			~amparray.insert(0, ms[3])
		}
		{
			~amparray.pop;
			~amparray.insert(0, 1.0.rand)
		}
	}
});



~analyzer.addEventFunc = {|events|
	~peakarray = events.reverse.keep(30).collect(_.amps).collect(_.at(1));
	if (~peakarray.isNil) {
		~peakarray = [0];
	}
}

~player.start(~foa)


~player.playFunc = {|ind, section, synth|
	{
		Server.default.sync;
		~sectionActive[section][ind] = synth.nodeID;
		~sectionAssignments[section].remove(ind);
		~sectionAssignments.keysValuesDo({|key,val|
			Post << key << ": " << val << Char.nl << Char.nl
		});
	}.fork;
	""
};

~player.freeFunc = {|ind|
	var section;
	~sectionActive.keysValuesDo({|key,val|
		if (val.includesKey(ind)) {
			section = key
		}
	});
	if (section.notNil) {
		~sectionActive[section][ind] = nil
	};
	~sectionActive.postln;
};


~player.setFoa('zoom', 1.0)
~player.setFoa('push', 1.0)
~player.setFoa('press', 1.0)
~player.setFoa('focus', 1.0)

// zoom 0 //
~ind0 = 89

~player.play(~ind0, 0, 'zoom', 0)


~player.set(~ind0, 1.0)

~player.setWithPattern(~ind0,
	Pseq([0.1, 0, 0.1, 0.05, 0.15, 1.0, 0.1, 0, 0.2, 0, 0.6, 0.2], inf), 0.125)

~player.setWithPattern(~ind0, Pwhite(0.05, 0.2, inf), Pbrown(0.03125, 0.25, 0.03125, inf))

~player.setWithPattern(~ind0, Pseq(Array.rand(8, 0.0, 1.0).round(0.1), inf), 0.125)


~player.free(~ind0)



// push 1 //
~ind1 = 7

~player.play(~ind1, 0, 'push', 0)


~player.set(~ind1, 1.0)

~player.setWithPattern(~ind1,
	Pseq([0.1, 0, 0.1, 0.05, 0.15, 0.4, 0.1, 0, 0.2, 0, 0.7, 0.2], inf), 0.125)

~player.setWithPattern(~ind1, Pwhite(0.001, 0.01, inf), Pbrown(0.03125, 0.25, 0.03125, inf))

~player.setWithPattern(~ind1, Pseq(Array.rand(8, 0.0, 1.0).round(0.1), inf), 0.125)

~player.free(~ind1)



// press 2 //
~ind2 = 84

~player.play(~ind2, 0, 'press', 0)


~player.set(~ind2, 0.7)

~player.setWithPattern(~ind2,
	Pseq([0.1, 0, 0.1, 0.05, 0.15, 0.4, 0.1, 0, 0.2, 0, 0.7, 0.2, 0.1, 0.1, 0.8], inf), 0.125)

~player.setWithPattern(~ind2, Pwhite(0.05, 0.4, inf), Pbrown(0.03125, 0.25, 0.03125, inf))

~player.setWithPattern(~ind2, Pseq(Array.rand(8, 0.0, 1.0).round(0.1), inf), 0.125)

~player.free(~ind2)



// focus 3 //
~ind3 = 75

~player.play(~ind3, 0, 'focus', 0)


~player.set(~ind3, 1.0)

~player.setWithPattern(~ind3,
	Pseq([0.1, 0, 0.1, 1.0, 1.0, 0.4, 0.1, 0, 1.0, 0, 1.0, 0.2, 0.1, 0.6], inf), 0.125)

~player.setWithPattern(~ind3, Pwhite(0.01, 0.4, inf), Pbrown(0.03125, 0.25, 0.03125, inf))

~player.setWithPattern(~ind3, Pseq(Array.rand(8, 0.0, 1.0).round(0.1), inf), 0.125)

~player.free(~ind3)




s.queryAllNodes

s.sendMsg("/n_free", 1021)


~graphics.mapCodePanel

~graphics.unmapCodePanel