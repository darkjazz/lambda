SynthDef('fm', {|out, fcar, fmod, index, amp, dur|
	var sig;
	sig = PMOsc.ar(fcar, fmod, index) * amp;
	Out.ar(out, sig * EnvGen.kr(Env.perc, Impulse.kr(1/dur), timeScale: dur))
}).add


~synth = Synth('fm', ['out', 0, 'fcar', 10, 'fmod', 10, 'index', 1, 'amp', 0.3, 'dur', 0.1])

OSCdef('android-acc', {|msg|
	msg.postln;
	~synth.set('fcar', msg[1].linexp(-10, 10, 20, 8000), 'fmod', msg[1].linexp(10, -10, 20, 8000),
		'index', msg[2].linexp(-10, 10, 1, 100), 'dur', msg[3].linexp(-10, 10, 0.01, 0.5)
	)
}, '/accxyz');

OSCdef('android-acc').clear



