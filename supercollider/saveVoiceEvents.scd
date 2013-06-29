(

~ncoef = 20;

~buffer = Buffer.read(s, "/Users/alo/sounds/voice/2012/Record_Sep18");
~bus = Bus.audio(s);

SynthDef(\input, {|out, buf|
	var sig;
	sig = PlayBuf.ar(1, buf, doneAction: 2);
	Out.ar(out, sig)
}).add;

SynthDef(\input2, {|out, buf|
	var sig;
	sig = Mix(PlayBuf.ar(2, buf, doneAction: 2));
	Out.ar(out, sig)
}).add;

)

~analyzer = MikroAnalyzer(~buffer.duration, ~ncoef, false, false);

(
if (~buffer.numChannels == 1) {
	~synth = Synth(\input, [\out, ~bus, \buf, ~buffer])
}{
	~synth = Synth(\input2, [\out, ~bus, \buf, ~buffer])
};
~analyzer.start(~bus, ~synth, \addAfter, -12.dbamp, 0.06, 30);

OSCFunc({|msg|
 	~analyzer.free;
 	"analysis finished...".postln;
}, '/n_end', s.addr).oneShot;
)


~analyzer.events.size

~analyzer.elapsedTime


(
~rout = Routine({
	~analyzer.events.do({|event|
		{
			VarSaw.ar(event.meanFreq) * 
			EnvGen.kr(event.ampsToEnv(16, 'sine', true, true, true, 0.001), levelScale: event.peakAmp,
				timeScale: event.duration, doneAction: 2)
		}.play;
		event.duration.wait
	})
}).play
)

~rout.stop


MikroData.savePath = "/Users/alo/Data/mikro/lib001/"

~analyzer.saveEvents





~analyzer.eventIntervals

~analyzer.events.collect(_.duration).minItem
~analyzer.events.collect(_.duration).maxItem
~analyzer.events.collect(_.duration).mean

~analyzer.clusterEvents(0.4)

~analyzer.clusters.collect(_.size)

~analyzer.clusters.collect(_.size)


~analyzer.eventdiff

~analyzer.visualize

~buffer.duration

s.queryAllNodes


~analyzer.events[0].ampsToEnv(8, 'sine', true).plot

~analyzer.events[0].duration

~analyzer.events.keep(4).do({|ev|
	ev.ampsToEnv(12, 'sine', true, true).plot
})


~analyzer.events.do({|ev|
	[ev.duration, ev.peakAmp].postln
})

~analyzer.events.do({|ev|
	ev.mfcs.collect(_.at(1)).mean.postln
})


~analyzer.clusterBoundaries