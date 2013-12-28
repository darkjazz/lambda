MikroData.loadPath = "/Users/alo/Data/mikro/lib002/";

~geen = MikroGeen(64, (2**5).reciprocal, "/Users/alo/Data/geplib/2013-03-11/synthdefs");

~geen.loadEventData

~data = ~geen.eventData

~events = ~data.datalib.values.first.events

SynthDef(\simple, {|freq, amp, dur|
	var sig;
	sig = LFSaw.ar(freq, LFSaw.ar(freq,0,freq.sqrt), amp) 
		* EnvGen.kr(EnvControl.kr, timeScale: dur, doneAction: 2);
	Out.ar(0, Pan2.ar(sig))
}).add


Tdef(\simple, {
	~events.do({|ev, i|
		var delta = 0;
		Synth(\simple, [\freq, ev.meanFreq, \amp, ev.meanAmp, \dur, ev.duration])
			.setn('env', Env.perc);
		if (i < ~events.lastIndex) {
			delta = ~events[i+1].start - ev.start;
		};
		delta.wait;
	})
}).play

Tdef(\simple).clear

~events.do({|ev, i|
	Post << "MFCC: " << ev.meanMFCC.keep(4).round(0.01) << Char.nl;
	Post << "AMP: " << ev.meanAmp.round(0.01) << Char.nl;
	Post << "FLAT: " << ev.meanFlatness.round(0.01) << Char.nl;
	Post << "FREQ: " << ev.meanFreq.round(0.01) << Char.nl;
	Post << "DUR: " << ev.duration.round(0.01) << Char.nl;
	Post << "TYPE: " << ~means.assignments[i] << Char.nl;
	"".postln;
})

~means = KMeans(32)

~events.do({|ev|
	~means.add([
		ev.meanMFCC.keep(4).round(0.01),
		ev.meanAmp.round(0.01),
		ev.meanFlatness.round(0.01),
		ev.meanFreq.expexp(20.0, 20000.0, 0.01, 1.0).round(0.01),
		ev.duration.round(0.01)
	].flat)
})

~means.update

~means.assignments

(0..~means.k-1).collect({|num| ~means.assignments.occurrencesOf(num) })