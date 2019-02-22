~graphics = CinderApp(800, 800, mode: 0)

~graphics.initWorld(17, 17, 17, 20);

~graphics.initContinuous;

~graphics.setAdd(0.98);

~graphics.resetWorld(8, 8, 8, 4, 4, 4)


~graphics = CinderApp(ciAddr: NetAddr("192.168.1.100", 7000));

~graphics = CinderApp(ciAddr: NetAddr("169.254.184.218", 7000));

~graphics = CinderApp(1024, 768, mode: 1)

~graphics = CinderApp(800, 800, mode: 0, path:"/Users/alo/dev/lambda/xcode/DerivedData/lambdaApp/Build/Products/Release/lambda.app")

~graphics.setFrameRate(23.0)

~graphics.patternLib.select({|pat| pat.active == 1 })
send



[ ( 'r': 1, 'colormap': 1, 'alphamap': 1, 'index': 1,
  'alpha': 1, 'g': 0.1, 'active': 1, 'b': 0.4 ), ( 'r': 0.1, 'colormap': 1, 'alphamap': 1, 'index': 9,
  'alpha': 1, 'g': 0.6, 'active': 1, 'b': 1 ), ( 'r': 0.2, 'colormap': 1, 'alphamap': 1, 'index': 18,
  'alpha': 1, 'g': 0.8, 'active': 1, 'b': 1 ), ( 'r': 0, 'colormap': 1, 'alphamap': 1, 'index': 29,
  'alpha': 0.2, 'g': 1, 'active': 1, 'b': 0.8 ) ]

1000*6/9

~graphics.open

~graphics.quit

24**3

40*40*10

~graphics.open

~graphics.initWorld(43, 43, 43, 20);

~graphics.initWorld(13, 13, 13, 20);

~graphics.initWorld(17, 17, 17, 20);

43**3

~graphics.initGenerations([ 4, 6, 9, 18, 24 ], [ 1, 4, 6, 8, 17, 23, 24, 26 ], 11);

~graphics.initGenerations([4, 6], [4], 13);


~graphics.setSymmetry(11)


~graphics.setViewpoint(9.0, -8.0, 8.5, 0.0, 0.0, 0.0)

~graphics.setViewpoint(0.0, 0.0, 0.0, 0.0, 0.0, -100.0)

~graphics.setViewpoint(0.0, 100.0, 0.0, 0.0, 0.0, 0.0)


~graphics.setViewpoint(0.0, 0.0, -90.0, 0.0, -5.0, 0.0)

~graphics.setViewpoint(0.0, -105.0, 0.0, 0.0, 0.0, -5.0)

~graphics.setViewpoint(-95.0, 0.0, 0.0, 0.0, -5.0, -2.0)


~graphics.setViewpoint(0.0, 0.0, 240.0, 0.0, 0.0, 0.0)

~graphics.setViewpoint(0.0, 41.0, 0.0, 0.0, 0.0, 0.0)

~graphics.setViewpoint(95.0, 0.0, 0.0, 0.0, 0.0, 0.0)


~graphics.setViewpoint(80.0, 80.0, 80.0, 0.0, 0.0, 0.0)

~graphics.setInterpolation(0, 7)

~graphics.setBackground(0.0, 0.0, 0.0)
~graphics.setBackground(0.0, 0.0, 0.0)

(
~startMessaging = {
	Tdef(\sendVector, {
		loop({
			~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
			rrand(0.3, 1.0).wait;
		});
	});

	Tdef(\sendVector).play
}
)

Tdef(\sendVector).clear

([2560, 1600] * 0.4).collect(_.asInt).collect(_.nextPrime)


(
~graphics = CinderApp(800, 600, mode: 1, path:"/Users/alo/dev/lambda/xcode/DerivedData/lambdaApp/Build/Products/Release/lambda.app");
~size = 7;
~startMessaging = {
	Tdef(\sendVector, {
		loop({
			~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
			rrand(0.3, 1.0).round(0.214).wait;
		});
	});

	Tdef(\sendVector).play
};
Tdef('run', {
	~graphics.open;
	3.wait;
	~graphics.initWorld(~size, ~size, ~size, 20);
	0.5.wait;
	~graphics.initGenerations( [ 4, 5, 6, 7, 26 ], [ 3, 6, 7, 11, 12, 13, 18, 23, 24, 25 ], 16 );
	0.5.wait;
	~graphics.setSymmetry(11);
	~graphics.setViewpoint(0.0, 0.0, -10.0, 0.0, 0.0, 0.0);
	~startMessaging.();
	Post << "Initialised.." << Char.nl;
}).play
)

