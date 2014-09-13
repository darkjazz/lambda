~graphics = CinderApp(1024, 768, mode: 0);


~graphics = CinderApp(1024, 768, path: "~/Development/lambda/xcode/build/Debug/lambda.app");

~graphics.makeArgumentString

~graphics.quit

~graphics.open

~graphics.initWorld(20, 20, 20, 20);

~graphics.initContinuous;

~graphics.setAdd(0.04);

~graphics.resetWorld(9, 9, 9, 4, 4, 4)

~graphics.setPattern(0, 0, 1.0, 1, 1, 0.6, 0.8, 1.0);

~graphics.setPattern(1, 1, 0.5, 1, 1, 0.9, 0.1, 0.4);

~graphics.setPattern(2, 0, 1.0, 1, 1, 0.5, 0.75, 0.9);

~graphics.setPattern(3, 0, 1.0, 1, 0, 0.6, 0.8, 0.8);

~graphics.setPattern(4, 0, 1.0, 1, 1, 1.0, 1.0, 0.3);

~graphics.setPattern(5, 0, 1.0, 1, 0, 0.7, 0.9, 1.0);

~graphics.setPattern(6, 1, 1.0, 1, 1, 1.0, 1.0, 0.3);

~graphics.setPattern(7, 1, 1.0, 1, 1, 1.0, 1.0, 0.3);



~graphics.setPattern(32, 0, 1.0, 1, 1, 1.0, 1.0, 0.5);

~graphics.setPattern(33, 0, 1.0, 1, 1, 0.6, 0.8, 0.8);

~graphics.setPattern(34, 1, 1.0, 0, 0, 1.0, 1.0, 0.3);

~graphics.setPattern(35, 1, 1.0, 1, 1, 0.9, 0.1, 0.4);



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
~graphics.setBackground(0.0, 0.0, 0.05)


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


~graphics = CinderApp(1024, 768);

~graphics = CinderApp(1024, 768)

~graphics.open



24**3

40*40*10

~graphics.initWorld(20, 20, 20, 20);

~graphics.initGenerations([4,6,8], [3,5,7,9], 12);

~graphics.initGenerations([4,6], [3,5], 12);

~graphics.setSymmetry(11)

~graphics.setViewpoint(90.0, -80.0, 85.0, 0.0, 0.0, 0.0)

~graphics.setViewpoint(0.0, -15.0, -180.0, 0.0, -15.0, 0.0)

~graphics.setInterpolation(1, 2)

~graphics.setPattern(5, 0, 1.0, 1, 1, 0.5, 1.0, 1.0);

~graphics.setPattern(6, 1, 1.0, 0, 0, 0.5, 0.9, 0.8);

~graphics.setPattern(7, 0, 1.0, 1, 1, 1.0, 0.3, 0.5);

~graphics.setPattern(8, 0, 1.0, 1, 1, 0.6, 0.7, 0.9);

~graphics.setPattern(9, 0, 1.0, 1, 1, 0.5, 0.8, 0.9);

~graphics.setPattern(10, 0, 1.0, 1, 1, 0.5, 0.8, 1.0);

~graphics.setPattern(11, 0, 1.0, 0, 1, 0.0, 0.3, 0.5);

~graphics.setPattern(12, 0, 1.0, 1, 1, 0.6, 0.8, 1.0);

~graphics.setPattern(13, 0, 1.0, 1, 1, 0.0, 0.6, 1.0);

~graphics.setPattern(14, 0, 1.0, 1, 0, 0.0, 0.5, 0.5);

~graphics.setPattern(15, 0, 0.4, 0, 0, 0.1, 0.7, 0.3);

~graphics.setPattern(26, 1, 0.3, 1, 1, 0.5, 0.6, 0.7);

~graphics.setPattern(27, 0, 1.0, 1, 1, 0.1, 0.6, 0.5);

~graphics.setPattern(28, 0, 1.0, 1, 1, 0.8, 1.0, 0.8);

~graphics.setPattern(29, 0, 1.0, 0, 0, 0.6, 0.9, 1.0);

~graphics.setPattern(30, 0, 1.0, 0, 0, 0.7, 0.8, 1.0);

~graphics.setPattern(31, 0, 1.0, 0, 0, 0.5, 0.3, 1.0);

~graphics.setPattern(32, 0, 1.0, 0, 0, 0.9, 0.9, 0.3);

~graphics.setPattern(33, 0, 0.5, 1, 1, 0.3, 0.6, 0.8);

~graphics.setPattern(34, 1, 1.0, 1, 1, 1.0, 0.2, 0.5);

~graphics.setPattern(35, 0, 1.0, 0, 0, 0.5, 1.0, 1.0);

24.do({|i| (i%4).postln })

~rot = Rotation(140.0, 0.007, 100.0, 60.0, 0.0, 0.0094, 0.0, 0.0088);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera

~graphics.stopRotation


