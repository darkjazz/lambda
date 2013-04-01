~ciAddr = NetAddr("98.151.254.234", 7000);
~scAddr = NetAddr("92.236.185.17", NetAddr.localAddr.port);

~graphics = CinderApp();

~graphics.open

~graphics.setFrameRate(16.0);
~graphics.initWorld(20, 20, 20, 20);
~graphics.setViewpoint(300.0, 400.0, 200.0, 200.0, 200.0, 200.0);
~graphics.activateSwarm(16, 400.0, 400.0, 400.0, 0.9, 50.0, 8.0, 5.0, 100.0);

(
Routine({
		
	100.do({
		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		0.1.wait;
	});
	"finished".postln
}).play;
)

~graphics.sendBoidPattern(5, 1, 4);


~graphics.sendBoidPattern(5, 1, 4);


~rot = Rotation(0.3, 0.33, 50.0, 200.0, 2pi.rand, 0.5, 2pi.rand, 0.33);
~graphics.setCameraRotation(~rot, 200.0, 200.0, 200.0, 200.0, 200.0, 200.0);
~graphics.rotateCamera;

~graphics.stopRotation;


~ciapp.ciAddr

~graphics.setViewpoint(300.0, 300.0, 300.0, 0.0, 0.0, 0.0)

~ciapp.activateSwarm(20, 400.0, 400.0, 400.0, 0.9, 50.0, 8.0, 10.0, 100.0);


~graphics.setSwarm(0.9, 50.0, 8.0, 20.0, 100.0)

~ciapp.killSwarm

~ciapp.rotate(1.0.rand, 1.0.rand, 1.0.rand, rrand(0.005, 0.02))



~app = CinderApp();

~app.setFrameRate(16.0);
~app.initWorld(20, 20, 20, 20);
~app.setViewpoint(500.0, 400.0, 600.0, 200.0, 200.0, 200.0);
~app.activateSwarm(16, 400.0, 400.0, 400.0, 0.9, 50.0, 8.0, 5.0, 100.0);
~app.sendBoidPattern(2, 1, 0);

~app.setViewpoint(300.0, 300.0, 300.0, 0.0, 0.0, 0.0)

~app.activateSwarm(20, 400.0, 400.0, 400.0, 0.9, 50.0, 8.0, 10.0, 100.0);


~app.setSwarm(0.9, 50.0, 8.0, 20.0, 100.0)

~ciapp.killSwarm

~ciapp.rotate(1.0.rand, 1.0.rand, 1.0.rand, rrand(0.005, 0.02))
