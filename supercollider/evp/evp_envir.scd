~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2, screenX: 1024, screenY: 768, mode: 1, decoderType: 'stereo', bpm: 140, channels: 2, foa: #[zoom,push], dbname: "ges_ld_00", patdefs: "patternDefsAppendLnx.scd", initPdefs: ['r01', 'b01', 'b02', 'b03', 'b04', 'b05'], worldDim: 17, ip: "127.0.0.1");

e = SpEnvir(~settings)

~vbufs = "/Users/alo/snd/evp_collab/venedikt*".pathMatch.collect({|path|
	Buffer.readChannel(s, path, channels: [0])
});


e.initGraphics(true)


s.queryAllNodes
Server.killAll
~matrix.setBPM(150)

s.sendMsg("/n_free", 1007)


s.queryAllNodes

Tdef('fuckbpm').clear

Tdef('fuckbpm', {
	loop({
		~matrix.setBPM(rrand(60, 140).round(30));
		rrand(0.1, 2.0).wait
	})
}).play

~ptrn = 'r99'

~matrix.defsAt(~ptrn).ctrls.keys(Array).sort.keep(11).do({|ctrname|
	~matrix.defsAt(~ptrn).ctrls[ctrname].active = 1;
	~matrix.defsAt(~ptrn).ctrls[ctrname].dur = rrand(0.1, 0.2);
	~matrix.defsAt(~ptrn).ctrls[ctrname].amp = rrand(0.4, 0.8);

})

~matrix.defsAt('r99').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.1, 0.4) },
	{ exprand(0.05, 0.4) },
	0.1
);

~matrix.defsAt('b01').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.1, 0.5) },
	0.1
);

~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 2.0) },
	{ exprand(0.05, 0.2) },
	0.1
);

~matrix.defsAt('b02').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.6, 2.0) },
	{ exprand(0.1, 0.5) },
	0.1
);

~matrix.defsAt('b05').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.5) },
	{ exprand(1.0, 2.0) },
	0.1
);

~matrix.defsAt('b04').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 2.0) },
	{ exprand(3.0, 6.0) },
	0.1
);

s.record

s.stopRecording

~matrix.defsAt('b06').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.2, 1.0) },
	{ exprand(0.5, 1.0) },
	0.1
);

~matrix.defsAt('b05').setControls(
	{ [0, 1].wchoose([0/8, 0.2]) },
	{ exprand(1.0, 1.5) },
	{ exprand(0.05, 0.2) },
	0.1
);

~matrix.defsAt('r01').recall(0);
~matrix.defsAt('r00').recall(0);
~matrix.defsAt('b04').recall(0);

~matrix.defsAt('b05').recall(0);


~matrix.defsAt('b06').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.2, 0.6) },
	{ exprand(0.5, 1.0) },
	0.1
);

(
Tdef('chng', {
	loop({

		[
		{
			~matrix.defsAt('b04').setControls(
			{ [0, 1].wchoose([0.9, 0.1]) },
			{ exprand(0.5, 1.0) },
			{ exprand(2.0, 4.0) },
			0.1
		);
		},
		{
		~matrix.defsAt('b03').setControls(
			{ [0, 1].wchoose([0.9, 0.1]) },
			{ exprand(0.6, 2.0) },
			{ exprand(0.4, 0.7) },
			0.1
		);
		},
		{
		~matrix.defsAt('b06').setControls(
			{ [0, 1].wchoose([0.9, 0.1]) },
			{ exprand(0.2, 1.0) },
			{ exprand(0.2, 0.4) },
			0.1
		);
		}
		].choose.();
		rrand(30, 50).wait;
	})
})
)
.play

Tdef('chng').clear

Pdef('matrix', Ppar([ Pdef('b00'), Pdef('r01'), Pdef('b03'), Pdef('b04'), Pdef('b06')]))

s.queryAllNodes
s.scope(2)

['flangingDecimator', 'granularReverb', 'feedbackSpectrum', 'cyclicWarp', 'latchOnset', 'cliqSaw', 'fxGrain', 'arhythmicGendy', 'neuralFilter']

~matrix.activateSkismSynth('granularReverb')

~matrix.setSkismAmp('granularReverb', 0.1)

~matrix.deactivateSkismSynth('granularReverb')



~matrix.activateSkismSynth('flangingDecimator')

~matrix.setSkismAmp('flangingDecimator', 0.9)

~matrix.deactivateSkismSynth('flangingDecimator')


~matrix.activateSkismSynth('latchOnset')

~matrix.setSkismAmp('latchOnset', 1.0)

~matrix.deactivateSkismSynth('latchOnset')



~matrix.buffers['evo']

~matrix.buffers['evo'].collect(_.path).select({|path| path.find("ev_").notNil }).size
.do(_.postln)

