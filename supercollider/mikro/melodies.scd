MikroData.loadPath = "/home/alo/data/mikro/data/lib003/";
~data = MikroData().loadPathMatch;
~order = 2;

~freqSet = MarkovSetN(order: ~order);
~durSet = MarkovSetN(order: 1);
~ampSet = MarkovSetN(order: ~order);

~data.datalib.collect({arg set;
	set.events.collect(_.frqs).collect(_.at(1))
}).values.asArray.flat.slide(~freqSet.order+1, 1).clump(~freqSet.order+1).do({arg freqs;
	~freqSet.read(freqs.keep(~freqSet.order).collect(_.roundFreq).round(0.01), freqs.last.roundFreq.round(0.01))
});

~collectdurs = ~data.datalib.collect({arg set;
	set.events.collect(_.duration)
}).values.asArray.flat.select({|dur| dur < 10  });
~min = 0.0625;
~max = ~collectdurs.maxItem;

~collectdurs.linlin(~min, ~max, ~min, 4.0).round(0.0625).doAdjacentPairs({arg durA, durB;
	~durSet.read(durA, durB)
});

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
}).size


(
~key = ~freqSet.dict.keys(Array).choose;

~freqs = Array.fill(64, {
	var arr, frq = ~freqSet.next(~key);
	arr = ~key.asString.interpret;
	arr.removeAt(0);
	arr = arr.add(frq);
	~key = arr.asSymbol;
	frq
});

~key = ~durSet.dict.keys(Array).choose;


~durs = Array.fill(64, {
	~key = ~durSet.next(~key);
});

~key = ~ampSet.dict.keys(Array).choose;


~amps = Array.fill(64, {
	var arr, amp = ~ampSet.next(~key);
	arr = ~key.asString.interpret;
	arr.removeAt(0);
	arr = arr.add(amp);
	~key = arr.asSymbol;
	amp
})
)

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