(~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2, screenX: 1024, screenY: 768, mode: 1, decoderType: 'stereo', 'localDecoder': true, bpm: 127, channels: 2, foa: #[zoom,push], dbname: "ges_ld_00", patdefs: "patternDefsDnB.scd", initPdefs: ['b00', 'b01', 'b02', 'b03', 'b04', 'b05', 'b06', 'b07', 'b08', 'b10', 'b11', 'b12'], worldDim: 21, ip: "127.0.0.1");

e = SpEnvir(~settings))


~matrix.setBPM(157)

(
~matrix.defsAt('b00').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.05, 0.1) },
	0.1
);

~matrix.defsAt('b01').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.01, 0.1) },
	0.1
);
)

(
~matrix.defsAt('b02').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.06, 0.1) },
	0.1
);

~matrix.defsAt('b03').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.05, 0.2) },
	0.1
);

)

~matrix.defsAt('b00').recall(0);
~matrix.defsAt('b01').recall(0);


(
~matrix.defsAt('b04').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.01, 0.2) },
	0.1
);

~matrix.defsAt('b05').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.01, 0.2) },
	0.1
);
)

(
~matrix.defsAt('b06').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.1, 1.0) },
	{ exprand(0.1, 0.3) },
	0.1
);

~matrix.defsAt('b07').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.1, 0.4) },
	0.1
);
)


~matrix.defsAt('b10').recall(0);
~matrix.defsAt('b12').recall(0);



(
~matrix.defsAt('b08').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.2, 0.5) },
	{ exprand(2.0, 4.0) },
	0.1
);
)


(
~matrix.defsAt('b10').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.05, 0.2) },
	0.1
);
~matrix.defsAt('b11').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.1, 0.4) },
	0.1
);
~matrix.defsAt('b12').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.1, 0.4) },
	0.1
);


)


(
~gespaths = (Paths.soundDir +/+ "evolver/ev/*").pathMatch;
~gesbufs = GESBufferLoader(~gespaths);
)



(
~wrp0 = Synth.tail(~matrix.group, 'wrprevm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[44], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

Pdef('swrp0',
	Pbind(
		\type, \set, \id, ~wrp0.nodeID, \delta, Pn(~matrix.beatdur * 2, inf),
		\rx, Pwhite(-pi, pi, inf),
		\ry, Pbrown(0, 2pi, 0.125pi, inf),
		\rz, Pbrown(0, 2pi, 0.125pi, inf),
		\freq, Pseq([0.5, 0.7, 1.4, 1.0, 2.0], inf),
		\args, #[rx, ry, rz, freq]
	)
).play
)

~wrp0.set('amp', 1.0, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.3, 'rate', 0.125, 'freq', 0.125, 'wrp', 0.125)

~wrp0.free; Pdef('swrp0').clear

s.scope(2)

s.stopRecording


(
~wrp1 = Synth.tail(~matrix.group, 'wrprevm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[33], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

Pdef('swrp1',
	Pbind(
		\type, \set, \id, ~wrp1.nodeID, \delta, Pn(~matrix.beatdur/4, inf),
		\rx, Pwhite(-pi, pi, inf),
		\ry, Pbrown(0, 2pi, 0.125pi, inf),
		\rz, Pbrown(0, 2pi, 0.125pi, inf),
		\freq, Pseq([0.5, 1.0, 0.7, 2.0, 1.4, 1.4, 0.5, 0.5], inf),
		\rate, Pseq([0.25, 0.125, 0.5, 1.0], inf),
		\args, #[rx, ry, rz, freq]
	)
).play
)

~wrp1.set('amp', 1.0, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.2, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.125)


~wrp1.free; Pdef('swrp1').clear

