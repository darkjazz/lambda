(
~chordloader = ChordLoader("/Users/alo/Data/pixies/pixieschords.csv");

~chordloader.load;

~durset = MarkovSet();
~deltaset = MarkovSet();
~chordset = MarkovSet();

~uchords = ();

~chordloader.chords.do({|chord|
	~uchords[chord.getKey] = chord.getFreqs
});

~deltas = [];

~chordloader.chords.doAdjacentPairs({|chA, chB|
	~chordset.read(chA.getKey, chB.getKey);
	~durset.read(chA.getDur.round(1/16), chB.getDur.round(1/16));
	~deltas = ~deltas.add((chB.getStartTime - chA.getStartTime).round(1/16));
});

~deltas.doAdjacentPairs({|dA, dB| ~deltaset.read(dA, dB) });

)

(
~len = 7;
~key = ~uchords.keys(Array).choose;
~chords = ~len.collect({
	~key = ~chordset.next(~key)	
});

~freqs = ~chords.collect({|key| ~uchords[key].collect(_.asInt)
	.collect(_.prevPrime) });
~dur = ~chordloader.chords.choose.getDur.round(1/16);
~durs = ~len.collect({ ~dur = ~durset.next(~dur) });
~delta = ~deltas.choose;
~deltas = ~len.collect({ ~delta = ~deltaset.next(~dur) });
~amps = ~len.collect({ rrand(0.2, 0.4) });
)


SynthDef('pluck', {|freq, amp, dur|
	var sig;
	sig = Mix(SinOsc.ar([freq * 0.5, freq, freq * 64], 
		LFSaw.kr(8).range(0, 2), [amp * 0.5, amp, amp * 0.2]))
		* EnvGen.kr(Env.perc, timeScale: dur, doneAction: 2);
	Out.ar(0, Pan2.ar(sig))
}).add


SynthDef('pluck', {|freq, amp, dur|
	var sig;
	sig = LPF.ar(PMOsc.ar(freq, freq * 4, 100) * amp, freq * 4 )
		+ Mix(SinOsc.ar([freq * 0.5, freq * 0.25], 0, amp))
		* EnvGen.kr(Env.perc, timeScale: dur, doneAction: 2);
	Out.ar(0, Pan2.ar(sig))
}).add

(
Pdef('caribou', 
	Pbind(
		\instrument, 'pluck',
		\freq, Pseq(~freqs, inf), 
		\amp, Pseq(~amps, inf), \dur, Pseq(~durs * 0.25, inf), 
		\delta, Pseq(~deltas * 0.25, inf)
	)
)
)
Pdef('caribou').play;
Pdef('caribou').clear


