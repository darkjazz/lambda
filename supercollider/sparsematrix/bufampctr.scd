~longbufs = "/Users/alo/sounds/wfsfx/*".pathMatch.collect({|path| 
	Buffer.read(s, path)
})

~longbufs.do(_.postln)

SynthDef(\msynth, {|buf, st, en, dur, gap, cu, t_gate|
	var sig, env;
	env = Env([st, en, en], [dur, gap], cu);
	sig = PlayBuf.ar(1, buf) * EnvGen.kr(env, t_gate);
	Out.ar(0, Pan2.ar(sig, 0))
}).add


~synth = Synth(\msynth, [\buf, ~longbufs[6]]);
~pff = Pbind(\type, \set, \id, ~synth.nodeID, 
	\args, #[\st, \en, \cu, \dur, \gap, \t_gate],
	\st, Pseq([0.0, 1.0, 0.0, 1.0], inf),
	\en, Pseq([1.0, 0.0, 1.0, 0.0], inf),
	\cu, Pseq([4, -4, 4, -4, -8], inf),
	\dur, Pseq([0.25, 0.33, 0.25, 0.125, 0.33, 0.25], inf), 
	\gap, Pseq([0, 0, 0, 0, 0, 0, 0, 0.5], inf),
	\t_gate, 1

).play

~pff.stop
~synth.free



SynthDef('envwtf', {|t_gate=0, st, en, cu, dur|
	var freq = EnvGen.kr(Env([st, en], [dur], cu), t_gate);
	Out.ar(0, LFSaw.ar(freq*SinOsc.ar(freq)).dup * EnvGen.kr(Env.perc, t_gate, timeScale: dur))
}).add


x = Synth('envwtf', [\st, 200, \en, 400, \cu, 4, \dr, 1])

~pff = Pbind(\type, \set, \id, x.nodeID, 
	\args, #[\st, \en, \cu, \dur, \t_gate],
	\st, Pseq([200, 400, 100, 800]*0.5, inf),
	\en, Pseq([400, 200, 800, 100], inf),
	\cu, Pseq([4, -4, 2, -2, 0], inf),
	\dur, Pseq([0.25, 0.33, 0.25, 0.125, 0.33, 0.25], inf), 
	\t_gate, 1

).play

~pff.stop

x.free

