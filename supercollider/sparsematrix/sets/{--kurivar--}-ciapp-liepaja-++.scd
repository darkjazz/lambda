(
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
~path = "/Users/kurivari/dev/lambda/xcode/build/Products/Debug/lambda.app";
~wrldsz = 17;
~initMsg = {
	Tdef(\sendVector, {
		loop({
			~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
			[ 0.0625, 0.125, 0.25].choose.wait;
		});
	}).play;
};
Tdef('init', {
	~graphics = CinderApp(1000, 800, mode: 1, path: ~path, fullScreen: true);
	~graphics.open;
	3.wait;
	~graphics.initWorld(~wrldsz, ~wrldsz, ~wrldsz, 20);
	1.wait;
	~graphics.initGenerations([ 4, 10, 14, 15, 21, 23 ], [ 6, 13, 25, 26 ], 23);
	1.wait;
	~graphics.setSymmetry(11);
	~graphics.setViewpoint(100.0, 0.0, 0.0, 0.0, 0.0, 0.0);
	~initMsg.();
	1.wait;
	~activePatterns = Array();
	~graphics.activateSwarm(13, 200.0, 200.0, 200.0, 0.8, 50.0, 8.0, 15.0, 100.0);
	0.2.wait;
	~graphics.sendCodeTitle("{}악당");
	1.0.wait;
	~graphics.sendBoidPattern(3, 1, 4);
	Post << "Initialised..." << Char.nl;
	~sendCode.value();
	{
		e.scopeWindow.window.alpha = 0.15;
		e.scopeWindow.scopeView.waveColors = [Color.cyan, Color.cyan];
		e.scopeWindow.window.bounds = Rect(Window.screenBounds.width, 0, 1920, 1028);
	}.defer;
	~graphics.hideCodePanel;
}).play
)


Tdef('code').clear

~zone1.()

(
~zone0 = {
	Tdef('zone', {
		~graphics.setPattern(0, 1, 1.0, 0, 0, 0.0, 0.7, 1.0);
		~graphics.setViewpoint(180.0, 0.0, 0.0, 0.0, 0.0, 0.0);
		loop({
			var arr;
			arr = Array.fill(3, { [200.0, 0.0].choose });
			~graphics.setViewpoint(arr[0], arr[1], arr[2], 0.0, 0.0, 0.0);
			(~matrix.beatdur * [6, 12, 16].choose).wait;
		})
	}).play
};

~zone1 = {
	Tdef('zone').clear;
	~graphics.setPattern(5, 0, 1.0, 1, 1, 0.1, 0.5, 1.0);
	~graphics.setPattern(4, 0, 0.3, 0, 0, 0.0, 0.7, 1.0);
	~graphics.showCodePanel;
	~graphics.sendBoidPattern(3, 0, 4);

	~sendCode.();
	~graphics.setViewpoint(0.0, 0.0, 200.0, 0.0, -30.0, 0.0);
	~graphics.setPattern(6, 1, 0.7, 1, 1, 1.0, 1.0, 1.0);
	~graphics.setPattern(22, 1, 0.5, 1, 1, 1.0, 1.0, 1.0);
	~graphics.setPattern(24, 1, 1.0, 1, 1, 0.5, 0.5, 0.5);
	Tdef('zone', {
		loop({
			var arr;
			arr = Array.fill(3, { [200.0, 0.0].choose });
			~graphics.setViewpoint(arr[0], arr[1], arr[2], 0.0, 0.0, 0.0);
			(~matrix.beatdur * [6, 12, 16].choose).wait;
			if (0.5.coin) {
				~graphics.mapCodePanel;

			}
			{
				~graphics.unmapCodePanel;
			}
		})
	}).play
};


~zone2 = {
	Tdef('zone').clear;
	~graphics.setPattern(22, 0, 0.5, 1, 1, 1.0, 1.0, 1.0);
	~graphics.setPattern(24, 0, 1.0, 1, 1, 0.5, 0.5, 0.5);
	~graphics.setPattern(6, 1, 0.7, 1, 1, 0.1, 0.5, 1.0);
	~graphics.setPattern(5, 1, 1.0, 1, 1, 0.1, 0.5, 1.0);
	~graphics.sendBoidPattern(3, 1, 4);
	~graphics.setViewpoint(0.0, 200.0, 0.0, 0.0, 0.0, 0.0);
	~graphics.hideCodePanel;

};




~zone3 = {
	~graphics.setPattern(1, 1, 1.0, 1, 1, 0.9, 0.1, 1.0);
	~graphics.setPattern(9, 1, 1.0, 1, 1, 0.0, 0.7, 1.0);
	~graphics.sendBoidPattern(3, 1, 4);
	~graphics.setViewpoint(0.0, 200.0, 0.0, 0.0, 0.0, 0.0);
};


~zone4 = {
	~graphics.setPattern(15, 1, 1.0, 1, 1, 0.5, 0.5, 0.5);
	~graphics.setPattern(9, 0, 1.0, 1, 1, 0.0, 0.7, 1.0);
	~graphics.sendBoidPattern(3, 1, 4);
	~graphics.setViewpoint(0.0, 200.0, 0.0, 0.0, 0.0, 0.0);
	~rot = Rotation(-220.0, 0.0, -220.0, 0.0, -270.0, 0.01, 0.0, 0.0);
	~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
	~graphics.rotateCamera;

};

~zone5 = {
	~graphics.setPattern(15, 0, 1.0, 1, 1, 0.5, 0.5, 0.5);
	~graphics.setPattern(1, 0, 1.0, 1, 1, 0.9, 0.1, 1.0);
	~graphics.showCodePanel;
	~graphics.mapCodePanel;
	~graphics.setBoidCam(true, false);
	~graphics.setPattern(39, 1, 1.0, 1, 1, 1.0, 1.0, 1.0);
	~graphics.setPattern(0, 1, 1.0, 1, 1, 0.0, 0.5, 1.0);
	Tdef('zone', {
		loop({
			(~matrix.beatdur * [6, 12, 16].choose).wait;
			if (0.5.coin) {
				~graphics.setBoidCam(true, false);
			}
			{
				~graphics.setBoidCam(false, false);
			}
		})
	}).play


};

~zone6 = {
	~graphics.stopRotation;

	~graphics.setPattern(5, 0, 1.0, 1, 1, 0.1, 0.5, 1.0);
	~graphics.setPattern(39, 0, 1.0, 1, 1, 1.0, 1.0, 1.0);
	~graphics.setPattern(0, 0, 1.0, 1, 1, 0.0, 0.5, 1.0);
	~graphics.sendBoidPattern(3, 0, 4);
	~graphics.setBoidCam(false, false);
	~graphics.hideCodePanel;

	~rot = Rotation(150.0, 0.03, 150.0, 50.0, 0.1, 0.03, 0.1, 0.01);
	~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
	~graphics.rotateCamera;

	~graphics.setPattern(30, 1, 0.3, 1, 1, 0.3, 0.3, 0.3);
	~graphics.sendBoidPattern(0, 1, 0);
};
)
