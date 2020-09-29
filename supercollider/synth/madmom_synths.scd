(
Synth('osc', {|buf, amp, rmp, dur, early, tail, rate|
	var sig, trig, rev, freqs;
	env = EnvControl.kr;
	freqs = ArrayControl.kr('freqs', 6, 0);
	trig = Impulse.kr(rate);
	sig = Resonz.ar(
		Osc.ar(buf, Demand.kr(trig, 0, Drand(freqs, inf)), 0, amp),
		, SinOsc.kr(rate*0.7).range(0.3, 0.6))
	* EnvGen.kr(Env.perc(curve: 2), trig, timeScale: dur);
	rev = GVerb.ar(sig * rmp, 40, 7.0, drylevel: 0, earlyreflevel: early, taillevel: tail);
	sig = LPF.ar(sig.dup + rev, LFSaw.kr(4).range(673, 113)) * EnvGen.kr(env, timeScale:  doneAction: 2);
	Out.ar(0,
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

~buf.plot


(
~lib = MadmomFeatureLib("/Users/alo/dev/reveries/audio.json");

~keys = #[tiersen, idioteque, lorelei, everything];
~intervalKeys = ['afx', 'blue-world'];

~lib.trainChordSets(~keys, 3);
~lib.trainIntervalSets(~intervalKeys, 3);
)

(
~chords = ~lib.generateChordSequence(13, nil, 5);
~chords = ~chords * (1..4);
~primeChords = ~chords.collect({|chord| chord.collect(_.nearestPrime) }).collect(_.asFloat);
)


MasterEQ(2)
Ndef('osc').play;


Ndef('osc').set('buf', ~buf,  'amp', 1.0, 'rmp', 0.2, 'dur', 0.1, 'early', 1.0, 'tail', 1.0, 'rate', ~matrix.beatdur * 16).setn('freqs', ~primeChords.scramble.keep(6))




~primeChords.collect(_.at(0))

Ndef('osc').stop


s.scope(2)

~droneChords = ~primeChords


Ndef('grain', {|trate=20, gdur=0.1, rmp=1.0, rtm=11, early=0.1, tail=1.0|
	var sig, trig, rev, freqs;
	trig = Dust.kr(trate);
	freqs = ArrayControl.kr('freqs', 13, 0);
	sig = FMGrain.ar(trig, TRand.kr(gdur*0.5, gdur*2.0, trig),
		Demand.kr(trig, 0, Drand(freqs, inf)),
		Demand.kr(trig, 0, Dseq(freqs, inf)),
		Demand.kr(trig, 0, Dseq(Array.primes(1, 11).mirror, inf))
	);
	rev = GVerb.ar(sig * rmp, 600, rtm,
		drylevel: 0, earlyreflevel: early, taillevel: tail, maxroomsize: 600);
	LPF.ar(rev, 501.nextPrime) + HPF.ar(rev, 10001.nextPrime, 0.1)
})


~primeChords.flat.size

Ndef('grain').play

Ndef('grain').set('trate', 23, 'gdur', 0.01, 'rtm', 7, 'early', 0.3, 'tail', 0.7)

Ndef('grain').setn('freqs', ~primeChords.flat.keep(13))

Ndef('grain').setn('freqs', ~droneChords.collect(_.at(2)).scramble.keep(13))

Ndef('grain').clear



~primeChords.flat.size

6/373
631/10149

~bassChords = ~primeChords

Ndef('pluck', {|rate, dec, coef, amp|
	var freq = ArrayControl.kr('freq', 5, 0);
	Pan2.ar(
		LeakDC.ar(
			Pluck.ar(WhiteNoise.ar, Impulse.kr(rate), 1, 1 / freq, dec, coef).sum * amp
		)
	)
})

Ndef('pluck').set('rate', ~matrix.beatdur * 2, 'dec', 10, 'freq', ~bassChords.scramble.keep(5), 'coef', 0.8, 'amp', 0.2)

Ndef('pluck').play

111/8
111/8

Ndef('pluck').clear

Ndef('pluck').setn('freqs', ~primeChords.flat)




MasterEQ(2)

s.scope(2)




Synth('')



