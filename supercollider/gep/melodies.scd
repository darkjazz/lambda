~scale = Scale.zanjaran

SynthDef('pitch', {|dfreq, ffreq, bw, del, dur, rt, amp|
	var src, sig, n=2;
	src = Dust2.ar(dfreq) + Logistic.ar(3.99, ffreq, 0.5);
	sig = Mix.fill(n, {|i|
		DelayL.ar(
			Resonz.ar(src, ffreq+(i-6*0.2), bw/ffreq, 1+(i*0.1)) 
				* EnvGen.kr(Env.perc(0.1,0.9+(i*0.05)), timeScale: dur), 
		0.2, del+(i*0.04));
	});
	sig.dup + GVerb.ar(sig, 3, rt, 0.9, 0.9, 5, 0, 1.0, 1.0);
	Out.ar(0, sig.softclip * Line.kr(amp, amp, dur: dur + rt, doneAction: 2 ))
}).add

Synth(\pitch, [\dfreq, 20, \ffreq, 300, \bw, 3, \del, 0.03, \dur, 1, \rt, 0.3, \amp, 30])


Pdef('pch',
	Pbind(
		\instrument, \pitch,
		\dfreq, 20, \ffreq, Prand(Array.geom(24, 330, 2**(1/24))[~scale.degrees], inf), 
		\bw, 4, \del, 0,  
		\dur, Prand([0.125], inf), \rt, 0.4, \amp, 30
	)
)

.play
