Tdef('ciAuto').clear

(

~patches.do({|arr, i|
	~graphics.setPattern(i, 0, 1.0, 0, 0, 1.0, 1.0, 1.0);
})
)

(
Tdef(\sendVector, {
	loop({
		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		[ 0.0625, 0.125, 0.25].choose.wait;
	});
}).play;
)

(


~lasttime = SystemClock.seconds;
~meanamp = 0;
~meandur = 0;
~ruleWeight = 0.3;
~changeWeight = 0.3;

~patches = [
	[1.0, 1, 1, 0.0, 1.0, 1.0], //0
	[1.0, 1, 1, 0.9, 0.1, 0.4],
	// [1.0, 0, 0, 1.0, 1.0, 1.0],
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

~activePatterns = [1];
~graphics.setPattern(1, 1, 1.0, 1, 1, 0.0, 1.0, 1.0);
~graphics.setViewpoint(0.0, 0.0, 20.0, 0.0, 0.0, 0.0);
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
				\frozenspirals,\nova, \rainzha, \rake, \sedimental,
				\transers, \worms, \xtasy
				].choose;
			);
		};

		if (0.1.coin) {
			~graphics.stopRotation;
			~graphics.setViewpoint(
				rrand(30.0, 60.0)*[1.0,-1.0].choose,
				rrand(30.0, 60.0)*[1.0,-1.0].choose,
				rrand(30.0, 60.0)*[1.0,-1.0].choose,
				0.0, 0.0, 0.0
			);
			~graphics.unmapCodePanel;
		}{
			if (0.1.coin) {
				~rot = Rotation(rrand(-100.0, 100.0), rrand(0.005, 0.05), rrand(-20.0, 20.0),
					rrand(-120.0, 120.0),
					rrand(-pi, pi), rrand(0.01, 0.08), rrand(-pi, pi), rrand(0.01, 0.07));
			}
			{
				~rot = Rotation(rrand(60.0, 120.0).neg, 0.0, rrand(60.0, 120.0).neg, 0.0, 0.0, -0.02, 0.0, 0.0);
			};
			~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
			~graphics.rotateCamera;
			~graphics.mapCodePanel;
		};

		rrand(0.2, 0.6).round(0.1).wait;
	})
}).play
)