[1334, 750] * 0.8


43**3

~graphics.setPattern(0, 1, 1.0, 0, 0, 0.3, 0.6, 1.0);

~graphics.setPattern(1, 0, 1.0, 1, 1, 1.0, 0.1, 0.4);

~graphics.setPattern(2, 0, 1.0, 0, 0, 0.9, 0.2, 0.9);

~graphics.setPattern(3, 0, 0.7, 1, 1, 0.38, 0.0, 0.3);

~graphics.setPattern(4, 0, 0.3, 0, 0, 1.0, 1.0, 0.0);

~graphics.setPattern(5, 0, 1.0, 1, 0, 1.0, 0.1, 0.4);

~graphics.setPattern(6, 1, 1.0, 1, 1, 0.7, 0.0, 0.5);

~graphics.setPattern(7, 0, 1.0, 0, 0, 0.9, 0.1, 0.5);

~graphics.setPattern(8, 0, 1.0, 1, 1, 1.0, 0.1, 0.4);

~graphics.setPattern(9, 0, 1.0, 0, 0, 0.1, 0.6, 1.0);


~graphics.setPattern(10, 1, 1.0, 1, 1, 0.0, 0.9, 0.6);

~graphics.setPattern(11, 0, 0.1, 1, 1, 0.1, 0.8, 1.0);

~graphics.setPattern(12, 1, 1.0, 1, 1, 0.2, 0.4, 0.6);

~graphics.setPattern(13, 0, 1.0, 0, 0, 0.2, 0.8, 1.0);

~graphics.setPattern(14, 0, 1.0, 0, 0, 0.0, 0.7, 1.0);

~graphics.setPattern(15, 0, 0.1, 0, 0, 1.0, 0.0, 0.7);

~graphics.setPattern(16, 0, 1.0, 0, 0, 1.0, 1.0, 1.0);

~graphics.setPattern(17, 1, 0.7, 0, 0, 0.4, 0.8, 1.0);

~graphics.setPattern(18, 1, 1.0, 1, 1, 0.2, 0.8, 1.0);

~graphics.setPattern(19, 0, 1.0, 1, 1, 0.1, 1.0, 0.4);

~graphics.setPattern(20, 0, 1.0, 0, 0, 1.0, 0.0, 0.5);

~graphics.setPattern(21, 0, 1.0, 0, 0, 1.0, 1.0, 0.0);

~graphics.setPattern(22, 1, 1.0, 1, 1, 0.4, 0.8, 1.0);

~graphics.setPattern(23, 0, 1.0, 1, 1, 1.0, 0.0, 1.0);

~graphics.setPattern(24, 0, 1.0, 1, 1, 0.5, 0.6, 0.7);

~graphics.setPattern(25, 0, 1.0, 1, 1, 0.8, 0.8, 0.8);

~graphics.setPattern(26, 0, 0.3, 0, 0, 0.3, 0.5, 0.5);

~graphics.setPattern(27, 0, 0.3, 0, 0, 0.4, 0.7, 0.1);

~graphics.setPattern(28, 0, 1.0, 1, 1, 1.0, 1.0, 1.0);

~graphics.setPattern(29, 0, 0.2, 1, 1, 0.0, 1.0, 0.8);

~graphics.setPattern(30, 0, 1.0, 1, 1, 0.3, 0.3, 0.3);

~graphics.setPattern(31, 0, 0.1, 1, 1, 1.0, 0.0, 1.0);

~graphics.setPattern(32, 0, 0.05, 1, 1, 0.0, 0.04, 0.04);

~graphics.setPattern(33, 0, 0.5, 1, 1, 0.4, 0.0, 0.2);

~graphics.setPattern(34, 0, 0.2, 1, 1, 0.2, 0.4, 1.0);

~graphics.setPattern(35, 0, 0.6, 1, 1, 0.0, 0.6, 1.0);

~graphics.setPattern(36, 0, 1.0, 0, 0, 1.0, 1.0, 1.0);

~graphics.setPattern(37, 0, 0.1, 1, 1, 0.1, 0.1, 0.1);

~graphics.setPattern(38, 1, 0.1, 0, 0, 1.0, 1.0, 1.0);

