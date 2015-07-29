~file = File.open("/Users/alo/SOVARR/dev/analyze/midinotes_velouria.txt", "r");
~file = File.open("/Users/alo/SOVARR/dev/analyze/midinotes_caribou.txt", "r");


~all = ~file.readAllString;
~file.close; ~file = nil;

~lines = ~all.split(Char.nl)

~events = Array();
~lines.do({|line|
	var start, freq, dur;
	#start, freq, dur = line.split(Char.tab);
	if (start.isEmpty.not)
	{
		~events = ~events.add((start: start.asFloat, freq: freq.asInt.midicps, dur: dur.asFloat))
	}
})

~chords = Array();

~currentStart = ~events.first.start;
~currentClump = Array();
~events.do({|ev|
	if (ev.start != ~currentStart)
	{
		~chords = ~chords.add(~currentClump);
		~currentClump = Array();
		~currentStart = ev.start;
	};
	~currentClump = ~currentClump.add(ev);
})

~freqs = ~chords.collect({|notes| 
	notes.collect(_.freq)
	 //.collect(_.asInt).collect(_.nextPrime) 
});
~amps = 0.3.bubble;
~durs = ~chords.collect(_.first).collect(_.dur);
~deltas = Array();
~chords.collect(_.first).collect(_.start).doAdjacentPairs({|a, b|
	~deltas = ~deltas.add(b - a)
});

SynthDef('pluck', {|freq, amp, dur|
	var sig;
	sig = Pan2.ar(StkPluck.ar(freq, 0.99).distort) * amp 
		* EnvGen.kr(Env.perc(curve: 1.0), timeScale: dur, doneAction: 2);
	Out.ar(0, sig)
}).add

SynthDef('sine', {|freq, amp, dur|
	var sig;
	sig = Pan2.ar(SinOsc.ar(freq)) * amp 
		* EnvGen.kr(Env.perc(curve: 1.0), timeScale: dur, doneAction: 2);
	Out.ar(0, sig)
}).add


Pdef('caribou', 
	Pbind(
		\instrument, 'pluck',
		\freq, Pseq(~freqs, 1), 
		\amp, Pseq(~amps, inf), \delta, Pseq(~deltas, 1), \dur, Pseq(~durs, 1)
	)
).play;

Pdef('caribou').clear
