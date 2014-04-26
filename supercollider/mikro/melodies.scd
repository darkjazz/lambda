MikroData.loadPath = "/home/alo/data/mikro/data/lib003/";
~data = MikroData().loadPathMatch;
~order = 2;

~freqSet = MarkovSetN(order: ~order);
~durSet = MarkovSetN(order: 1);

~data.datalib.collect({arg set;
	set.events.collect(_.frqs).collect(_.at(1))
}).values.asArray.flat.slide(~freqSet.order+1, 1).clump(~freqSet.order+1).do({arg freqs;
	~freqSet.read(freqs.keep(~freqSet.order).collect(_.roundFreq).round(0.01), freqs.last.roundFreq.round(0.01))
});

~min = 0.125;
~max = ~data.datalib.collect({arg set;
	set.events.collect(_.duration)
}).values.asArray.flat.maxItem;

~data.datalib.collect({arg set;
	set.events.collect(_.duration)
}).values.asArray.flat.linlin(~min, ~max, 0.125, 2.0).round(0.125).doAdjacentPairs({arg durA, durB;
	~durSet.read(durA, durB)
});


~freqSet.dict.select({arg val, key;
	val.first.size > 1
})

~durSet.dict.select({arg val, key;
	val.first.size > 1
})

~key = ~freqSet.dict.keys(Array).choose;

~freqs = Array.fill(64, {
	var arr, frq = ~freqSet.next(~key);
	arr = ~key.asString.interpret;
	arr.removeAt(0);
	arr = arr.add(frq);
	~key = arr.asSymbol;
	frq
})

~key = ~durSet.dict.keys(Array).choose;

~durSet.next(~key)

~durs = Array.fill(64, {
	~key = ~durSet.next(~key);
})


SynthDef('fr', {|out, amp, freq, dur, rms, rtm|
	var sig, n=4, freqs, ugenargs, amps, ugens, bw;
	ugens = [Dust, Crackle, Logist0, Nagumo];
	freqs = ArrayControl.kr('freqs', 4, 1);
	bw = ArrayControl.kr('bw', 4, 1);
	amps = ArrayControl.kr('amps', 4, 1);
	ugenargs = [[freqs[0]], [1.995], [freqs[2], 3.8, 0.5], [0.1, 0.005, LFPulse.ar(1000,0,0.5,0.5,0.1)]];
	sig = Mix.fill(n, {|i|
		var frq = freq * freqs[i];
		Resonz.ar(ugens[i].ar(*ugenargs[i]), frq, bw[i]/frq ) * amps[i];
	}) * EnvGen.kr(EnvControl.kr, timeScale: dur);
	sig = GVerb.ar(sig * amp, roomsize: rms, revtime: rtm);
	Line.kr(dur: dur + rtm, doneAction: 2);
	Out.ar(out, sig)
}).add



Routine({
	~freqs.do({|freq|

		Synth('fr', [\out, 0, \amp, rrand(4, 8), \dur, 0.25, \rms, 300, \rtm, 2, \freq, freq*[1, 2, 4].choose]).setn('env', Env.perc)
		.setn('freqs', (1..4)).setn('bw', (1 ! 4)).setn('amps', Array.geom(4, 1.0, 0.9) * 10);
		0.125.wait;
	})
}).play