~graphics.setPattern(39, 0, 1.0, 0, 0, 1.0, 1.0, 1.0);



Tdef(\sendVector, {
	loop({
		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		[ 0.1, 0.05 ].choose.wait;
	});
});

Tdef(\sendVector).play

Tdef(\sendVector).stop




~pava = Pseq([16], inf).asStream;
~pact = [];

Ndef('graphics', {
	loop({
		var fadeIn, fadeOut;
		fadeIn = ~pava.next;
		~pact = ~pact.add
	})
}).play


~graphics.setPattern(35, 0, 1.0, 0, 0, 0.5, 1.0, 1.0);

24.do({|i| (i%4).postln })

~rot = Rotation(140.0, 0.0, 140.0, 0.0, 0.0, 0.0, 0.0, 0.1);

~rot = Rotation(90.0, 0.015, 90.0, 50.0, 0.01, 0.002, 0.01, 0.01);

~rot = Rotation(120.0, 0.3, 120.0, 100.0, 0.1, 0.3, 0.1, 0.1);

~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera

~graphics.stopRotation


~rot = Rotation(120.0, 0.0, 170.0, 0.0, 0.0, 0.0, 0.0, 0.014);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera
~graphics.stopRotation

~graphics.setViewpoint(0.0, 0.0, 0.0, 0.0, 0.0, 0.0)

Generations

			\flamingstarbow, \chenille, \belzhab, \glissergy,
			\cooties, \faders, \frozenspirals, \glisserati,
			\nova, \orthogo, \rainzha, \rake, \sedimental,
			\snake, \starwars, \sticks, \thrillgrill,
			\transers, \wanderers, \worms, \xtasy


Tdef('rule', {
	loop({
		var rule = [\flamingstarbow, \chenille, \belzhab, \glissergy,
			\faders, \frozenspirals, \glisserati,
			\nova, \orthogo, \rainzha, \rake, \sedimental,
			\snake, \starwars, \sticks, \thrillgrill,
			\transers, \wanderers, \worms, \xtasy].choose;
		~graphics.sendPredefined3DRule(rule);
		0.2.wait
	})
}).play

Tdef('rule').clear

~graphics.sendPredefined3DRule(\nova)

~graphics.sendPredefined3DRule(\frozenspirals)

~graphics.sendPredefinedGenRule(\xtasy)

~graphics.sendPredefined3DRule(\belzhab)

~graphics.sendPredefined3DRule(\glisserati)


~graphics.sendPredefined3DRule(\transers)



~graphics.sendGenRule([16],[12],12);

(
~range = (3..26).scramble;
~arr1 = (8.rand + 1).collect({ ~range.pop }).sort;
~range = (3..26).scramble;
~arr2 = (8.rand + 1).collect({ ~range.pop }).sort;
~states = rrand(7, 24);
[~arr1, ~arr2, ~states].postln;
~graphics.sendGenRule(~arr1, ~arr2, ~states);
)


