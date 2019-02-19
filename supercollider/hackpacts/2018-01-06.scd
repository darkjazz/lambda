~graphics = CinderApp(800, 800, mode: 1)

~graphics.open

~graphics.initWorld(23, 23, 23, 20);

~graphics.initContinuous;

~graphics.setAdd(0.05);

~graphics.resetWorld(8, 8, 8, 4, 4, 4)

~graphics.setViewpoint(65.0, 65.0, 65.0, 0.0, -5.0, 0.0)


~graphics.setInterpolation(1, 8)

(
Tdef(\sendVector, {
	loop({
		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		[ 0.0625, 0.125, 0.25].choose.wait;
	});
});

Tdef(\sendVector).play
)

~graphics.setPattern(10, 1, 0.4, 0, 0, 0.6, 0.9, 1.0);
~graphics.setPattern(22, 1, 0.6, 1, 1, 0.4, 0.8, 1.0);



~graphics.setPattern(26, 1, 1.0, 1, 1, 0.3, 0.4, 0.7);



~graphics.setPattern(27, 1, 0.3, 1, 1, 0.4, 0.7, 0.1);

(
~dur = 10;
~delta = 0.1;
Tdef('hsv', {
	loop({
		(~dur/~delta).asInt.do({|i|
			var color = Color.hsv(i.linlin(0, (~dur/~delta).asInt - 1, 0.0, 0.999), 1.0, 1.0, 1.0);
			~graphics.setPattern(27, 1, 0.3, 1, 1, color.red, color.green, color.blue);
			~delta.wait
		})
	})
}).play

)

Tdef('hsv').clear



~rot = Rotation(115.0, 0.0, 115.0, 0.0, 0.0, 0.05, 0.25pi, 0.07);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, -5.0, 0.0);
~graphics.rotateCamera
