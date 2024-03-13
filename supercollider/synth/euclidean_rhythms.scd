
b = Bjorklund2()

(
// ~br = { | o = 1, p = 4 |
// 	(o / p * (0..p - 1)).floor.differentiate.asInteger.min(1)[0] = if (o <= 0) { 0 } { 1 };
// };

// mass generate SynthDefs to save typing
~ugens = [SinOsc, LFNoise2, LFSaw, LFPulse, SinOsc, VarSaw, LFNoise0, LFTri, SinOsc, SinOsc, VarSaw];

//~ugens = PinkNoise.dup(11);

~defs = ~ugens.collect({|ugen, i|
	SynthDef((ugen.name.asString.toLower ++ i.asString).asSymbol, {arg freq, amp, dur, pan;
		Out.ar(0, Pan2.ar(ugen.ar(freq, mul: amp), pan)
			* EnvGen.kr(Env.perc, timeScale: dur, doneAction: 2)
		)
	})
});

~scale = (Array.geom(12, 67, 2**(1/12))[Scale.minor.degrees].dup(2) * (1..2)).flat;

)



Array.primes(3, 32).do({|k|
	~br.(k, 32).postln;
	Bjorklund(k, 32).postln;
	"---".postln;
})

~br.(5, 32).rotate(-2)
Bjorklund(5, 8)





(
~defs.do(_.add);

~makePat = {|o, p, d, inst|
	var div, pat;
	div = 1 / d;
	Pbind('instrument', inst,
		'delta', div, 'pat', Pbjorklund(o, p),
		'type', Pfunc({|ev| if (ev.pat == 1) {\note} {\rest} }),
		'amp', rrand(0.4, 0.7), 'dur', 0.2,
		'freq', ~scale.choose,
		'pan', Pwhite(-1.0, 1.0)
	)
}
)


Pdef('beats').play


p = Pif(Pbjorklund(5, 8), \note, \rest).asStream
p.next


(
Pdef('beats', Ppar(
	Array.fill(11, {|i|
		~makePat.(Array.primes(1, 7).choose, 16, 8, ~defs.choose)
	})
))
)



Pdef('beats').clear


(
~steps = 128;
Array.primes(3, ~steps).do({|num|
	Bjorklund(num, ~steps).postln
});
)


~pb = ~makePat.(3, 16).play;

~pb.stop
