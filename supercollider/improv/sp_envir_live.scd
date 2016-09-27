~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2, screenX: 1024, screenY: 768, mode: 1, decoderType: 'stereo', bpm: 140, channels: 2, foa: #[zoom,push], dbname: "ges_00", patdefs: "patternDefsAppendLnx.scd", initPdefs: ['b03', 'b04', 'b05', 'b06'], worldDim: 21, ip: "127.0.0.1");

e = SpEnvir(~settings)

s.queryAllNodes
Server.killAll

~player.start(~foa)


~player.setFoa('zoom', 1.0)
~player.setFoa('push', 1.0)


~ind0 = 2

~player.loadData(~ind0)

Tdef('trig1', {
	loop({
		~player.trigger((0..4).choose, rrand(0.05, 0.2), 'zoom', rrand(0.2, 0.4), 1, 0);
		rrand(0.1, 0.7).wait
	})
})
.play

Tdef('trig1').clear

~player.trigger(~ind0, 0.3, 'zoom', 0.5, 1, 0)

~player.play(~ind0, 0, 'zoom', 0);

~player.set(~ind0, 0.3)

~player.free(~ind0)


s.scope(2)

~ind1 = 8

~player.loadData(~ind1)

~player.trigger(~ind1, 0.3, 'push', 0.3, 1, 0)

~player.play(~ind1, 0, 'zoom', 0)

~player.set(~ind1, 0.1)

~player.free(~ind1);


~ind2 = 19

~player.loadData(~ind2)

~player.trigger(~ind2, 0.08, 'push', 0.1, 1, 0);
~player.set(~ind0, 0.0)


~player.play(~ind2, 0, 'zoom', 0)

~player.set(~ind2, 0.0)

~player.free(~ind2);

SparseMatrix

SynthDef(\bitSt2, {|out, efx, amp, emp, buf, dur|
	var sig;
	sig = Normalizer.ar(
		PlayBuf.ar(2, buf, BufRateScale.ir(buf) * 1.neg, 1, BufFrames.kr(buf)),
		amp) * EnvGen.kr(\env.kr(Env.newClear(8).asArray), timeScale: dur, doneAction: 2);
	Out.ar(efx, sig * emp);
	Out.ar(out, sig * amp)
}).add;

Tdef('tex', {
	loop({
		Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.4, 2.0), 'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(3, 5)], 'dur', exprand(0.3, 0.7), 'env', [Env.perc, Env.sine].choose] );
		rrand(1.0, 2.0).wait
	})
})
.play

Tdef('tex').clear

~wrp0 = Synth.tail(~matrix.group, 'wrprev', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][10], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])


~wrp0.set('amp', 0.0, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0, 'rate', 1.0, 'freq', 2.0 , 'wrp', 0.1)




~wrp1 = Synth.tail(~matrix.group, 'revwrp', ['out', ~decoder.bus, 'rate', 0.5, 'start', 0, 'wrp', 0.1, 'freq', 2.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 40, 'rtime', 12.0, 'ramp', 0.5, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][11], 'amp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])

~wrp1.set('amp', 0.2, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0, 'freq', 1.0, 'rate', 1.0, 'wrp', 0.1)




~wrp2 = Synth.tail(~matrix.group, 'revwrp', ['out', ~decoder.bus, 'rate', 0.5, 'start', 0, 'wrp', 0.1, 'freq', 2.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 40, 'rtime', 12.0, 'ramp', 0.0, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][12], 'amp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])

~wrp2.set('amp', 0.0, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.2, 'freq', 1.0, 'rate', 1.0, 'wrp', 0.1)



~wrp3 = Synth.tail(~matrix.group, 'wrprev', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 30, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][5], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])


~wrp3.set('amp', 0.0, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.1)


~wrp0.free;
~wrp1.free;
~wrp2.free;
~wrp3.free



~matrix.defsAt('b00').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ exprand(0.2, 1.0) },
	{ exprand(0.1, 0.5) },
	0.1
);

~matrix.defsAt('b01').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.5, 1.0) },
	0.1
);

~matrix.defsAt('r00').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.5, 1.5) },
	{ exprand(0.03, 0.2) },
	0.1
);


~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.03, 0.2) },
	0.1
);


SynthDef('vox', {|efx, amp, del|
	var input;
	input = DelayC.ar(SoundIn.ar(0) * amp, 1.0, del);
	Out.ar(efx, input);
	// Out.ar(0, input.dup)
}).add

z = Synth.tail(~matrix.efxgroup, 'vox', ['efx', ~decoder.bus, 'amp', 0.2, 'del', 0.7])

z.set('amp', 0.1, 'del', 0.5)

z.free


['flangingDecimator', 'granularReverb', 'feedbackSpectrum', 'cyclicWarp', 'latchOnset', 'cliqSaw', 'fxGrain', 'arhythmicGendy']

~matrix.activateSkismSynth('latchOnset')

~matrix.setSkismAmp('latchOnset', 0.3)

~matrix.deactivateSkismSynth('latchOnset')



~matrix.activateSkismSynth('granularReverb')

~matrix.setSkismAmp('granularReverb', 0.1)

~matrix.deactivateSkismSynth('granularReverb')



~matrix.activateSkismSynth('cliqSaw')

~matrix.setSkismAmp('cliqSaw', 0.0)

~matrix.deactivateSkismSynth('cliqSaw')



Pdef('matrix', Ppar([ Pdef('r00'), Pdef('r01'), Pdef('b00'), Pdef('b01')]))


Pdef('efx').play

Pdef('efx').stop

(0..31).do({|index|
	var efxkeys = ['efx0'].select({ 0.5.coin });
	~matrix.defsAt('b00').setEfx(index, efxkeys)
})

(0..31).do({|index|
	var efxkeys = ['efx4'].select({ 0.5.coin });
	~matrix.defsAt('b00').setEfx(index, efxkeys)
})

(0..31).do({|index|
	var efxkeys = ['efx5'].select({ 0.5.coin });
	~matrix.defsAt('r00').setEfx(index, efxkeys)
})


~matrix.efxamps['efx0'] = 0.4

~matrix.efxamps['efx4'] = 1.0

~matrix.efxamps['efx5'] = 1.0
