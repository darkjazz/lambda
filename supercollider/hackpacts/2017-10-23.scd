~graphics = CinderApp(600, 600, mode: 0)

, path: "/Users/alo/dev/lambda/xcode/DerivedData/lambdaApp/Build/Products/Release/lambda.app/");

~decoder = FoaDecoder(true, 'stereo');

~gesbufs = GESBufferLoader((Paths.soundDir +/+ "evolver/wrp/*.aiff").pathMatch)

MasterEQ(2)


(97 * (27/[32, 40, 48]).reciprocal).collect(_.asInt).collect(_.nearestPrime)

6+30+31+31+30+31+14 // days i have known Cosima

169.nextPrime


// minor triad

~freqs = Array.geom(17, 47, 32/27).collect(_.asInt).collect(_.nearestPrime);

2.do({|i|
	~freqs = ~freqs ++ Array.geom(17, (~freqs[i*17+8] + (~freqs[i*17+9] - ~freqs[i*17+8] / 2)).nearestPrime, 32/27).collect(_.asInt).collect(_.nearestPrime)
})



~freqs.drop(1).select({|f,  i| i.even }).reverse ++ [~freqs.first] ++ ~freqs.drop(1).select({|f, i| i.odd })


113.even

~freqs = ~freqs.clump(17).collect({|freqs|
	freqs.drop(1).select({|f,  i| i.even }).reverse ++ [freqs.first] ++ freqs.drop(1).select({|f, i| i.odd })
})

~freqs = Array.geom(17, 101, 32/27).collect(_.asInt).collect(_.nearestPrime)

~freqs = Array.geom(4, Array.geom(12, "f 2".notemidi.midicps, 2**(1/12))[Scale.minor.degrees], 2).flat.collect(_.asInt).collect(_.nearestPrime);

~freqs.clump(12)

~freqs = Array.primeSeries(28, 43, 5)

~freqs.size

~freqs[~minorChordDegrees]

~minorChordDegrees = Scale.minor.degrees[[2, 3, 4]]

p = Pbind('freq', Prand(~freqs, inf)).play

Server.killAll

p.stop

Paths.matrixdefs.load

~decoder.start

~graphics.open

~graphics.initWorld(17, 17, 17, 20);
~graphics.initGenerations([ 4, 6, 13, 26 ], [ 18 ], 8);
~graphics.setSymmetry(11)
~graphics.setViewpoint(-115.0, 75.0, -115.0, 0.0, 0.0, 0.0)

(
Tdef(\sendVector, {
	loop({
		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		[ 0.0625, 0.125, 0.25].choose.wait;
	});
});

Tdef(\sendVector).play
)


164/4

(
~graphics.setPattern(3, 0, 1.0, 1, 1, 0.5, 0.0, 0.3);
~graphics.setPattern(13, 1, 1.0, 1, 0, 0.0, 1.0, 0.8);
~graphics.setPattern(16, 0, 1.0, 1, 1, 1.0, 1.0, 1.0);
~graphics.setPattern(9, 0, 1.0, 0, 1, 0.0, 0.7, 1.0)

)

~graphics.sendPredefined3DRule(\nova);

~graphics.sendPredefined3DRule(\frozenspirals);

~graphics.sendPredefined3DRule(\rainzha);


~decoder = FoaDecoder(true, 'stereo');

~decoder.start


(
SynthDef('nested_fm_sin', {|out, amp, dur, pct, rate, angle|
	var bf, sig, freqs, next, inds;
	freqs = ArrayControl.kr('freqs', 3, 1);
	next = ArrayControl.kr('next', 3, 1);
	inds = ArrayControl.kr('inds', 3, 1);
	sig = SinOsc.ar(freqs[0] * XLine.kr(1, 16/15, dur*0.75)
		+ SinOsc.ar(freqs[1] * XLine.kr(1, 15/16, dur*0.75)
			+ SinOsc.ar(freqs[2] * XLine.kr(1, 16/15, dur*0.75),
				0, inds[2] * freqs[2]),
			0, inds[1] * freqs[1]
		), 0, inds[0] * freqs[0]
	);
	sig = sig * (amp + SinOsc.kr(rate).range((amp * pct).neg, amp * pct));
	sig = sig * EnvGen.kr(Env.perc, timeScale: dur, doneAction: 2);
	bf = FoaEncode.ar(sig, FoaEncoderMatrix.newDirection);
	bf = FoaRotate.ar(bf, angle);
	Out.ar(out, bf)
}).add
)

