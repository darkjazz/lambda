Ndef('klank', {|freq=17, nhrm=47, rate=2|
	var sig, frqs, amps, rngs, blip, n=11, fltn, trg, klnk;
	trg = Impulse.kr(rate);
	blip = Blip.ar(freq, nhrm);
	frqs = Array.primeSeries(n, 17, 3);
	amps = Array.geom(n, 1, 0.99 );
	rngs = amps.reverse;
	fltn = Mix(Resonz.ar(WhiteNoise.ar, Array.geom(11, freq, 1.5), 1/freq, Array.geom(11, pi**pi,0.8) )) *
	EnvGen.kr(Env.perc(curve: -16), trg, timeScale: 1/rate*0.5);
	klnk = Klank.ar(`[frqs, amps, rngs], blip);
	sig =   fltn;
	sig.dup * EnvGen.kr(Env.perc(curve: -4), trg, timeScale: 1/rate)
})

Ndef('klank').clear

Ndef('klank').play

// ~frqs = Array.primeSeries(11, 47, 3);
// ~amps = Array.geom(11, 1, 1-pi.reciprocal );
// ~rngs = ~amps.reverse;
// Tdef('klank').set('freq', 47, 'nhrm', 37, 'rate', 2).setn('frqs', ~frqs, 'amps', ~amps, 'rngs', ~rngs)

s.scope(2)



Server.killAll


SynthDef(\bitSt3, {|out, efx, amp, emp, buf, dur, rotx, roty, rotz|
	var sig;
	sig = Normalizer.ar(
		PlayBuf.ar(2, buf, BufRateScale.ir(buf)),
		amp) * EnvGen.kr(EnvControl.kr, timeScale: dur, doneAction: 2);
	Out.ar(efx, sig * emp);
	// Out.ar(out, FoaTransform.ar(
	// 	FoaEncode.ar(sig * amp, FoaEncoderMatrix.newDirection), 'rtt', rotx, roty, rotz)
	// )
}).add;

Synth(\bitSt3, [\efx, 0, \emp, 1, \buf, ~matrix.buffers['evo'][0], \dur, 0.3]).setn(\env, Env.perc.asArray)