[ [ 4, 5, 6, 7, 26 ], [ 3, 6, 7, 11, 12, 13, 18, 23, 24, 25 ], 16 ]
[ [ 4, 7, 14 ], [ 8, 10, 12, 14, 15, 17, 18, 22, 26 ], 16 ]
[ [ 4, 6, 9, 18, 24 ], [ 1, 4, 6, 8, 17, 23, 24, 26 ], 11 ]
[ [ 4, 8, 11, 16, 19, 23, 26 ], [ 2, 3, 5, 13, 18, 20, 24 ], 15 ]
[ [ 4, 25 ], [ 10, 26 ], 19 ]
[ [ 4, 8, 9, 10, 12, 13, 26 ], [ 6, 8, 15, 16, 20 ], 18 ]
[ [ 4, 8, 14, 17, 21, 22, 24 ], [ 8, 9, 15, 18, 20 ], 14 ]
[ [ 4, 10, 11, 13, 14, 15, 18 ], [ 3, 7, 13 ], 22 ]
[ [ 4, 6, 18, 20, 21, 24, 25, 26 ], [ 6, 10, 13, 15, 16, 18, 23, 26 ], 13 ]
[ [ 4, 13, 16, 18, 19, 23 ], [ 6, 9, 14, 19, 20, 21 ], 19 ]
[ [ 4, 6, 13, 14, 18, 24 ], [ 5, 6, 8, 15, 17 ], 9 ]
[ [ 4, 5, 12, 15, 16, 21, 26 ], [ 10, 20, 26 ], 17 ]
[ [ 4, 14, 18, 23, 25 ], [ 4, 6, 13 ], 13 ]
[ [ 4, 10, 17, 21, 24, 25 ], [ 12, 19, 20, 26 ], 10 ]
[ [ 4, 7, 17 ], [ 5, 8 ], 16 ]
[ [ 4, 6, 13, 26 ], [ 18 ], 8 ]
[ [ 4, 6, 9, 13, 20, 23, 24, 25 ], [ 8, 14, 18 ], 23 ]
[ [ 4, 22, 23, 24 ], [ 4, 6, 11, 17, 24, 26 ], 7 ]
[ [ 4, 8 ], [ 3, 13, 14 ], 23 ]
[ [ 4, 11 ], [ 3, 5, 10, 12, 13, 22, 23, 26 ], 15 ]
[ [ 4, 10, 14, 15,f 21, 23 ], [ 6, 13, 25, 26 ], 23 ]
[ [ 4, 12, 20 ], [ 8, 10, 20 ], 24 ]
[ [ 4, 6, 7, 10, 14, 19, 22 ], [ 3, 13, 15, 17, 18, 25, 26 ], 19 ],
[ [ 4, 22, 24 ], [ 14, 24 ], 24 ]
[ [ 4, 5 ], [ 13, 17, 20, 26 ], 13 ]
[ [ 4, 9, 11, 13, 14, 19, 25 ], [ 23, 26 ], 19 ]
[ [ 4, 10, 14 ], [ 7, 12, 17, 18, 25 ], 19 ]
[ [ 4, 6, 8, 10, 19 ], [ 14, 21 ], 14 ]
[ [ 4, 14, 16 ], [ 3, 6, 7, 8, 11, 16, 20, 22 ], 22 ]
[ [ 4, 6, 11, 14, 16, 25 ], [ 4, 10, 14, 19, 25, 26 ], 7 ]
[ [ 4, 5, 8, 10, 12, 17, 19, 20 ], [ 6 ], 24 ]
[ [ 4, 8, 10, 13, 19, 20, 24 ], [ 6, 8, 11, 12, 13, 15, 17, 20 ], 19 ]
[ [ 4, 13, 14, 17, 18, 19, 25 ], [ 4, 5, 8, 10, 18, 23, 25, 26 ], 23 ]



(
~graphics.sendGenRule(*
[ [ 4, 5, 6, 7, 26 ], [ 3, 6, 7, 11, 12, 13, 18, 23, 24, 25 ], 16 ]
);
)

37**3

~arr1.sort

~graphics.sendGenRule([ 4, 5, 6, 7, 26 ], [ 3, 6, 7, 11, 12, 13, 18, 23, 24, 25 ], 16);

3/8*26

[[2],[2,3],8]

[2,4,7,8],[4,5,6,7,8],25

\lambda0 -> [[3,5,7,9],[4,6,8],8],
\lambda1 -> [[3,5,7,9],[4,6,8],16],
\lambda2 -> [[3,4,5],[3,4,5],17],
\lambda3 -> [[0,1,2,3,4,5],[4,5],15],
\lambda4 -> [[2,3],[4,6],9],


~graphics.sendGenRule([0, 3],[6,14],2);
~graphics.sendGenRule([0,4,5,6,7,8],[2,4,7,8],17);


~graphics.sendPredefined3DRule(\nova)

~graphics.sendPredefined3DRule(\belzhab)

~graphics.sendPredefined3DRule(\belzhabsedi)

~graphics.sendPredefined3DRule(\bombers)

~graphics.sendPredefined3DRule(\brain6)

~graphics.sendPredefined3DRule(\faders)


Generations


~graphics.quit




~graphics = CinderApp(1024, 768, mode: 1);

~graphics = CinderApp(1600, 1050, mode: 1);

~graphics.open

~graphics = CinderApp(1024, 768, path: "~/Development/lambda/xcode/build/Debug/lambda.app");

~graphics.makeArgumentString

~graphics.quit

~graphics.open

~graphics.initWorld(20, 20, 20, 20);

~graphics.initContinuous;

~graphics.setAdd(0.98);

~graphics.resetWorld(9, 9, 9, 4, 4, 4)

