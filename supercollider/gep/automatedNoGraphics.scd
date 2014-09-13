(
~ncoef = 20;
~rate = 20;
~headsize = 16;
~numgenes = 4;

~data = UGepLoader(~headsize, ~numgenes).load;

~foa = #[zoom,focus,push,press];

)


(

~means = KMeans(4);
~dmeans = KMeans(8);

~data.do({|dataitem|
	~means.add(dataitem.stats.mfcc.collect(_.stdDev));
	~dmeans.add(dataitem.stats.mfcc.collect(_.mean));
});

~means.update;
~dmeans.update;


~assignments = ();

~foa.do({|key| ~assignments[key] = [] });

~means.assignments.do({|assign, i|
	~assignments[~foa[assign]] = ~assignments[~foa[assign]].add(i)
});

~assignments.keys(Array).do({ |key|
	~assignments[key] = ~assignments[key].scramble
});

~foaActive = ~assignments.collect({()});

~sections = (0..7);

~sectionAssignments = ();

~sections.do({|key| ~sectionAssignments[key] = [] });

~dmeans.assignments.do({|assign, i|
	~sectionAssignments[~sections[assign]] = ~sectionAssignments[~sections[assign]].add(i)
});

~sectionAssignments.keys(Array).do({ |key|
	~sectionAssignments[key] = ~sectionAssignments[key].scramble
});

~sectionActive = ~sectionAssignments.collect({()});

~minSectionDur = 1000;
~maxSectionDur = 1200;
~minItems = ~sectionAssignments.collect(_.size).values.minItem;
~maxItems = ~sectionAssignments.collect(_.size).values.maxItem;

~meanSectionDurations = ~sectionAssignments.collect({|assignments|
	assignments.size.linlin(~minItems, ~maxItems, ~minSectionDur, ~maxSectionDur)
});

~meanFragmentDurations = ~sectionAssignments.collect({|assignments|
	assignments.size.linlin(~minItems, ~maxItems, ~minSectionDur, ~maxSectionDur) / assignments.size
});

~meanFragmentDurations = ~meanFragmentDurations.collect({|frag| rrand(20.0, 30.0) })

)


(

~graphics = CinderApp();

~decoder = FoaDecoder(decoderType:'stereo');

~player = GepPlayer(~data, ~decoder, ~graphics);

~currentSection = ~sectionAssignments.keys(Array).first;

)


(
~decoder.start;

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

(
~player.setFoa('zoom', 1.0);
~player.setFoa('focus', 1.0);
~player.setFoa('push', 1.0);
~player.setFoa('press', 1.0);

)


~data[63]

~player.play(63, 1.0, 'zoom', 0)

~player.free(63)

~player.play(105, 1.0, 'zoom', 0)

~player.free(105)

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
					if (array.includes(index))
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
			(~meanFragmentDurations[section] * rrand(0.25, 0.5)).wait;
		});
		Post << "FINISHED SECTION " << section << Char.nl;
		rrand(5.0, 10.0).wait;
	});

	30.wait;
	~player.free

}).play

)

~sectionAssignments

s.queryAllNodes

s.boot