~graphics.setViewpoint(100.0, 100.0, 100.0, 0.0, 0.0, 0.0)

~graphics.sendPredefined3DRule(\faders)

~graphics.sendPredefined3DRule(\cooties)

~graphics.sendPredefined3DRule(\nova)

~graphics.sendPredefined3DRule(\xtasy)

~graphics.sendPredefined3DRule(\flamingstarbow)

~graphics.sendGenRule([2],[3,4,5],6);


~graphics.sendPredefined3DRule(\briansbrain)


~graphics.sendPredefined3DRule(\belzhab)

~graphics.sendPredefined3DRule(\belzhabsedi)

~graphics.sendPredefined3DRule(\bombers)

~graphics.sendPredefined3DRule(\brain6)

~graphics.sendPredefined3DRule(\chenille)


Generations


Tdef(\sendVector, {
	loop({
		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		0.25.wait;
	});
});

Tdef(\sendVector).play

Tdef(\sendVector).stop

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


Tdef(\autopilot, {
	var active, max=15, min=5;
	active = 6;
	~graphics.fadeInPattern(6, 10, 1.0);
	30.wait;
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


~graphics.setViewpoint(0.0, 0.0, 60.0, 0.0, 0.0, 0.0)

~graphics.setInterpolation(1, 2)

~graphics.sendGenRule([4],[4],25)

~graphics.sendGenRule([3], [3,4,5], 12)

~graphics.assignCodeWindow(Document.current);

~graphics.showCodePanel

~graphics.mapCodePanel

~graphics.sendCodeTitle("sc.live.code.fest")

~graphics.sendPredefinedGenRule(\cooties)

~graphics.sendPredefined3DRule(\brain6)

~graphics.setBackground(0.0, 0.0, 0.0)

~rot = Rotation(140.0, 0.03, 100.0, 20.0, 0.0, 0.0034, 0.0, 0.0038);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera

~graphics.stopRotation

~matrix.assignCodeWindow(Document.current);


~graphics.setFrameRate(32.0)

~graphics = CinderApp();

~graphics.open

~graphics.hideCodePanel

~graphics.initWorld(20, 20, 20, 8);

~graphics.initContinuous;

~graphics.setAdd(0.2);

~graphics.resetWorld(9, 9, 9, 4, 4, 4)

~graphics.setViewpoint(0.0, 0.0, 80.0, 0.0, 0.0, 0.0)

~graphics.setPattern(18, 0, 1.0, 0, 0, 0.9, 0.9, 0.2);

~graphics.setPattern(19, 0, 1.0, 0, 0, 0.9, 0.9, 0.2);

~graphics.setPattern(20, 0, 1.0, 0, 0, 0.9, 0.9, 0.2);

~graphics.setPattern(21, 0, 1.0, 1, 1, 0.6, 0.7, 0.9);

~graphics.setPattern(22, 1, 1.0, 0, 0, 0.6, 0.7, 0.9);

~graphics.setPattern(23, 0, 1.0, 1, 1, 0.6, 0.7, 0.9);

~graphics.setPattern(24, 0, 1.0, 0, 0, 0.6, 0.7, 0.9);

~graphics.setPattern(25, 0, 1.0, 1, 1, 0.9, 0.1, 0.4);

~graphics.unmapCodePanel

~graphics.mapCodePanel

~graphics.sendPredefined3DRule(\faders)

~rot = Rotation(50.0, 0.03, -60.0, 60.0, 0.0, 0.035, 0.0, 0.045);
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

~graphics.setFrameRate(16.0);


~graphics.activateSwarm(16, 200.0, 200.0, 200.0, 0.8, 50.0, 8.0, 5.0, 100.0);

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

~graphics.sendBoidPattern(1, 0, 0);

~graphics.sendBoidPattern(3, 1, 0);

~graphics.sendBoidPattern(5, 1, 0);


~rot = Rotation(0.3, 0.133, -50.0, -100.0, 2pi.rand, 0.05, 2pi.rand, 0.033);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera;

~graphics.stopRotation;


~graphics.setViewpoint(25.0,25.0, 25.0, 0.0, 0.0, 0.0)

~graphics.setSwarm(0.9, 50.0, 8.0, 5.0, 100.0)

~graphics.killSwarm

~graphics.setBoidCam(false, true)

~graphics.mapCodePanel

~graphics.unmapCodePanel

~graphics.setCodePanelFade(200)

~graphics.showCodePanel

(
// keyDownAction to send evaluated code to the window
Document.current.keyDownAction = {|doc, char, mod, uni, key|
	var sendarray;
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







~rot = Rotation(40.0, 0.1, 20.0, 100.0, 0.0, 0.055, 0.0, 0.06);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera



~matrix.defsAt('b01').setControls(
	{ [0, 1].wchoose([0.5, 0.5]) },
	{ rrand(0.1, 0.5) },
	{ rrand(0.05, 0.2) }
);

Generations