~graphics.setPattern(0, 0, 1.0, 1, 1, 0.6, 0.8, 1.0);

~graphics.setPattern(1, 1, 0.5, 1, 1, 0.9, 0.1, 0.4);

~graphics.setPattern(2, 1, 1.0, 1, 1, 0.5, 0.75, 0.9);

~graphics.setPattern(3, 0, 1.0, 1, 0, 0.6, 0.8, 0.8);

~graphics.setPattern(4, 0, 1.0, 1, 1, 1.0, 1.0, 0.3);

~graphics.setPattern(5, 1, 1.0, 1, 0, 0.7, 0.9, 1.0);

~graphics.setPattern(6, 1, 1.0, 1, 1, 1.0, 1.0, 0.3);

~graphics.setPattern(7, 0, 1.0, 1, 1, 1.0, 1.0, 0.3);



~graphics.setPattern(32, 0, 1.0, 1, 1, 1.0, 1.0, 0.5);

~graphics.setPattern(33, 0, 1.0, 1, 1, 0.6, 0.8, 0.8);

~graphics.setPattern(34, 1, 1.0, 0, 0, 1.0, 1.0, 0.3);

~graphics.setPattern(35, 1, 0.1, 0, 0, 0.9, 0.1, 0.4);



(
// keyDownAction to send evaluated code to the window
Document.current.keyDownAction = {|doc, char, mod, uni, key|
	var sendarray;
	Post << uni << " " << key << Char.nl;
	if ((uni == 13) and: { key == 37 })
	{
		Post << "Sending: " << doc.selectedString << Char.nl;
		sendarray = doc.selectedString.split(Char.nl);
		sendarray[0] = "alo@ " ++ sendarray[0];
		sendarray.do({|str|
			~graphics.sendCodeLine(str)
		})
	}
}
)

~file = File("/Users/alo/dev/lambda/supercollider/sparsematrix/sets/_lg_r_v__A___U_E.scd", "r")

~code = ~file.readAllString

~file.close

~graphics.sendCodeTitle("roosa poni")

~graphics.showCodePanel

~graphics.hideCodePanel

~graphics.mapCodePanel

~graphics.unmapCodePanel


Tdef('sendcode', {
	loop({
		var str;
		str = "";
		if (1.0.coin) {
			rrand(4, 16).do({
				6.do({ str = str ++ [rrand(48, 56),  rrand(65, 70)].choose.asAscii });
				str = str ++ " ";
			});
		}
		{
			str = "-     "
		};
		~graphics.sendCodeLine(str);
		rrand(0.3, 0.6).wait
	})
}).play

Tdef('sendcode').clear





10.do({
	~txt.drop(rrand(0, 3000)).keep(60).postln
})

~graphics.sendCodeLine("buffering buffering bits and bites and megabytes")

48.asAscii
90.asAscii

~sendarr = ~code.split(Char.nl)
Tdef('code', {
	~sendarr.do({|line|
		~graphics.sendCodeLine(["poni$ ", "roosa$ "].choose ++ line);
		rrand(0.5, 2.0).wait;
	})
}).play

Document.current.keyDownAction = {}



(
Routine({

	var streams = Array.fill(8, { Pbrown(0.0, 1.0, 0.1).asStream });

	100.do({
		~graphics.sendSOMVector( streams.collect(_.next) );
		0.1.wait;
	});
	"finished".postln
}).play;
)

~graphics.sendSOMVector(Array.rand(8, 0.0, 1.0));

~graphics.setPattern(6, 0, 1.0, 0, 0, 0.1, 0.8, 1.0);

~graphics.setPattern(8, 0, 1.0, 0, 0, 1.0, 1.0, 1.0);


~graphics.setInterpolation(1, 4)

~graphics.rotate(1.0, 0.0, 0.0, 0.0)

~graphics.rotate(1.0.rand, 1.0.rand, 1.0.rand, rrand(0.005, 0.02))


~graphics.setViewpoint(50.0, 50.0, 50.0, 0.0, 0.0, 0.0)

~graphics.setBackground(0.1, 0.15, 0.15)
~graphics.setBackground(0.0, 0.0, 0.0)


(
var size = 24;
~enc = {|arr, max|
	arr[0]*max+arr[1]*max+arr[2]
};
~arr = Array.fill(size, {|x| Array.fill(size, {|y| [x, y, size/2-1] }) });
~arr.postln;
~arr = ~arr.flatten(1).collect({|arr|
	~enc.(arr, size).asInteger
})
)

