~graphics = CinderApp(800, 800, mode: 1)

~graphics.open

~graphics.initWorld(17, 17, 17, 20);

~graphics.initContinuous;

~graphics.setAdd(0.03);

~graphics.resetWorld(8, 8, 8, 4, 4, 4)

~graphics.setViewpoint(80.0, 80.0, 80.0, 0.0, 0.0, 0.0)


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


~rot = Rotation(100.0, 0.0015, 100.0, 50.0, 0.01, 0.002, 0.01, 0.001);

~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera



~graphics.setPattern(0, 1, 1.0, 1, 1, 1.0, 0.0, 0.4);

~graphics.setPattern(1, 1, 1.0, 1, 1, 1.0, 0.1, 0.4);

~graphics.setPattern(2, 0, 1.0, 0, 0, 1.0, 1.0, 1.0);

~graphics.setPattern(3, 0, 1.0, 1, 1, 0.5, 0.0, 0.3);

~graphics.setPattern(4, 0, 1.0, 0, 0, 0.4, 0.4, 0.4);

~graphics.setPattern(5, 1, 1.0, 1, 1, 0.6, 1.0, 0.3);

~graphics.setPattern(6, 0, 1.0, 1, 1, 0.5, 0.9, 0.8);

~graphics.setPattern(7, 0, 1.0, 0, 0, 0.0, 1.0, 1.0);

~graphics.setPattern(8, 0, 1.0, 0, 1, 0.7, 1.0, 1.0);

~graphics.setPattern(9, 1, 1.0, 0, 1, 0.1, 0.6, 1.0);

~graphics.setPattern(10, 0, 0.4, 0, 0, 0.6, 0.9, 1.0);

~graphics.setPattern(11, 0, 1.0, 0, 1, 0.0, 1.0, 1.0);

~graphics.setPattern(12, 0, 1.0, 1, 1, 0.2, 0.4, 0.6);

~graphics.setPattern(13, 0, 1.0, 0, 1, 0.7, 1.0, 0.2);

~graphics.setPattern(14, 0, 1.0, 0, 0, 0.3, 0.7, 1.0);

~graphics.setPattern(15, 0, 1.0, 0, 0, 1.0, 1.0, 1.0);

~graphics.setPattern(16, 0, 0.1, 1, 1, 1.0, 1.0, 1.0);

~graphics.setPattern(17, 0, 1.0, 0, 1, 0.4, 0.8, 1.0);

~graphics.setPattern(18, 0, 0.1, 0, 1, 1.0, 0.0, 1.0);

~graphics.setPattern(19, 0, 1.0, 0, 1, 0.1, 1.0, 0.4);

~graphics.setPattern(20, 0, 1.0, 0, 0, 1.0, 0.0, 0.5);

~graphics.setPattern(21, 0, 1.0, 1, 1, 1.0, 1.0, 0.0);

~graphics.setPattern(22, 1, 1.0, 1, 1, 0.4, 0.8, 1.0);

~graphics.setPattern(23, 0, 1.0, 1, 1, 0.9, 0.0, 0.3);

~graphics.setPattern(24, 1, 1.0, 1, 1, 0.5, 0.6, 0.7);

~graphics.setPattern(25, 0, 1.0, 1, 1, 0.8, 0.8, 0.8);

~graphics.setPattern(26, 0, 0.4, 1, 1, 0.3, 0.4, 0.7);

~graphics.setPattern(27, 0, 0.3, 1, 1, 0.4, 0.7, 0.1);

~graphics.setPattern(28, 0, 1.0, 0, 0, 1.0, 1.0, 1.0);

~graphics.setPattern(29, 0, 1.0, 0, 0, 0.6, 0.9, 1.0);

~graphics.setPattern(30, 0, 1.0, 1, 1, 0.0, 1.0, 1.0);

~graphics.setPattern(31, 0, 0.3, 0, 0, 1.0, 0.0, 1.0);

~graphics.setPattern(32, 0, 1.0, 0, 0, 0.0, 0.04, 0.04);

~graphics.setPattern(33, 0, 1.0, 0, 0, 0.4, 0.0, 0.2);

~graphics.setPattern(34, 0, 0.4, 1, 1, 0.4, 0.4, 0.7);

~graphics.setPattern(35, 0, 0.2, 1, 1, 0.0, 0.0, 0.5);

~graphics.setPattern(36, 1, 0.1, 0, 0, 1.0, 1.0, 1.0);

~graphics.setPattern(37, 0, 1.0, 0, 0, 1.0, 1.0, 1.0);

~graphics.setPattern(38, 0, 1.0, 0, 0, 1.0, 1.0, 1.0);

~graphics.setPattern(39, 0, 1.0, 1, 1, 0.5, 1.0, 1.0);
