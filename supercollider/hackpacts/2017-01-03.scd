~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2, screenX: 1024, screenY: 768, mode: 1, decoderType: 'stereo', bpm: 140, channels: 2, foa: #[zoom,push], dbname: "ges_ld_00", patdefs: "patternDefsAppendLnx.scd", initPdefs: ['b03', 'b04', 'b05', 'b06'], worldDim: 21, ip: "127.0.0.1");

e = SpEnvir(~settings)

~matrix.buffers['evo'].collect(_.path).do(_.postln)

~matrix.setBPM(171)


~matrix.defsAt('b03').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.4) },
	{ exprand(0.03, 0.1) },
	0.1
);


~matrix.defsAt('b05').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.3, 0.6) },
	0.1
);

~matrix.defsAt('b05').recall(0);
~matrix.defsAt('b06').recall(0)

~matrix.defsAt('b06').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.3, 0.7) },
	{ exprand(2.0, 4.0) },
	0.1
);




~graphics = CinderApp(800, 450, mode: 0, path:"/Users/alo/dev/lambda/xcode/DerivedData/lambdaApp/Build/Products/Debug/lambda.app")

~graphics.open

~graphics.initWorld(19, 19, 19, 20);

~graphics.initGenerations([4,6],[4,6],17);

~graphics.setSymmetry(11)

~graphics.setViewpoint(0.0, 80.0, 0.0, 0.0, 0.0, 0.0)

Tdef(\sendVector, {
	loop({
		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		[ 0.0625, 0.125, 0.25].choose.wait;
	});
}).play;

~graphics.setPattern(15, 1, 1.0, 0, 0, 1.0, 1.0, 1.0);

~graphics.setPattern(28, 1, 1.0, 0, 0, 1.0, 1.0, 1.0);

~graphics.setPattern(36, 1, 0.4, 0, 0, 1.0, 1.0, 1.0);

~graphics.activateSwarm(17, 200.0, 200.0, 200.0, 0.8, 50.0, 8.0, 15.0, 100.0);

~graphics.sendBoidPattern(0, 1, 0);

~graphics.sendBoidPattern(4, 1, 0);

~graphics.sendBoidPattern(5, 0, 0);



~graphics.setBoidCam(false, false)



~wrp0 = Synth.tail(~matrix.group, 'wrprev', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][5], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])


~wrp0.set('amp', 0.4, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 1.0, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.1)


~wrp0.free



