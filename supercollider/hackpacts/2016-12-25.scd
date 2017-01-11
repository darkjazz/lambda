~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2, screenX: 1024, screenY: 768, mode: 1, decoderType: 'stereo', bpm: 140, channels: 2, foa: #[zoom,push], dbname: "ges_ld_00", patdefs: "patternDefsAppendLnx.scd", initPdefs: ['r00', 'b00', 'r01', 'r02', 'b03'], worldDim: 21, ip: "127.0.0.1");

e = SpEnvir(~settings)

e.initGraphics(true)

~matrix.setBPM(121)

s.queryAllNodes

~gesbufs = GESBufferLoader().loadByDate("161224")
~gesbufs.preload
~gesbufs.buffers.collect(_.path).do(_.postln)
~gesbufs.size

24, 25, 26, 27, 32, 33, 35, 36

~wrp0 = Synth.tail(~matrix.group, 'wrprev', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs.at(32), 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])


~wrp0.set('amp', 0.4, 'wamp', 0.8, 'iamp', 2.0, 'ramp', 0.4, 'rate', 1.0, 'freq', 2.0, 'wrp', 0.3)

~wrp0.free

~wrp1 = Synth.tail(~matrix.group, 'revwrp', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs.at(35), 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])


~wrp1.set('amp', 0.7, 'wamp', 0.4, 'iamp', 1.0, 'ramp', 0.4, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.5)


~wrp1.free


~wrp2 = Synth.tail(~matrix.group, 'wrprev', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs.at(35), 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])


~wrp2.set('amp', 0.4, 'wamp', 0.7, 'iamp', 1.0, 'ramp', 0.5, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.1)

~wrp2.free

s.queryAllNodes



~matrix.defsAt('m02').assignEfx(
	( efx1: (0..31))
)

~matrix.defsAt('m03').assignEfx(
	( efx5: (0..31))
)


~matrix.efxamps['efx1'] = 0.1

~matrix.defsAt('r03').assignEfx(
	(efx1: (0..31))
)

~matrix.efxamps['efx0'] = 0.1


~matrix.defsAt('b00').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.3, 0.7) },
	{ exprand(0.05, 0.2) },
	0.1
);

~matrix.defsAt('b03').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.2, 0.8) },
	{ exprand(0.6, 4.0) },
	0.0
);

~matrix.defsAt('b06').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.1, 0.4) },
	{ exprand(4.0, 6.0) },
	0.0
);

~matrix.defsAt('b03').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.1, 1.0) },
	{ exprand(0.2, 0.4) },
	0.1
);

~matrix.defsAt('r07').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.05, 0.2) },
	{ exprand(2.0, 4.0) },
	0.1
);

s.queryAllNodes

Server.killAll

~matrix.defsAt('r06').recall(0);

~matrix.defsAt('r00').recall(0);
~matrix.defsAt('r01').recall(0);

~matrix.defsAt('b03').recall(0);





['flangingDecimator', 'granularReverb', 'feedbackSpectrum', 'cyclicWarp', 'latchOnset', 'cliqSaw', 'fxGrain', 'arhythmicGendy']

~matrix.activateSkismSynth('latchOnset')

~matrix.setSkismAmp('latchOnset', 1.0)

~matrix.deactivateSkismSynth('latchOnset')


Tdef('sendcode', {
	loop({
		var str;
		str = "";
		rrand(4, 16).do({
			6.do({ str = str ++ [rrand(39, 47),  rrand(58, 63)].choose.asAscii });
			str = str ++ " ";
		});
		~graphics.sendCodeLine(str);
		rrand(0.3, 0.6).wait
	})
}).play

~graphics.showCodePanel
~graphics.mapCodePanel

~graphics = CinderApp(800, 450, mode: 0, path:"/Users/alo/dev/lambda/xcode/DerivedData/lambdaApp/Build/Products/Debug/lambda.app")

~graphics.open
~graphics.initWorld(19, 19, 19, 20);
~graphics.initGenerations([4,6],[4,6],17);
~graphics.setViewpoint(0.0, 0.0, 100.0, 0.0, 0.0, 0.0)
~graphics.setSymmetry(11)

Tdef('moveCam', {
	loop({
		var dur = [3, 8].choose;
		~graphics.moveCamera([[1.0, 120.0].choose, [1.0, 120.0].choose, [1.0, 120.0].choose, 0.0, 0.0, 0.0], [1.0, 1.0, 1.0, 0.0, 0.0, 0.0], dur, 10);
		dur.wait;
	})
}).play

~graphics.sendCodeTitle(":::------:::::")

~graphics.setPattern(15, 1, 1.0, 0, 0, 1.0, 1.0, 1.0);
~graphics.setPattern(36, 1, 1.0, 0, 0, 1.0, 1.0, 1.0);
~graphics.setPattern(12, 1, 1.0, 1, 1, 0.0, 1.0, 0.0);

~graphics.setPattern(39, 1, 1.0, 0, 0, 1.0, 1.0, 1.0);

~graphics.sendPredefined3DRule(\nova)
~graphics.sendPredefined3DRule(\belzhab)
~graphics.sendPredefined3DRule(\faders)
~graphics.sendPredefined3DRule(\xtasy)

Tdef(\sendVector, {
	loop({
		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		[ 0.0625, 0.125, 0.25].choose.wait;
	})f;
}).play;

