~ciapp = CinderApp(800, 600);

~ciapp.quit

~ciapp.open

~ciapp.initWorld(24, 24, 24, 20);

~ciapp.initContinuous;

~ciapp.setAdd(0.04);

~ciapp.resetWorld(9, 9, 9, 4, 4, 4)

~ciapp.setPattern(0, 0, 1.0, 1, 1, 0.6, 0.8, 1.0);

~ciapp.setPattern(1, 0, 1.0, 1, 1, 0.9, 0.1, 0.4);

~ciapp.setPattern(2, 0, 1.0, 1, 1, 0.5, 0.75, 0.9);

~ciapp.setPattern(3, 0, 1.0, 1, 0, 0.6, 0.8, 0.8);

~ciapp.setPattern(4, 0, 1.0, 0, 0, 1.0, 1.0, 0.3);

~ciapp.setPattern(5, 0, 1.0, 0, 0, 0.7, 0.9, 1.0);

~ciapp.setPattern(6, 0, 1.0, 0, 0, 1.0, 1.0, 0.3);

~ciapp.setPattern(7, 1, 1.0, 0, 0, 1.0, 1.0, 0.3);

(
Routine({
	
	var streams = Array.fill(8, { Pbrown(0.0, 1.0, 0.1).asStream });
	
	100.do({
		~ciapp.sendSOMVector( streams.collect(_.next) );
		0.1.wait;
	});
	"finished".postln
}).play;
)

~ciapp.sendSOMVector(Array.rand(8, 0.0, 1.0));

~ciapp.setPattern(6, 0, 1.0, 0, 0, 0.1, 0.8, 1.0);

~ciapp.setPattern(8, 0, 1.0, 0, 0, 1.0, 1.0, 1.0);


~ciapp.setInterpolation(1, 8)

~ciapp.rotate(1.0, 0.0, 0.0, 0.0)

~ciapp.rotate(1.0.rand, 1.0.rand, 1.0.rand, rrand(0.005, 0.02))


~ciapp.setViewpoint(-80.0, 80.0, 40.0, 0.0, 0.0, 0.0)

~ciapp.setBackground(0.6, 0.6, 0.65)
~ciapp.setBackground(0.0, 0.0, 0.05)


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

~ciapp.queryStates(~arr, {|msg| msg.postln });

~ciapp.stopQuery

~ciapp.quit


Array.geom(30, 1.0, 0.96)

1.0 - Array.series(30, 0, 0.02)


~ciapp = CinderApp();

~ciapp.open

~ciapp.initWorld(20, 20, 20, 8);

~ciapp.initGenerations([4,6,8], [3,5,7,9], 12);

~ciapp.setSymmetry(11)

~ciapp.setPattern(5, 0, 0.3, 0, 0, 0.9, 0.1, 0.4);

~ciapp.setPattern(6, 0, 0.5, 1, 1, 0.5, 0.9, 0.8);

~ciapp.setPattern(7, 1, 1.0, 0, 0, 1.0, 1.0, 1.0);

~ciapp.setPattern(8, 0, 1.0, 1, 1, 0.6, 0.7, 0.9);

~ciapp.setPattern(9, 0, 0.5, 1, 1, 0.3, 0.7, 0.9);

~ciapp.setPattern(10, 0, 1.0, 0, 0, 0.5, 0.8, 1.0);

~ciapp.setPattern(11, 0, 1.0, 0, 0, 0.0, 0.3, 0.5);

~ciapp.setPattern(12, 1, 0.5, 0, 0, 0.6, 0.8, 1.0);
	
~ciapp.setPattern(13, 0, 1.0, 1, 1, 0.0, 0.6, 1.0);

~ciapp.setPattern(14, 0, 1.0, 0, 0, 0.0, 0.5, 0.5);

~ciapp.setPattern(15, 0, 0.2, 0, 0, 0.0, 0.5, 0.7);

~ciapp.setViewpoint(-80.0, 80.0, 80.0, 0.0, 0.0, 0.0)


Tdef(\sendVector, {
	loop({
		~ciapp.sendSOMVector( Array.rand(8, 0.0, 1.0) );
		0.25.wait;
	});	
});

Tdef(\sendVector).play

Tdef(\sendVector).stop

(
Routine({
		
	100.do({
		~ciapp.sendSOMVector( Array.rand(8, 0.0, 1.0) );
		0.1.wait;
	});
	"finished".postln
}).play;
)


~ciapp.setViewpoint(0.0, 0.0, 60.0, 0.0, 0.0, 0.0)

~ciapp.setInterpolation(1, 2)

~ciapp.sendGenRule([4],[4],25)

~ciapp.sendGenRule([3], [3,4,5], 12)

~ciapp.assignCodeWindow(Document.current);


~ciapp.sendPredefinedGenRule(\nova)

~ciapp.sendPredefined3DRule(\brain6)

~ciapp.setBackground(0.8, 0.8, 0.9)

~rot = Rotation(140.0, 0.01, 100.0, 20.0, 0.0, 0.011, 0.0, 0.013);
~ciapp.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~ciapp.rotateCamera

~ciapp.stopRotation


~ciapp.setFrameRate(64.0)

~ciapp = CinderApp();

~ciapp.open

~ciapp.hideCodePanel

~ciapp.initWorld(20, 20, 20, 8);

~ciapp.initContinuous;

~ciapp.setAdd(0.2);

~ciapp.resetWorld(9, 9, 9, 4, 4, 4)

~ciapp.setViewpoint(0.0, 0.0, 80.0, 0.0, 0.0, 0.0)

~ciapp.setPattern(18, 1, 1.0, 0, 0, 0.0, 0.3, 0.5);

~ciapp.setPattern(21, 1, 1.0, 1, 1, 0.6, 0.7, 0.9);

~ciapp.setPattern(22, 1, 1.0, 0, 0, 0.6, 0.7, 0.9);

~ciapp.setPattern(23, 1, 1.0, 1, 1, 0.6, 0.7, 0.9);

~ciapp.setPattern(24, 0, 1.0, 0, 0, 0.6, 0.7, 0.9);

~ciapp.setPattern(25, 0, 1.0, 1, 1, 0.6, 0.7, 0.9);


(
Routine({
		
	100.do({
		~ciapp.sendSOMVector( Array.rand(8, 0.0, 1.0) );
		0.1.wait;
	});
	"finished".postln
}).play;
)
