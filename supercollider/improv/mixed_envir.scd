~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2, screenX: 1024, screenY: 768, mode: 1, decoderType: 'stereo', bpm: 140, channels: 2, foa: #[zoom,push], dbname: "ges_ld_00", patdefs: "patternDefsAppendLnx.scd", initPdefs: ['r99', 'b03', 'b04', 'b05'], worldDim: 17, ip: "127.0.0.1");

e = SpEnvir(~settings)


e.initGraphics(true)

s.queryAllNodes
Server.killAll
~matrix.setBPM(130)

SparseMatrix

// voice thru
SynthDef('vox', {|efx, amp|
	var input;
	input = SoundIn.ar(0) * amp;
	Out.ar(efx, input);
	// Out.ar(0, input.dup)
}).add

z = Synth.tail(~matrix.efxgroup, 'vox', ['efx', ~decoder.bus, 'amp', 2.0])

z.set('amp', 3.0)

s.sendMsg("/n_free", 11161)


z.free
 // voice thru end

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

~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.3, 1.0) },
	{ exprand(0.01, 0.3) },
	0.1
);


~matrix.defsAt('b03').setControls(
	{ [0, 1].wchoose([0.5, 0.5]) },
	{ exprand(0.5, 2.0) },
	{ exprand(0.05, 0.2) },
	0.1
);

~matrix.defsAt('b03').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.3) },
	{ exprand(0.1, 0.4) },
	0.1
);

~matrix.defsAt('b04').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.3, 1.0) },
	{ exprand(2.0, 4.0) },
	0.1
);


~matrix.defsAt('b04').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.2, 1.0) },
	{ exprand(0.2, 0.4) },
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

~matrix.defsAt('b03').recall(0);


~matrix.defsAt('b06').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.2, 0.6) },
	{ exprand(0.5, 1.0) },
	0.1
);



Pdef('matrix', Ppar([ Pdef('r00'), Pdef('r01'), Pdef('b03'), Pdef('b04'), Pdef('b06')]))


s.scope(2)

['flangingDecimator', 'granularReverb', 'feedbackSpectrum', 'cyclicWarp', 'latchOnset', 'cliqSaw', 'fxGrain', 'arhythmicGendy']

~matrix.activateSkismSynth('latchOnset')

~matrix.setSkismAmp('latchOnset', 1.0)


~matrix.deactivateSkismSynth('latchOnset')



~matrix.activateSkismSynth('feedbackSpectrum')

~matrix.setSkismAmp('feedbackSpectrum', 0.5)

~matrix.deactivateSkismSynth('feedbackSpectrum')


~matrix.activateSkismSynth('flangingDecimator')

~matrix.setSkismAmp('flangingDecimator', 0.0)

~matrix.deactivateSkismSynth('flangingDecimator')



~matrix.buffers['evo']

~matrix.buffers['evo'].collect(_.path).select({|path| path.find("ev_").notNil }).size
.do(_.postln)

~wrp0 = Synth.tail(~matrix.group, 'wrprev', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 30, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][37], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])


~wrp0.set('amp', 0.8, 'wamp', 0.1, 'iamp', 0.0, 'ramp', 0.8, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.05)

~wrp0.free


~wrp1 = Synth.tail(~matrix.group, 'revwrp', ['out', ~decoder.bus, 'rate', 0.5, 'start', 0, 'wrp', 0.1, 'freq', 2.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 40, 'rtime', 12.0, 'ramp', 0.0, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][38], 'amp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])

~wrp1.set('amp', 0.0, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.2, 'freq', 1.0, 'rate', 1.0, 'wrp', 0.1)

~wrp1.free


~wrp2 = Synth.tail(~matrix.group, 'revwrp', ['out', ~decoder.bus, 'rate', 0.5, 'start', 0, 'wrp', 0.1, 'freq', 2.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 40, 'rtime', 12.0, 'ramp', 0.0, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][39], 'amp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])

~wrp2.set('amp', 0.2, 'iamp', 0.7, 'ramp', 0.4, 'freq', 1.0, 'rate', 1.0, 'wrp', 0.1)

~wrp2.free


~wrp3 = Synth.tail(~matrix.group, 'wrprev', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 30, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][36], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])


~wrp3.set('amp', 0.0, 'wamp', 0.4, 'iamp', 0.9, 'ramp', 0.3, 'rate', 0.25, 'freq', 0.5, 'wrp', 0.1)


~wrp3.free



s.queryAllNodes

~player.start(~foa)


~player.setFoa('zoom', 1.0)
~player.setFoa('push', 1.0)


~ind0 = 39

~player.loadData(~ind0)

~player.play(~ind0, 0, 'zoom', 0)

~player.set(~ind0, 0.0)

~player.free(~ind0)


~ind1 = 35

~player.loadData(~ind1)

~player.play(~ind1, 0, 'zoom', 0)

~player.set(~ind1, 0.0)

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
		Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.1, 0.3), 'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(75, 90)], 'dur', exprand(0.2, 0.4), 'env', [Env([0.001, 1.0], [1], [2]), Env.perc].choose] );
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

Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.1, 1.0), 'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(0, 4)], 'dur', exprand(0.1, 0.2), 'env', [Env.sine, Env.perc].choose] );



SynthDef('vox', {|efx, amp, del|
	var input;
	input = DelayC.ar(SoundIn.ar(0) * amp, 1.0, del);
	Out.ar(efx, input);
	// Out.ar(0, input.dup)
}).add

z = Synth.tail(~matrix.efxgroup, 'vox', ['efx', ~decoder.bus, 'amp', 0.0, 'del', 0.7])

z.set('amp', 0.0, 'del', 1.0)

z.free