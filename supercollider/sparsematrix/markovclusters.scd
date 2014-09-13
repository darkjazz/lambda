(
~nclusters = 48;
~headsize = 16;
~numgenes = 4;

~data = UGepLoader(~headsize, ~numgenes).load;

)

(
~clusters = KMeans(~nclusters);

~data.do({|data|
	~clusters.add(data.stats.mfcc.collect(_.mean))
});

~clusters.update;
)

(
MikroData.loadPath = Paths.eventLibDir +/+ "lib003" +/+ "";

~eventData = MikroData().loadPathMatch;
)


/****  PLAY EVENTS  ****/

~decoder = FoaDecoder(decoderType: 'stereo');

~player = GepPlayer(~data, ~decoder, CinderApp());


~foa = #[zoom,focus,push,press];

~decoder.start

~player.start(~foa)



(
~player.setFoa('zoom', 1.0);
~player.setFoa('focus', 1.0);
~player.setFoa('push', 1.0);
~player.setFoa('press', 1.0);
)


~clusters.assignments.indexOf(~clusters.classify(~eventData.datalib['140402_210315'].events.first.meanMFCC))




(

~play = Routine({

	var dataindex, events;
	var min, max, intervals;

	events = ~eventData.datalib['140402_211634'].events;
	dataindex = ~clusters.assignments.indexOf(~clusters.classify(events.first.meanMFCC));

	intervals = [];

	events.doAdjacentPairs({|evA, evB| intervals = intervals.add(evB.start - evA.start) });
	min = intervals.minItem;
	max = intervals.maxItem;

	events.doAdjacentPairs({|evA, evB|
		var delta, foa, cluster=0;
		Post << "Cluster: " << cluster << "  | Index: " << dataindex << Char.nl;
		delta = evB.start - evA.start;
		delta = delta.linlin(min, max, 2.0, 8.0);
		foa = ~foa.choose;
		~player.play(dataindex, 1.0, foa, 0);
		delta.wait;
		~player.free(dataindex);
		cluster = ~clusters.classify(evB.meanMFCC);
		dataindex = ~clusters.assignments.selectIndices({|clst| clst == cluster }).choose;

	})

}).play


)

482, 381, 306

s.queryAllNodes

s.sendMsg("/n_free")

~play.stop

~eventData.datalib.collect(_.events).collect(_.size)

~clusters.assignments.occurrencesOf(12)


~occ = (0..47).collect({|i| ~clusters.assignments.occurrencesOf(i) })

~occ.maxItem


~clusterSet = MarkovSetN(order: 2);



~mfcc = ~eventData.datalib.collect({arg set;
	set.events.collect(_.meanMFCC)
}).values.asArray.flatten.collect({|mfcc|
	~clusters.classify(mfcc)
})



~mfcc.slide(~clusterSet.order+1, 1).clump(~clusterSet.order+1).do({arg index;
	~clusterSet.read(index.keep(~clusterSet.order), index.last)
});


~checkCluster = [];

~clusterSet.dict.keys(Array).do({|key|
	var c1, c2;
	#c1, c2 = key.asString.interpret;
	if (~checkCluster.includes(c1).not) { ~checkCluster = ~checkCluster.add(c1) };
	if (~checkCluster.includes(c2).not) { ~checkCluster = ~checkCluster.add(c2) }
})

(0..47).do({|i|
	if (~checkCluster.includes(i)) {
		Post << i << ": " << ~clusters.assignments.occurrencesOf(i) << Char.nl
	}
})

~makeClusterSeq = {|size|
	var clusters, key = ~clusterSet.dict.keys(Array).choose;

	clusters = Array.fill(size, {
		var arr, clst = ~clusterSet.next(key);
		arr = key.asString.interpret;
		arr.removeAt(0);
		arr = arr.add(clst);
		key = arr.asSymbol;
		clst
	});

	clusters

}


~makeClusterSeq.(64).collect({|index| ~clusters.assignments.indexOf(index) })


~findNearestInCluster = {|index, mfcc|

}






s.queryAllNodes