MasterEQ(2)

~rev = SynthDef('reverb', {arg revamp=0.01, dry=0.8, revtime=0.5;
	var sig;
	sig = In.ar(0, ~decoder.numChannels);
	ReplaceOut.ar(0, GVerb.ar(sig, 150, revtime, drylevel: dry, earlyreflevel: revamp))
}).play(~decoder.synth, nil, \addAfter)

~rev.free

~rev.set('revamp', 0.2, 'revtime', 1.9, 'dry', 1.0)


s.scope(2)

~makeChord.(~freqs.choose)

~makeChord = {|fund|
	[fund] ++ (fund * (27/[32, 40, 48])
		.reciprocal).collect(_.asInt).collect(_.nearestPrime) * Array.rand(1, 4, 6, 8);
};


~makeChord = {
	~freqs.collect(_.choose)
}


~delta = 0.12;
~lap = 4.0;

Tdef('fm', {
	loop({
		rrand(1, 5).do({
			Synth.before(~decoder.synth, 'nested_fm_sin', ['out', ~decoder.bus,
				'amp', rrand(0.05, 0.5), 'dur', ~delta * ~lap, 'angle', rrand(-pi, pi),
				'rate', (~delta * ~lap).reciprocal * 8, 'pct', 0.3
			])
			.setn('freqs', ~freqs.collect(_.choose))
			.setn('inds', [1, 1, 1].collect(_.nearestPrime));
			0.001.rand.wait
		});
		~delta.next.wait
	})
})
.play

Tdef('fm').clear

Server.killAll

~freqs = Array.primeSeries(28, 211, 11);
~mods = Array.primeSeries(28, 211, 11).reverse;

~freqs = Array.geom(4, 211, 2).collect({|fund| fund * Scale.ionian.ratios }).flat;
~mods = ~freqs.reverse;

~durs = Array.geom(8, 0.1, 0.9);
~amps = Array.geom(28, 1.0, 0.95);
~angles = Array.series(28, 4pi/28, 4pi/28);

