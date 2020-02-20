
(
~file = File("/Users/alo/dev/lambda/supercollider/sparsematrix/sets/codehack.scd", "r");
~code = ~file.readAllString;
~file.close;
~sendarr = ~code.split($%);
~sendCode = {
	Tdef('code', {
		loop({
			~sendarr.do({|code|
				var usr = ["poni$ ", "roosa$ "].choose;
				code.split(Char.nl).do({|line|
					if (line.size > 0) {
						~graphics.sendCodeLine(usr ++ line)
					}
				});
				rrand(4.0, 15.0).wait;
			})
		})
	}).play
};
~path = "/Users/alo/dev/lambda/xcode/DerivedData/lambdaApp/Build/Products/Release/lambda.app";
~wrldsz = 11;
~initMsg = {
	Tdef(\sendVector, {
		loop({
			~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
			[ 0.0625, 0.125, 0.25].choose.wait;
		});
	}).play;
};
Tdef('init', {
	~graphics = CinderApp(1000, 800, mode: 1, path: ~path);
	~graphics.open;
	3.wait;
	~graphics.initWorld(~wrldsz, ~wrldsz, ~wrldsz, 20);
	1.wait;
	~graphics.initGenerations([ 4, 10, 14, 15, 21, 23 ], [ 6, 13, 25, 26 ], 23);
	1.wait;
	~graphics.setSymmetry(11);
	~graphics.setViewpoint(0.0, 60.0, 0.0, 0.0, 0.0, 0.0);
	~initMsg.();
	1.wait;
	~activePatterns = Array();
	~graphics.activateSwarm(13, 200.0, 200.0, 200.0, 0.8, 50.0, 8.0, 15.0, 100.0);
	0.2.wait;
	~graphics.setPattern(38, 1, 1.0, 0, 0, 1.0, 1.0, 1.0);
	// ~graphics.fadeInPattern(38, 240, 1.0);
	~graphics.sendCodeTitle("roosa poni");
	Post << "Initialised..." << Char.nl;
}).play
)

~graphics.mapCodePanel

Tdef('ciAuto').clear

(

~patches.do({|arr, i|
	~graphics.setPattern(i, 0, 1.0, 0, 0, 1.0, 1.0, 1.0);
});
)

(
~ruleWeight = 0.1;
~changeWeight = 0.1;
~maxPatterns = 3;
~initWaitTime = 0;
~rotWeight = 0.1;
)

