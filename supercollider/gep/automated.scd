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
~dmeans = KMeans(8);

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

~sections = (0..7);

~sectionAssignments = ();

~sections.do({|key| ~sectionAssignments[key] = [] });

~dmeans.assignments.do({|assign, i|
	~sectionAssignments[~sections[assign]] = ~sectionAssignments[~sections[assign]].add(~indices[i])
});

~sectionAssignments.keys(Array).do({ |key|
	~sectionAssignments[key] = ~sectionAssignments[key].scramble
});

~sectionActive = ~sectionAssignments.collect({()});

~minSectionDur = 120;
~maxSectionDur = 420;
~minItems = ~sectionAssignments.collect(_.size).values.minItem;
~maxItems = ~sectionAssignments.collect(_.size).values.maxItem;

~meanSectionDurations = ~sectionAssignments.collect({|assignments|
	assignments.size.linlin(~minItems, ~maxItems, ~minSectionDur, ~maxSectionDur)
});

~meanFragmentDurations = ~sectionAssignments.collect({|assignments|
	assignments.size.linlin(~minItems, ~maxItems, ~minSectionDur, ~maxSectionDur) / assignments.size
});

)


~graphics = CinderApp(800, 600, mode: 0);

~graphics.open

~graphics.sendCodeTitle("ges.automaton")


~analyzer = MikroAnalyzer(numcoef:~ncoef,recordInput:false,isMono:false);

~decoder = FoaDecoder(decoderType:'stereo');


~player = GepPlayer(~data, ~decoder, ~graphics)

~player.sendEnabled = true

~player.assignCodeWindow(Document.current, "alo$ ")

~graphics.showCodePanel



~decoder.start

~graphics.initWorld(20, 20, 20, ~ncoef);

~graphics.initContinuous;

~graphics.setAdd(0.05);


~analyzer.start(~decoder.bus, ~decoder.synth, \addBefore, 0.01)

(
~amparray = Array.fill(30, 0.0);
~peakarray = Array.fill(30, 0.0);

~analyzer.addMFCCResponderFunction({|ti, re, ms, an|
	~graphics.sendSOMVector(ms[3..~ncoef+2])
});

~libPatterns = (0..7) ++ (18..25);

~currentSection = ~sectionAssignments.keys(Array).first;

~sectionPatterns = [
	(0..7), 
	~libPatterns.scramble.clump(4) ++ ~libPatterns.scramble.clump(4)
].lace(16).asArgsDict;

~analyzer.runningOnsetAction = {
	var indx, ampdev, xspeed;
	if (~amparray.mean.coin) {
		ampdev = ~amparray.stdDev(~amparray.mean);
		xspeed = ampdev.expexp(0.001, 1.0, 0.00001, 0.8);
		~rot = Rotation(rrand(20.0, 80.0), xspeed, rrand(5.0, 30.0), 
			rrand(30.0, 60.0), pi.rand, rrand(0.005, 0.1), pi.rand, rrand(0.005, 0.1));
		~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
		~graphics.rotateCamera	
	};
	if (~graphics.patternLib.select({|pat| ~libPatterns.includes(pat.index) }).collect(_.active).sum > 1) {
		indx = ~graphics.patternLib.select({|pat| 
			~libPatterns.includes(pat.index).and(pat.active.booleanValue) 
		}).choose.index;
		~graphics.setPattern(indx, 0, 0.0, 2.rand, 2.rand, 
			rrand(0.0, 1.0), rrand(0.0, 1.0), rrand(0.0, 1.0))
	};
	if (~amparray.mean.coin) {
		~graphics.setPattern(~sectionPatterns[~currentSection].choose, 1, 1.0, 2.rand, 2.rand, 
			rrand(0.0, 1.0), rrand(0.0, 1.0), rrand(0.0, 1.0));
		~graphics.setAdd([~amparray.mean, 1.0 - ~amparray.mean].choose);
	}
};


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

)

(
~player.start(~foa);

~player.playFunc = {|ind, section, synth|
	{
		Server.default.sync;
		~sectionActive[section][ind] = synth.nodeID;
//		~sectionAssignments[section].remove(ind);
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

)

~graphics.unmapCodePanel

~graphics.showCodePanel

(
~player.setFoa('zoom', 1.0);
~player.setFoa('focus', 1.0);
~player.setFoa('push', 1.0);
~player.setFoa('press', 1.0);

)

(
Routine({
	~sectionAssignments.keys(Array).do({|section|
		Post << "BEGINNING SECTION " << section << Char.nl;
		~currentSection = section;
		~sectionAssignments[section].do({|index|
			Post << "Starting " << index << Char.nl;
			Routine({
				var foa, level, att, sus, rel;
				~assignments.keysValuesDo({|key, array|
					if (array.includes2(index))
					{
						foa = key
					}
				});
				#att, sus, rel = ~meanFragmentDurations[section] * rrand(0.75, 1.5) 
					* (Array.rand(3, 0.2, 1.0) * [0.5, 1.0, 0.5]).normalizeSum;
				level = rrand(0.4, 0.8);
				~player.play(index, 0.0, foa, section);
				~player.fade(index, 0.0, level, att);
				(att+sus).wait;
				~player.fade(index, level, 0.0, rel);
				rel.wait;
				~player.free(index)
			}).play;
			(~meanFragmentDurations[section] * rrand(0.33, 0.67)).wait;
		});
		Post << "FINISHED SECTION " << section << Char.nl;
		rrand(5.0, 10.0).wait;
	});
	
	30.wait;
	~player.free
	
}).play
)

s.queryAllNodes