(
~wrp0 = Synth.before(~decoder.synth, 'wrprevm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.0, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[2], 'amp', 1.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

Pdef('swrp0',
	Pbind(
		\type, \set, \id, ~wrp0.nodeID, \delta, Pn(0.2, inf),
		\rx, Pbrown(0, 2pi, 0.0625pi, inf),
		\ry, Pbrown(0, 2pi, 0.0625pi, inf),
		\rz, Pbrown(0, 2pi, 0.0625pi, inf),
		\args, #[rx, ry, rz]
	)
).play;

)

~wrp0.set('ramp', 0., 'wamp', 0.3, 'iamp', 0.0);

~wrp0.free; Pdef('swrp0').clear

~paths = [];
~paths = ~paths.add(~gesbufs[0].path)

//3, 15, 17, 22, 24, 28

~wrp1 = Synth.before(~decoder.synth, 'wrprevm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.0, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[28], 'amp', 1.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

Pdef('swrp1',
	Pbind(
		\type, \set, \id, ~wrp1.nodeID, \delta, Pn(0.2, inf),
		\rx, Pbrown(0, 2pi, 0.125pi, inf),
		\ry, Pbrown(0, 2pi, 0.125pi, inf),
		\rz, Pbrown(0, 2pi, 0.125pi, inf),
		\args, #[rx, ry, rz]
	)
).play;

~wrp1.set('ramp', 0.4, 'wamp', 0.4, 'iamp', 0.3, 'wrp', 0.125 );

~wrp1.free; Pdef('swrp1').clear

~rev = SynthDef('reverb', {arg revamp=0.01, dry=0.8, revtime=0.5;
	var sig;
	sig = In.ar(0, 2);
	ReplaceOut.ar(0, GVerb.ar(sig, 150, revtime, drylevel: dry, earlyreflevel: revamp))
}).play(~decoder.synth, nil, \addAfter)

)

~rev.free

~rev.set('revamp', 0.3, 'revtime', 3.0, 'dry', 0.8)

(
~rules = [
	[ [ 4, 5, 6, 7, 26 ], [ 3, 6, 7, 11, 12, 13, 18, 23, 24, 25 ], 16 ],
	[ [ 4, 7, 14 ], [ 8, 10, 12, 14, 15, 17, 18, 22, 26 ], 16 ],
	[ [ 4, 6, 9, 18, 24 ], [ 1, 4, 6, 8, 17, 23, 24, 26 ], 11 ],
	[ [ 4, 8, 11, 16, 19, 23, 26 ], [ 2, 3, 5, 13, 18, 20, 24 ], 23 ],
	[ [ 4, 25 ], [ 10, 26 ], 19 ],
	[ [ 4, 8, 9, 10, 12, 13, 26 ], [ 6, 8, 15, 16, 20 ], 18 ],
	[ [ 4, 8, 14, 17, 21, 22, 24 ], [ 8, 9, 15, 18, 20 ], 14 ],
	[ [ 4, 10, 11, 13, 14, 15, 18 ], [ 3, 7, 13 ], 22 ],
	[ [ 4, 6, 18, 20, 21, 24, 25, 26 ], [ 6, 10, 13, 15, 16, 18, 23, 26 ], 13 ],
	[ [ 4, 13, 16, 18, 19, 23 ], [ 6, 9, 14, 19, 20, 21 ], 19 ],
	[ [ 4, 6, 13, 14, 18, 24 ], [ 5, 6, 8, 15, 17 ], 9 ],
	[ [ 4, 5, 12, 15, 16, 21, 26 ], [ 10, 20, 26 ], 17 ],
	[ [ 4, 14, 18, 23, 25 ], [ 4, 6, 13 ], 13 ],
	[ [ 4, 10, 17, 21, 24, 25 ], [ 12, 19, 20, 26 ], 10 ],
	[ [ 4, 7, 17 ], [ 5, 8 ], 16 ],
	[ [ 4, 6, 13, 26 ], [ 18 ], 8 ],
	[ [ 4, 6, 9, 13, 20, 23, 24, 25 ], [ 8, 14, 18 ], 23 ],
	[ [ 4, 22, 23, 24 ], [ 4, 6, 11, 17, 24, 26 ], 7 ],
	[ [ 4, 8 ], [ 3, 13, 14 ], 23 ],
	[ [ 4, 11 ], [ 3, 5, 10, 12, 13, 22, 23, 26 ], 15 ],
	[ [ 4, 10, 14, 15, 21, 23 ], [ 6, 13, 25, 26 ], 23 ],
	[ [ 4, 12, 20 ], [ 8, 10, 20 ], 24 ],
	[ [ 4, 6, 7, 10, 14, 19, 22 ], [ 3, 13, 15, 17, 18, 25, 26 ], 19 ],
	[ [ 2, 4, 7, 8]*2, [4, 5, 6, 7, 8]*2, 25]
];

~getRule = {|index|
	var rule = ~rules[index];
	~maxState = rule.last;
	rule
}
)

~graphics.open

~graphics.initWorld(17, 17, 17, 20);
~graphics.initGenerations(*[ [ 4, 6, 9, 13, 20, 23, 24, 25 ], [ 8, 14, 18 ], 23 ]);
~graphics.setSymmetry(11)
~graphics.setViewpoint(-115.0, 75.0, -115.0, 0.0, 0.0, 0.0)

(
Tdef(\sendVector, {
	loop({
		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		[ 0.0625, 0.125, 0.25].choose.wait;
	});
});

Tdef(\sendVector).play
)


164/4

(
~graphics.setPattern(13, 1, 1.0, 1, 0, 0.3, 1.0, 1.0);
~graphics.setPattern(3, 1, 1.0, 1, 1, 0.5, 0.0, 0.3);
~graphics.setPattern(16, 1, 1.0, 1, 1, 1.0, 1.0, 1.0);
~graphics.setPattern(9, 0, 1.0, 0, 1, 0.0, 0.7, 1.0)

)



~graphics.sendGenRule(*~getRule.(2))



~graphics.sendPredefined3DRule(\nova);
(
~rules = [
	[ [ 4, 7, 14 ], [ 8, 10, 12, 14, 15, 17, 18, 22, 26 ], 16 ],
	[ [ 4, 25 ], [ 10, 26 ], 19 ],
	[ [ 4, 8, 9, 10, 12, 13, 26 ], [ 6, 8, 15, 16, 20 ], 18 ],
	[ [ 4, 8, 14, 17, 21, 22, 24 ], [ 8, 9, 15, 18, 20 ], 14 ],
	[ [ 4, 6, 18, 20, 21, 24, 25, 26 ], [ 6, 10, 13, 15, 16, 18, 23, 26 ], 13 ],
	[ [ 4, 14, 18, 23, 25 ], [ 4, 6, 13 ], 13 ],
	[ [ 4, 10, 17, 21, 24, 25 ], [ 12, 19, 20, 26 ], 10 ],
	[ [ 4, 6, 13, 26 ], [ 18 ], 8 ]
];

~getRule = {|index|
	var rule = ~rules[index];
	~maxState = rule.last;
	rule
}
)

~graphics.sendGenRule(*~getRule.(2))

QueryStates.uniform3D(~graphics.world['sizeX'], 3)

~current = []

(
~graphics.queryGenStates(QueryStates.uniform3D(~graphics.world['sizeX'], 3), {|ms|
	var ampscale, states = ms.drop(1);
	// if (~current != states) {
	// 	~current = states;
	// 	states.postln
	// }
	// states.select({|state| state == 1 }).sum.postln
	ms.postln;
	// ms.drop(1).size.postln;
	// ms.drop(1).sum.postln;
	// ampscale = states.select({|state| state > 0 }).size;
	// states.do({|state, i|
	// 	if (state > 0) {
	// 		Synth.before(~decoder.synth, 'mod', ['out', ~decoder.bus,
	// 			'freq', ~freqs[i], 'mod', ~mods[i], 'dur', ~durs[state],
	// 			'ind', state, 'del', if (state == 1) { 0 } { 0.1 * (8 - state).reciprocal },
	// 			'angle', ~angles[i], 'amp', 0.08 * ampscale.reciprocal * ~amps[i]
	// 		]).setn('env', Env.sine.asArray)
	// 	}
	// });
	// if (ampscale == 0) {
	// 	[~wrp0, ~wrp1].choose.set('ramp', 1.0)
	// }
	// {
	// 	~wrp0.set('ramp', 0.0);
	// 	~wrp1.set('ramp', 0.0);
	// }
	});
)

~graphics.queryAliveStates({|ms| ms.postln })

~graphics.clearQueryDef('alive')


~size = ~graphics.world['sizeX']
QueryStates.uniform3D(~size, 4).do({|enc|
	x = (enc/pow(~size, 2)).asInt;
	y = (enc/~size).asInt%~size;
	z = enc%~size;
	[x, y, z].postln
})


~wrp1.free; Pdef('swrp1').clear

1125/2

s.stopRecording

Generations

~maxState = 24;
(1..24).do({|state|
	((~maxState - state) * (1 / ~maxState)).postln;
})