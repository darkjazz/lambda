SynthDef('addsin', {|out, amp, dur|
	var sig, freqs, amps, env, n = 5;
	freqs = ArrayControl.kr('freqs', n, 1);
	amps = ArrayControl.kr('amps', n, 0);
	env = EnvControl.kr;
	sig = Mix.fill(freqs.size, {|i|
		DelayC.ar(SinOsc.ar(freqs[i], 0, amps[i]), 0.05, Rand(0.01, 0.05))
		* EnvGen.kr(env, timeScale: dur * Rand(0.9, 1.0), doneAction: 2);
	});
	Line.kr(dur: dur, doneAction: 2);
	Out.ar(0, Pan2.ar(sig * amp))
}).add;

~seq = [ [ 479, 599, 701, 823, 941 ], [ 653, 769, 883, 1013, 1117 ], [ 419, 521, 631, 743, 859 ], [ 709, 827, 947, 1061, 1187 ], [ 463, 587, 683, 811, 929 ] ];

~envs = [Env.perc, Env.sine, Env([0, 1, 0], [0.8, 0.2], [3])].collect(_.bubble);

Pdef('c00',
	Pbind('instrument', 'addsin', 'out', 0,
		'amp', Pwhite(0.4, 0.8), 'dur', Pwhite(0.4, 1.0) , 'amps', Array.geom(5, 1.0, 13/21).bubble,
		'freqs', Pseq(~seq.collect(_.bubble), inf), 'env', Pwrand(~envs, [1.0, 0.0, 0.0], inf),
		'delta', Pwrand([0.4, 0.8, 1.6] * 2.0, [0.3, 0.2, 0.5], inf)
	)
)

Pdef('c00').play

~rev = SynthDef('reverb', {arg revamp=0.01, dry=0.8, revtime=0.5;
	var sig;
	sig = In.ar(0, 2);
	ReplaceOut.ar(0, GVerb.ar(sig, 50, revtime, drylevel: dry, earlyreflevel: revamp))
}).play

~rev.free

s.scope(2)

~rev.set('revamp', 0.01, 'revtime', 1.6, 'dry', 1.0)


Pdef('c00').stop

~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2, screenX: 1024, screenY: 768, mode: 1, decoderType: 'stereo', bpm: 140, channels: 2, foa: #[zoom,push], dbname: "ges_ld_00", patdefs: "patternDefsAppendLnx.scd", initPdefs: ['b03', 'b04', 'b05', 'b06'], worldDim: 21, ip: "127.0.0.1");

e = SpEnvir(~settings)

~matrix.setBPM(135)

~gesbufs = GESBufferLoader().loadByDate("161224")
~gesbufs.preload

~wrp0 = Synth.tail(~matrix.group, 'wrprev', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[36], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])


~wrp0.set('amp', 1.0, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 1.0, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.1)


~wrp0.free

~wrp1 = Synth.tail(~matrix.group, 'wrprev', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[0], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])


~wrp1.set('amp', 1.0, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.1)

Pdef('matrix', Ppar([ Pdef('r01'), Pdef('r02') ]))

(
~matrix.defsAt('r01').ctrls['r124'] = ( 'durdev': 0, 'emp': 0.1, 'active': 1, 'ampdev': 0,
  'amp': 0.5121657847852, 'dur': 0.20719961823511 );

~matrix.defsAt('r01').ctrls['r118'] = ( 'durdev': 0, 'emp': 0.1, 'active': 1, 'ampdev': 0,
  'amp': 0.52660730428949, 'dur': 0.2824603340597 );
)

(
~matrix.defsAt('r02').ctrls['r201'] = ( 'durdev': 0, 'emp': 0.1, 'active': 1, 'ampdev': 0,
  'amp': 0.37709341169187, 'dur': 0.23423766423075 );

~matrix.defsAt('r02').ctrls['r226'] = ( 'durdev': 0, 'emp': 0.1, 'active': 1, 'ampdev': 0,
  'amp': 0.4458423685053, 'dur': 0.12028319051329 );

~matrix.defsAt('r02').ctrls['r220'] = ( 'durdev': 0, 'emp': 0.1, 'active': 1, 'ampdev': 0,
  'amp': 0.33407233925465, 'dur': 0.10480229226524 );

~matrix.defsAt('r02').ctrls['r229'] = ( 'durdev': 0, 'emp': 0.1, 'active': 1, 'ampdev': 0,
  'amp': 0.3242758407423, 'dur': 0.26675905390782 );

~matrix.defsAt('r02').ctrls['r202'] = ( 'durdev': 0, 'emp': 0.1, 'active': 1, 'ampdev': 0,
  'amp': 0.40216625729222, 'dur': 0.2980789886048 );

~matrix.defsAt('r02').ctrls['r213'] = ( 'durdev': 0, 'emp': 0.1, 'active': 1, 'ampdev': 0,
  'amp': 0.5165108126834, 'dur': 0.16442185642832 );

~matrix.defsAt('r02').ctrls['r218'] = ( 'durdev': 0, 'emp': 0.1, 'active': 1, 'ampdev': 0,
  'amp': 0.52042794163307, 'dur': 0.24532509375889 );

~matrix.defsAt('r02').ctrls['r209'] = ( 'durdev': 0, 'emp': 0.1, 'active': 1, 'ampdev': 0,
  'amp': 0.45775454827742, 'dur': 0.13276613321668 );
)

~matrix.defsAt('r01').ctrls.do({|ctr| ctr.active = 0  })
~matrix.defsAt('r02').ctrls.do({|ctr| ctr.active = 0  })

~graphics = CinderApp(600, 450, mode: 0, path:"/Users/alo/dev/lambda/xcode/DerivedData/lambdaApp/Build/Products/Debug/lambda.app")

~graphics.open
~graphics.initWorld(19, 19, 19, 20);
~graphics.initGenerations([4,6],[4,6],17);

~graphics.setViewpoint(0.0, -100.0, 0.0, 0.0, 0.0, -10.0)

~graphics.setSymmetry(11)

~graphics.setPattern(6, 1, 1.0, 1, 1, 0.5, 0.9, 0.8);

~graphics.setPattern(7, 1, 1.0, 1, 1, 1.0, 0.3, 0.5);

~graphics.sendPredefined3DRule(\rainzha)
