~graphics = CinderApp();

~graphics.open

~graphics.initWorld(20, 20, 20, 20);

~graphics.initGenerations([4,6,8], [3,5,7,9], 16);

~graphics.setSymmetry(5)

~graphics.setViewpoint(60.0, 50.0, 55.0, 0.0, 0.0, 0.0);

~graphics.sendPredefined3DRule(\cooties)

~graphics.sendPredefined3DRule(\bombers)

~graphics.sendPredefined3DRule(\xtasy)


Tdef(\background, {
	loop({
		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		0.125.wait;
	});	
});

Tdef(\background).play

Generations

//////////////// GRAPHICS //////////////////////

~graphics.setPattern(5, 0, 1.0, 1, 1, 0.9, 0.1, 0.4);

~graphics.setPattern(6, 0, 1.0, 0, 0, 0.5, 0.9, 0.8);

~graphics.setPattern(7, 1, 1.0, 0, 0, 1.0, 1.0, 1.0);

~graphics.setPattern(8, 0, 1.0, 1, 1, 0.6, 0.7, 0.9);

~graphics.setPattern(8, 0, 0.2, 1, 1, 0.6, 0.7, 0.9);

~graphics.setPattern(9, 0, 1.0, 1, 1, 0.3, 0.7, 0.9);

~graphics.setPattern(10, 0, 1.0, 0, 0, 0.5, 0.8, 1.0);

~graphics.setPattern(11, 0, 1.0, 0, 0, 0.0, 0.3, 0.5);

~graphics.setPattern(12, 1, 1.0, 1, 1, 0.44, 0.32, 0.66);

~graphics.setPattern(13, 0, 0.7, 1, 1, 0.6, 0.8, 1.0);

~graphics.setPattern(14, 1, 1.0, 1, 1, 0.0, 0.5, 0.5);

~graphics.setPattern(15, 0, 1.0,0, 0, 0.0, 0.5, 0.7);
