(
~graphics = CinderApp(800, 800, mode: 0);

~decoder = FoaDecoder(true, 'stereo');

~gesbufs = GESBufferLoader((Paths.soundDir +/+ "evolver/wrp/*.aiff").pathMatch);
MasterEQ(2);

~buffers = (Paths.soundDir +/+ "evolver/perc/*").pathMatch.collect({|path| Buffer.read(Server.default, path, 0, Server.default.sampleRate * 4) });

~freqs = Array.geom(17, 47, 32/27).collect(_.asInt).collect(_.nearestPrime);

2.do({|i|
	~freqs = ~freqs ++ Array.geom(17, (~freqs[i*17+8] + (~freqs[i*17+9] - ~freqs[i*17+8] / 2)).nearestPrime, 32/27).collect(_.asInt).collect(_.nearestPrime)
});

~freqs = ~freqs.clump(17).collect({|freqs|
	freqs.drop(1).select({|f,  i| i.even }).reverse ++ [freqs.first] ++ freqs.drop(1).select({|f, i| i.odd })
});

"gep_gen000_113_170512_145731.aiff";

SynthDef('wrprevm', {|out, rate, start, wrp, freq, wsize, dens, randr,
		room, rtime, ramp, damp, iamp, buf, amp, wamp, rx, ry, rz |
	var input, warpsig, revsig, bf;
	input = PlayBuf.ar(1, buf, rate, 1, start * BufFrames.kr(buf), 1);
	warpsig = Warp0.ar(
		buffer: buf,
		warpFactor: [wrp, wrp*15/16],
		freqScale: freq,
		windowSize: wsize,
		overlaps: dens,
		windowRandRatio: randr
	);
	revsig = GVerb.ar(warpsig, room, rtime,
		drylevel: damp, earlyreflevel: ramp * 0.5, taillevel: ramp);
	bf = FoaEncode.ar(input * iamp, FoaEncoderMatrix.newDirection) +
	FoaEncode.ar(warpsig * wamp, FoaEncoderMatrix.newStereo) +
	FoaEncode.ar(revsig * amp, FoaEncoderMatrix.newStereo);
	bf = FoaTransform.ar(bf, 'focus', pi/2);
	bf = FoaTransform.ar(bf, 'rtt', rx, ry, rz);
	Out.ar(out, LeakDC.ar(bf));
}).add;

SynthDef('nested_fm_sin', {|out, amp, dur, pct, rate, angle|
	var bf, sig, freqs, next, inds;
	freqs = ArrayControl.kr('freqs', 3, 1);
	inds = ArrayControl.kr('inds', 3, 1);
	sig = SinOsc.ar(freqs[0] * XLine.kr(1, 16/15, dur*0.9)
		+ SinOsc.ar(freqs[1] * XLine.kr(1, 15/16, dur*0.9)
			+ SinOsc.ar(freqs[2] * XLine.kr(1, 16/15, dur*0.9), 0, inds[2] * freqs[2]),
			0, inds[1] * freqs[1]
		), 0, inds[0] * freqs[0]
	);
	sig = sig * amp * SinOsc.kr(rate).range((amp * pct).neg, amp * pct);
	sig = sig * EnvGen.kr(Env.perc, timeScale: dur, doneAction: 2);
	bf = FoaEncode.ar(sig, FoaEncoderMatrix.newDirection);
	bf = FoaRotate.ar(bf, angle);
	Out.ar(out, bf)
}).add;

SynthDef(\bitSt2, {|out, efx, amp, emp, buf, dur|
	var sig;
	sig = Normalizer.ar(
		PlayBuf.ar(2, buf, BufRateScale.ir(buf) * 1.neg, 1, BufFrames.kr(buf)),
		amp) * EnvGen.kr(\env.kr(Env.newClear(8).asArray), timeScale: dur, doneAction: 2);
	Out.ar(efx, sig * emp);
	Out.ar(out, sig * amp)
}).add;

~rules = [
	[ [ 4, 6, 9, 13, 20, 23, 24, 25 ], [ 8, 14, 18 ], 23 ],
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

~graphics.open

~size = 17;

~graphics.initWorld(~size, ~size, ~size, 20);
~graphics.initGenerations(*~getRule.(1));
~graphics.setSymmetry(11)
~graphics.setViewpoint(-55.0, 55.0, -55.0, 0.0, 0.0, 0.0)

(
Tdef(\sendVector, {
	loop({
		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		[ 0.0625, 0.125, 0.25].choose.wait;
	});
});

Tdef(\sendVector).play
)

(
~rot = Rotation(140.0, 0.015, 140.0, 40.0, 0.01, 0.02, 0.01, 0.01);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera;
)

(
~graphics.setPattern(13, 0, 1.0, 1, 0, 0.3, 1.0, 1.0); // x%4,y%4,z%4
~graphics.setPattern(3, 1, 1.0, 1, 1, 0.5, 0.0, 0.3);  // all
~graphics.setPattern(16, 0, 1.0, 1, 1, 1.0, 1.0, 1.0); // max state 4?
~graphics.setPattern(9, 1, 1.0, 0, 1, 0.0, 0.7, 1.0);  // sides
)
s.scope(2)

~graphics.sendGenRule(*~getRule.(2))


~decoder.start

// ~chords = Array();

// f = [ [ 53, 2521, 7639 ], [ 53, 2521, 9049 ], [ 53, 2999, 7639 ], [ 53, 2999, 9049 ], [ 709, 2521, 7639 ], [ 709, 2521, 9049 ], [ 709, 2999, 7639 ], [ 709, 2999, 9049 ] ]
//
// f = [ [ 601, 2521, 10729 ], [ 601, 331, 10729 ], [ 601, 331, 12713 ], [ 601, 389, 10729 ], [ 601, 389, 12713 ], [ 601, 769, 7639 ], [ 601, 769, 9049 ], [ 601, 2999, 10729 ], [ 601, 2999, 12713 ], [ 509, 769, 10729 ], [ 509, 769, 12713 ], [ 509, 1511, 10729 ], [ 509, 1511, 12713 ], [ 709, 331, 10729 ], [ 709, 331, 12713 ], [ 709, 389, 10729 ], [ 709, 389, 12713 ], [ 709, 769, 7639 ], [ 709, 769, 9049 ], [ 709, 2999, 12713 ] ]
//
// z = f.flat.asSet.asArray.sort
// x = (z.size/3).asInt
// z = z.keep(x*3).clump(x).flop
//
// clump(3).flop
(
~minDelta = 0.1;
~lap = 8.0;

~fm = {
	t = SystemClock.seconds;
	~graphics.setPattern(16, 1, 1.0, 1, 1, 1.0, 1.0, 1.0);
	~graphics.queryCoordsByState(4, 4, {|ms|
		var delta, chords, freqs, fac;
		delta = (SystemClock.seconds - t);
		if (delta > ~minDelta) {
			t = SystemClock.seconds;
			chords = ~graphics.unpackCoords(ms).collect({|c|
				[c.x, c.y, c.z].collect({|ind, i| ~freqs[i][ind] })
			});
			freqs = chords.flat.asSet.asArray.sort;
			fac = (freqs.size/3).asInt;
			chords = freqs.keep(fac*3).clump(fac).flop;
			chords.do({|freqs|
				Synth.before(~decoder.synth, 'nested_fm_sin', ['out', ~decoder.bus,
					'amp', rrand(0.01, 0.04), 'dur', delta * ~lap, 'angle', rrand(-pi, pi),
					'rate', (delta * ~lap).reciprocal * 8, 'pct', 1.0
				])
				.setn('freqs', freqs)
				.setn('inds', [1, 1, 1].collect(_.nearestPrime));
			})
		}
	});
	~rev = SynthDef('reverb', {arg revamp=0.01, dry=0.8, revtime=0.5;
		var sig;
		sig = In.ar(0, ~decoder.numChannels);
		ReplaceOut.ar(0, GVerb.ar(sig, 150, revtime, drylevel: dry, earlyreflevel: revamp))
	}).play(~decoder.synth, nil, \addAfter);
	SystemClock.sched(1.0, {
		~rev.set('revamp', 0.3, 'revtime', 1.9, 'dry', 1.0);
		nil
	});
	~wrp0 = Synth.before(~decoder.synth, 'wrprevm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[35], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);
	Pdef('swrp0',
		Pbind(
			\type, \set, \id, ~wrp0.nodeID, \delta, Pn(0.2, inf),
			\rx, Pbrown(0, 2pi, 0.125pi, inf),
			\ry, Pbrown(0, 2pi, 0.125pi, inf),
			\rz, Pbrown(0, 2pi, 0.125pi, inf),
			\args, #[rx, ry, rz]
		)
	).play;
	SystemClock.sched(0.5, {
		~wrp0.set('amp', 1.0, 'wamp', 0.0, 'iamp', 1.0, 'ramp', 0.5 , 'rate', 1.0, 'freq', 1.0, 'wrp', 0.25);
		nil
	});
};

~wrp = {
	~ind = 40;
	~wrp3 = Synth.before(~decoder.synth, 'wrprevm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[~ind], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);
	0.5.wait;
	Pdef('swrp3',
		Pbind(
			\type, \set, \id, ~wrp3.nodeID, \delta, Pn(0.2, inf),
			\rx, 0,
			\ry, 0,
			\rz, 0,
			\args, #[rx, ry, rz]
		)
	).play;
	0.5.wait;
	~wrp3.set('amp', 1.0, 'wamp', 0.0, 'iamp', 1.0, 'ramp', 0.5, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.25);
	~graphics.setPattern(13, 1, 1.0, 1, 0, 0.3, 1.0, 1.0);
};

~bit = {
	~graphics.setPattern(3, 1, 1.0, 1, 1, 0.5, 0.0, 0.3);
	Tdef('trig', {
		loop({
			Synth.before(~decoder.synth, \bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.4, 0.7), 'emp', 0.0, 'buf', ~buffers[rrand(22, 47)], 'dur', exprand(0.7, 3.0), 'env', [Env.perc, Env.sine].choose] );
			rrand(0.2, 1.0).wait;
		});
	}).play
};
)


(
Tdef('play', {
	~wrp.();
	43.wait;
	~graphics.sendGenRule(*~getRule.(2));
	~bit.();
	43.wait;
	~fm.();
	43.wait;
	~graphics.sendGenRule(*~getRule.(0));
	37.wait;
	~graphics.setPattern(16, 0, 1.0, 1, 1, 1.0, 1.0, 1.0);
	~graphics.clearQueryDef('coords');
	Tdef('trig').clear;
	~graphics.setPattern(3, 0, 1.0, 1, 1, 0.5, 0.0, 0.3);
	7.wait;
	~wrp3.free;
	Pdef('swrp3').clear;
	~wrp0.free;
	Pdef('swrp0').clear;
	~graphics.setPattern(13, 0, 1.0, 1, 0, 0.3, 1.0, 1.0);
	~rev.free;
}).play
)


43+43+43+37+7

~graphics.sendGenRule(*~getRule.(0))

~graphics.clearQueryDef('coords')

