~funcs = ( Paths.devdir +/+ "lambda/supercollider/sparsematrix/deffuncs02.scd").load;



(
~func = ~funcs[22];
Ndef(\test, {|amp=1.0, emp=0.0|
	var efx, sig = Pan2.ar(SynthDef.wrap(~func) * EnvGen.kr(Env.perc, Impulse.kr(1.5), timeScale: 0.3));
	efx = Greyhole.ar(sig*emp, 0.1, 0.1, 1, 0.707, 0.1, 0.01, 2);
	sig + efx
}).play

)

Ndef(\test).set(\emp, 0.4)

Ndef(\test).clear



JPverb.ar(sig*emp, 1.0, 0.5, 1.3, 0.9);

Greyhole.ar(sig*emp, 0.1, 0.1, 1, 0.707, 0.1, 0.01, 2);