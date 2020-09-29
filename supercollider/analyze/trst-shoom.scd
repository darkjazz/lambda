f = File("/Users/alo/dev/lambda/supercollider/analyze/trst-shoom.json", "r");
z = f.readAllString;
f.close;
~features = z.parseJson;

~features.keys(Array)


~features["chords"].do(_.postln)
~features["notes"].do(_.postln)

~features["tempo"]

~features.keys()

x = { SinOsc.ar(164).dup * EnvGen.kr(Env.perc, Impulse.kr(~bps), timeScale: 0.3) }.play
x.free
~bpm = 100;
~bps = ~bpm / 60;


52.midicps

Scale

ChordNote

~chords = (
	'C:maj': ["C" "E" "G"],
	'C#:maj': ["C#", "E#", "G#"],
	'D:maj': ["D", "F#", "A"],
	'D#:maj': ["Eb", "G", "Bb"],
	'Eb:maj': ["Eb", "G", "Bb"],
	'E:maj': ["E", "G#", "B"],
	'F:maj': ["F", "A", "C"],
	'F#:maj': ["F#", "A#", "C#"],
	'G:maj': ["G" "B" "D"],
	'Ab:maj': ["Ab", "C", "Eb"],
	'A:maj': ["A", "C#", "E"],
	'A#:maj': ["Bb", "D", "F"],
	'Bb:maj': ["Bb", "D", "F"],
	'B:maj': ["B", "D#", "F#"],
	'C:min': ["C", "Eb", "G"],
	'C#:min': ["C#", "E", "G#"],
	'D:min': ["D", "F", "A"],
	'D#:min': ["D#", "E#", "F#"],
	'Eb:min': ["Eb", "Gb", "Bb"],
	'E:min': ["E", "G", "B"],
	'F:min': ["F", "Ab", "C"],
	'F#:min': ["F#", "A", "C#"],
	'G:min': ["G", "Bb", "D"],
	'Ab:min': ["Ab", "B", "Eb"],
	'A:min': ["A", "C", "E"],
	'A#:min': ["A#", "B#", "C#"],
	'Bb:min': ["Bb", "Db", "F"],
	'B:min': ["B", "D", "F#"],
	'N': []
)

~get_freqs = {|chord, octave|
	~chords[chord.asSymbol].collect({|str| (str.toLower ++ " " ++ octave.asString).notemidi.midicps })
}
~features["chords"].do({|dict|
	if (~chords[dict["chord"].asSymbol].isNil) { dict["chord"].postln };
	~chords[dict["chord"].asSymbol].collect({|str| (str.toLower ++ " " ++ "4").notemidi.midicps }).postln
})



Pdef('playnotes',
	Ppar([
		Pbind('instrument', 'notes', 'dur', 0.5, 'amp', 0.5,
			'freq', Pseq([
				Pseq([ 277.18263097687, 329.62755691287, 415.30469757995, 277.18263097687 * 2 ], 4),
				Pseq([ 220, 277.18263097687, 329.62755691287, 440 ], 4)
			], inf),
			'bw', Pseg(Pseq([5, 10, 5]), Pseq(((100 / 60).reciprocal * 8).dup), 'sine', inf),
			'delta', (100 / 60).reciprocal / 4
		),
		Pbind('instrument', 'bass', 'dur', 0.5, 'amp', 0.3,
			'freq', Pseq([
				Pseq([277.18263097687 * 0.125], 16),
				Pseq([220 * 0.125], 16),
			], inf),
			'delta', (100 / 60).reciprocal
		),
		Pbind('instrument', 'saw', 'dur', 0.1, 'amp', 0.05,
			'freq', Pseq( [Pn(277.18263097687 * 0.25, 16), Pn(220 * 0.25, 16)], inf),
			'del', (100 / 60).reciprocal / 4, 'dec', (100 / 60).reciprocal * 4,
			'delta', (100 / 60).reciprocal / 4
		)
	])
).play

Pdef('playnotes').clear

277.18263097687 * 2

(61+1).nextPrime

~get_freqs.('C#:min', 5)


SynthDef('notes', {|freq, dur, amp, bw|
	var sig;
	sig = Resonz.ar(PMOsc.ar(freq, freq, 10), freq, bw / freq) * EnvGen.kr(Env.perc, levelScale: amp, timeScale:dur, doneAction: 2);
	Out.ar(0, sig.dup )
}).add

SynthDef('bass', {|freq, dur, amp|
	var bass;
	bass = SinOsc.ar(freq, 0.5pi) * EnvGen.kr(Env.perc(curve:2), levelScale: amp, timeScale:dur, doneAction: 2);
	Out.ar(0, bass.dup)
}).add

SynthDef('saw', {|freq, amp, dur, del, dec|
	var src, sig;
	src = Decimator.ar(LFSaw.ar(freq, 0), freq*4)
	* EnvGen.kr(Env([0, 1, 1, 0], [0, 1, 0]), levelScale: amp, timeScale: dur, doneAction: 2);
	// sig = CombC.ar(src, 0.5, del, dec) * Line.kr(1, 1, dec, doneAction: 2);
	Out.ar(0, src.dup)
}).add



~features["chords"].do({|dict|
	Post << dict["start"] << ": " << dict["chord"] << Char.nl
})

~chords['C#:min'].collect({|str| (str.toLower ++ " " ++ "4").notemidi.midicps })

(~bps/2)

Ndef('buzz', {|amp=0|
	var sig, freqs, trig, n=4;
	trig = Impulse.kr(~bps / 2);
	freqs = ArrayControl.kr('freqs', n, 0);
	sig = Mix.arFill(n, {|i|
		DelayC.ar(
			SinOsc.ar(freqs[i]) * EnvGen.kr(Env.perc, trig, levelScale: amp, timeScale: 0.3),
			~bps / 6, (~bps / 6) * i
		)
	});
	Pan2.ar(sig)
}).play(out: 0, numChannels: 2)


Tdef('play', {
	~features["chords"].do({|dict|
		var freqs, time;
		time = dict["end"].asFloat - dict["start"].asFloat;
		freqs = ~chords[dict["chord"].asSymbol].collect({|str|
			(str.toLower ++ " " ++ "4").notemidi.midicps
		});
		if (freqs.size == 3) {
			Ndef('buzz').setn('freqs', freqs * [0.5, 1.0, 2.0, 2.0]);
			Ndef('buzz').set('amp', 0.6);
		};
		time.wait;
	})
}).play

Tdef('play').clear

Ndef('buzz').set('amp', (52.midicps * 2).nearestPrime)

Ndef('buzz').clear



