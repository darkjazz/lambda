(
~chordloader = ChordLoader(Paths.dataDir +/+ "pixies/pixieschords.csv");

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
~len = 37;
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

(
~lenb = 7;
~keyb = ~uchords.keys(Array).choose;
~chordsb = ~lenb.collect({
	~keyb = ~chordset.next(~keyb)
});

~freqsb = ~chordsb.collect({|key| ((~uchords[key].collect(_.asInt) * 0.25).asInt)
	.collect(_.prevPrime) });
~durb = ~chordloader.chords.choose.getDur.round(1/16);
~dursb = ~lenb.collect({ ~durb = ~durset.next(~durb) });
~deltab = ~deltas.choose;
~deltasb = ~lenb.collect({ ~deltab = ~deltaset.next(~durb) });
~ampsb = ~lenb.collect({ rrand(0.3, 0.5) });
)



(
SynthDef('pluck', {|freq, amp, dur|
	var sig;
	sig = DelayN.ar(
		Decimator.ar(VarSaw.ar(freq, LFSaw.ar(freq).range(0, 2pi), 0.4, amp),8810,8) * EnvGen.kr(EnvControl.kr, timeScale: dur, doneAction: 2),
		0.2,
		Rand(0.02, 0.04)
	);
	Out.ar(0, Pan2.ar(sig))
}).add
)

SynthDef('pluck', {|freq, amp, dur|
	var sig;
	sig = Mix(SinOsc.ar([freq * 0.5, freq, freq * 64],
		LFSaw.kr(8).range(0, 2), [amp * 0.5, amp, amp * 0.2]))
		* EnvGen.kr(EnvControl.kr, timeScale: dur, doneAction: 2);
	Out.ar(0, Pan2.ar(sig))
}).add


SynthDef('pluck', {|freq, amp, dur|
	var sig;
	sig = LPF.ar(PMOsc.ar(freq, freq * 23, Line.kr(20, 40, dur)) * amp, freq * 4 )
		+ Mix(SinOsc.ar([freq * 0.5, freq * 0.25], 0, amp))
		* EnvGen.kr(Env.perc, timeScale: dur, doneAction: 2);
	Out.ar(0, Pan2.ar(sig))
}).add

SynthDef('gverb', {|dry, rt|
	var sig, input;
	sig = GVerb.ar(In.ar(0, 2), 300, rt, drylevel:dry);
	ReplaceOut.ar(0, sig)
}).add

~rev = Synth('gverb', ['dry', 0.5, 'rt', 1.0])

~rev.set('dry', 1.0, 'rt', 0.2)

~rev.free

s.sendMsg("/n_free", 8328)


(
Pdef('caribou',
	Ppar([
		Pbind(
			\instrument, 'pluck',
			\freq, Pseq(~freqs, inf),
			\amp, Pseq(~amps, inf) * 0.5, \dur, Pseq([0.125], inf),
			\env, Env.perc.asArray.bubble
		),
		Pbind(
			\instrument, 'pluck',
			\freq, Pseq(~freqsb, inf),
			\amp, Pseq([0.5] , inf), \dur, Pseq([0.5], inf),
			\env, Env.perc(0.05).asArray.bubble
		)
	])
)
)


Pdef('caribou').play;

Pdef('caribou').clear

s.scope
