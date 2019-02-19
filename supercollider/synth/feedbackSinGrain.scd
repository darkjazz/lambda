(
SynthDef('grain', {|out, amp, dur, ebf|
	var osc1, osc2, osc3, tr1, tr2, tr3, freqs, amps, bf, env, n = 3, wghts, trigs;
	var theta, dr1, dr2, dr3, fb;
	theta = (Array.series(3, 0, 2/3) * pi).stutter + [-0.1pi, 0.1pi];
	wghts = [0.6, 0.2, 0.2];
	freqs = ArrayControl.kr('freqs', n*3, 1.0);
	amps = ArrayControl.kr('amps', n, 1.0);
	env = EnvControl.kr;
	fb = LocalIn.ar(3);
	#tr1, tr2, tr3 = Lag.ar(fb.linlin(-1.0, 1.0, 5.0, 50.0), 0.2);
	#dr1, dr2, dr3 = Lag.ar(fb.linlin(-1.0, 1.0, 0.1, 0.01), 0.2);
	trigs = [ Dust.kr(tr2), Dust.kr(tr3), Dust.kr(tr1) ];
	osc1 = SinGrainBBF.ar(trigs[0], dr3, Dwrand(freqs[(0..2)], wghts, inf), ebf,
		TRand.kr(theta[0], theta[1], trigs[0]), 0, 1, 0);
	osc2 = SinGrainBBF.ar(trigs[1], dr1, Dwrand(freqs[(3..5)], wghts, inf), ebf,
		TRand.kr(theta[2], theta[3], trigs[1]), 0, 1, 0);
	osc3 = SinGrainBBF.ar(trigs[2], dr2, Dwrand(freqs[(6..8)], wghts, inf), ebf,
		TRand.kr(theta[4], theta[5], trigs[2]), 0, 1, 0);
	LocalOut.ar(osc1, osc2, osc3);
	bf = (osc1 + osc2 + osc3) * EnvGen.kr(env, timeScale: dur, doneAction: 2);
	Out.ar(out, bf)
}).add;
)

Server.killAll

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

Pdef('cloud',
	Pbind('instrument', 'grain', 'out', ~decoder.bus, 'addAction', 'addBefore', 'target', ~decoder.synth,
		'amp', Pwhite(0.05, 0.1), 'dur', Pwhite(0.3, 1.0), 'ebf', Env.perc.bubble,
		'freqs', Pseq(~freqs, inf), 'amps', Array.geom(3, 1.0, 0.618).bubble, 'env', Env.sine.bubble,
		'delta', Pstutter(Pwhite(1, 4), Prand([1/3, 1/5, 1/7, 1/11], inf))
	)
)

Pdef('cloud').play




17/20000
47/20000

1-(0.9906/0.9943)
1-(0.9346/0.96)

(
Tdef('cloud', {
	var delta = Pstutter(Pwhite(1, 4), Prand([1/3, 1/5, 1/7, 1/11], inf)).asStream;
	loop({
		Synth.before(~decoder.synth, 'grain', ['out', ~decoder.bus, 'amp', rrand(0.05, 0.1), 'dur', rrand(0.3, 1.0), 'theta', rrand(-pi, pi), 'phi', rrand(-0.5pi, 0.5pi)]).setn('freqs', ~freqs).setn('amps', Array.rand(3, 0.5, 1.0)).setn('inds', ~inds).setn('env', Env.perc);
		// .setn('env', Env([0.0, 1.0, 0.0], Array.rand(2, 0.1, 1.0).normalizeSum, Array.rand(2, 1.0, 4.0)));
		delta.next.wait;
	})
}).play
)