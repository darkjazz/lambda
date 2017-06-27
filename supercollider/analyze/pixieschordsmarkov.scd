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
~len = 11;
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

SynthDef('nested_fm_sin', {|out, amp, dur|
	var sig, freqs, inds;
	freqs = ArrayControl.kr('freqs', 5, 1);
	inds = ArrayControl.kr('inds', 5, 1);
	sig = SinOsc.ar(freqs[0]
		+ SinOsc.ar(freqs[1]
			+ SinOsc.ar(freqs[2]
			), 0, inds[1] * freqs[1]
		), 0, inds[0] * freqs[0]
	) + SinOsc.ar(freqs[3]
		+ SinOsc.ar(freqs[4], 0, inds[4] * freqs[4]), 0, inds[3] * freqs[3]
	), 0, inds[2] * freqs[2];
	Out.ar(out, Pan2.ar(sig * EnvGen.kr(Env.perc, timeScale: dur, doneAction: 2), 0, amp))
}).add


f = ~freqs.collect(_.at(0)).scramble

p = Ppar( [ Pbind(\freq, z, \amp, 0.5, \dur, 0.24), Pbind(\freq, b, \amp, 0.7, \dur, 0.72)]).play

0.24 * 6 / 2

p.stop

z = Pseq([
	Pseq([ 463, 193, 367, 389, 409, 109, 113, 367, 311, 587, 523 ], 3),
	Pn(0, 22)
], inf)


z = Pseq([
	Pseq([ 463, 193, 367, 389, 409, 109, 113, 367, 311, 587, 523 ], 3),
	Pseq([ 389, 193, 439, 439, 311, 523, 463, 463, 389, 389, 127 ], 3),
	Pseq([ 389, 587, 439, 317, 199, 367, 587, 181, 151, 389, 317 ], 2)
], inf)
b = Pseq([ 109, 199, 151, 181, 113, 127, 193, 139, 109, 127, 193 ], inf)