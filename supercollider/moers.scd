~graphics = CinderApp(1024, 768, mode: 1);

~graphics.open

~graphics.initWorld(20, 20, 20, 20);

~graphics.initContinuous;

~graphics.setAdd(0.05);

~graphics.resetWorld(9, 9, 9, 4, 4, 4)

~graphics.setPattern(0, 0, 1.0, 1, 1, 0.6, 0.8, 1.0);

~graphics.setPattern(1, 1, 0.5, 1, 1, 0.9, 0.1, 0.4);

~graphics.setPattern(2, 0, 1.0, 1, 1, 0.5, 0.75, 0.9);

~graphics.setPattern(3, 0, 1.0, 1, 0, 0.6, 0.8, 0.8);

~graphics.setPattern(4, 0, 1.0, 1, 1, 1.0, 1.0, 0.3);

~graphics.setPattern(5, 0, 1.0, 0, 0, 0.7, 0.9, 1.0);

~graphics.setPattern(16, 0, 1.0, 0, 0, 1.0, 0.5, 0.8);

~graphics.setPattern(17, 0, 1.0, 0, 0, 0.5, 0.5, 1.0);

~graphics.setPattern(18, 0, 1.0, 0, 0, 0.9, 0.9, 0.2);

~graphics.setPattern(19, 0, 1.0, 0, 0, 0.9, 0.9, 0.2);

~graphics.setPattern(20, 0, 1.0, 0, 0, 0.9, 0.9, 0.2);

~graphics.setPattern(21, 1, 1.0, 1, 1, 0.6, 0.7, 0.9);

~graphics.setPattern(22, 1, 1.0, 0, 0, 0.6, 0.7, 0.9);

~graphics.setPattern(23, 0, 1.0, 1, 1, 0.6, 0.7, 0.9);

~graphics.setPattern(24, 0, 1.0, 0, 0, 0.6, 0.7, 0.9);

~graphics.setPattern(25, 0, 1.0, 1, 1, 0.6, 0.7, 0.9);

Tdef(\sendSOM, {
	loop({
		~graphics.sendSOMVector(Array.rand(20, 0.0, 1.0));
		0.25.wait	
	})
})

Tdef(\sendSOM).play

~rot = Rotation(rrand(20.0, 40.0), rrand(0.005, 0.08), rrand(30.0, 60.0), rrand(20.0, 60.0), rrand(-pi, pi), rrand(0.005, 0.05), rrand(-pi, pi), rrand(0.005, 0.05));
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera

~graphics.stopRotation


~graphics.activateSwarm(24, 200.0, 200.0, 200.0, 0.8, 50.0, 8.0, 5.0, 100.0);

~graphics.sendBoidPattern(0, 1, 0);

~graphics.sendBoidPattern(1, 0, 0);

~graphics.sendBoidPattern(2, 0, 0);

~graphics.sendBoidPattern(3, 1, 4);

~graphics.sendBoidPattern(4, 1, 4);

~graphics.sendBoidPattern(5, 1, 4);


~graphics.setSwarm(0.5, 50.0, 8.0, 15.0, 100.0)

~graphics.killSwarm

~graphics.setBoidCam(false, false)

~graphics.quit

