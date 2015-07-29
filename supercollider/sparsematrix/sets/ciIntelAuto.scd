(

~samplesize = 100;
~beatrate = Array.fill(~samplesize, 0);
~collectMfcc = Array.fill(~samplesize, Array.fill(~ncoef, 0));

~lasttime = SystemClock.seconds;
~meanamp = 0;
~meandur = 0;
~ruleWeight = 0.2;

~colors = [
	[0.0, 1.0, 1.0],
	[0.5, 1.0, 1.0],
	[0.3, 0.7, 0.3],
	[0.6, 0.8, 0.8],
	[0.0, 0.4, 1.0],
	[0.5, 1.0, 1.0],
	[0.5, 0.9, 0.8],
	[1.0, 0.3, 0.5],
	[0.6, 0.7, 0.9],
	[0.5, 0.8, 0.9],
	[0.0, 0.2, 0.2],
	[0.0, 0.5, 0.0],
	[0.6, 0.8, 1.0],
	[0.0, 0.6, 1.0],
	[0.0, 0.5, 0.5],
	[0.4, 0.4, 0.4],
	[0.1, 0.7, 0.3],
	[0.1, 0.3, 0.7],
	[1.0, 1.0, 1.0],
	[0.8, 0.6, 0.7],
	[1.0, 0.6, 0.2],
	[0.5, 0.6, 0.7],
	[1.0, 0.9, 1.0],
	[0.5, 0.6, 0.7],
	[0.5, 0.7, 0.6],
	[0.7, 0.5, 0.6],
	[0.6, 0.7, 0.5],
	[0.1, 0.6, 0.5],
	[0.8, 1.0, 0.8],
	[0.6, 0.9, 1.0],
	[0.0, 0.8, 1.0],
	[0.7, 0.8, 1.0],
	[0.5, 0.3, 1.0],
	[0.3, 0.9, 0.9],
	[0.0, 0.3, 0.4],
	[0.3, 0.4, 0.0],
	[1.0, 1.0, 0.5]
];

~graphPatterns = (0..34);

~activePatterns = [8];
~graphics.setPattern(8, 1, 1.0, 1, 1, 0.6, 0.7, 0.9);

~matrix.onsetFunc = {|mfcc|
	var delta, curr, args;
	delta = SystemClock.seconds - ~lasttime;
	~lasttime = SystemClock.seconds;
	~beatrate.pop;
	~beatrate.insert(0, delta);
//	~collectMfcc.pop;
//	~collectMfcc.insert(0, mfcc);
	~meanamp = ~matrix.patterndefs.values.asArray.select({|patdef| 
		patdef.ctrls.select({|ctr| ctr.active == 1 }).size > 0
	}).collect({|patdef| patdef.ctrls.collect(_.amp) }).collect(_.values).collect(_.asArray).flat.mean;
	~meandur = ~matrix.patterndefs.values.asArray.select({|patdef| 
		patdef.ctrls.select({|ctr| ctr.active == 1 }).size > 0
	}).collect({|patdef| patdef.ctrls.collect(_.dur) }).collect(_.values).collect(_.asArray).flat.mean;
//	Post << "BPS: " << ~beatrate.mean.reciprocal << " | AMP: " << ~meanamp << " | DUR: " << ~meandur 
//		<< Char.nl;
//	Post << "MFCC: " << ~collectMfcc.flop.collect(_.mean).collect(_.round(0.01)) << Char.nl;
	
	if (~activePatterns.size > 3)
	{
		~activePatterns.size.rand.do({
			curr = ~activePatterns.choose;
			~activePatterns.remove(curr);
			args = [curr, 0, 1.0, 1, 1] ++ ~colors.choose;
			~graphics.setPattern(*args);
		})
	}
	{
		curr = ~graphPatterns.choose;
		~activePatterns = ~activePatterns.add(curr);
		args = [curr, 1, 1.0] ++ [0, 1].choose.dup ++ ~colors.choose;
		~graphics.setPattern(*args);
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
		~graphics.stopRotation;
		~graphics.setViewpoint(
			rrand(30.0, 60.0)*[1.0,-1.0].choose,
			rrand(30.0, 60.0)*[1.0,-1.0].choose,
			rrand(30.0, 60.0)*[1.0,-1.0].choose,
			0.0, 0.0, 0.0
		);
		~graphics.unmapCodePanel;
	}{
		if (0.5.coin) {
			~rot = Rotation(rrand(-60.0, 60.0), rrand(0.005, 0.05), rrand(-20.0, 20.0),
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
}
)