~arr.flatten(1).size.do(_.postln)

Fx3D

~graphics.queryStates(~arr, {|msg| msg.postln });

~graphics.stopQuery

~graphics.quit


Array.geom(30, 1.0, 0.96)

1.0 - Array.series(30, 0, 0.02)


~graphics.patternLib.select({|ev| ev.active == 1}).collect(_.index)

~graphics = CinderApp();
(
Routine({

	100.do({
		~graphics.sendSOMVector( Array.rand(8, 0.0, 1.0) );
		0.1.wait;
	});
	"finished".postln
}).play;
)

(
[
	[5, 0, 0.2, 0, 0, 0.9, 0.1, 0.4],
	[6, 0, 0.5, 1, 1, 0.5, 0.9, 0.8],
	[7, 0, 1.0, 0, 0, 1.0, 1.0, 1.0],
	[8, 0, 0.2, 1, 1, 0.6, 0.7, 0.9],
	[9, 0, 0.5, 1, 1, 0.3, 0.7, 0.9],
	[10, 0, 1.0, 0, 0, 0.5, 0.8, 1.0],
	[11, 0, 1.0, 1, 1, 0.0, 0.3, 0.5],
	[12, 0, 0.3, 0, 0, 0.44, 0.32, 0.66],
	[13, 0, 0.7, 0, 0, 0.6, 0.8, 1.0],
	[14, 0, 1.0, 1, 1, 0.0, 0.5, 0.5],
	[15, 0, 1.0,0, 0, 0.0, 0.5, 0.7]
].do({|arglist|
	~graphics.setPattern(*arglist)
})
)

(
Tdef(\autopilot, {
	var active, max=15, min=5;
	active = 6;
	~graphics.fadeInPattern(6, 10, 1.0);
	10.wait;
	loop({
		var newPattern, time, fade;
		fade = rrand(5, 10);
		time = rrand(20, 35);
		newPattern = rrand(min, max);
		~graphics.xfadePatterns(newPattern, 1.0, active, fade);
		(fade + time).wait;
		active = newPattern;
		if (0.3.coin) {
			~graphics.sendPredefined3DRule(
				[\nova, \briansbrain, \brain6, \cooties, \faders].choose;
			);
		}
	})
}).play
)

~graphics.setViewpoint(0.0, 0.0, 60.0, 0.0, 0.0, 0.0)

~graphics.setInterpolation(1, 2)

~graphics.sendGenRule([4],[4],25)

~graphics.sendGenRule([3], [3,4,5], 12)

~graphics.assignCodeWindow(Document.current);

~graphics.showCodePanel

~graphics.hideCodePanel

~graphics.unmapCodePanel

~graphics.sendCodeTitle("klingt.gut")

~graphics.sendPredefinedGenRule(\cooties)

~graphics.sendPredefined3DRule(\brain6)

~graphics.setBackground(0.0, 0.0, 0.0)



~graphics.stopRotation


~rot = Rotation(140.0, 0.03, 100.0, 20.0, 0.0, 0.034, 0.0, 0.038);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera


~matrix.assignCodeWindow(Document.current);


~graphics.setFrameRate(32.0)

~graphics = CinderApp();

~graphics.open

~graphics.hideCodePanel

~graphics.initWorld(20, 20, 20, 20);

~graphics.initContinuous;

~graphics.setAdd(0.93);

~graphics.resetWorld(9, 9, 9, 4, 4, 4)

~graphics.setViewpoint(0.0, 0.0, 80.0, 0.0, 0.0, 0.0)

~graphics.setBackground(0.4, 0.4, 0.4)


~graphics.setPattern(1, 1, 1.0, 0, 0, 0.1, 0.1, 0.1);


~graphics.setPattern(19, 1, 1.0, 0, 0, 0.1, 0.1, 0.1);

~graphics.setPattern(20, 0, 1.0, 0, 0, 0.1, 0.1, 0.2);

~graphics.setPattern(21, 0, 1.0, 1, 1, 0.6, 0.7, 0.9);

~graphics.setPattern(22, 0, 1.0, 0, 0, 0.6, 0.7, 0.9);

~graphics.setPattern(23, 0, 1.0, 1, 1, 0.0, 0.1, 0.1);

