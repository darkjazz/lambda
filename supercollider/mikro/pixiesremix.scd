MikroData.loadPath = "/Users/alo/data/mikro/lib004/";

~datalib = MikroData().loadPathMatch;

~key = ~datalib.datalib.keys(Array).sort[15]


~data = MikroData().loadPathMatch(MikroData.loadPath ++ "140827_160537.events");


~events = ~datalib.datalib[~key].events

~events = ~data.datalib.values.first.events


~noteocc = ();

~events.collect(_.meanFreq).collect(_.cpsmidi).collect(_.midinote).do({|note|
	var key = note.asSymbol;
	if (~noteocc.includesKey(key))
	{
		~noteocc[key] = ~noteocc[key] + 1;	
	}
	{
		~noteocc[key] = 1;
	}
})

~noteocc.size


~flatocc = ();

~events.collect(_.meanFlatness).round(0.001).do({|flat|
	var key = flat.asSymbol;
	if (~flatocc.includesKey(key))
	{
		~flatocc[key] = ~flatocc[key] + 1;	
	}
	{
		~flatocc[key] = 1;
	}
})


~mfccocc = ();

~events.collect(_.meanMFCC).collect(_.mean).round(0.001).do({|mfcc|
	var key = mfcc.asSymbol;
	if (~mfccocc.includesKey(key))
	{
		~mfccocc[key] = ~mfccocc[key] + 1;	
	}
	{
		~mfccocc[key] = 1;
	}
})


~mfccocc.keys(Array).asFloat.minItem

~stats.collect(_.mfcc).round(0.001).minItem

~pfreqs = ~events.collect(_.meanFreq)
~tfreqs = ~pfreqs.collect({|frq| frq * 2 })

~pfreqs = (~events.collect(_.meanFreq).collect(_.asInt) * 2).collect(_.nextPrime)
~tfreqs = (~pfreqs + 1).collect(_.nextPrime)

~durs = ~events.collect(_.duration)
~amps = ~events.collect(_.meanAmp)



b = Bus.audio;

SynthDef('pm', {|ou, fr, mo, am, du, xi|
	var sig;
	sig = PMOsc.ar(fr, mo, xi, mul: am) * Gendy3.ar(3, 3, freq: fr)
		* EnvGen.kr(EnvControl.kr, timeScale: du, doneAction: 2);
	Out.ar(ou, sig)
}).add;


SynthDef('gn', {|ou, fr, am, du|
	var sig;
	sig = Gendy3.ar(3, 3, freq: fr) * 
		EnvGen.kr(EnvControl.kr, timeScale: du, levelScale: am, doneAction: 2);
	Out.ar(ou, sig)
}).add;

SynthDef('revb', {|in, ti, ea, ta|
	var sig, input;
	input = In.ar(in);
	sig = GVerb.ar(input, 100, ti, 
		drylevel: 1,
		earlyreflevel: ea,
		taillevel: ta
	);
	Out.ar(0, sig)
}).add;


r = Synth('revb', [\in, b, \ti, 3, \ea, 0.1, \ta, 0.1]);

r.set(\ti, 1)

(
Pdef('pixiesprimes',
	Pbind(
		\instrument, \pm,
		\ou, b,
		\fr, Pseq(~pfreqs , 1),
		\mo, Pseq(~tfreqs, 1),
		\am, Pseq(~amps, 1),
		\du, Pseq(~durs, 1),
		\delta, Pkey(\du) * 0.8,
		\xi, Pseq(~durs.reciprocal, 1),
		\env, [Env.sine]
	)
).play;
)

r.free

Pdef('pixiesprimes').clear



