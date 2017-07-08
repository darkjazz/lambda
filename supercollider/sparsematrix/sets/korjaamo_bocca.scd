(~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2, screenX: 1024, screenY: 768, mode: 1, decoderType: 'stereo', bpm: 111, channels: 2, foa: #[zoom,push], dbname: "ges_ld_00", patdefs: "patternDefsAppendLnx.scd", initPdefs: ['b00', 'r07'], worldDim: 21, ip: "127.0.0.1");

e = SpEnvir(~settings))

Server.killAll

~gesbufs = GESBufferLoader().loadByDate("161224")
~gesbufs.preload

(
~bocca = Buffer.read(s, "/Users/alo/snd/bocca/pink.aiff");
~bbus = Bus.audio(Server.default, 2);

SynthDef('bocca', {|out, efx, buffer, amp, emp|
	var sig = PlayBuf.ar(2, buffer, doneAction: 2);
	Out.ar(efx, sig * emp);
	Out.ar(out, sig * amp)
}).add
)

(
~wrp0 = Synth.tail(~matrix.group, 'wrprevm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[11], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

Pdef('swrp0',
	Pbind(
		\type, \set, \id, ~wrp0.nodeID, \delta, Pn(0.2, inf),
		\rx, Pbrown(0, 2pi, 0.125pi, inf),
		\ry, Pbrown(0, 2pi, 0.125pi, inf),
		\rz, Pbrown(0, 2pi, 0.125pi, inf),
		\args, #[rx, ry, rz]
	)
).play
)

~wrp0.set('amp', 1.0, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.1)

~wrp0.free; Pdef('swrp0').clear



(
~wrp1 = Synth.tail(~matrix.group, 'wrprevm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[20], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

Pdef('swrp1',
	Pbind(
		\type, \set, \id, ~wrp1.nodeID, \delta, Pn(0.2, inf),
		\rx, Pbrown(0, 2pi, 0.125pi, inf),
		\ry, Pbrown(0, 2pi, 0.125pi, inf),
		\rz, Pbrown(0, 2pi, 0.125pi, inf),
		\args, #[rx, ry, rz]
	)
).play
)

~wrp1.set('amp', 1.0, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.4, 'rate', 1.0, 'freq', 0.5, 'wrp', 0.1)

~wrp1.free; Pdef('swrp1').clear



(
~wrp2 = Synth.tail(~matrix.group, 'revwrpm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[30], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

Pdef('swrp2',
	Pbind(
		\type, \set, \id, ~wrp2.nodeID, \delta, Pn(0.2, inf),
		\rx, Pbrown(0, 2pi, 2pi/16, inf),
		\ry, Pbrown(0, 2pi, 2pi/16, inf),
		\rz, Pbrown(0, 2pi, 2pi/16, inf),
		\args, #[rx, ry, rz]
	)
).play
)

~wrp2.set('amp', 1.0, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.1)

~wrp2.free; Pdef('swrp2').clear

(
~wrp3 = Synth.tail(~matrix.group, 'wrprevm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[35], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

Pdef('swrp3',
	Pbind(
		\type, \set, \id, ~wrp3.nodeID, \delta, Pn(0.2, inf),
		\rx, 0,
		\ry, 0,
		\rz, 0,
		\args, #[rx, ry, rz]
	)
).play;

)

~wrp3.set('amp', 1.0, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.1)

~wrp3.free; Pdef('swrp3').clear


Pdef('matrix', Ppar([ Pdef('b00'), Pdef('b01'), Pdef('b02'), Pdef('b03'), Pdef('b05'), Pdef('b04')]))


Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.4, 0.7), 'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(50, 45)], 'dur', exprand(0.7, 3.0), 'env', [Env.perc, Env.sine].choose] );



~graphics = CinderApp(800, 600, mode: 1, path:"/Users/alo/dev/lambda/xcode/DerivedData/lambdaApp/Build/Products/Debug/lambda.app")

~graphics.open
~graphics.initWorld(19, 19, 19, 20);
~graphics.initGenerations([4,6],[4,6],17);

~graphics.setViewpoint(0.0, 100.0, 0.0, 0.0, 0.0, -10.0)

~graphics.setSymmetry(11)

~graphics.setPattern(6, 0, 1.0, 0, 1, 0.5, 0.9, 0.8);

~graphics.setPattern(22, 0, 0.7, 0, 0, 1.0, 0.0, 1.0);

~graphics.setPattern(24, 0, 1.0, 1, 1, 0.6, 0.7, 0.8);

(

Tdef('loopgraph', {
	var settings, select, indices;
	settings = (
		17: [ 0.7, 0, 1, 0.7, 0.9, 0.3],
		18: [ 0.4, 1, 1, 0.4, 0.7, 0.4],
		25: [ 1.0, 1, 1, 0.9, 0.8, 0.7],
		26: [ 0.5, 1, 1, 0.1, 0.2, 0.3]
	);
	indices = [];
	loop({
		if (select.notNil)
		{
			~graphics.setPattern(select, 0, *settings[select])
		};
		if (indices.size == 0) { indices = [17, 18, 25, 26].scramble };
		select = indices.pop;
		~graphics.setPattern(select, 1, *settings[select]);
		rrand(30.0, 45.0).wait
	})
}).play

)

Tdef('loopgraph').clear


(
~graphics.setViewpoint(0.0, 30.0, 0.0, 0.0, 0.0, 0.0);

~graphics.setPattern(2, 1, 1.0, 0, 0, 1.0, 1.0, 1.0);
)

~graphics.sendPredefined3DRule(\nova)

~graphics.sendPredefined3DRule(\sedimental)
~graphics.sendPredefined3DRule(\xtasy)



(
Tdef(\sendVector, {
	loop({
		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		[ 0.0625, 0.125, 0.25].choose.wait;
	});
}).play;
)


~matrix.defsAt('b00').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.2, 0.5) },
	{ exprand(0.5, 1.0) },
	0.1
);

