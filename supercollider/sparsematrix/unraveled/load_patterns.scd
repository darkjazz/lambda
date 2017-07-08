JsonLoader.viewDir = "views";
~loader = JsonLDLoader("rhythm_patterns")

~unraveled = ~loader.db.getParsed("unraveled_by_name", "Basikolo")

~patterns = ~unraveled["rows"][0]["value"]

~patterns = ~patterns.collect({|pat| pat.collect(_.asInt) })

(

// mass generate SynthDefs to save typing
~ugens = [LFNoise2, LFSaw, LFPulse, SinOsc, VarSaw, LFNoise0, LFTri, SinOsc, SinOsc, VarSaw];

//~ugens = PinkNoise.dup(11);

~defs = ~ugens.collect({|ugen, i|
	SynthDef((ugen.name.asString.toLower ++ i.asString).asSymbol, {arg freq, amp, dur, pan;
		Out.ar(0, Pan2.ar(ugen.ar(freq, mul: amp), pan)
			* EnvGen.kr(Env.perc, timeScale: dur, doneAction: 2)
		)
	})
})

)


~defs.do({arg def; def.add })
~defs.do(_.add);

~bpm = 120;
~bps = ~bpm / 60;
~delta = ~bps.reciprocal / 4

(
~freqs = Array.geom(11, 121.0, 2**(1/5));
~binds = ~patterns.size.collect({|i|
	Pbind(
		'instrument', ~defs[i].name,// (ugen.name.asString.toLower ++ i.asString).asSymbol,
		'freq', ~freqs[i],
		'amp', Pwhite(0.2, 0.5, inf),
		'dur', Pbrown(0.05, 0.3, 0.06, inf),
		'delta', Pfunc({ ~delta }),
		'type', Pseq(~patterns[i].replace(0, \rest).replace(1, \note), inf),
		'pan', Pwhite(-1.0, 1.0, inf)
	)
})
)

Pdef('rhythm', Ppar(~binds)).quant(24)

Pdef('rhythm').play

Pdef('rhythm').stop

~patterns.do(_.postln)












// this is bullshit...the better solution would be to not insert zeroes into original sparsematrix
// patterns since they never get used as events anyway
// calculate time intervals between events instead of having a time step
(
~freqs = Array.geom(11, 121.0, 2**(1/5));
~binds = ~patterns.size.collect({|i|
	Pbind(
		'instrument', ~defs[i].name,// (ugen.name.asString.toLower ++ i.asString).asSymbol,
		'freq', ~freqs[i],
		'amp', Pwhite(0.2, 0.5, inf),
		'dur', Pbrown(0.05, 0.3, 0.06, inf),
		'delta', Pfunc({ ~delta }),
		'type', Pseq(~patterns[i].replace(0, \rest).replace(1, \note), inf),
		'pan', Pwhite(-1.0, 1.0, inf)
	)
})
)

~patterns.do({|pat| ~deltaSum.(pat).postln })

~deltaSum = {|pat|
	var arr, delta, sum = 0;
	arr = Array();
	delta = Array();
	pat.do({|ev|
		if (ev.booleanValue) {
			if (sum > 0) { arr = arr.add(\rest); delta = delta.add(sum); };
			arr = arr.add(\note);
			sum = 0;
		};
		sum = sum + 1
	});
	delta = delta.add(sum);
	[arr, delta]
}




~reader = PatternReader()
~pattern = ~reader.load("Basikolo")

