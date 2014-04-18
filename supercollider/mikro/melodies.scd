MikroData.loadPath = "/Users/alo/Data/mikro/lib003/";
~data = MikroData().loadPathMatch;

~freqSet = MarkovSetN(order: 3);
~durSet = MarkovSetN(order: 3);
~deltaSet = MarkovSetN(order: 3);





~data.datalib.collect({|set|
	set.events.collect(_.frqs).collect(_.at(1))
}).values.asArray.flat.do({|freq|
	
})


~data.datalib['140402_220352'].events.collect({|ev| ev.frqs.collect(_.at(1)) })
	.collect(_.size).do(_.postln)
	
~data = datalib['140402_220352'].events.collect({|ev| ev.frqs.collect(_.at(1)) })
	.collect(_.size).do(_.postln)

SynthDef('fr', {|out, amp, dur|
	var sig, n=4, freqs;
	ugens = [Dust, Crackle, Logist0, Nagumo];
	freqs = ArrayControl.kr('freqs', 8, 1);
	rq = ArrayControl.kr('rq', 8, 1);
	sig = Mix.fill(n, {|i|
		ugens[i].ar()
	});
})
