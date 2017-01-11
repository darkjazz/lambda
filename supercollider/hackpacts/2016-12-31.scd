~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2, screenX: 1024, screenY: 768, mode: 1, decoderType: 'stereo', bpm: 140, channels: 2, foa: #[zoom,push], dbname: "ges_ld_00", patdefs: "patternDefsAppendLnx.scd", initPdefs: ['m01', 'r04', 'b05', 'b06'], worldDim: 21, ip: "127.0.0.1");

e = SpEnvir(~settings)

~matrix.setBPM(127)

SynthDef('grain', {|out, efx, amp, emp, dur, theta=0, phi=0|
	var osc1, osc2, osc3, freqs, amps, inds, mono, bf, env, n = 3;
	freqs = ArrayControl.kr('freqs', n, 1.0);
	amps = ArrayControl.kr('amps', n, 1.0);
	inds = ArrayControl.kr('inds', n, 1.0);
	env = EnvControl.kr;
	osc1 = SinOsc.ar(freqs[0], LocalIn.ar * inds[0], amps[0]);
	osc2 = SinOsc.ar(freqs[1], osc1 * inds[1], amps[1]);
	osc3 = SinOsc.ar(freqs[2], osc2 * inds[2], amps[2]);
	LocalOut.ar(osc3);
	mono = (osc1 + osc2 + osc3) * EnvGen.kr(env, timeScale: dur, doneAction: 2);
	bf = PanB.ar(mono * amp, theta, phi);
	Out.ar(efx, mono * emp);
	Out.ar(out, bf)
}).add;

~seeds = [37, 53+1, 73 + 1];
~freqmap = 3.collect({|i| Array.primeSeries(5, ~seeds[i], 1) });
~rbus = Bus.audio;


Pdef('x00',
	Pbind('instrument', 'grain', 'addAction', 'addToTail', 'group', ~matrix.group,
		'out', ~decoder.bus, 'amp', Pwhite(0.05, 0.1), 'efx', ~rbus, 'emp', 0.05,
		'dur', Pfunc({ ~matrix.beatdur * [7.0, 11.0, 5.0].choose }),
		'theta', Pwhite(-pi, pi), 'phi', Pwhite(-0.5pi, 0.5pi),
		'inds', Pfunc({ Array.rand(3, 1, 5).bubble }), 'amps', Pfunc({ Array.rand(3, 0.5, 1.0).bubble }),
		'env', Pfunc({ Env([0.0, 1.0, 0.0], Array.rand(2, 0.1, 1.0).normalizeSum, Array.rand(2, 1.0, 4.0)).asArray.bubble }), 'freqs', Pfunc({ ~freqmap.collect(_.choose).bubble }),
		'delta', ~matrix.beatdur, 'type', Pwrand([\note, \rest], [0.4, 0.6], inf)
	)
)

Pdef('matrix', Ppar([ Pdef('m00'), Pdef('m01'), Pdef('b05'), Pdef('x00') ]))



(
~rev = SynthDef('reverb', {arg in, revamp=0.01, dry=0.8, revtime=0.5;
	var sig, rev;
	sig = In.ar(in, 1);
	rev = GVerb.ar(sig, 50, revtime, drylevel: dry, earlyreflevel: revamp);
	Out.ar(0, Limiter.ar(rev, 0.9))
}).play(~decoder.synth, ['in', ~rbus, 'revamp', 0.01, 'revtime', 4.4, 'dry', 0.0], 'addBefore')
)

~rev.set('revamp', 0.01, 'revtime', 2.6, 'dry', 0.0);



~matrix.defsAt('m00').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.6, 1.4) },
	{ exprand(0.01, 0.1) },
	0.1
);

~matrix.defsAt('b05').recall(0)

~matrix.defsAt('b05').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.6, 0.9) },
	{ exprand(2.0, 1.0) },
	0.1
);


~graphics = CinderApp(800, 450, mode: 0, path:"/Users/alo/dev/lambda/xcode/DerivedData/lambdaApp/Build/Products/Debug/lambda.app")

~worldSize = 13;

~graphics.open

~graphics.initWorld(~worldSize, ~worldSize, ~worldSize, 20);


~graphics.initGenerations([4,6],[4,6],17);


~graphics.setSymmetry(11)

~graphics.setViewpoint(40.0, -20.0, 50.0, 0.0, 0.0, 0.0)

Tdef(\sendVector, {
	loop({
		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		[ 0.0625, 0.125, 0.25].choose.wait;
	});
}).play;

