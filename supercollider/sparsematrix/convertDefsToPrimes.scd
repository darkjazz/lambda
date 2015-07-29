~fnc = {|freq=40| Mix(SinOsc.ar(Array.primesN(4, freq), 0.5pi)) }

~makeDef = {|name, func|
	SynthDef(name, {|out, efx, dur = 0.1, amp = 1.0, freq = 32.0, emp = 0.0, rotx = 0.0, roty = 0.0, rotz = 0.0|
		var sig;
		sig = SynthDef.wrap(func, prependArgs: [freq] )
			* EnvGen.kr(EnvControl.kr, timeScale: dur, doneAction: 2);
		Out.ar(efx, sig * emp);
		Out.ar(out, FoaTransform.ar(
			FoaEncode.ar(sig * amp, FoaEncoderMatrix.newDirection), 'rtt', rotx, roty, rotz)
		)
	}).add;
};


~makeDef.('r0000', ~fnc)