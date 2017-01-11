~graphics = CinderApp(800, 450, mode: 0, path:"/Users/alo/dev/lambda/xcode/DerivedData/lambdaApp/Build/Products/Debug/lambda.app")

~graphics.open

~graphics.initWorld(11, 11, 11, 20);


~graphics.initGenerations([4,6],[4,6],17);


~graphics.setSymmetry(11)

~graphics.setViewpoint(80.0, 80.0, 80.0, 0.0, 0.0, 0.0)

Tdef(\sendVector, {
	loop({
		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		[ 0.0625, 0.125, 0.25].choose.wait;
	});
}).play;

~graphics.setPattern(12, 1, 1.0, 1, 1, 0.6, 0.8, 1.0);



~graphics.queryAliveStates({|ms|
	~msg = ms;
	~msg.size.postln
})

~msg.drop(1).clump(2).do(_.postln)

~msg.drop(1).clump(2).collect({|tuple|
	var packed = tuple.first;
	x = floor(packed.asFloat/(~graphics.world.sizeY * ~graphics.world.sizeZ));
	y = floor(packed.asFloat/~graphics.world.sizeY.asFloat)%~graphics.world.sizeY;
	z = packed%~graphics.world.sizeZ;
	[x, y, z, packed, tuple.last].postln
})

~msg.drop(1).clump(2).collect(_.first).do(_.postln)

~graphics.stopQuery

~graphics.queryFunc
