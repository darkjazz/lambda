~graphics = CinderApp(1024, 768)

~graphics = CinderApp(800, 600, mode: 0, path:"/Users/alo/dev/lambda/xcode/DerivedData/lambdaApp/Build/Products/Debug/lambda.app")


~graphics.open

~graphics.initWorld(20, 20, 20, 20);


~graphics.activateSwarm(13, 200.0, 200.0, 200.0, 0.8, 50.0, 8.0, 15.0, 100.0);

~graphics.sendBoidPattern(0, 1, 0);

~graphics.sendBoidPattern(1, 0, 0);

~graphics.sendBoidPattern(2, 0, 1);

~graphics.sendBoidPattern(4, 1, 0);

~graphics.sendBoidPattern(3, 1, 4);

~graphics.sendBoidPattern(6, 0, 0);

~graphics.setViewpoint(0.0,0.0,-200.0, 0.0, 0.0, 0.0)

~graphics.setSwarm(0.9, 50.0, 8.0, 25.0, 100.0)

~graphics.killSwarm

~graphics.setBoidCam(true, true)


Server.killAll

Tdef(\sendVector, {
	loop({
		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		[ 0.0625, 0.125, 0.25].choose.wait;
	});
});

Tdef(\sendVector).play

Tdef(\sendVector).stop