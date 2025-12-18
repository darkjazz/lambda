(
~mode = 1;
~path = "/Users/kurivari/dev/kv/xcode/build/Release/kv.app";
~wrldsz = 17;
~nboids = 23;
Tdef('code').clear;
~file = File("/Users/kurivari/dev/lambda/supercollider/sparsematrix/sets/{--kurivar-envir--}_++.postln.scd", "r");
~code = ~file.readAllString;
~file.close;
~sendarr = ~code.split(Char.nl);
~sendarr = ~sendarr.collect({|line| line.replace(Char.tab, "  ") });

~maxwidth = 130;

~file2 = File("/Users/kurivari/dev/lambda/supercollider/sparsematrix/sets/ogl-debug.scd", "r");
~code2 = ~file2.readAllString;
~file2.close;
~sendarr2 = ~code2.split(Char.nl);
~sendarr2 = ~sendarr2.collect({|line| line.replace(Char.tab, "  ") });

~sendCode = {
    Tdef('code', {
		var filler = String.fill(~maxwidth*2, $-);
		~graphics.sendCodeLine(filler);
		loop({
			~sendarr2.do({|code, i|
				// var usr = "{}kurivari$ ";
				var line;
				line = (code[0..(~maxwidth-1)].padRight(~maxwidth) ++ "| " ++ ~sendarr.wrapAt(i)[0..(~maxwidth-1)]);
				if (i%67 == 0) {
					~graphics.sendCodeLine(filler);
				};
				~graphics.sendCodeLine(line);
				rrand(0.05, 0.5).wait;
			})
		})
	}).play
};
~initMsg = {
	Tdef(\sendVector, {
		loop({
			~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
			[ 0.0625, 0.125, 0.25].choose.wait;
		});
	}).play;
};
Tdef('init', {
	~graphics = CinderApp(1000, 800, mode: ~mode, path: ~path, fullScreen: true);
	~graphics.open;
	3.wait;
	~graphics.initWorld(~wrldsz, ~wrldsz, ~wrldsz, 20);
	1.wait;
	~graphics.initGenerations([ 4, 6, 9, 18, 24 ], [ 1, 4, 6, 8, 17, 23, 24, 26 ], 13);
	1.wait;
	~graphics.setSymmetry(11);
	~graphics.setViewpoint(0.0, 0.0, -180.0, -30.0, 0.0, 0.0);
	// ~initMsg.();
	1.wait;
	~activePatterns = Array();
	~graphics.activateSwarm(~nboids, 200.0, 200.0, 200.0, 0.8, 50.0, 8.0, 15.0, 100.0);
	~graphics.sendCodeTitle("{} 사악한 그림자");
	~graphics.setCodePanelFont("Inconsolata", 11);
	~graphics.setCodePanelColor(1.0, 0.2, 0.7);
	Post << "Initialised..." << Char.nl;
	~sendCode.value();
	{
		e.scopeWindow.window.alpha = 0.13;
		e.scopeWindow.scopeView.waveColors = [Color.yellow, Color.yellow];
		e.scopeWindow.window.bounds = Rect(Window.screenBounds.width, 0, 1280, 720);
	}.defer;
	~graphics.hideCodePanel;
	~gpatterns = [
		[1.0, 1, 1, 0.0, 0.2, 1.0],  // Pattern 0
		[1.0, 1, 1, 1.0, 0.0, 0.3],  // Pattern 1
		[1.0, 1, 1, 0.9, 0.0, 1.0],  // Pattern 2
		[1.0, 1, 1, 1.0, 0.0, 1.0],  // Pattern 3
		[1.0, 0, 0, 0.5, 0.5, 0.5],  // Pattern 4
		[1.0, 0, 0, 0.5, 0.5, 0.5],  // Pattern 5
		[1.0, 1, 1, 0.9, 0.2, 0.2],  // Pattern 6
		[1.0, 1, 1, 1.0, 0.0, 0.0],  // Pattern 7
		[1.0, 1, 1, 0.0, 0.2, 1.0],  // Pattern 8
		[0.1, 1, 1, 0.0, 1.0, 0.0],  // Pattern 9
		[1.0, 0, 0, 0.0, 0.0, 1.0],  // Pattern 10
		[1.0, 0, 0, 0.7, 0.0, 0.7],  // Pattern 11
		[1.0, 1, 1, 0.0, 0.0, 1.0],  // Pattern 12
		[1.0, 0, 0, 0.0, 0.6, 1.0],  // Pattern 13
		[1.0, 1, 1, 0.2, 0.5, 0.5],  // Pattern 14
		[1.0, 1, 1, 0.2, 0.5, 1.0],  // Pattern 15
		[0.2, 1, 1, 0.8, 0.0, 1.0],  // Pattern 16
		[1.0, 1, 1, 0.9, 0.0, 0.9],  // Pattern 17
		[0.3, 1, 1, 0.6, 0.1, 0.3],  // Pattern 18
		[1.0, 0, 0, 0.7, 0.0, 0.3],  // Pattern 19
		[1.0, 0, 0, 0.0, 0.2, 1.0],  // Pattern 20
		[1.0, 1, 1, 0.0, 0.3, 1.0],  // Pattern 21
		[1.0, 0, 0, 0.0, 0.0, 0.0],  // Pattern 22
		[1.0, 0, 0, 0.0, 0.2, 1.0]   // Pattern 23
	];

	~boidpatterns = 4.collect({|i|
		[i, 0, 0]
	});

	~zone = {|index|

		~gpatterns.do({|argarr, i|
			var args = [i, 0] ++ argarr;
			~graphics.setPattern(*args);
		});

		~boidpatterns.do({|argarr|
			~graphics.sendBoidPattern(*argarr);
		});

		Tdef('zone').clear;
		Tdef("gfx").clear;

		switch(index,
			0, {
				~rad = 3.0;
				~graphics.activateEfx("radial", 1);
				~graphics.setEfx([0.5, 0.5, ~rad, 14]);
				~graphics.setPattern(8, 1, 1.0, 1, 1, 0.0, 0.2, 1.0);
				~graphics.setPattern(10, 1, 1.0, 0, 0, 0.0, 0.0, 1.0);
				Tdef("gfx", {
					// var step = 3.0 / 120;
					// 120.do({
					// 	~rad = ~rad - step;
					// 	~graphics.setEfx([0.5, 0.5, ~rad, 14]);
					// 	1.wait;
					// });
					// "Finished radial fade".postln;
					loop({
						~graphics.setEfx([0.5, 0.5, exprand(0.01, 1.0), 14]);
						([2, 4, 8].choose * ~matrix.beatdur).wait;
					})
				}).play;
			},
			1, {
				~graphics.showCodePanel;
				~graphics.mapCodePanel;
				~graphics.activateEfx("glitch", 1);

				~graphics.setViewpoint(0.0, 0.0, -200.0, -80.0, 0.0, 0.0);
				~graphics.setPattern(0, 1, 1.0, 1, 1, 0.0, 0.2, 1.0);
				~graphics.setPattern(1, 1, 1.0, 1, 1, 1.0, 0.0, 0.3);
				Tdef("gfx", {
					loop({
						~graphics.setEfx([rrand(0.5, 1.0), 0.0, rrand(0.5, 5.0), rrand(0.5, 4.0)]);
						([2, 4, 8].choose * ~matrix.beatdur).wait;
					})
				}).play;
			},
			2, {
				~graphics.activateEfx("motion", 1);
				~graphics.setViewpoint(170.0, 0.0, 0.0, 0.0, 0.0, -70.0);
				~graphics.setPattern(2, 1, 1.0, 1, 1, 0.9, 0.0, 1.0);
				~graphics.setPattern(21, 1, 1.0, 1, 1, 0.0, 0.3, 1.0);
				~graphics.setPattern(10, 1, 1.0, 0, 0, 0.0, 0.0, 1.0);
				Tdef("gfx", {
					loop({
						~graphics.setEfx([rrand(1, 23), rrand(0.001, 1.0), rrand(1, 37)]);
						([2, 4, 8].choose * ~matrix.beatdur).wait;
					})
				}).play;


			},
			3, {
				~graphics.activateEfx("motion", 0);
				~graphics.hideCodePanel;
				~graphics.unmapCodePanel;
				~graphics.setPattern(4, 1, 1.0, 0, 0, 0.5, 0.5, 0.5);
				~graphics.setPattern(19, 1, 1.0, 0, 0, 0.7, 0.0, 0.3);
				~graphics.setPattern(20, 1, 1.0, 0, 0, 0.0, 0.2, 1.0);

				~rot = Rotation(-220.0, 0.0, -220.0, 0.0, -270.0, 0.01, 0.0, 0.0);
				~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				~graphics.rotateCamera;
			},
			4, {
				~graphics.setPattern(0, 1, 1.0, 1, 1, 0.0, 0.2, 1.0);
				~graphics.setPattern(12, 1, 1.0, 1, 1, 0.0, 0.0, 1.0);
				~graphics.setPattern(16, 1, 1.0, 1, 1, 0.1, 0.0, 0.1);
				~graphics.sendBoidPattern(2, 1, 0);
				~graphics.sendBoidColor(2, 1.0, 0.2, 1.0);
				~rot = Rotation(150.0, 0.03, 150.0, 50.0, 0.1, 0.03, 0.1, 0.01);
				~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				~graphics.rotateCamera;
				Tdef('zone', {
					var off, patterns = [
						{~graphics.setPattern(6, 1, 1.0, 1, 1, 0.0, 1.0, 0.0)},
						{~graphics.setPattern(16, 1, 1.0, 1, 1, 0.1, 0.0, 0.1)}
					];
					off = {
						~graphics.setPattern(6, 0, 1.0, 1, 1, 0.0, 1.0, 0.0);
						~graphics.setPattern(16, 0, 1.0, 1, 1, 0.1, 0.0, 0.1);
					};
					loop({
						off.();
						patterns.choose.();
						(~matrix.beatdur * [8, 12, 16].choose).wait
					})
				}).play;
			},
			5, {
				~graphics.stopRotation;
				~graphics.setViewpoint(0.0, 200.0, 0.0, 0.0, 0.0, 0.0);
				~graphics.showCodePanel;
				~graphics.mapCodePanel;
				~graphics.setBoidCam( true, true );
				~graphics.sendBoidPattern(0, 1, 0);
				~graphics.setPattern(12, 1, 1.0, 1, 1, 0.0, 0.0, 1.0);
				~graphics.setPattern(23, 1, 1.0, 0, 0, 0.0, 0.2, 1.0);
			},
			6, {
				~graphics.hideCodePanel;
				~graphics.unmapCodePanel;
				~graphics.setBoidCam( false, false );
				~graphics.setViewpoint(0.0, 200.0, 0.0, 0.0, 0.0, 0.0);
				~graphics.sendBoidPattern(1, 1, 0);
				~graphics.sendBoidColor(1, 0.0, 0.2, 1.0);
				~graphics.setPattern(15, 1, 1.0, 1, 1, 0.2, 0.5, 1.0);
				~graphics.setPattern(17, 1, 1.0, 1, 1, 0.9, 0.0, 0.9);
				~rot = Rotation(150.0, 0.03, 150.0, 50.0, 0.1, 0.03, 0.1, 0.01);
				~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				~graphics.rotateCamera;
			},
			7, {
				~graphics.setPattern(15, 0, 1.0, 1, 1, 0.2, 0.5, 1.0);
				~graphics.setPattern(17, 0, 1.0, 1, 1, 0.9, 0.0, 0.9);
				~graphics.sendBoidPattern(3, 1, 0);
				~graphics.sendBoidColor(3, 0.0, 0.0, 0.7);
				~graphics.setPattern(23, 1, 1.0, 0, 0, 0.0, 0.2, 1.0);
			},
			8, {
				~graphics.stopRotation;
				~graphics.setViewpoint(250.0, 0.0, 0.0, 0.0, 0.0, -90.0);
				~graphics.setPattern(0, 1, 1.0, 1, 1, 0.0, 0.2, 1.0);
				~graphics.setPattern(10, 1, 1.0, 0, 0, 0.0, 0.0, 1.0);
				~graphics.setPattern(18, 1, 0.3, 1, 1, 0.6, 0.1, 0.3);
				Tdef('zone', {
					var off, patterns = [
						{~graphics.setPattern(6, 1, 1.0, 1, 1, 0.9, 0.2, 0.2)},
						{~graphics.setPattern(11, 1, 1.0, 0, 0, 0.7, 0.0, 0.7)},
						{~graphics.setPattern(18, 1, 0.3, 1, 1, 0.6, 0.1, 0.3)}
					];
					off = {
						~graphics.setPattern(6, 0, 1.0, 1, 1, 0.9, 0.2, 0.2);
						~graphics.setPattern(11, 0, 1.0, 0, 0, 0.7, 0.0, 0.7);
						~graphics.setPattern(18, 0, 0.3, 1, 1, 0.6, 0.1, 0.3);
					};
					loop({
						off.();
						patterns.choose.();
						(~matrix.beatdur * 16).wait
					})
				}).play;
				~graphics.activateEfx("glitch", 1);
				Tdef("gfx", {
					loop({
						~graphics.setEfx([rrand(0.5, 1.0), 0.0, rrand(0.5, 5.0), rrand(0.5, 4.0)]);
						([2, 4, 8].choose * ~matrix.beatdur).wait;
					})
				}).play;

			},
			9, {
				~graphics.activateEfx("glitch", 0);
				~graphics.sendBoidPattern(3, 1, 0);
				~graphics.sendBoidColor(3, 0.0, 0.0, 0.7);
				~graphics.setPattern(23, 1, 1.0, 0, 0, 0.0, 0.2, 1.0);
				~graphics.setPattern(8, 1, 1.0, 1, 1, 0.0, 0.2, 1.0);
				~graphics.activateEfx("radial", 1);
				Tdef('gfx', {
					loop({
						~graphics.setEfx([0.5, 0.5, 1.0.rand, 16]);
						([2, 4, 8].choose * ~matrix.beatdur).wait;
					})
				}).play

			},
			10, {
				~graphics.activateEfx("radial", 0);
				~graphics.sendBoidPattern(2, 1, 0);
				~graphics.sendBoidColor(2, 0.0, 1.0, 1.0);
				~graphics.sendBoidPattern(3, 1, 0);
				~graphics.sendBoidColor(3, 0.0, 0.3, 0.3);
				~graphics.stopRotation;
				~graphics.setViewpoint(0.0, 200.0, 0.0, 0.0, 0.0, 0.0);
			}
		)

	}
}).play;
)

