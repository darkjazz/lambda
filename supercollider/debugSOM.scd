~ciapp = CinderApp();

~ciapp.open

~ciapp.initWorld(20, 20, 20, 20);

(
Routine({
	
	var streams = Array.fill(8, { Pbrown(0.0, 1.0, 0.1).asStream });
	
	1000.do({
		~ciapp.sendSOMVector( streams.collect(_.next) );
		0.2.wait;
	});
	"finished".postln
}).play;
)

(
Routine({
	
	1000.do({
		~ciapp.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		0.2.wait;
	});
	"finished".postln
}).play;
)


~ciapp.setPattern(8, 0, 1.0, 0, 0, 1.0, 1.0, 1.0);

~ciapp.rotate(1.0.rand, 1.0.rand, 1.0.rand, 0.0)


~ciapp.setViewpoint(0.0, -100.0, 0.0, 0.0, 0.0, 0.0)

~ciapp.setBackground(0.3, 0.3, 0.35)

~ciapp.setBackground(0.0, 0.0, 0.0)

~ciapp.setViewpoint(400.0, 400.0, 400.0, 200.0, 200.0, 200.0)

~ciapp.setViewpoint(500.0, 400.0, 600.0, 200.0, 200.0, 200.0)

~ciapp.setViewpoint(800.0, 800.0, 800.0, 200.0, 200.0, 200.0)

~ciapp.activateSwarm(16, 400.0, 400.0, 400.0, 0.9, 50.0, 8.0, 10.0, 100.0);

~ciapp.setSwarm(0.9, 40.0, 10.0, 25.0, 100.0)

~ciapp.setBoidCam(false, false)

~ciapp.setFrameRate(16.0)

~ciapp.sendBoidPattern(0, 1, 6) 

~ciapp.sendBoidPattern(0, 0, 0)

~ciapp.sendBoidPattern(1, 1, 3)
~ciapp.sendBoidPattern(1, 0, 0)

~ciapp.sendBoidPattern(2, 1, 0)
~ciapp.sendBoidPattern(2, 0, 0)

~ciapp.sendBoidPattern(3, 1, 6)
~ciapp.sendBoidPattern(3, 0, 4)

~ciapp.sendBoidPattern(4, 1, 4)
~ciapp.sendBoidPattern(4, 0, 1)

~ciapp.sendBoidPattern(5, 1, 3)
~ciapp.sendBoidPattern(5, 0, 1)