~graphics.setPattern(24, 1, 1.0, 0, 0, 0.2, 0.1, 0.1);

~graphics.setPattern(25, 0, 1.0, 1, 1, 0.9, 0.1, 0.4);

~graphics.unmapCodePanel

~graphics.mapCodePanel

~graphics.showCodePanel

~graphics.sendPredefined3DRule(\faders)

~rot = Rotation(50.0, 0.3, -60.0, 60.0, 0.0, 0.35, 0.0, 0.045);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera

~graphics.stopRotation


(
Routine({

	100.do({
		~graphics.sendSOMVector( Array.rand(8, 0.0, 1.0) );
		0.1.wait;
	});
	"finished".postln
}).play;
)

~graphics.setFrameRate(12.0);


~graphics.activateSwarm(100, 200.0, 200.0, 200.0, 0.8, 50.0, 8.0, 15.0, 100.0);

(
Routine({

	100.do({
		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		0.1.wait;
	});
	"finished".postln
}).play;
)

~graphics.sendBoidPattern(0, 1, 0);

~graphics.sendBoidPattern(1, 1, 4);

~graphics.sendBoidPattern(2, 0, 1);

~graphics.sendBoidPattern(4, 0, 0);

~graphics.sendBoidPattern(3, 1, 0);

~graphics.sendBoidPattern(5, 1, 3);


~rot = Rotation(0.3, 0.133, -50.0, -100.0, 2pi.rand, 0.05, 2pi.rand, 0.033);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera;

~graphics.stopRotation;


~graphics.setViewpoint(265.0,265.0,225.0, 0.0, 0.0, 0.0)

~graphics.setSwarm(0.9, 50.0, 8.0, 25.0, 100.0)

~graphics.killSwarm

~graphics.setBoidCam(true, true)

~graphics.mapCodePanel

~graphics.unmapCodePanel

~graphics.setCodePanelFade(200)

~graphics.showCodePanel

(
// keyDownAction to send evaluated code to the window
Document.current.keyDownAction = {|doc, char, mod, uni, key|
	var sendarray;
	[uni, key].postln;
	if ((uni == 13) and: { key == 36 })
	{
		Post << "Sending: " << doc.selectedString << Char.nl;
		sendarray = doc.selectedString.split(Char.nl);
		sendarray[0] = "alo@ " ++ sendarray[0];
		sendarray.do({|str|
			~graphics.sendCodeLine(str)
		})
	}
}

)

Document.current.keyDownAction ={}

~rot = Rotation(40.0, 0.1, 20.0, 100.0, 0.0, 0.055, 0.0, 0.06);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera



~matrix.defsAt('b01').setControls(
	{ [0, 1].wchoose([0.5, 0.5]) },
	{ rrand(0.1, 0.5) },
	{ rrand(0.05, 0.2) }
);




Generations

(
Tdef('ciAuto', {|mfcc|
	loop({
		var delta, curr, args;
		delta = SystemClock.seconds - ~lasttime;
		~lasttime = SystemClock.seconds;
		~beatrate.pop;
		~beatrate.insert(0, delta);
	//	~collectMfcc.pop;
	//	~collectMfcc.insert(0, mfcc);
//		~meanamp = ~matrix.patterndefs.values.asArray.select({|patdef|
//			patdef.ctrls.select({|ctr| ctr.active == 1 }).size > 0
//		}).collect({|patdef| patdef.ctrls.collect(_.amp) }).collect(_.values).collect(_.asArray).flat.mean;
//		~meandur = ~matrix.patterndefs.values.asArray.select({|patdef|
//			patdef.ctrls.select({|ctr| ctr.active == 1 }).size > 0
//		}).collect({|patdef| patdef.ctrls.collect(_.dur) }).collect(_.values).collect(_.asArray).flat.mean;
	//	Post << "BPS: " << ~beatrate.mean.reciprocal << " | AMP: " << ~meanamp << " | DUR: " << ~meandur
	//		<< Char.nl;
	//	Post << "MFCC: " << ~collectMfcc.flop.collect(_.mean).collect(_.round(0.01)) << Char.nl;

		if (~changeWeight.coin)
		{

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
})


)

Tdef('ciAuto').clear


QueryStates.uniform3D(7, 3)

~graphics.queryAliveStates({|ms|
	~msg = ms;
	~msg.size.postln
})

~msg.

~graphics.stopQuery

~graphics.queryFunc