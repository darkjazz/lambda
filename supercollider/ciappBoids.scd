~graphics = CinderApp(1024, 768)

~graphics.open

~graphics.initWorld(20, 20, 20, 20);


~graphics.activateSwarm(30, 200.0, 200.0, 200.0, 0.8, 50.0, 8.0, 15.0, 100.0);

~graphics.sendBoidPattern(0, 1, 0);

~graphics.sendBoidPattern(1, 0, 0);

~graphics.sendBoidPattern(2, 1, 1);

~graphics.sendBoidPattern(4, 1, 0);

~graphics.sendBoidPattern(3, 1, 4);

~graphics.sendBoidPattern(5, 0, 0);

~graphics.setViewpoint(100.0,100.0,100.0, 0.0, 0.0, 0.0)

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