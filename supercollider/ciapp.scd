~ciapp = CinderApp();

~ciapp.open(false)

~ciapp.initWorld(24, 24, 24, 8);

~ciapp.initContinuous;

~ciapp.setAdd(0.08);

~ciapp.resetWorld(9, 9, 9, 4, 4, 4)

~ciapp.setPattern(0, 1, 1.0, 0, 0, 0.6, 0.8, 1.0);

~ciapp.setPattern(1, 1, 0.3, 0, 0, 0.2, 0.6, 0.5);

~ciapp.setPattern(2, 0, 1.0, 0, 0, 0.3, 0.3, 0.33);

~ciapp.setPattern(3, 0, 1.0, 1, 1, 0.6, 0.8, 0.8);

~ciapp.setPattern(4, 0, 1.0, 0, 0, 0.6, 1.0, 1.0);

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


~ciapp.setInterpolation(1, 2)

~ciapp.rotate(1.0, 0.0, 0.0, 0.01)

~ciapp.rotate(1.0.rand, 1.0.rand, 1.0.rand, rrand(0.005, 0.02))


~ciapp.setViewpoint(0.0, -160.0, 0.0, 0.0, 0.0, 0.0)

~ciapp.setBackground(0.3, 0.3, 0.33)
~ciapp.setBackground(0.0, 0.0, 0.0)


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

~ciapp.queryStates(~arr, {|msg| msg.postln });

~ciapp.stopQuery

~ciapp.quit


Array.geom(30, 1.0, 0.96)

1.0 - Array.series(30, 0, 0.02)



~ciapp.initWorld(24, 24, 24, 8);

~ciapp.initGenerations([4,6,8], [3,5,7,9], 16);

~ciapp.setPattern(8, 0, 1.0, 0, 0, 0.6, 0.7, 0.9);

~ciapp.setPattern(9, 1, 1.0, 0, 0, 0.3, 0.7, 0.9);

~ciapp.setPattern(10, 1, 1.0, 0, 0, 0.5, 0.2, 0.5);

~ciapp.setPattern(11, 0, 1.0, 0, 0, 0.6, 0.6, 0.6);

~ciapp.setPattern(13, 1, 1.0, 0, 0, 0.6, 0.8, 1.0);

~ciapp.setPattern(14, 0, 1.0, 0, 0, 0.7, 0.7, 0.8);

~ciapp.setPattern(15, 1, 1.0, 0, 0, 0.5, 0.9, 0.8);

~ciapp.setSymmetry(11)


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

~ciapp.setViewpoint(0.0, 0.0, -60.0, 0.0, 0.0, 0.0)

~ciapp.rotate(1.0.rand, 1.0.rand, 1.0.rand, rrand(0.005, 0.02))

