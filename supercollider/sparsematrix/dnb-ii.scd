SparseMatrix.sparsePatterns




(// Load some basic synths
SynthDef(\kick, { |freq = 37, amp = 0.8, dur|
    Out.ar(0, SinOsc.ar(freq, 0.5) * EnvGen.kr(Env.perc, timeScale: dur, doneAction: 2) * amp);
}).add;

SynthDef(\snare, { |freq = 200, amp = 0, dur|
    Out.ar(0, WhiteNoise.ar() * EnvGen.kr(Env.perc, timeScale: dur, doneAction: 2) * amp);
}).add;

SynthDef(\hat, { |freq = 1000, amp = 0.4, dur|
    Out.ar(0, HPF.ar(WhiteNoise.ar(), freq) * EnvGen.kr(Env.perc, timeScale: dur, doneAction: 2) * amp);
}).add;
)
// Kick and Snare for Neurofunk
~kick = [1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0];
~snare = [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1];
~hats = [1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]; // Tight and consistent hats


// Jungle-style groove with shuffle
~kick = [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0];
~snare = [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1];
~hats = [0, 1, 0, 1, 0, 1, 1, 0, 0, 1, 0, 1, 0, 0, 1, 1];


// Kick, Snare, and Hi-hats (with ghost notes)
~kick = [1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0];
~snare = [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1];
~hats = [0, 0, 1, 0, 0, 0, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1];

// Kick and Snare
~kick = [1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
~snare = [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0];
~hats = [0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1]; // Standard hi-hat pattern



(
Pdef('dnb',
	Ppar([
		Pbind(
			\instrument, \kick,
			\dur, 0.3,
			\amp, Pseq(~kick, inf),
			\delta, Pfunc({ ~matrix.beatdur / 4 })
		),
		Pbind(
			\instrument, \snare,
			\dur, 0.15,
			\amp, Pseq(~snare, inf),
			\delta, Pfunc({ ~matrix.beatdur / 4 })
		),
		Pbind(
			\instrument, \hat,
			\dur, 0.01,
			\amp, Pseq(~hats, inf),
			\delta, Pfunc({ ~matrix.beatdur / 4 })
		)
	])
).play
)

Pdef('dnb').clear

p = Pbind(
	\instument, \hat,
	\dur, 0.1,
	\amp, Pseq(~hats, inf),
	\delta, Pfunc({ ~matrix.beatdur / 4 })
).play
p.stop