~voice = Synth.head(~matrix.efxgroup, 'bocca', [\out, ~decoder.bus, \efx, ~bbus, \buffer, ~bocca, \amp, 1.0, \emp, 1.0]);

~voice.set('amp', 1.0)

~matrix.activateBoccaSynth('cyclicWarp', ~bbus);

~matrix.setSkismAmp('cyclicWarp', 0.0)

~matrix.deactivateSkismSynth('cyclicWarp')




~matrix.activateBoccaSynth('granularReverb', ~bbus);

~matrix.setSkismAmp('granularReverb', 1.0)

~matrix.deactivateSkismSynth('granularReverb')


~matrix.activateBoccaSynth('feedbackSpectrum', ~bbus)

~matrix.setSkismAmp('feedbackSpectrum', 0.2)

~matrix.deactivateSkismSynth('feedbackSpectrum')



~matrix.activateBoccaSynth('flangingDecimator', ~bbus)

~matrix.setSkismAmp('flangingDecimator', 1.0)

~matrix.deactivateSkismSynth('flangingDecimator')



~matrix.activateBoccaSynth('latchOnset', ~bbus)

~matrix.setSkismAmp('latchOnset', 0.5)

~matrix.deactivateSkismSynth('latchOnset')



~matrix.activateBoccaSynth('arhythmicGendy', ~bbus)

~matrix.setSkismAmp('arhythmicGendy', 0.4)

~matrix.deactivateSkismSynth('arhythmicGendy')


SynthDef(\bitSt2, {|out, efx, amp, emp, buf, dur|
	var sig;
	sig = Normalizer.ar(
		PlayBuf.ar(2, buf, BufRateScale.ir(buf) * 1.neg, 1, BufFrames.kr(buf)),
		amp) * EnvGen.kr(\env.kr(Env.newClear(8).asArray), timeScale: dur, doneAction: 2);
	Out.ar(efx, sig * emp);
	Out.ar(out, sig * amp)
}).add;

Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.4, 0.7), 'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(50, 65)], 'dur', exprand(0.7, 3.0), 'env', [Env.perc, Env.sine].choose] );


Tdef('tex').clear

, {
	loop({
		Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.4, 0.8), 'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(50, 45)], 'dur', exprand(0.3, 0.7), 'env', [Env.perc, Env.sine].choose] );
		rrand(0.1, 0.4).wait
	})
})
.play


Server.killAll


Quarks.gui

x=SynthDef('test', { Out.ar(0, Dust.ar(30)) }).play
x.free


o=SynthDef('out34', {|amp=0.3| Out.ar([2, 3], SoundIn.ar([0, 1]) * amp) }).play
o.set('amp', 0.03)
o.free