(
~lasttime = SystemClock.seconds;
~meanamp = 0;
~meandur = 0;
~rules = [
	[ [ 4, 5, 6, 7, 26 ], [ 3, 6, 7, 11, 12, 13, 18, 23, 24, 25 ], 16 ],
	[ [ 4, 7, 14 ], [ 8, 10, 12, 14, 15, 17, 18, 22, 26 ], 16 ],
	[ [ 4, 6, 9, 18, 24 ], [ 1, 4, 6, 8, 17, 23, 24, 26 ], 11 ],
	[ [ 4, 8, 11, 16, 19, 23, 26 ], [ 2, 3, 5, 13, 18, 20, 24 ], 15 ],
	[ [ 4, 25 ], [ 10, 26 ], 19 ],
	[ [ 4, 8, 9, 10, 12, 13, 26 ], [ 6, 8, 15, 16, 20 ], 18 ],
	[ [ 4, 8, 14, 17, 21, 22, 24 ], [ 8, 9, 15, 18, 20 ], 14 ],
	[ [ 4, 10, 11, 13, 14, 15, 18 ], [ 3, 7, 13 ], 22 ],
	[ [ 4, 6, 18, 20, 21, 24, 25, 26 ], [ 6, 10, 13, 15, 16, 18, 23, 26 ], 13 ],
	[ [ 4, 13, 16, 18, 19, 23 ], [ 6, 9, 14, 19, 20, 21 ], 19 ],
	[ [ 4, 6, 13, 14, 18, 24 ], [ 5, 6, 8, 15, 17 ], 9 ],
	[ [ 4, 5, 12, 15, 16, 21, 26 ], [ 10, 20, 26 ], 17 ],
	[ [ 4, 14, 18, 23, 25 ], [ 4, 6, 13 ], 13 ],
	[ [ 4, 10, 17, 21, 24, 25 ], [ 12, 19, 20, 26 ], 10 ],
	[ [ 4, 7, 17 ], [ 5, 8 ], 16 ],
	[ [ 4, 6, 13, 26 ], [ 18 ], 8 ],
	[ [ 4, 6, 9, 13, 20, 23, 24, 25 ], [ 8, 14, 18 ], 23 ],
	[ [ 4, 22, 23, 24 ], [ 4, 6, 11, 17, 24, 26 ], 7 ],
	[ [ 4, 8 ], [ 3, 13, 14 ], 23 ],
	[ [ 4, 11 ], [ 3, 5, 10, 12, 13, 22, 23, 26 ], 15 ],
	[ [ 4, 10, 14, 15, 21, 23 ], [ 6, 13, 25, 26 ], 23 ],
	[ [ 4, 12, 20 ], [ 8, 10, 20 ], 24 ],
	[ [ 4, 6, 7, 10, 14, 19, 22 ], [ 3, 13, 15, 17, 18, 25, 26 ], 19 ],
	[ [ 4, 22, 24 ], [ 14, 24 ], 24 ],
	[ [ 4, 5 ], [ 13, 17, 20, 26 ], 13 ],
	[ [ 4, 9, 11, 13, 14, 19, 25 ], [ 23, 26 ], 19 ],
	[ [ 4, 10, 14 ], [ 7, 12, 17, 18, 25 ], 19 ],
	[ [ 4, 6, 8, 10, 19 ], [ 14, 21 ], 14 ]
];
~getRule = {|index|
	var rule = ~rules[index];
	~maxState = rule.last;
	rule
};
~patches = [
	[1.0, 1, 1, 0.0, 0.6, 1.0], //0
	[1.0, 1, 1, 1.0, 0.1, 0.4],
	[1.0, 0, 0, 0.9, 0.2, 0.9],
	[1.0, 1, 1, 1.0, 0.1, 0.4],
	[0.3, 0, 0, 1.0, 1.0, 0.0],
	[1.0, 1, 1, 0.6, 1.0, 0.3], //5
	[1.0, 1, 1, 0.5, 0.9, 0.8],
	[1.0, 0, 0, 0.9, 0.1, 0.5],
	[1.0, 1, 1, 1.0, 0.1, 0.4],
	[1.0, 1, 1, 0.1, 0.6, 1.0],
	[0.5, 1, 1, 1.0, 1.0, 0.0], //10
	[1.0, 0, 1, 0.0, 1.0, 1.0],
	[1.0, 1, 1, 0.2, 0.4, 0.6],
	[1.0, 0, 1, 0.6, 1.0, 0.0],
	[1.0, 0, 0, 0.3, 0.7, 1.0],
	[1.0, 0, 0, 1.0, 1.0, 1.0], //15
	[1.0, 1, 1, 1.0, 1.0, 1.0],
	[1.0, 1, 1, 1.0, 0.0, 1.0],
	[1.0, 1, 1, 0.2, 0.8, 0.0],
	[1.0, 0, 1, 0.1, 1.0, 0.4],
	[1.0, 1, 0, 1.0, 0.0, 0.5], //20
	[1.0, 0, 0, 1.0, 1.0, 0.0],
	[1.0, 1, 1, 0.4, 0.8, 1.0],
	[1.0, 1, 1, 1.0, 0.0, 1.0],
	[1.0, 1, 1, 0.5, 0.6, 0.7],
	[0.3, 1, 1, 0.8, 0.8, 0.8], //25
	[0.4, 1, 1, 0.1, 0.2, 0.3],
	[0.3, 1, 1, 0.4, 0.5, 0.1],
	[1.0, 0, 0, 1.0, 1.0, 1.0],
	[0.5, 0, 0, 0.6, 0.9, 1.0],
	[1.0, 1, 1, 0.0, 1.0, 1.0], //30
	[0.4, 1, 1, 1.0, 0.0, 1.0],
	[1.0, 1, 1, 0.0, 0.04, 0.04],
	[0.5, 1, 1, 0.4, 0.0, 0.2],
	[0.4, 1, 1, 0.4, 0.4, 0.7],
	[1.0, 0, 1, 0.0, 0.0, 0.5], //35
	[1.0, 0, 0, 1.0, 1.0, 1.0],
	[1.0, 1, 1, 0.2, 0.2, 0.2],
	[1.0, 0, 0, 1.0, 1.0, 1.0],
	[1.0, 1, 1, 0.5, 1.0, 1.0]
];

~graphPatterns = [0, 1, 7, 8, 9, 12, 13, 17, 18, 20, 22, 31];

Tdef('ciAuto', {|mfcc|
	~initWaitTime.wait;
	~graphics.sendBoidPattern(3, 1, 0);
	loop({
		var delta, curr, args;
		delta = SystemClock.seconds - ~lasttime;
		~lasttime = SystemClock.seconds;
		if (~changeWeight.coin)
		{

			if (~activePatterns.size > ~maxPatterns)
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
			~graphics.sendGenRule(*~getRule.(~rules.size.rand));
		};

		if (~rotWeight.coin) {
			~graphics.stopRotation;
			~graphics.setViewpoint(
				rrand(30.0, 60.0)*[1.0,-1.0].choose,
				rrand(30.0, 60.0)*[1.0,-1.0].choose,
				rrand(30.0, 60.0)*[1.0,-1.0].choose,
				0.0, 0.0, 0.0
			);
			~graphics.unmapCodePanel;
		}{
			if (~rotWeight.coin) {
				~rot = Rotation(rrand(-100.0, 100.0), rrand(0.05, 0.1), rrand(-20.0, 20.0),
					rrand(-120.0, 120.0),
				rrand(-pi, pi), rrand(0.1, 0.8), rrand(-pi, pi), rrand(0.1, 0.7));
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