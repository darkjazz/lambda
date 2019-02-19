~graphics = CinderApp(600, 600, mode: 0)
~decoder = FoaDecoder(true, 'stereo');

~gesbufs = GESBufferLoader().loadByDate("161224")
~gesbufs.preload

MasterEQ(2)

Paths.matrixdefs.load

~decoder.start

~graphics.open

~graphics.initWorld(17, 17, 17, 20);
~graphics.initGenerations([0],[4],18);
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
~graphics.setPattern(9, 1, 1.0, 1, 1, 0.1, 0.6, 1.0);
~graphics.setPattern(10, 1, 1.0, 1, 1, 1.0, 1.0, 0.0);
~graphics.setPattern(12, 1, 0.3, 1, 1, 0.2, 1.0, 0.8);

~graphics.sendPredefined3DRule(\glisserati);
)

~graphics.sendPredefined3DRule(\xtasy);

~graphics.sendPredefined3DRule(\frozenspirals);

~graphics.sendPredefined3DRule(\rainzha);

(
SynthDef('mod', {|out, amp, freq, mod, dur, ind, del, angle=0|
	var sig, bf, env;
	sig = DelayL.ar(PMOsc.ar(freq, mod, ind), 0.1, del)
	* EnvGen.kr(EnvControl.kr, timeScale: dur, doneAction: 2);
	bf = FoaEncode.ar(sig, FoaEncoderMatrix.newDirection);
	bf = FoaRotate.ar(bf, angle);
	Out.ar(out, bf)
}).add;

~freqs = Array.primeSeries(28, 211, 11);
~mods = Array.primeSeries(28, 211, 11).reverse;

~freqs = Array.geom(4, 211, 2).collect({|fund| fund * Scale.ionian.ratios }).flat;
~mods = ~freqs.reverse;

~durs = Array.geom(8, 0.1, 0.9);
~amps = Array.geom(28, 1.0, 0.95);
~angles = Array.series(28, 4pi/28, 4pi/28);

~wrp0 = Synth.before(~decoder.synth, 'wrprevm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.0, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[14], 'amp', 1.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

Pdef('swrp0',
	Pbind(
		\type, \set, \id, ~wrp0.nodeID, \delta, Pn(0.2, inf),
		\rx, Pbrown(0, 2pi, 0.125pi, inf),
		\ry, Pbrown(0, 2pi, 0.125pi, inf),
		\rz, Pbrown(0, 2pi, 0.125pi, inf),
		\args, #[rx, ry, rz]
	)
).play;

~wrp1 = Synth.before(~decoder.synth, 'wrprevm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.0, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[30], 'amp', 1.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

Pdef('swrp1',
	Pbind(
		\type, \set, \id, ~wrp1.nodeID, \delta, Pn(0.2, inf),
		\rx, Pbrown(0, 2pi, 0.125pi, inf),
		\ry, Pbrown(0, 2pi, 0.125pi, inf),
		\rz, Pbrown(0, 2pi, 0.125pi, inf),
		\args, #[rx, ry, rz]
	)
).play;

~rev = SynthDef('reverb', {arg revamp=0.01, dry=0.8, revtime=0.5;
	var sig;
	sig = In.ar(0, 2);
	ReplaceOut.ar(0, GVerb.ar(sig, 150, revtime, drylevel: dry, earlyreflevel: revamp))
}).play(~decoder.synth, nil, \addAfter)

)


~rev.free

~rev.set('revamp', 0.3, 'revtime', 3.0, 'dry', 0.8)


(
~graphics.queryStates(QueryStates.uniform3D(17, 3), {|ms|
	var ampscale, states = ms.drop(1);
	ampscale = states.select({|state| state > 0 }).size;
	states.do({|state, i|
		if (state > 0) {
			Synth.before(~decoder.synth, 'mod', ['out', ~decoder.bus,
				'freq', ~freqs[i], 'mod', ~mods[i], 'dur', ~durs[state],
				'ind', state, 'del', if (state == 1) { 0 } { 0.1 * (8 - state).reciprocal },
				'angle', ~angles[i], 'amp', 0.08 * ampscale.reciprocal * ~amps[i]
			]).setn('env', Env.sine.asArray)
		}
	});
	if (ampscale == 0) {
		[~wrp0, ~wrp1].choose.set('ramp', 1.0)
	}
	{
		~wrp0.set('ramp', 0.0);
		~wrp1.set('ramp', 0.0);
	}
});
)

~graphics.stopQuery

~wrp0.free; Pdef('swrp0').clear

~wrp1.free; Pdef('swrp1').clear

1125/2

s.stopRecording

