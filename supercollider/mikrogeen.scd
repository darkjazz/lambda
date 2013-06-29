~ciapp = CinderApp();

~ciapp.open

~ciapp.initWorld(24, 24, 24, 8);

(
~rout = Routine({	
	var vec;
	inf.do({|i|
		vec =  Array.rand(8, 0.0, 1.0) ;
		~ciapp.sendSOMVector( vec = Array.rand(8, 0.0, 1.0) );
		0.2.wait;
		if (i%10==0) { vec.postln }
	});
}).play;

)

~rout.stop

~ciapp.rotate(1.0, 0.5, 0.25, 0.2);


~ciapp.rotate(1.0.rand, 1.0.rand, 1.0.rand, 0.0);

~ciapp.setViewpoint(150.0, -140.0, -150.0, 200.0, 200.0, 200.0);

~ciapp.setBackground(0.7, 0.7, 0.73)

~ciapp.setBackground(0.0, 0.0, 0.0)

~camrot = Rotation(200.0, 0.012*5, 200.0, 400.0, 0.0, 0.024*4, 0.0, 0.0);

~camrot.rhoRate = 0.012*4

~camrot.rhoMin = 200.0
~camrot.rhoRange = 1200.0

~ciapp.setCameraRotation(~camrot, 200.0, 200.0, 200.0, 200.0, 200.0, 200.0);

~ciapp.rotateCamera

~ciapp.stopRotation

~ciapp.activateSwarm(32, 400.0, 400.0, 400.0, 0.9, 50.0, 8.0, 10.0, 100.0);

~ciapp.setSwarm(0.9, 50.0, 8.0, 15.0, 100.0)


~ciapp.moveCamera([200.0, 200.0, -1200.0, 200.0, 200.0, 200.0], [200.0, 200.0, -200.0, 200.0, 200.0, 200.0], 60, 10, {"finished".postln})

~ciapp.setBoidCam(true, true)

~ciapp.setBoidCam(false, false)

~viewpoints = [
	(coords: [800.0, 800.0, -1200.0, 200.0, 200.0, 200.0], time: 30),
	(coords: [200.0, 200.0, -1200.0, 200.0, 200.0, 200.0], time: 45),	(coords: [200.0, 200.0, -200.0, 200.0, 200.0, 200.0], time: 60)
];

~viewpoints.doAdjacentPairs({|a, b|
	[a.coords, b.coords].postln
})

(
Routine({
	~ciapp.initWorld(24, 24, 24, 8);
	1.wait;
	~rout = Routine({	
		loop({
			~ciapp.sendSOMVector( Array.rand(8, 0.0, 1.0) );
			0.2.wait;
		});
	}).play;
	
	~viewpoints.doAdjacentPairs({|viewA, viewB|
		~ciapp.moveCamera(viewA.coords, viewB.coords, viewA.time, 10, { Post << "coords: " << viewB.coords << Char.nl });
		(viewA.time + 2).wait
	})
	
}).play

)


~moveView = {|start, end, time, rate, donefunc|
	
	Routine({
		
		var num, steps, incr, value;
		steps = time * rate;
		incr = end - start / steps;
		value = start;
		steps.do({
			~ciapp.setViewpoint(*value);
			value = value + incr;
			rate.reciprocal.wait
		});		
		donefunc.();
		
	}).play;

};

~moveView.( [500, 500, 1000, 400, 400, 400], [500, 500, 500, 200, 200, 200], 20, 10, { "finished".postln })
