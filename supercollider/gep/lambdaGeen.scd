(
~ncoef = 20;
~rate = 20;
~headsize = 16;
~numgenes = 4;

~meta = UGenExpressionTree.loadMetadataFromDir.select({|data| data.args.isKindOf(Event) });
~data = ~meta.collect({|meta|
	var data, path = UGEP.archDir +/+ meta.defname.asString ++ "." ++ UGEP.fileExt;
	if (File.exists(path)) { 
		data = UGEP.loadData(path) 
	};
	data['defname'] = meta.defname;
	data['args'] = meta.args.args;
	data['stats'] = meta.stats;
	data
});
~inds = ~data.selectIndices({|data| data.header.headsize == ~headsize  });
~meta = ~inds.collect({|index| ~meta[index] });
~data = ~inds.collect({|index| ~data[index] });
~list = ~data.collect(_.code);
)

(
~indices=[1,4,5,8,9,10,11,12,14,15,18,21,22,23,24,25,26,28,32,34,36,37,38,40,41,
44,45,46,48,49,50,51,54,55,58,59,60,63,64,66,67,68,69,70,71,72,73,74,77,78,79,81,
82,83,85,86,87,89,92,93,95,96,97,100,101,103,104,105,107,108,109,111,112,113,115,
116,117,118,120,123,124,126,127,128,129,130,132,133,134,138,139];
~means = KMeans(4);
~dmeans = KMeans(4);

~indices.do({|ind|
	~means.add(~data[ind].stats.mfcc.collect(_.stdDev));
	~dmeans.add(~data[ind].stats.mfcc.collect(_.mean))
});

~means.update;
~dmeans.update;

~foa = #[zoom,focus,push,press];

~assignments = ();

~foa.do({|key| ~assignments[key] = [] });

~means.assignments.do({|assign, i|
	~assignments[~foa[assign]] = ~assignments[~foa[assign]].add(~indices[i])
});

~assignments.keys(Array).do({ |key|
	~assignments[key] = ~assignments[key].scramble
});

~foaActive = ~assignments.collect({()});

~sections = #[00,01,02,03];

~sectionAssignments = ();

~sections.do({|key| ~sectionAssignments[key] = [] });

~dmeans.assignments.do({|assign, i|
	~sectionAssignments[~sections[assign]] = ~sectionAssignments[~sections[assign]].add(~indices[i])
});

~sectionAssignments.keys(Array).do({ |key|
	~sectionAssignments[key] = ~sectionAssignments[key].scramble
});

~sectionActive = ~sectionAssignments.collect({()})
)





~graphics = CinderApp(1024, 768, mode: 1);

~graphics.open

~graphics.sendCodeTitle("statex.newforms")


~analyzer = MikroAnalyzer(numcoef:~ncoef,recordInput:false,isMono:false);

~decoder = FoaDecoder(decoderType:'quad');




~input = MikroFoaInput(~decoder);

~inputAnalyzer = MikroAnalyzer(numcoef: ~ncoef,recordInput:false,isMono:false);


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

~input.synth.set(\mamp, 0)

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

//~analyzer.removeEventResponderFunction(\grphx)



~player.start(~foa)

//~player.playFunc = {|ind, foaKind, synth|
//	{
//		Server.default.sync;
//		~foaActive[foaKind][ind] = synth.nodeID;
//		~assignments[foaKind].remove(ind);
//		~assignments.keysValuesDo({|key,val| Post << key << ": " << val << Char.nl << Char.nl });
//	}.fork;
//	""
//};

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

~player.synths[1].stopPattern

~player.defStrings.do(_.postln);
""

s.queryAllNodes

~graphics.mapCodePanel

~assignments['zoom']



~player.setFoa('zoom', 1.0)

// zoom 0 //
~ind0 = 1

~player.play(~ind0, 0, 'zoom', 0)


~player.set(~ind0, 0.1)

~player.setWithPattern(~ind0, Pseq([0.1, 0, 0.1, 0.05, 0.15, 0.4, 0.1, 0, 0.2, 0, 0.3, 0.2], inf), 0.125)

~player.setWithPattern(~ind0, Pwhite(0.05, 0.1, inf), Pbrown(0.03125, 0.25, 0.03125, inf))

~player.setWithPattern(~ind0, Pseq(Array.rand(8, 0.0, 1.0).round(0.1), inf), 0.125)



~player.free(~ind0)

~ind1 = 73

~player.play(~ind1, 0.0, 'zoom', 0)

~player.set(~ind1, 0.4)

~player.setWithPattern(~ind1, Pseq([0.1, 0.6, 0.1, 0.05, 0.3, 0.7, 0.1, 0].scramble, inf), 0.25)

~player.setWithPattern(~ind1, Pseq([0.3, 0.4, 0.5, 0.3, 0.4, 0.5, 0.1, 0.2].scramble, inf), 0.25)