~wrp0 = Synth.tail(~matrix.group, 'wrprev', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 30, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~vbufs[0], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

~wrp3 = Synth.tail(~matrix.group, 'wrprev', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 30, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~vbufs[2], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

~wrp0.set('amp', 0.3, 'wamp', 0.6, 'iamp', 0.0, 'ramp', 0.0, 'rate', 1.0, 'freq', 0.25, 'wrp', 2.0);

~wrp3.set('amp', 0.3, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.6, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.1)

~wrp0.free

~wrp3.free


~wrp1 = Synth.tail(~matrix.group, 'revwrp', ['out', ~decoder.bus, 'rate', 0.5, 'start', 0, 'wrp', 0.1, 'freq', 2.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 40, 'rtime', 12.0, 'ramp', 0.0, 'damp', 0, 'iamp', 0.0, 'buf', ~vbufs[2], 'amp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])

~wrp1.set('amp', 0.3, 'wamp', 0.0, 'iamp', 1.0, 'ramp', 0.0, 'freq', 1.0, 'rate', 1.0, 'wrp', 0.7)

~wrp1.free


~wrp2 = Synth.tail(~matrix.group, 'revwrp', ['out', ~decoder.bus, 'rate', 0.5, 'start', 0, 'wrp', 0.1, 'freq', 2.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 40, 'rtime', 12.0, 'ramp', 0.0, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][105], 'amp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])

~wrp2.set('amp', 1.0, 'wamp', 0.0, 'iamp', 1.4, 'ramp', 0.4, 'freq', 1.0, 'rate', 1.0, 'wrp', 0.25)

~wrp2.free


~wrp3 = Synth.tail(~matrix.group, 'wrprev', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 30, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][154], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])


~wrp3.set('amp', 0.0, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.5)


~wrp3.free

~wrp4 = Synth.tail(~matrix.group, 'revwrp', ['out', ~decoder.bus, 'rate', 0.5, 'start', 0, 'wrp', 0.1, 'freq', 2.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 40, 'rtime', 12.0, 'ramp', 0.0, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][69], 'amp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])

~wrp4.set('amp', 0.4, 'iamp', 0.0, 'ramp', 0.0, 'freq', 1.0, 'rate', 1.0, 'wrp', 0.1)

~wrp4.free


~wrp5 = Synth.tail(~matrix.group, 'revwrp', ['out', ~decoder.bus, 'rate', 0.5, 'start', 0, 'wrp', 0.1, 'freq', 2.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 40, 'rtime', 12.0, 'ramp', 0.0, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][30], 'amp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])

~wrp5.set('amp', 0.2, 'iamp', 0.0, 'ramp', 0.0, 'wamp', 0.0, 'freq', 0.9, 'rate', 1.0, 'wrp', 0.1)
~wrp5.free

// 80

~wrp6 = Synth.tail(~matrix.group, 'wrprev', ['out', ~decoder.bus, 'rate', 0.5, 'start', 0, 'wrp', 0.1, 'freq', 2.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 40, 'rtime', 12.0, 'ramp', 0.0, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][80], 'amp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])

~wrp6.set('amp', 0.4, 'iamp', 0.1, 'ramp', 0.2, 'wamp', 0.0, 'freq', 1.0, 'rate', 1.0, 'wrp', 0.1)
~wrp6.free


s.queryAllNodes

~player.start(~foa)


~player.setFoa('zoom', 1.0)
~player.setFoa('push', 1.0)


~ind0 = 42

~player.loadData(~ind0)

~player.play(~ind0, 0, 'zoom', 0)

~player.set(~ind0, 0.2)

~player.free(~ind0)


~ind1 = 43

~player.loadData(~ind1)

~player.play(~ind1, 0, 'zoom', 0)

~player.set(~ind1, 0.4)

~player.free(~ind1)






~ind2 = 36

~player.loadData(~ind2)

~player.play(~ind2, 0, 'zoom', 0)

~player.set(~ind2, 0.0)

~player.free(~ind2)




///// TRIGGER ///////

~player.start(~foa)


~player.setFoa('zoom', 1.0)
~player.setFoa('push', 1.0)


~ind0 = 1

~player.loadData(~ind0)

Tdef('trig1', {
	loop({
		~player.trigger((0..4).choose, rrand(0.05, 0.1), 'zoom', rrand(0.2, 0.4), 1, 0);
		rrand(0.1, 0.7).wait
	})
})
.play

Tdef('trig1').clear

~player.trigger(~ind0, 0.6, 'zoom', 0.5, 1, 0)

~player.play(~ind0, 0, 'zoom', 0);

~player.set(~ind0, 0.0)

~player.free(~ind0)






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
		Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.5, 1.0), 'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(87,86)], 'dur', exprand(0.7, 1.0), 'env', [Env([0.001, 1.0], [1], [2]), Env.perc].choose] );
		rrand(0.05, 0.3).wait
	})
})
.play

Tdef('tex').clear

Tdef('tex', {
	loop({
		Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.4, 1.0), 'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(70, 75)], 'dur', exprand(0.1, 0.4), 'env', [Env.perc, Env.sine].choose] );
		rrand(0.4, 0.8).wait
	})
})
.play

"it's not until hunched over"

"The transmitter itself is made of standard brass"

"pine and bamboo"


Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.5, 2.0), 'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(33, 38)], 'dur', exprand(0.3, 1.0), 'env', [Env.sine, Env.perc].choose] );

Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(1.0, 2.0), 'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(6, 10)], 'dur', exprand(0.7, 1.0), 'env', [Env.perc, Env([0.001, 1.0], [1], [2])].choose] );



SynthDef('vox', {|efx, amp, del|
	var input;
	input = DelayC.ar(SoundIn.ar(0) * amp, 1.0, del);
	Out.ar(efx, input);
	// Out.ar(0, input.dup)
}).add

z = Synth.tail(~matrix.efxgroup, 'vox', ['efx', ~decoder.bus, 'amp', 0.0, 'del', 0.7])

z.set('amp', 0.0, 'del', 1.0)

z.free

