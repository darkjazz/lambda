~ins.ins[0].set('amp', 1.0, 'revamp', 0.2, 'revtime', 5.1);
~ins.startEfx('cyclicWarp', 0);
~ins.setEfx('cyclicWarp', ['amp', 0.3, 'iwrp', 0.25);
%
~ins.startEfx('granularReverb', 0)
~ins.setEfx('granularReverb', ['amp', 0.7])
~ins.stopEfx('granularReverb')
%
~ins.startRecording;
%
~ins.startShift(0.7, 0.5, 2.0);
%
~ins.setShift(0, ['shift', 1.0, 'rate', -0.5, 'amp', 0.6]);
%
(
Tdef(\playshift, {
	loop({
		~ins.shifts.choose.set('buffer', ~ins.recBufs.choose);
		rrand(2, 4).wait;
	})
}).play
)
%
Pdef('playsamp',
	Pbind('instrument', 'playSample',
		'group', ~matrix.group, 'addAction', 'addToTail',
		'out', ~decoder.bus, 'rate', Prand([1.0, 0.5, 0.25, 0.125, -0.5, -1.0], inf),
		'buffer', Pxrand(~ins.recBufs, inf), 'amp', Pwhite(1.0, 2.0),
		'rx', Pwhite(-pi, pi), 'ry', Pwhite(-pi, pi), 'rz', Pwhite(-pi, pi),
		'delta', Pfunc({|ev| ev.buffer.duration * ev.rate.abs.reciprocal })
	)
).play
%
~wrp0 = Synth.tail(~matrix.group, 'wrprevm', ['out', ~decoder.bus, 'rate', 1,
	'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03,
	'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0,
	'buf', ~gesbufs[15], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);
Pdef('swrp0',
	Pbind(
		\type, \set, \id, ~wrp0.nodeID, \delta, Pn(0.2, inf),
		\rx, Pbrown(-0.5pi, 0.5pi, 0.125pi, inf),
		\ry, Pbrown(0, 2pi, 0.125pi, inf),
		\rz, Pbrown(0, 2pi, 0.125pi, inf),
		\args, #[rx, ry, rz]
	)
).play
%
~matrix.setBPM(137)
%
~freqs = Array.twinPrimes(47, 1001).select({|it, i| it.odd });
~ranges = ~freqs.clump((~freqs.size/3).floor);
%
SynthDef('prsine', {|out, efx, freq, amp, dur, ang|
	var sig, bf;
	sig = SinOsc.ar([freq, freq + 2]) *
	EnvGen.kr(Env.perc, timeScale: dur, doneAction: 2);
	bf = FoaEncode.ar(Mix(sig), FoaEncoderMatrix.newDirection);
	bf = FoaRotate.ar(bf, ang);
	Out.ar(efx, bf[1] * amp);
	Out.ar(out, bf * amp)
}).add;
%
~sinebus = Bus.audio(Server.default);
%
~rev = SynthDef('reverb', {arg out, in, revamp=0.05, dry=0.0, revtime=3.1;
	var sig, bf;
	sig = In.ar(in);
	sig = GVerb.ar(sig, 150, revtime, drylevel: dry, earlyreflevel: revamp);
	sig = sig.dup.flat;
	bf = FoaEncode.ar(Array.fill(4, { |i|
			IFFT( PV_Diffuser( FFT( LocalBuf(1024), sig[i]), Dust.kr(200.0) ))
	}), FoaEncoderMatrix.newAtoB('fud'));
	Out.ar(out, bf)
}).play(~matrix.decoder.synth, ['out', ~matrix.decoder.bus, 'in'], \addBefore)
%
~matrix.addPatternBufferDef('p00', (0..~ins.recBufs.size), 4, 4,
	['Yanvalou', 'Wolosodon', 'Toro', 'Timiny', 'Soli', 'Soboniko'],
	2, "p0", 'bufproto', ~ins.recBufs, 'bit01', true
);

~matrix.addPatternBufferDef('p01', (0..~ins.recBufs.size), 4, 4,
	['Sinte', 'Sabar', 'Madan', 'Lolo', 'Kpatsia', 'Kpanlogo', 'Kononwulen', 'Konkoba'],
	2, "p1", 'bufproto', ~ins.recBufs, 'bit00', true
);
%
~wrp0.set('amp', 1.0, 'wamp', 0.0, 'iamp', 0.9, 'ramp', 0.2, 'rate', 1.0,
	'freq', 1.0, 'wrp', 0.125)
%
Pdef('matrix',
	Ppar([ Pdef('b02'), Pdef('r01'), Pdef('b04'),
		Pdef('b07'), Pdef('b08'), Pdef('b12'), Pdef('b10'), Pdef('b11')
]))
%
~matrix.defsAt('b12').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) }, { exprand(0.4, 1.0) },
	{ exprand(0.1, 0.4) }, 0.1
);
%
~matrix.defsAt('b11').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) }, { exprand(0.5, 1.0) },
	{ exprand(0.2, 0.4) }, 0.1
);
%
~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) }, { exprand(0.2, 0.6) },
	{ exprand(0.03, 0.07) }, 0.1
);
%
~matrix.defsAt('b12').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) }, { exprand(0.4, 1.0) },
	{ exprand(0.1, 0.4) }, 0.1
);
%
Tdef('trigger', {
	rrand(4, 10).do({
		Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.4, 0.7),
			'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(50, 45)],
			'dur', exprand(0.7, 3.0), 'env', [Env.perc, Env.sine].choose] )
	})
}).play
%
~matrix.defsAt('b11').setActives(nil, { rrand(0.01, 0.1) });
~matrix.defsAt('b12').setActives(nil, { rrand(0.01, 0.1) });
~matrix.defsAt('r01').setActives(nil, { rrand(0.02, 0.1) });
%
['b10', 'b11', 'b12', 'b08', 'r01'].do({|name|
	~matrix.defsAt(name).recall(0)
})
%
Tdef('trigger', {
	rrand(4, 10).do({
		Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.4, 0.7),
			'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(50, 45)],
			'dur', exprand(0.7, 3.0), 'env', [Env.perc, Env.sine].choose] )
	})
}).play
%
~matrix.defsAt('b11').setActives(nil, { rrand(0.01, 0.1) });
~matrix.defsAt('b12').setActives(nil, { rrand(0.01, 0.1) });
~matrix.defsAt('r01').setActives(nil, { rrand(0.02, 0.1) });
%
Tdef('trigger', {
	rrand(4, 10).do({
		Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.4, 0.7),
			'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(50, 45)],
			'dur', exprand(0.7, 3.0), 'env', [Env.perc, Env.sine].choose] )
	})
}).play
%
['b10', 'b11', 'b12', 'b08', 'r01'].do({|name|
	~matrix.defsAt(name).recall(0)
})
%
~wrp1 = Synth.tail(~matrix.group, 'wrprevm', ['out', ~decoder.bus, 'rate', 1,
	'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03,
	'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0,
	'buf', ~gesbufs[44], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);
%
Pdef('swrp1',
	Pbind(
		\type, \set, \id, ~wrp1.nodeID, \delta, Pn(0.2, inf),
		\rx, Pbrown(-0.5pi, 0.5pi, 0.125pi, inf),
		\ry, Pbrown(0, 2pi, 0.125pi, inf),
		\rz, Pbrown(0, 2pi, 0.125pi, inf),
		\args, #[rx, ry, rz]
	)
).play
%
~wrp1.set('amp', 1.0, 'wamp', 0.0, 'iamp', 0.2, 'ramp', 0.3, 'rate', 1.0,
	'freq', 0.25, 'wrp', 0.125);
~wrp0.free; Pdef('swrp0').clear;
%
~matrix.defsAt('b08').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) }, { exprand(0.2, 0.6) },
	{ exprand(0.1, 0.2) }, 0.1
);
%
~matrix.defsAt('b07').setControls(
	{ [0, 1].wchoose([0.9, 0.1]) }, { exprand(0.5, 0.7) },
	{ exprand(0.1, 0.2) }, 0.1
);
%
~matrix.defsAt('b10').setActives(nil, { rrand(0.01, 0.1) });
~matrix.defsAt('b11').setActives(nil, { rrand(0.01, 0.1) });
%
~matrix.defsAt('b12').setActives(nil, { rrand(0.01, 0.1) });
~matrix.defsAt('b08').setActives(nil, { rrand(0.01, 0.1) });
~matrix.defsAt('r01').setActives(nil, { rrand(0.02, 0.1) });
%
~wrp1.set('amp', 1.0, 'wamp', 0.0, 'iamp', 0.4, 'ramp', 0.0, 'rate', 1.0,
	'freq', 0.25, 'wrp', 0.125);
