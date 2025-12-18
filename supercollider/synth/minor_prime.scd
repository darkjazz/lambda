
(
~pratios = [];
Array.geom(57, 60, 16/15).do({|root|
	var pratios, primes, scale = root * Scale.minor.ratios;
	primes = scale.collect(_.nearestPrime).postln;
	pratios = primes.collect({|freq| freq / root }).postln;
	~pratios = ~pratios.add(pratios)
})
)

~pratios.flat.asSet.size


(
SynthDef(\prms, {|freq, dur, amp|
	var sig;
	sig = Resonz.ar(
		Crackle.ar(1.8),
		freq,
		dur.reciprocal / freq,
		dur.reciprocal*10
	) **
	PMOsc.ar(
		freq,
		freq*16/15,
		freq.log,
		0.0,
		0.1
	);
	Out.ar(
		0,
		Pan2.ar(
			sig * EnvGen.kr(Env.perc, levelScale: amp, timeScale: dur, doneAction: 2),
			Rand(-0.5, 0.5)
		)
	)
}).add
)


(

// ~scales = Array.geom(57, 60, 16/15).collect({|root|
// 	(root * Scale.minor.ratios).collect(_.nearestPrime)
// });
~scales = Array.geom(73, 60, 16/15).collect(_.nearestPrime).clump(5);
~deltas = [0.15, 0.3, 0.45, 0.6];
Pdef('prms',
	Ppar(
		Array.fill(~deltas.size, {|ind|
			Pbind(\freq,
				Pxrand(
					Array.fill(~scales.size, {|i|
						Prand(~scales[i].keep(3), 3)
					}),
					inf
				),
				\dur, Pwhite(0.3, 0.6),
				\amp, Pwhite(0.01, 0.2),
				\type, Pwrand([\rest, \note], [0.7, 0.3], inf),
				\delta, ~deltas[ind],
				\instrument, \prms
			)
		})
	)
).play
)


Pdef('prms').stop

~rev = SynthDef(\rev, {
	var sg, in = In.ar(0, 2);
	sg = GVerb.ar(in, 20, 4.5);
	ReplaceOut.ar(0, sg)
}).play

~rev.free