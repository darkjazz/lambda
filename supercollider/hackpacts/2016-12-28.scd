~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2, screenX: 1024, screenY: 768, mode: 1, decoderType: 'stereo', bpm: 140, channels: 2, foa: #[zoom,push], dbname: "ges_ld_00", patdefs: "patternDefsAppendLnx.scd", initPdefs: ['m00', 'm01', 'b05', 'efx'], worldDim: 21, ip: "127.0.0.1");

e = SpEnvir(~settings)

~matrix.setBPM(143)

(
~primes = Array.primes(101, 401);
~seq = Array.fill(23, {
	Array.primeSeries(5, ~primes.choose, 7);
});
~freqs = Pseq(~seq.collect(_.bubble), inf);
)

~matrix.addPatternChordDef('c00', 4, 2, "c0", 'argproto', 'nested_pm', ~freqs, Array.geom(5, rrand(10, 18), 8/5).bubble, Pwhite(0.1, 0.4, inf), Pwhite(0.3, 0.5));

(
~matrix.patterndefs['c00'].ctrls.active = 1;
~matrix.patterndefs['c00'].ctrls.dur = 0.2;
~matrix.patterndefs['c00'].ctrls.amp = 0.0;
~matrix.patterndefs['c00'].ctrls.emp = 0.0;
Pdefn('c00efx', ~matrix.efx['efx1'].args.in);
)

Pdef('matrix', Ppar([ Pdef('m00'), Pdef('m01'), Pdef('b05'), Pdef('c00'), Pdef('efx') ]))

~matrix.efxamps['efx1'] = 0.1

SparseMatrix

s.queryAllNodes

~matrix.addPatternMelodyDef('m00', (0..31), 4, 8,
	['basikolo', 'cassa', 'diansa', 'sokou'],
	0, "m0", 'argproto', false, 'd03', Prand(Array.primeSeries(5, 201, 5), inf)
);

~matrix.defsAt('r02').assignEfx(
	( efx2: (0..31))
)

Tdef(\sendVector).play;
~matrix.defsAt('m01').setControls(0, 0.4, 0.04, 0.1);
~matrix.defsAt('m00').setControls(0, 1.0, 0.01, 0.1);
Tdef(\sendVector).stop

~matrix.defsAt('b05').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.3, 0.6) },
	{ exprand(0.1, 0.3) },
	0.1
);

~matrix.defsAt('b05').recall(2)

~graphics = CinderApp(600, 450, mode: 0, path:"/Users/alo/dev/lambda/xcode/DerivedData/lambdaApp/Build/Products/Debug/lambda.app")


~graphics.open
~graphics.initWorld(19, 19, 19, 20);
~graphics.initGenerations([4,6],[4,6],17);

~graphics.setViewpoint(-110.0, -110.0, -110.0, 0.0, -10.0, 0.0)

~graphics.setSymmetry(11)

Tdef(\sendVector, {
	loop({
		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		[ 0.0625, 0.125, 0.25].choose.wait;
	});
})

~graphics.setPattern(37, 1, 1.0, 1, 1, 1.0, 1.0, 1.0);

~graphics.sendGenRule([2,3],[2,3],17);

~graphics.sendPredefined3DRule(\nova)

~graphics.setPattern(33, 1, 1.0, 0, 0, 0.3, 0.8, 1.0);

~graphics.setPattern(0, 0, 1.0, 1, 1, 1.0, 0.0, 1.0);