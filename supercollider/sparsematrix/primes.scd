~allPrimes = Array.primes(13, 20000);

~twinPrimes = Array();
~allPrimes.doAdjacentPairs({|x, y|
	if (y - x == 2) {
		~twinPrimes = ~twinPrimes.addAll([x, y]);
	}
});

SynthDef('pm', {|b, f, a, d, x|
	var sig;
	sig = PMOsc.ar(f, f, x, mul: a) * 
		EnvGen.kr(EnvControl.kr, timeScale: d, doneAction: 2);
	Out.ar(b, sig)
}).add;

SynthDef('gn', {|b, f, a, d|
	var sig;
	sig = Gendy3.ar(3, 3, freq: f) * 
		EnvGen.kr(EnvControl.kr, timeScale: d, levelScale: a, doneAction: 2);
	Out.ar(b, sig)
}).add;

SynthDef('lg', {|b, f, a, d, w, c|
	var sig;
	sig = Resonz.ar(Logist1.ar(f, c), f, w/f, 1000/w) * 
		EnvGen.kr(EnvControl.kr, timeScale: d, levelScale: a, doneAction: 2);
	Out.ar(b, sig)
}).add;

SynthDef('revb', {|b, t|
	var sig, input;
	input = In.ar(b);
	sig = GVerb.ar(input, 50, t, earlyreflevel: 0.3, taillevel: 0.4);
	Out.ar(0, sig)
}).add;

b = Bus.audio;

r = Synth('revb', [\b, b, \t, 1.4]);
r.free
r.set(\t, 2)

~bpm = 144;
~bps = ~bpm/60;
~delta = 

Pdef('primes',
	Pbind(
		\instrument, \lg,
		\b, b,
		\f, Pxrand(~chords, inf),
		\a, 0.1,
		\d, Pbrown(0.5, 2.0, 0.1, inf),
		\w, Pbrown(1, 10, 1, inf),
		\c, Pkey(\f).linlin(~freqs.minItem, ~freqs.maxItem, 1.9, 1.4),
		\delta, Prand(~delta, inf),
		\ekey, Pwrand(~envs.keys(Array), [0.5, 0.1, 0.3, 0.1], inf),
		\env, Pfunc({|ev| ~envs[ev.ekey].asArray.bubble  })
	)
)
