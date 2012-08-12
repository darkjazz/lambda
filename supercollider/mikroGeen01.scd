s.loadDirectory("/Users/alo/Data/gep/synthdefs");

~metadata = UGenExpressionTree.loadMetadataFromDir.select({|data|
	data.stats.mfcc.size == 20 && data.stats.mfcc.collect(_.mean).sum.isNaN.not
});

~ciapp = CinderApp(fps: 10).open;

(
// cluster synthdefs

~nclusters = 64;
~kmeans = KMeans(~nclusters);

~metadata.do({|data|
	~kmeans.add(data.stats.mfcc.collect(_.mean))
});

~kmeans.update
)


(
~data = MikroData().loadPathMatch;

~durSet = MarkovSet();
~freqSet = MarkovSet();
~ampSet = MarkovSet();
~intSet = MarkovSet();
~clusterSet = MarkovSet();

~envSet = FuzzySet();

~timeQuant = (2**6).reciprocal;
~freqQuant = {|freq, octavediv=24, ref=440|
	2**(round(log2(freq/ref)*octavediv)/octavediv)*ref
};
)


(
~data.datalib.keysValuesDo({|key, data|
	var intervals = Array();
	data.events.doAdjacentPairs({|evA, evB|
		~durSet.read(*[evA.duration, evB.duration].round(~timeQuant));
		~freqSet.read(*~freqQuant.([evA.meanFreq, evB.meanFreq]));
		~ampSet.read(*[evA.peakAmp, evB.peakAmp].round(~timeQuant));
		~envSet.put(evA.duration.round(~timeQuant), evA.ampsToEnv(8, 'sine', true, true, true));
		~clusterSet.read( ~kmeans.classify(evA.meanMFCC), ~kmeans.classify(evB.meanMFCC) );
		intervals = intervals.add(evB.start - evA.start);
	});
	~envSet.put(data.events.last.duration.round(~timeQuant), data.events.last.ampsToEnv(8, 'sine', true, true, true));
	intervals.doAdjacentPairs({|intA, intB| ~intSet.read(*[intA, intB].round(~timeQuant))  });
});

~allEvents = ~data.datalib.values.collect(_.events).flat;

)


(
~record = false;

~source = ~allEvents.choose;
~currentEvent = (
	dur: ~source.duration.round(~timeQuant), 
	freq: ~freqQuant.(~source.meanFreq),
	amp: ~source.peakAmp.round(~timeQuant),
	env: ~envSet[~source.duration.round(~timeQuant)],
	cluster: ~kmeans.classify(~source.meanMFCC),
	int: ~intSet.dict.choose[0];
);

~defclusters = ();

~clusterSet.dict.keys(Array).do({|num|
	~defclusters[num] = ~kmeans.assignments.selectIndices({|ind| num == ind })
});

~rout = Routine({
	var dynsynth, mainbus, defaultEnv;
	1.wait;
	defaultEnv = Env([0.001, 1.0, 1.0, 0.001], [0.3, 0.4, 0.3], \sine);
	SynthDef(\dynamics, {|in, ra, rt, er, tl|
		var eq, input, sig, rev;
		eq = (
			ugen: [BLowShelf, (BPeakEQ ! 3), BHiShelf].flat,
			freq: Array.geom(5, "c 3".notemidi.midicps, 3.6),
			bw: [0.65, 1, 3.5, 1.5, 1],
			db: [4, 0, -4, 2, 6]
		);
		input = Limiter.ar(In.ar(in, 2).tanh, -1.0.dbamp, 0.1);
		
		sig = Mix.fill(5, {|i| eq.ugen[i].ar(input, eq.freq[i], eq.bw[i], eq.db[i]) });
		rev = GVerb.ar(sig[0] * ra, 10, rt, drylevel: 0, earlyreflevel: er, taillevel: tl);
		Out.ar(0, ((sig**0.3) + rev) * -1.0.dbamp)
	}).add;
	SynthDef(\procgen, {|out, in, dur, amp|
		var env, input;
		env = EnvControl.kr(size: 16);
		input = In.ar(in, 2) * EnvGen.kr(env, timeScale: dur, levelScale: amp, doneAction: 3);
		Out.ar(out, input)
	}).add;
	s.sync;
	mainbus = Bus.audio(s, 2);
	s.sync;
	dynsynth = Synth(\dynamics, [\in, mainbus, \ra, 0.06, \rt, 3, \er, 0.7, \tl, 0.7]);
	if (~record) {s.record};
	CmdPeriod.add({ if (~record) { s.stopRecording }; dynsynth.free; mainbus.free; });
	s.sync;
	loop({
		var synth, defindex, data, bus, args, dur, env;
		bus = Bus.audio(s, 2);
		defindex = ~defclusters[~currentEvent.cluster].choose;
		data = ~metadata[defindex];
		args = data.args;
		args.selectIndices({|item| item > ~freqQuant.("c 0".notemidi.midicps) }).do({|argindex|
			args[argindex] = ~freqQuant.(args[argindex], 24, ~currentEvent.freq)
		});
		if (~currentEvent.env.levels.size > 16) { env = defaultEnv } { env = ~currentEvent.env };
		synth = Synth.before(dynsynth, data.defname, [\out, bus] ++ args);
		Synth.after(synth, \procgen, [\out, mainbus, \in, bus, \dur, ~currentEvent.dur * 2, \amp, ~currentEvent.amp])
			.setn(\env, env);
		SystemClock.sched(~currentEvent.dur * 2, { bus.free; bus = nil; });
		~currentEvent.int.wait;
		dur = ~durSet.next(~currentEvent.dur);
		~currentEvent = (
			dur: dur, 
			freq: ~freqSet.next(~currentEvent.freq),
			amp: ~ampSet.next(~currentEvent.amp),
			env: ~envSet[dur],
			cluster: ~clusterSet.next(~currentEvent.cluster),
			int: ~intSet.next(~currentEvent.int) ? 1.0
		)
	})
}).play
)


~rout.stop

s.stopRecording
