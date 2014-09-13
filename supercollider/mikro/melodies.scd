MikroData.loadPath = "/Users/alo/data/mikro/lib004/";
~data = MikroData().loadPathMatch;
~order = 3;

~freqSet = MarkovSetN(order: ~order);
~durSet = MarkovSetN(order: ~order);
~ampSet = MarkovSetN(order: ~order);



~data.datalib.collect({arg set;
	set.events.collect(_.frqs).collect(_.at(1))
}).values.asArray.flat.slide(~freqSet.order+1, 1).clump(~freqSet.order+1).do({arg freqs;
	~freqSet.read(freqs.keep(~freqSet.order).collect(_.roundFreq).round(0.01), freqs.last.roundFreq.round(0.01))
});


~data.datalib.collect({arg set;
	set.events.collect(_.duration)
}).values.asArray.flat.slide(~durSet.order+1, 1).clump(~durSet.order+1).do({arg durs;
	~durSet.read(durs.keep(~durSet.order).collect(_.round(1/32)), durs.last.round(1/32))
});

//~collectdurs = ~data.datalib.collect({arg set;
//	set.events.collect(_.duration)
//}).values.asArray.flat.select({|dur| dur < 10  });
//~min = ~collectdurs.minItem;
//~max = ~collectdurs.maxItem;
//~round = 1/32;

//~collectdurs.round(~round).doAdjacentPairs({arg durA, durB;
//	~durSet.read(durA, durB)
//});

~data.datalib.collect({arg set;
	set.events.collect(_.peakAmp)
}).values.asArray.flat.slide(~ampSet.order+1, 1).clump(~ampSet.order+1).do({arg amps;
	~ampSet.read(amps.keep(~ampSet.order).round(0.01), amps.last.round(0.01))
});

~freqSet.dict.select({arg val, key;
	val.first.size > 1
})

~durSet.dict.select({arg val, key;
	val.first.size > 1
})

~ampSet.dict.select({arg val, key;
	val.first.size > 1
})

~freqSet.dict.keys.do({|key| ~freqSet.dict[key].size.postln })


(
var length = 32;

~key = ~freqSet.dict.keys(Array).choose;

~freqs = Array.fill(length, {
	var arr, frq = ~freqSet.next(~key);
	arr = ~key.asString.interpret;
	arr.removeAt(0);
	arr = arr.add(frq);
	~key = arr.asSymbol;
	frq
});

~key = ~durSet.dict.keys(Array).choose;

~durs = Array.fill(length, {
	var arr, dur = ~durSet.next(~key);
	arr = ~key.asString.interpret;
	arr.removeAt(0);
	arr = arr.add(dur);
	~key = arr.asSymbol;
	dur
});

~key = ~ampSet.dict.keys(Array).choose;

~amps = Array.fill(length, {
	var arr, amp = ~ampSet.next(~key);
	arr = ~key.asString.interpret;
	arr.removeAt(0);
	arr = arr.add(amp);
	~key = arr.asSymbol;
	amp
})
)


~freqs.collect(_.cpsmidi).collect(_.midinote)





SynthDef('pluck', {|freq, amp, dur|
	var sig;
	sig = tanh(CrossoverDistortion.ar(
		GVerb.ar(StkPluck.ar(freq, 0.5), 3, 1), amp, 0.7)
	) * 0.5 * EnvGen.kr(Env.perc(curve: -2.0), timeScale: dur, doneAction: 2);
	Out.ar(0, sig)
}).add

~pat = Pbind(
	\instrument, 'pluck',
	\freq, Pseq(~freqs, inf) * Prand([1, 1, 1, 1, 2, 2, 3, 4], inf), 
	\amp, Pseq(~amps, inf), \delta, Pseq(~durs, inf), \dur, Pkey(\delta) * Pwhite(1.0, 2.0, inf)
)

Pdef('pixies', ~pat)

~player = Pdef('pixies', ~pat).play
 
~player.stop

SynthDef('fsyn00', {|out, efx, amp, emp, freq, dur, rms, rtm|
	var sig, n=4, freqs, ugenargs, amps, ugens, bw;
	ugens = [Dust, Crackle, Logist0, Nagumo];
	freqs = ArrayControl.kr('freqs', 4, 1);
	bw = ArrayControl.kr('bw', 4, 1);
	amps = ArrayControl.kr('amps', 4, 1);
	ugenargs = [[freq], [1.995], [freq, freq.explin(20, 2000, 1.0, 2.0), 0.1],
		[0.1, 0.005, LFPulse.ar(freq*4,0,0.5,0.5,0.1), 0.1]];
	sig = Mix.fill(n, {|i|
		var frq = freq * freqs[i];
		BPF.ar(ugens[i].ar(*ugenargs[i]), frq, bw[i]/frq, 20-bw ) * amps[i];
	}) * EnvGen.kr(EnvControl.kr, timeScale: dur, doneAction: 2);
	Out.ar(efx, sig * emp);
	Out.ar(out, FoaTransform.ar(
		FoaEncode.ar(sig * amp, FoaEncoderMatrix.newDirection), 'rtt', rotx, roty, rotz)
	)
}).add

SynthDef('reverb', {|in, rms, rtm|
	var sig;
	sig = GVerb.ar(In.ar(in), roomsize: rms, revtime: rtm, drylevel: 0,
		earlyreflevel: 0.3, taillevel: 0.4
	).distort;
	Out.ar(0, sig)
}).add;

~bus = Bus.audio(s);
~rev = Synth('reverb', [\in, ~bus, \rms, 100, \rtm, 3]);
~rev.set(\rtm, 1, \rms, 100)

~rev.free

Pdef('ml00',
	Pbind(\instrument, \fsyn00, \out, ~bus,
		\amp, Pseq(~amps, 4), \dur, Pseq(~durs* 2, 4), \freq, Pseq(~freqs, 4),
		\freqs, (1..4).bubble, \bw, (1 ! 4).bubble, \amps, (Array.geom(4, 1.0, 0.9)).bubble,
		\envindex, Pseq((0..4).stutter(4), inf),
		\env, Pfunc({|ev|
			[Env.perc, Env.sine, Env.triangle, Env([0.001, 1.0], [1], 4)].at(ev['envindex']).asArray.bubble
		})
	)
)
.play


s.queryAllNodes

SynthDef('fsyn01', {|out, amp, freq, dur, bw|
	var sig;
	sig = Resonz.ar(
		Nagumo.ar(0.1, 0.005, LFPulse.ar(freq*4,0,0.5,0.5,0.1), 0.1), freq, bw/freq, amp
	) * EnvGen.kr(EnvControl.kr, levelScale: 20-bw, timeScale: dur, doneAction: 2);
	Out.ar(out, sig)
}).add

~player = Pbind(\instrument, \fsyn01, \out, ~bus, \bw, 4, \target, ~rev, \addAction, \addBefore,
	\amp, Pseq(~amps * 4, 4), \dur, Pseq(~durs * 2, 4), \fund, Pseq(~freqs, 4),
	\freq, Pkey(\fund) * Prand([1, 2, 4], inf),
	\env, Env.perc.asArray.bubble
).play

~player.stop