~graphics = CinderApp(1024, 768);

~graphics = CinderApp();

~graphics.open


13.fib


~graphics.initWorld(34, 21, 5, 20);

~graphics.initGenerations([4,6,8], [3,5,7,9], 12);

~graphics.initGenerations([4,6], [3,5], 12);

~graphics.setSymmetry(11)

~graphics.setViewpoint(0.0, 0.0, -100.0, 0.0, 0.0, 0.0)

~graphics.setViewpoint(0.0, 80.0, 90.0, 0.0, 0.0, 0.0)


~graphics.setInterpolation(1, 4)

~graphics.setPattern(5, 1, 1.0, 1, 1, 0.9, 1.0, 0.0);

~graphics.setPattern(6, 0, 1.0, 1, 1, 0.5, 0.9, 0.8);

~graphics.setPattern(7, 1, 1.0, 0, 0, 1.0, 0.3, 0.5);

~graphics.setPattern(8, 0, 1.0, 1, 1, 0.6, 0.7, 0.9);

~graphics.setPattern(9, 1, 1.0, 0, 0, 0.5, 0.3, 0.9);

~graphics.setPattern(10, 0, 1.0, 1, 1, 0.5, 0.8, 1.0);

~graphics.setPattern(11, 0, 1.0, 1, 1, 0.0, 0.3, 0.5);

~graphics.setPattern(12, 0, 0.1, 1, 1, 0.6, 0.8, 1.0);

~graphics.setPattern(13, 0, 1.0, 0, 0, 0.0, 0.6, 1.0);

~graphics.setPattern(14, 0, 1.0, 1, 1, 0.0, 0.5, 0.5);

~graphics.setPattern(15, 1, 1.0, 0, 0, 0.7, 0.7, 0.7);

~graphics.setPattern(26, 0, 1.0, 0, 0, 0.6, 0.9, 1.0);

~graphics.setPattern(27, 0, 1.0, 1, 1, 0.3, 0.8, 0.9);

~graphics.setPattern(28, 0, 1.0, 1, 1, 0.0, 1.0, 0.8);

~graphics.setPattern(29, 0, 1.0, 0, 0, 0.0, 0.8, 1.0);

~graphics.setPattern(30, 0, 1.0, 0, 0, 0.7, 0.8, 1.0);

~graphics.setPattern(31, 1, 1.0, 1, 1, 0.3, 0.3, 0.3);


~rot = Rotation(140.0, 0.004, 100.0, 60.0, 0.0, 0.0034, 0.0, 0.0038);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera

~graphics.stopRotation




~rot = Rotation(140.0, 2.0, 100.0, 60.0, 0.0, 1.78, 0.0, 2.1);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera

~graphics.stopRotation



~graphics.setViewpoint(50.0, 100.0, 0.0, 0.0, 0.0, 0.0)

~graphics.sendPredefined3DRule(\faders)

~graphics.sendPredefined3DRule(\cooties)

~graphics.sendPredefined3DRule(\nova)

~graphics.sendPredefined3DRule(\xtasy)

~graphics.sendPredefined3DRule(\flamingstarbow)

~graphics.sendGenRule([2],[3,4,5],6);


~graphics.sendPredefined3DRule(\briansbrain)


Tdef(\sendVector, {
	loop({
		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		0.25.wait;
	});
});

Tdef(\sendVector).play

Tdef(\sendVector).stop