~wrp1 = Synth.tail(~matrix.group, 'revwrp', ['out', ~decoder.bus, 'rate', 0.5, 'start', 0, 'wrp', 0.1, 'freq', 2.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 40, 'rtime', 12.0, 'ramp', 0.5, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][2], 'amp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])

~wrp1.set('amp', 0.4, 'wamp', 0.4, 'iamp', 0.3, 'ramp', 0.7, 'freq', 1.0, 'rate', 1.0, 'wrp', 0.1);

~wrp1.free



Tdef('ciAuto').clear

(

~patches.do({|arr, i|
	~graphics.setPattern(i, 0, 1.0, 0, 0, 1.0, 1.0, 1.0);
})
)


Tdef(\sendVector, {
	loop({
		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		[ 0.0625, 0.125, 0.25].choose.wait;
	});
}).play;

(

~lasttime = SystemClock.seconds;
~meanamp = 0;
~meandur = 0;
~ruleWeight = 0.05;
~changeWeight = 0.05;

~patches = [
	[1.0, 1, 1, 0.0, 1.0, 1.0], //0
	[1.0, 1, 1, 0.9, 0.1, 0.4],
	[1.0, 0, 0, 1.0, 1.0, 1.0],
	[1.0, 1, 1, 0.6, 0.8, 0.8],
	[1.0, 0, 0, 1.0, 1.0, 1.0],
	[1.0, 1, 1, 0.5, 1.0, 1.0], //5
	[1.0, 1, 1, 0.5, 0.9, 0.8],
	[1.0, 1, 1, 1.0, 0.3, 0.5],
	[1.0, 0, 0, 0.6, 0.7, 0.9],
	[1.0, 0, 0, 0.5, 0.8, 0.9],
	[1.0, 1, 1, 0.2, 0.8, 0.8], //10
	[1.0, 0, 0, 0.0, 0.5, 1.0],
	[1.0, 0, 0, 0.6, 0.8, 1.0],
	[1.0, 1, 1, 0.2, 0.8, 1.0],
	[1.0, 0, 0, 1.0, 1.0, 1.0],
	[1.0, 0, 0, 1.0, 1.0, 1.0], //15
	[1.0, 1, 1, 0.1, 1.0, 0.3],
	[1.0, 1, 1, 0.7, 1.0, 0.0],
	[1.0, 1, 1, 1.0, 1.0, 1.0],
	[1.0, 0, 0, 1.0, 1.0, 1.0],
	[1.0, 1, 1, 1.0, 1.0, 0.2], //20
	[1.0, 1, 1, 1.0, 1.0, 1.0],
	[1.0, 1, 1, 1.0, 0.9, 1.0],
	[1.0, 0, 1, 1.0, 1.0, 1.0],
	[1.0, 1, 1, 0.5, 0.6, 0.7],
	[1.0, 0, 0, 0.5, 0.6, 0.7], //25
	[1.0, 1, 1, 0.6, 0.7, 0.8],
	[1.0, 1, 1, 0.2, 0.7, 0.6],
	[1.0, 0, 0, 1.0, 1.0, 1.0],
	[1.0, 0, 0, 0.6, 0.9, 1.0],
	[1.0, 0, 0, 1.0, 1.0, 1.0], //30
	[1.0, 0, 0, 0.5, 0.3, 1.0],
	[1.0, 1, 1, 0.0, 1.0, 0.0],
	[0.5, 1, 1, 1.0, 0.0, 1.0],
	[1.0, 0, 0, 1.0, 0.2, 0.5],
	[1.0, 0, 0, 0.0, 1.0, 0.8], //35
	[1.0, 0, 0, 1.0, 1.0, 1.0],
	[1.0, 1, 1, 1.0, 1.0, 1.0],
	[1.0, 0, 0, 1.0, 1.0, 1.0],
	[1.0, 0, 0, 1.0, 1.0, 1.0]
];

~graphPatterns = (0..39);

~graphPatterns.remove(21);

~activePatterns = [14];
~graphics.setPattern(14, 1, 1.0, 0, 0, 1.0, 1.0, 1.0);
~graphics.setViewpoint(0.0, 0.0, 60.0, 0.0, 0.0, 0.0);
Tdef('ciAuto', {|mfcc|
	loop({
		var delta, curr, args;
		delta = SystemClock.seconds - ~lasttime;
		~lasttime = SystemClock.seconds;
		if (~changeWeight.coin)
		{

			if (~activePatterns.size > 3)
			{
				~activePatterns.size.rand.do({
					curr = ~activePatterns.choose;
					~activePatterns.remove(curr);
					args = [curr, 0] ++ ~patches[curr];
					~graphics.setPattern(*args);
				})
			}
			{
				curr = ~graphPatterns.choose;
				~activePatterns = ~activePatterns.add(curr);
				args = [curr, 1] ++ ~patches[curr];
				~graphics.setPattern(*args);
			}
		};
		if (~ruleWeight.coin) {
				~graphics.sendPredefined3DRule(
				[
				\flamingstarbow, \chenille, \belzhab, \glissergy,
				\cooties, \faders, \frozenspirals, \glisserati,
				\nova, \orthogo, \rainzha, \rake, \sedimental,
				\snake, \starwars, \sticks, \thrillgrill,
				\transers, \wanderers, \worms, \xtasy
				].choose;
			);
		};

		if (0.3.coin) {
			~graphics.setSwarm(rrand(0.8, 0.99), rrand(10.0, 50.0), 8.0, 25.0, 100.0)
		};

		rrand(0.2, 0.6).round(0.1).wait;
	})
}).play
)