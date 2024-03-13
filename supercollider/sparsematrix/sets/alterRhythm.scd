Tdef('r0', {
	loop({
		var defs = ['r00', 'r01', 'r02', 'r03'];
		defs.keep(defs.size.rand).do({|def|
			var act = rrand(0.05, 0.2);
			Post << def << ": " << act << Char.nl;
			~matrix.defsAt(def).setControls(
				{ [0, 1].wchoose([1.0 - act, act]) },
				{ exprand(0.4, 0.8) },
				{ exprand(0.05, 0.1) },
				0.1
			);
		});
		"--".postln;
		(~matrix.beatdur * [8, 16].choose).wait;

	})
}).play



Tdef('b0', {
	loop({
		var act, def = ['b10', 'b11'].choose;
		act = rrand(0.1, 0.2);
		Post << def << ": " << act << Char.nl;
		"--".postln;
		~matrix.defsAt(def).setControls(
			{ [0, 1].wchoose([1.0 - act, act]) },
			{ exprand(0.5, 1.0) },
			{ exprand(0.1, 0.2) },
			0.1
		);
		(~matrix.beatdur * [8, 16].choose).wait;
	})
}).play



Tdef('b1', {
	loop({
		var act, def = 'b04';
		act = rrand(0.05, 0.1);
		Post << def << ": " << act << Char.nl;
		~matrix.defsAt(def).setControls(
			{ [0, 1].wchoose([1.0-act, act]) },
			{ exprand(0.4, 0.7) },
			{ exprand(2.0, 4.0) },
			0.1
		);
		(~matrix.beatdur * [16, 32, 48, 64].choose).wait;
	})
}).play



Tdef('b0').clear


~matrix.defsAt('b05').setActives(nil, { rrand(0.1, 0.01) });
~matrix.defsAt('b09').setActives(nil, { rrand(0.1, 0.01) });


~matrix.defsAt('b05').recall(0);
~matrix.defsAt('b10').recall(0);



Server.default.scope(2)

(
~matrix.defsAt('b11').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 0.7) },
	{ exprand(0.1, 0.3) },
	0.1
);

~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 0.9) },
	{ exprand(0.05, 0.3) },
	0.1
);

~matrix.defsAt('r00').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.1, 0.2) },
	0.1
);

~matrix.defsAt('r03').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.1, 0.2) },
	0.1
);

)