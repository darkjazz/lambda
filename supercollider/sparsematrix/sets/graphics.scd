~graphics = CinderApp(1024, 768)

~graphics.open

~graphics.initWorld(20, 20, 20, 20);
~graphics.initWorld(24, 24, 24, 20);

~graphics.initGenerations([4,6], [3,5], 8);

~graphics.setSymmetry(11)

~graphics.setViewpoint(-150.0, 0.0, 0.0, 0.0, 0.0, 0.0)

~graphics.setPattern(0, 0, 0.4, 0, 0, 0.0, 1.0, 1.0);

~graphics.setPattern(1, 0, 1.0, 0, 0, 0.5, 1.0, 1.0);

~graphics.setPattern(2, 0, 1.0, 1, 1, 1.0, 0.2, 0.7);


~graphics.setPattern(3, 0, 1.0, 1, 0, 0.6, 0.8, 0.8);

~graphics.setPattern(4, 0, 1.0, 1, 0, 1.0, 0.3, 1.0);


~graphics.setPattern(5, 0, 1.0, 1, 1, 0.5, 1.0, 1.0);
~graphics.setPattern(5, 1, 1.0, 1, 1, 0.9, 1.0, 0.0);

~graphics.setPattern(6, 0, 0.7, 1, 1, 0.5, 0.9, 0.8);

~graphics.setPattern(7, 0, 1.0, 1, 0, 1.0, 0.3, 0.5);

~graphics.setPattern(8, 1, 1.0, 1, 1, 0.6, 0.7, 0.9);

~graphics.setPattern(9, 0, 0.5, 1, 1, 0.5, 0.8, 0.9);

~graphics.setPattern(10, 0, 0.3, 1, 1, 0.5, 0.8, 1.0);

~graphics.setPattern(11, 0, 1.0, 0, 1, 0.0, 0.3, 0.5);

~graphics.setPattern(12, 0, 1.0, 1, 1, 0.6, 0.8, 1.0);

~graphics.setPattern(13, 0, 1.0, 1, 1, 0.0, 0.6, 1.0);

~graphics.setPattern(14, 1, 1.0, 1, 1, 0.0, 0.5, 0.5);
~graphics.setPattern(14, 0, 1.0, 0, 0, 0.0, 0.5, 0.5);

~graphics.setPattern(15, 0, 0.4, 0, 0, 0.1, 0.7, 0.3);


~graphics.setPattern(16, 0, 1.0, 1, 1, 0.1, 0.7, 0.3);
~graphics.setPattern(17, 0, 1.0, 0, 0, 0.8, 0.8, 0.8);
~graphics.setPattern(18, 0, 1.0, 0, 0, 1.0, 1.0, 0.0);


~graphics.setPattern(19, 1, 0.6, 1, 1, 0.8, 0.6, 0.7);

~graphics.setPattern(20, 1, 1.0, 0, 0, 1.0, 0.6, 0.2);

~graphics.setPattern(21, 0, 0.6, 1, 1, 0.5, 0.6, 0.7);

~graphics.setPattern(22, 1, 1.0, 0, 0, 1.0, 0.9, 1.0);

~graphics.setPattern(23, 0, 0.6, 1, 1, 0.5, 0.6, 0.7);

~graphics.setPattern(24, 1, 0.6, 1, 1, 0.5, 0.6, 0.7);

~graphics.setPattern(25, 1, 1.0, 1, 1, 0.5, 0.6, 0.7);


~graphics.setPattern(26, 0, 0.2, 1, 1, 0.5, 0.6, 0.7);

~graphics.setPattern(27, 0, 1.0, 1, 1, 0.1, 0.6, 0.5);

~graphics.setPattern(28, 0, 1.0, 0, 0, 0.8, 1.0, 0.8);

~graphics.setPattern(29, 0, 1.0, 0, 0, 0.6, 0.9, 1.0);
~graphics.setPattern(29, 1, 0.3, 0, 0, 0.0, 0.8, 1.0);

~graphics.setPattern(30, 0, 1.0, 0, 0, 0.7, 0.8, 1.0);