~player.setWithPattern(~ind1, Pseq(Array.rand(24, 0.0, 0.5).round(0.1), inf), 0.125)

~player.setWithPattern(~ind1, Pwhite(0.01, 0.1, inf), Pbrown(0.03125, 0.25, 0.03125, inf))


~player.setWithPattern(~ind1, Pwhite(0.001, 0.1, inf), Prand([0.1, 0.05, 0.08, 0.3], inf))



~player.free(~ind1)


// focus 1 //

~ind1 = 55

~player.play(~ind1, 0.0, 'focus', 1)

~player.setFoa('focus', 0.0)

~player.free(~ind1)


// push 2 //

~player.setFoa('push', 1.0)

~ind2 = 58

~player.play(~ind2, 0.0, 'push', 2)


~player.setWithPattern(~ind2, Pwhite(0.01, 0.4, inf), Pbrown(0.03125, 0.25, 0.03125, inf))


~player.set(~ind2, 0.3)

~player.free(~ind2)

s.queryAllNodes


~ind3 = 36

~player.play(~ind3, 0.0, 'push', 2)


~player.setWithPattern(~ind3, Pwhite(0.001, 0.01, inf), Pbrown(0.03125, 0.25, 0.03125, inf))

~player.setWithPattern(~ind3, Pseq([0.01, 0.2, 0.1, 0.05, 0.1, 0.1, 0.1, 0.05].scramble, inf), 0.25)


~player.set(~ind3, 0.05)

~player.free(~ind3)


// press 3 //

~ind3 = 12

~player.play(~ind3, 'press')

~player.setFoa('press', 0.0)

~player.free(~ind3)


~decoder.free

Server.default.queryAllNodes

s.sendMsg("/n_free", 1039)

//Document.themes.put(\livecode,
//Ê Ê (
//Ê Ê Ê Ê classColor: Color.new255(53, 74, 187),
//Ê Ê Ê Ê textColor: Color.new255(200, 200, 200),
//Ê Ê Ê Ê stringColor: Color.new255(96, 129, 158),
//Ê Ê Ê Ê commentColor: Color.new255(206, 27, 28),
//Ê Ê Ê Ê symbolColor: Color.new255(57, 154, 20),
//Ê Ê Ê Ê numberColor: Color.new255(157, 80, 65)
//Ê Ê )
//);
//Document.setTheme(\default)
~doc = Document()
~doc.background_(Color.grey(0.0, 0.8))
~doc.stringColor_(Color.grey(0.9))
~doc.prSetBounds(Rect(0, 0, 800, 600))
~doc.front


~graphics.resetWorld(9, 9, 9, 4, 4, 4)

~graphics.setPattern(0, 0, 1.0, 1, 1, 0.6, 0.8, 1.0);

~graphics.setPattern(1, 0, 1.0, 1, 1, 0.9, 0.1, 0.4);

~graphics.setPattern(2, 0, 1.0, 1, 1, 0.5, 0.75, 0.9);

~graphics.setPattern(3, 0, 1.0, 1, 0, 0.6, 0.8, 0.8);

~graphics.setPattern(4, 1, 1.0, 0, 0, 1.0, 1.0, 0.3);


~graphics.setPattern(18, 0, 1.0, 0, 0, 0.9, 0.1, 0.4);

~graphics.setPattern(19, 0, 1.0, 1, 0, 0.5, 0.75, 0.9);

~graphics.setPattern(20, 0, 1.0, 0, 0, 0.6, 0.8, 0.8);

~graphics.setPattern(21, 0, 1.0, 1, 1, 0.5, 0.5, 0.5);

~graphics.setPattern(22, 0, 1.0, 1, 1, 0.9, 0.7, 0.9);

~graphics.setPattern(23, 0, 1.0, 1, 1, 0.7, 0.9, 1.0);

~graphics.setPattern(24, 0, 0.1, 0, 0, 0.3, 1.0, 0.8);

~graphics.setPattern(25, 1, 0.1, 0, 0, 0.6, 0.7, 0.9);


~graphics.activateSwarm(16, 200.0, 200.0, 200.0, 0.8, 50.0, 8.0, 5.0, 100.0);

~graphics.sendBoidPattern(4, 1, 4);

~graphics.setViewpoint(50.0,50.0,50.0, 0.0, 0.0, 0.0)

~graphics.setSwarm(0.8, 50.0, 8.0, 15.0, 100.0)

~graphics.killSwarm

~graphics.setBoidCam(false, false)


~rot = Rotation(40.0, 0.01, 30.0, 60.0, 0.0, 0.021, 0.0, 0.012);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera

~graphics.stopRotation

~graphics.mapCodePanel

~graphics.setFrameRate(24.0)