~graphics.setPattern(5, 1, 0.5, 1, 1, 0.6, 0.8, 1.0);
~graphics.setPattern(7, 0, 0.0, 1, 1, 0.6, 0.8, 1.0);
~graphics.setPattern(11, 0, 0.0, 1, 1, 0.6, 0.8, 1.0);
~graphics.setPattern(9, 0, 0.5, 0, 0, 0.6, 0.8, 1.0);


~graphics.queryAliveStates({|ms|
	~msg = ms;
	~msg.size.postln
})

~msg.drop(1).clump(2).do(_.postln)

~msg.drop(1).clump(2).collect({|tuple|
	var packed = tuple.first;
	x = floor(packed.asFloat/(~graphics.world.sizeY * ~graphics.world.sizeZ));
	y = floor(packed.asFloat/~graphics.world.sizeY.asFloat)%~graphics.world.sizeY;
	z = packed%~graphics.world.sizeZ;
	[x, y, z, packed, tuple.last].postln
})

~msg.drop(1).clump(2).collect(_.first).do(_.postln)

~graphics.stopQuery

~graphics.queryFunc

SynthDef('grain', {|out, amp, dur, theta=0, phi=0|
	var osc1, osc2, osc3, freqs, amps, inds, mono, bf, env, n = 3;
	freqs = ArrayControl.kr('freqs', n, 1.0);
	amps = ArrayControl.kr('amps', n, 1.0);
	inds = ArrayControl.kr('inds', n, 1.0);
	env = EnvControl.kr;
	osc1 = SinOsc.ar(freqs[0], LocalIn.ar * inds[0], amps[0]);
	osc2 = SinOsc.ar(freqs[1], osc1 * inds[1], amps[1]);
	osc3 = SinOsc.ar(freqs[2], osc2 * inds[2], amps[2]);
	LocalOut.ar(osc3);
	mono = (osc1 + osc2 + osc3) * EnvGen.kr(env, timeScale: dur, doneAction: 2);
	bf = PanB.ar(mono, theta, phi);
	Out.ar(out, bf)
}).add;

~decoder = FoaDecoder(true, 'stereo');
~decoder.start

~seeds = [37, 53+1, 73 + 1];
~freqmap = 3.collect({|i| Array.primeSeries(5, ~seeds[i], 1) })

~bpm = 137;
~bps = 137/60;
~beatdur = ~bps.reciprocal;

(
Tdef('fbpm', {
	loop({
		(4.rand + 1).wait;
		~freqs = ~freqmap.collect(_.choose);
		~freqs.postln;
		Synth.before(~decoder.synth, 'grain', ['out', ~decoder.bus, 'amp', rrand(0.05, 0.1), 'dur', rrand(4.0, 8.0), 'theta', rrand(-pi, pi), 'phi', rrand(-0.5pi, 0.5pi)]).setn('freqs', ~freqs).setn('amps', Array.rand(3, 0.5, 1.0)).setn('inds', Array.rand(3, 1, 5)).setn('env', Env([0.0, 1.0, 0.0], Array.rand(2, 0.1, 1.0).normalizeSum, Array.rand(2, 1.0, 4.0)));
	})
}).play
)

Tdef('fbpm').clear
~freqmap = Array.primesN(pow(~worldSize, 3), 17);



Tdef('grainme', {
	var delta = 0.1, gensize;
	gensize = Pbrown(20, 100, Pbrown(1, 7, 1, inf), inf).asStream;
	geninds = (0..1330);
	loop({
		var num, ind;
		num = gensize.next;
		ind = (0..10).dup(3);
		num.do({|i|
			var inds, freqs, spherical, theta, phi;
			inds = ind.collect(_.choose);
			freqs = ~freqmap.collect({|farr, i| farr[inds[i]] });
			spherical = Cartesian(*(inds - (~worldSize * 0.5).dup(3))).asSpherical;
			theta = spherical.theta;
			phi = spherical.phi;
			Synth.before(~decoder.synth, 'grain', ['out', ~decoder.bus, 'amp', rrand(0.05, 0.1), 'dur', rrand(0.05, 0.2), 'theta', theta, 'phi', phi]).setn('freqs', freqs).setn('amps', Array.rand(3, 0.5, 1.0)).setn('inds', Array.rand(2, 1, 10)).setn('env', Env([0.0, 1.0, 0.0], Array.rand(2, 0.1, 1.0).normalizeSum, Array.rand(2, 1.0, 4.0)));
		});
		delta.wait;
	})
}).play

Tdef('grainme').clear

s.scope(2)

