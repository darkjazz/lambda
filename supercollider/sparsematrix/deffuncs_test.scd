~funcs = ( Paths.devdir +/+ "lambda/supercollider/sparsematrix/deffuncs01.scd").load;



(
~func = ~funcs[32];
Ndef(\test, {
	Pan2.ar(SynthDef.wrap(~func) * EnvGen.kr(Env.perc, Impulse.kr(2), timeScale: 0.2))
}).play

)

Ndef(\test).clear