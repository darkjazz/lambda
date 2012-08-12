~ciapp = CinderApp();

~ciapp.open(false)

~ciapp.initWorld(24, 24, 24, 8);

~ciapp.initContinuous;

~ciapp.setAdd(0.08);

~ciapp.resetWorld(9, 9, 9, 4, 4, 4)

~ciapp.setPattern(0, 1, 0.2, 0, 0, 0.6, 0.8, 1.0);

~ciapp.setPattern(1, 0, 0.3, 0, 0, 0.2, 0.6, 0.5);

~ciapp.setPattern(2, 1, 1.0, 0, 0, 0.3, 0.3, 0.33);

~ciapp.setPattern(3, 0, 1.0, 1, 1, 0.6, 0.8, 0.8);

~ciapp.setPattern(4, 0, 1.0, 0, 0, 0.6, 1.0, 1.0);

(
Routine({
	
	var streams = Array.fill(8, { Pbrown(0.0, 1.0, 0.1).asStream });
	
	1000.do({
		~ciapp.sendSOMVector( streams.collect(_.next) );
		0.1.wait;
	});
	"finished".postln
}).play;
)

~ciapp.sendSOMVector(Array.rand(8, 0.0, 1.0));

~ciapp.setPattern(6, 1, 1.0, 0, 0, 0.1, 0.8, 1.0);

~ciapp.setPattern(7, 1, 1.0, 0, 0, 1.0, 1.0, 1.0);


~ciapp.setInterpolation(1, 2)

~ciapp.rotate(1.0, 0.0, 0.0, 0.0)

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