%
~matrix.patterndefs.do({|def| def.setActives(0) });
%
~matrix.defsAt('b11').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) }, { exprand(0.5, 1.0) },
	{ exprand(0.2, 0.4) }, 0.1
);
~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) }, { exprand(0.2, 0.6) },
	{ exprand(0.03, 0.07) }, 0.1
);
%
~wrp1.set('amp', 1.0, 'wamp', 0.0, 'iamp', 0.4, 'ramp', 0.5, 'rate', 1.0,
	'freq', 0.25, 'wrp', 0.125);
%
~matrix.activateSkismSynth('latchOnset');
%
~matrix.setSkismAmp('latchOnset', 0.7);
%
Tdef('trigger', {
	rrand(4, 10).do({
		Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.4, 0.7),
			'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(50, 45)],
			'dur', exprand(0.7, 3.0), 'env', [Env.perc, Env.sine].choose] )
	})
}).play
%
Tdef('trigger', {
	rrand(4, 10).do({
		Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.4, 0.7),
			'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(50, 45)],
			'dur', exprand(0.7, 3.0), 'env', [Env.perc, Env.sine].choose] )
	})
}).play
%
~player.start(~foa);

~player.setFoa('zoom', 1.0); ~player.setFoa('push', 1.0);
%
~ind1 = 53; ~player.loadData(~ind1)
~player.play(~ind1, 0, ['zoom', 'push'].choose, 0);
%
~player.set(~ind1, 0.4)
%
~matrix.defsAt('b08').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ exprand(0.2, 0.6) }, { exprand(0.1, 0.2) }, 0.1
);
%
~matrix.defsAt('b07').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.5, 0.7) }, { exprand(0.1, 0.2) }, 0.1
);
%
~player.free(~ind1)