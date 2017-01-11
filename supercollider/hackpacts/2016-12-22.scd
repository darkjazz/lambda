~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2, screenX: 1024, screenY: 768, mode: 1, decoderType: 'stereo', bpm: 140, channels: 2, foa: #[zoom,push], dbname: "ges_ld_00", patdefs: "patternDefsAppendLnx.scd", initPdefs: ['r03', 'r04', 'b04', 'm02', 'm03', 'efx'], worldDim: 21, ip: "127.0.0.1");

e = SpEnvir(~settings)

e.initGraphics(true)

~matrix.setBPM(151)

Tdef('fuckbpm').clear

Tdef('fuckbpm', {
	loop({
		~matrix.setBPM(rrand(30, 200).round(30));
		rrand(0.1, 2.0).wait
	})
}).play

s.queryAllNodes

~matrix.addPatternMelodyDef('m02', (0..31), 4, 8,
	['basikolo', 'cassa', 'diansa', 'sokou'].reverse,
	0, "m2", 'argproto', false, 'd12', Pseq([
		Pseq([ 463, 193, 367, 389, 409, 109, 113, 367, 311, 587, 523 ], 3),
		Pn(\rest, 21),
		Pseq([ 109, 199, 151, 181, 113, 127, 193, 139, 109, 127, 193 ], 2),
		Pn(\rest, 21)
	], inf)
);

~matrix.defsAt('m02').assignEfx(
	( efx0: (0..31))
)

~matrix.defsAt('m03').assignEfx(
	( efx5: (0..31))
)


~matrix.efxamps['efx0'] = 0.3

~matrix.defsAt('r03').assignEfx(
	(efx1: (0..31))
)

~matrix.efxamps['efx0'] = 0.1

~matrix.defsAt('m02').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.2, 0.8) },
	{ exprand(0.1, 0.2) },
	0.1
);

~matrix.defsAt('m03').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.3, 0.6) },
	{ exprand(0.1, 0.3) },
	0.5
);

~matrix.defsAt('b04').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 0.7) },
	{ exprand(2.0, 4.0) },
	0.1
);

~matrix.defsAt('r05').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.5) },
	{ exprand(0.05, 0.2) },
	0.0
);

~matrix.defsAt('r06').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.2, 0.5) },
	{ exprand(0.5, 2.0) },
	0.0
);

~matrix.defsAt('b03').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.1, 1.0) },
	{ exprand(0.2, 0.4) },
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

~matrix.defsAt('r06').recall(0);

~matrix.defsAt('r00').recall(0);
~matrix.defsAt('r01').recall(0);

~matrix.defsAt('b03').recall(0);


~matrix.setBPM(140)

Pdef('matrix', Ppar([ Pdef('r05'), Pdef('r06'), Pdef('b04'), Pdef('m02'), Pdef('m03'), Pdef('efx')]))



['flangingDecimator', 'granularReverb', 'feedbackSpectrum', 'cyclicWarp', 'latchOnset', 'cliqSaw', 'fxGrain', 'arhythmicGendy']

~matrix.activateSkismSynth('latchOnset')

~matrix.setSkismAmp('latchOnset', 1.0)

~matrix.deactivateSkismSynth('latchOnset')



~graphics = CinderApp(800, 450, mode: 0, path:"/Users/alo/dev/lambda/xcode/DerivedData/lambdaApp/Build/Products/Debug/lambda.app")

~graphics.open
~graphics.initWorld(17, 17, 17, 20);
~graphics.initGenerations([4,6],[4,6],17);
~graphics.setSymmetry(11)
~graphics.setViewpoint(0.0, 60.0, 60.0, 0.0, 0.0, 0.0)

(
Tdef(\sendVector, {
	loop({
		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		[ 0.0625, 0.125, 0.25].choose.wait;
	});
}).play;
)

~graphics.sendPredefined3DRule(\nova)

~graphics.sendPredefined3DRule(\belzhab)


~graphics.sendPredefined3DRule(\xtasy)

~graphics.sendPredefined3DRule(\flamingstarbow)

~graphics.setPattern(1, 0, 1.0, 1, 1, 0.4, 0.8, 0.8);

~graphics.setPattern(13, 0, 0.5, 0, 0, 0.4, 0.5, 1.0);

~graphics.setPattern(19, 0, 0.5, 0, 0, 1.0, 0.33, 1.0);

~graphics.setPattern(4, 1, 1.0, 1, 1, 1.0, 1.0, 1.0);

