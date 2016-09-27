~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2, screenX: 1024, screenY: 768, mode: 1, decoderType: 'stereo', bpm: 140, channels: 2, foa: #[zoom,push], dbname: "ges_ld_00", patdefs: "patternDefsAppendLnx.scd", initPdefs: ['b03', 'b04', 'b05', 'b06'], worldDim: 21, ip: "127.0.0.1");


e = SpEnvir(~settings)

e.initGraphics(true)

~matrix.setBPM(135)

Tdef('fuckbpm').clear

Tdef('fuckbpm', {
	loop({
		~matrix.setBPM(rrand(30, 200).round(30));
		rrand(0.1, 2.0).wait
	})
}).play

Server.killAll


~matrix.defsAt('r00').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ exprand(0.1, 2.0) },
	{ exprand(0.01, 0.2) },
	0.1
);

~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.01, 0.3) },
	0.1
);

~matrix.defsAt('r02').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.01, 0.1) },
	0.1
);

~matrix.defsAt('b04').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.1, 0.8) },
	{ exprand(0.5, 1.0) },
	0.1
);

~matrix.defsAt('b03').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.1, 0.8) },
	{ exprand(0.4, 0.8) },
	0.1
);

~matrix.defsAt('b05').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.1, 0.4) },
	0.1
);

s.queryAllNodes

Server.killAll

~matrix.defsAt('b06').recall(0);

~matrix.defsAt('r00').recall(0);
~matrix.defsAt('r01').recall(0);

~matrix.defsAt('b03').recall(0);


~matrix.setBPM(140)

Pdef('matrix', Ppar([ Pdef('r00'), Pdef('r01'), Pdef('b00'), Pdef('b01')]))


s.record

s.stopRecording

s.scope(2)

['flangingDecimator', 'granularReverb', 'feedbackSpectrum', 'cyclicWarp', 'latchOnset', 'cliqSaw', 'fxGrain', 'arhythmicGendy']

~matrix.activateSkismSynth('latchOnset')

~matrix.setSkismAmp('latchOnset', 1.0)

~matrix.deactivateSkismSynth('latchOnset')



~matrix.activateSkismSynth('feedbackSpectrum')

~matrix.setSkismAmp('feedbackSpectrum', 0.5)

~matrix.deactivateSkismSynth('feedbackSpectrum')



~matrix.activateSkismSynth('cliqSaw')

~matrix.setSkismAmp('cliqSaw', 1.0)

~matrix.deactivateSkismSynth('cliqSaw')


~changeWeight = 0.3

Server.killAll


~player.start(~foa)


~player.setFoa('zoom', 1.0)
~player.setFoa('push', 1.0)


~ind0 = 67

~player.loadData(~ind0)

~player.play(~ind0, 0, 'zoom', 0)

~player.set(~ind0, 1.0)

~player.free(~ind0)


s.scope(2)

~ind1 = 42

~player.loadData(~ind1)

~player.play(~ind1, 0, 'zoom', 0)

~player.set(~ind1, 0.0)

~player.free(~ind1);


~ind2 = 50

~player.loadData(~ind2)

~player.play(~ind2, 0, 'zoom', 0)

~player.set(~ind2, 0.0)

~player.free(~ind2);


s.queryAllNodes


s.sendMsg("/n_free", 1009)

~graphics = CinderApp(1024, 768, mode: 1)


~graphics.open
~graphics.initWorld(17, 17, 17, 20);
~graphics.initGenerations([4,6],[4,6],16);
~graphics.setSymmetry(11)
~graphics.setViewpoint(80.0, 80.0, 80.0, 0.0, 0.0, 0.0)

Tdef(\sendVector, {
	loop({
		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		[ 0.25, 0.125, 0.5].choose.wait;
	});
});

Tdef(\sendVector).play

Tdef('ciAuto').clear

s.queryAllNodes

s.record


s.stopRecording

~wrp0 = Synth.tail(~matrix.group, 'wrprev', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][10], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])


~wrp0.set('amp', 0.0, 'wamp', 1.0, 'iamp', 0.5, 'ramp', 0.0, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.1)


~wrp0.free

(
Pdef('swrp0',
	Pbind(
		\type, \set,
		\id, ~wrp0.nodeID,
		\wamp, Pseq([0.5, 0.0, 0.2, 0.0], inf),
		\iamp, Pseq([0.0, 0.4, 0.0, 0.0, 0.0], inf),
		\freq, Pseq([0.5, 0.25], inf),
		\wrp, Pseq([0.1, 0.2], inf),
		\delta, Prand([1, 2, 4] * ~matrix.beatdur, inf),
		\args, #[wamp, iamp, freq, wrp]
	)
)
)

Pdef('swrp0').play

Pdef('swrp0').stop

Server.killAll

~wrp1 = Synth.tail(~matrix.group, 'revwrp', ['out', ~decoder.bus, 'rate', 0.5, 'start', 0, 'wrp', 0.1, 'freq', 2.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 40, 'rtime', 12.0, 'ramp', 0.5, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][17], 'amp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])

~wrp1.set('amp', 0.2, 'wamp', 1.0, 'iamp', 0.9, 'ramp', 0.3, 'freq', 1.0, 'rate', 1.0, 'wrp', 0.1)

~wrp1.free


~wrp2 = Synth.tail(~matrix.group, 'revwrp', ['out', ~decoder.bus, 'rate', 0.5, 'start', 0, 'wrp', 0.1, 'freq', 2.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 40, 'rtime', 12.0, 'ramp', 0.0, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][14], 'amp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])

~wrp2.set('amp', 0.2, 'wamp', 1.0, 'iamp', 0.8, 'ramp', 0.1, 'freq', 1.0, 'rate', 1.0, 'wrp', 0.1)

~wrp2.free



~wrp3 = Synth.tail(~matrix.group, 'wrprev', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 30, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][13], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])


~wrp3.set('amp', 0.4, 'wamp', 0.2, 'iamp', 0.0, 'ramp', 0.3, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.1)

~wrp3.free


Server.default.queryAllNodes

Server.killAll