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
~len = 13;
~key = ~uchords.keys(Array).choose;
~chords = ~len.collect({
	~key = ~chordset.next(~key)
});

~freqs = ~chords.collect({|key| ~uchords[key].collect(_.asInt)
	.collect(_.nearestPrime) });
~freqs = ~freqs.collect({|chord|
	chord.keep(3).collect({|freq| [ freq, (freq-1).prevPrime, (freq+1).nextPrime ]  }).flat.bubble
});
~dur = ~chordloader.chords.choose.getDur.round(1/16);
~durs = ~len.collect({ ~dur = ~durset.next(~dur) });
~delta = ~deltas.choose;
~deltas = ~len.collect({ ~delta = ~deltaset.next(~dur) });
~amps = ~len.collect({ rrand(0.2, 0.4) });
)

~decoder = FoaDecoder(decoderType: 'stereo');

~decoder.start

(
Synth('osc', {|buf, amp, rmp, rt, dur, early, tail, rate|
	var sig, trig, rev, freqs, env;
	env = EnvControl.kr;
	freqs = ArrayControl.kr('freqs', 6, 0);
	trig = Impulse.kr(rate);
	sig = Resonz.ar(
		Osc.ar(buf, Demand.kr(trig, 0, Drand(freqs, inf)), 0, amp),
		freqs[1], SinOsc.kr(rate*0.7).range(0.3, 0.6)
	) * EnvGen.kr(Env.perc(curve: 2), trig, timeScale: dur);
	rev = GVerb.ar(sig * rmp, 40, rt, drylevel: 0, earlyreflevel: early, taillevel: tail);
	sig = LPF.ar(sig.dup + rev, LFSaw.kr(4).range(673, 113))
	* EnvGen.kr(env, timeScale: dur+rt, doneAction: 2);
	Out.ar(0, sig)
}).add
)

Ndef('osc').play

Ndef('osc').clear

(
~frqs = Array.primesN(11, 3);
~frqs[0] = 1;
~buf = Buffer.alloc(s, 1024);
~buf.sine2(~frqs, Array.geom(~frqs.size, 1, 0.77))
)