~graphics.setPattern(31, 1, 1.0, 0, 0, 0.5, 0.3, 1.0);
~graphics.setPattern(31, 1, 0.5, 1, 1, 0.3, 0.9, 0.9);

~graphics.setPattern(32, 0, 0.08, 0, 0, 0.9, 0.9, 0.3);

~graphics.setPattern(33, 0, 0.1, 0, 1, 0.3, 0.6, 0.8);

~graphics.setPattern(34, 0, 0.3, 1, 1, 1.0, 0.2, 0.5);


~rot = Rotation(-120.0, 0.0, -120.0, 0.0, 0.0, -0.02, 0.0, 0.0);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera

~graphics.stopRotation


~graphics.sendPredefined3DRule(\faders)

~graphics.sendPredefined3DRule(\cooties)

~graphics.sendPredefined3DRule(\nova)

~graphics.sendPredefined3DRule(\xtasy)

~graphics.sendPredefined3DRule(\flamingstarbow)


\flamingstarbow, \chenille, \belzhab, \glissergy,
\cooties, \faders, \frozenspirals, \glisserati,
\nova, \orthogo, \rainzha, \rake, \sedimental,
\snake, \starwars, \sticks, \thrillgrill,
\transers, \wanderers, \worms, \xtasy

~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );


Tdef(\sendVector, {
	loop({
		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		[0.75, 0.5, 0.5].choose.wait;
	});
});

Tdef(\sendVector).play

Tdef(\sendVector).stop


~graphics.showCodePanel

~graphics.hideCodePanel

~graphics.unmapCodePanel







(

Tdef(\autopilot, {
	var actives, max=10, min=5, patterns;
	~graphics.patternLib.select({|pat| pat.active == 1 }).do({|pat|
		pat.active = 0;
		~graphics.sendPattern(pat.index)
	});
	~patterns = (5..15) ++ (26..31);
	actives = [~patterns.choose];
	~graphics.fadeInPattern(actives.first, 10, 1.0);
	rrand(8.0, 12.0).wait;
	actives = actives ++ ~patterns.choose;
	~graphics.fadeInPattern(actives.last, 5, 1.0);
	rrand(6.0, 12.0).wait;
	loop({
		var newPattern, remove, time, fade;
		~patterns.collect({|patnum|
			var pole, active;
			pole = 2.rand;
			active = actives.includes(patnum).asInt;
			[patnum, active, 1.0, pole, pole, 1.0.rand, 1.0.rand, 1.0.rand]
		}).do({|arglist|
			~graphics.setPattern(*arglist)
		});
		fade = rrand(2, 5);
		time = rrand(5, 15);
		newPattern = ~patterns.reject({|pnum| actives.includes(pnum) }).choose;
		remove = actives.remove(actives.choose);
		~graphics.xfadePatterns(newPattern, 1.0, remove, fade);
		(fade + time).wait;
		actives = actives ++ newPattern;
		~graphics.sendPredefined3DRule(
			[
			\flamingstarbow, \chenille, \belzhab, \glissergy,
			\cooties, \faders, \frozenspirals, \glisserati,
			\nova, \orthogo, \rainzha, \rake, \sedimental,
			\snake, \starwars, \sticks, \thrillgrill,
			\transers, \wanderers, \worms, \xtasy
			].choose;
		);
		if (0.3.coin) {
			~graphics.stopRotation;
			~graphics.setViewpoint(
				rrand(30.0, 60.0)*[1.0,-1.0].choose,
				rrand(30.0, 60.0)*[1.0,-1.0].choose,
				rrand(30.0, 60.0)*[1.0,-1.0].choose,
				0.0, 0.0, 0.0
			);
			~graphics.unmapCodePanel;
		}{
			~rot = Rotation(rrand(-60.0, 60.0), rrand(0.005, 0.05), rrand(-20.0, 20.0),
				rrand(-120.0, 120.0),
				rrand(-pi, pi), rrand(0.01, 0.08), rrand(-pi, pi), rrand(0.01, 0.07));
			~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
			~graphics.rotateCamera;
			~graphics.mapCodePanel;
		};
	})
}).play
)

Tdef(\autopilot).stop

