(
Tdef('rec', {
	~file = File.open("/Users/alo/dev/lambda/supercollider/evp/buffering.txt", "r");
	~txt = ~file.readAllString;
	~file.close;
	~txt.do({|char, i|
		if (char.isFileSafe.not) { ~txt[i] = Char.space }
	});
	~graphics = CinderApp(1024, 768);
	1.wait;
	~graphics.open;
	2.wait;
	~graphics.initWorld(24, 24, 24, 20);
	0.2.wait;
	~graphics.initGenerations([4,6],[4,6],24);
	0.2.wait;
	~graphics.setSymmetry(11);
	0.2.wait;
	~graphics.setViewpoint(0.0, 100.0, 80.0, 0.0, 0.0, 0.0);
	0.2.wait;
	~graphics.sendCodeTitle("buffering.......");
	0.2.wait;
	~graphics.sendCodeLine(String.fill(140, Char.space));
	0.2.wait;
	~graphics.hideCodePanel;
	0.2.wait;
	Tdef(\sendVector, {
		loop({
			~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
			[ 0.0625, 0.125, 0.25].choose.wait;
		});
	});
	Tdef(\sendVector).play;
	10.wait;
	Tdef('pat', {
		var on, act, ind;
		~pats = [16, 18, 20, 24, 25, 34];
		~patches = (
			16: [0.4, 1, 1, 0.1, 0.6, 0.7],
			18: [0.5, 1, 1, 0.0, 1.0, 1.0],
			20: [0.2, 1, 1, 0.0, 0.3, 0.5],
			24: [0.5, 1, 1, 0.5, 0.6, 0.7],
			25: [0.4, 0, 0, 0.5, 0.6, 0.7],
			34: [0.3, 1, 1, 1.0, 0.0, 0.5]
		);
		act = [16];
		~graphics.setPattern(25, 1, 0.3, 1, 1, 0.5, 0.6, 0.7);
		60.wait;
		loop({
			if (act.size > 4) {
				ind = act.remove(act.choose);
				~graphics.setPattern(ind, 0, 0.3, );
			};
			ind = ~pats.choose;
			if (act.size == 0) { on = 1 } { on = 2.rand } ;
			~graphics.setPattern(ind, on, *~patches[ind]);
			rrand(5, 10).wait;
		});
	}).play;

	60.wait;
	20.do({
		var str;
		str = "";
		rrand(4, 16).do({
			6.do({ str = str ++ [rrand(48, 56),  rrand(65, 70)].choose.asAscii });
			str = str ++ " ";
		});
		~graphics.sendCodeLine([str, "      "].choose);
	});
	Tdef('sendcode', {
		loop({
			var str;
			str = "";
			rrand(4, 16).do({
				6.do({ str = str ++ [rrand(48, 56),  rrand(65, 70)].choose.asAscii });
				str = str ++ " ";
			});
			~graphics.sendCodeLine(str);
			rrand(1.0, 3.0).wait
		})
	}).play;
	~graphics.showCodePanel;
	~graphics.mapCodePanel;
	Tdef('send', {
		loop({
			var txt = [~txt.drop(rrand(0, 2000)).keep(rrand(60, 140)), "     "].wchoose([0.4, 0.6]);
			txt.postln;
			~graphics.sendCodeLine(txt);
			rrand(1.0, 4.0).wait
		})
	}).play;

	120.wait;

	Tdef('view', {
		loop({
			var txt;
			~graphics.setViewpoint(0.0, rrand(60.0, 120.0), rrand(60.0, 120.0), 0.0, 0.0, 0.0);
			txt = "~graphics.setViewpoint(0.0, " ++ rrand(40.0, 150.0).round(0.1).asString ++ ", " ++
			rrand(40.0, 150.0).round(0.1).asString ++ ", 0.0, 0.0, 0.0);";
			if (0.1.coin) { ~graphics.sendCodeLine(txt) };
			rrand(0.1, 0.4).wait
		})
	}).play;

	120.wait;

	Tdef('view').clear;
	~graphics.setViewpoint(0.0, 100.0, 80.0, 0.0, 0.0, 0.0);

	120.wait;

	Tdef('pat').clear;
	~pats.do({|ind|
		~graphics.setPattern(ind, 0, *~patches[ind]);
	});
	~graphics.setPattern(25, 1, 0.3, 1, 1, 0.5, 0.6, 0.7);
}).play
)