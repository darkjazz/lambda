~graphics.open

~matrix.assignCodeWindow(Document.current);

~matrix.setBPM(138)

~matrix.preparePatternDefs;


~matrix.prepareAudio

~graphics.sendCodeTitle("shiny.toys.space")

SynthDef(\mtrxbass, {|out, freq, dur, amp, wbl|
	var sig, swp, env, bf;
	swp = SinOsc.ar(wbl).exprange(40, 500);
	sig = LFSaw.ar(freq*[0.99,1,1.01]).sum;
	sig = LPF.ar(sig, swp);
	sig = Normalizer.ar(sig);
	sig = sig + GVerb.ar(sig,10,0.5,0.7,mul:0.5);
	sig = (sig.distort + tanh(sig**0.8)) * 
		EnvGen.kr(EnvControl.kr, timeScale: dur, doneAction: 2);
	bf = FoaEncode.ar(sig*amp, FoaEncoderMatrix.newStereo);
	Out.ar(out,bf)
}).add


Pdef('matrix', Ppar([  Pdef('r03'), Pdef('r00'), Pdef('r01'), Pdef('r04')])).quant(128)

Pdef('matrix').play

~seconds = SystemClock.seconds;


~matrix.defsAt('b01').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.1, 0.5) },
	{ rrand(0.05, 0.3) }
);

~matrix.defsAt('b02').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ exprand(0.3, 1.0) },
	{ rrand(0.05, 0.3) }
);

~matrix.defsAt('r02').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ exprand(0.3, 1.0) },
	{ rrand(0.05, 0.1) }
);

~matrix.defsAt('r00').setControls(
	{ [0, 1].wchoose([0.5, 0.5]) },
	{ exprand(0.3, 1.0) },
	{ rrand(0.05, 0.2) }
);


~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([0.5, 0.5]) },
	{ rrand(0.1, 0.3) },
	{ rrand(0.01, 0.2) }
);

~matrix.defsAt('r03').setControls(
	{ [0, 1].wchoose([0.6, 0.4]) },
	{ rrand(0.3, 1.0) },
	{ rrand(0.01, 0.1) }
);

~matrix.defsAt('r04').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ rrand(0.3, 1.0) },
	{ rrand(0.01, 0.2) }
);




~graphics.initWorld(20, 20, 20, ~ncoef);

~graphics.initGenerations([4,6,8], [3,5,7,9], 16);

//~graphics.resetWorld(5, 5, 5, 8, 8, 8)

~graphics.setSymmetry(11)

~graphics.showCodePanel

~graphics.setViewpoint(70.0, 65.0, 60.0, 0.0, 0.0, 0.0);


~graphics.sendPredefined3DRule(\brain6)

~graphics.sendPredefined3DRule(\cooties)

~graphics.sendPredefined3DRule(\nova)

~graphics.sendPredefined3DRule(\faders)

~patterns.collect({|patnum|
	[patnum, 0, 1.0, 1.rand, 1.rand, 1.0.rand, 1.0.rand, 1.0.rand] 
})

(
[	
	[5, 0, 0.2, 0, 0, 0.9, 0.1, 0.4],
	[6, 0, 0.5, 1, 1, 0.5, 0.9, 0.8],
	[7, 0, 1.0, 0, 0, 1.0, 1.0, 1.0],
	[8, 0, 0.2, 1, 1, 0.6, 0.7, 0.9],
	[10, 0, 1.0, 0, 0, 0.5, 0.8, 1.0],
	[11, 0, 1.0, 1, 1, 0.0, 0.3, 0.5],
	[12, 0, 0.3, 0, 0, 0.44, 0.32, 0.66],
	[13, 0, 0.7, 0, 0, 0.6, 0.8, 1.0],
	[14, 0, 1.0, 1, 1, 0.0, 0.5, 0.5],
	[15, 0, 1.0,0, 0, 0.0, 0.5, 0.7]
].do({|arglist|
	~graphics.setPattern(*arglist)
})
)

Tdef(\background, {
	loop({
//		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		if (0.66.coin) {
			~graphics.setBackground(*[0.0, 0.1, 0.2].choose.dup(3).round(0.1));
		};
		0.125.wait;
	});	
});

Tdef(\background).play

~graphics.fadeInPattern(11, 10, 1.0)

~graphics.xfadePatterns(12, 1.0, 6, 20)

~graphics.xfadePatterns(9, 1.0, 12, 20)

~graphics.xfadePatterns(14, 1.0, 9, 20)

~graphics.xfadePatterns(8, 1.0, 14, 20)



~graphics.mapCodePanel

~graphics.unmapCodePanel


(5..15).remove(9)

(
Tdef(\autopilot, {
	var actives, max=10, min=5, patterns;
	~graphics.patternLib.select({|pat| pat.active == 1 }).do({|pat|
		pat.active = 0;
		~graphics.sendPattern(pat.index)
	});
	~patterns = (5..15);
	actives = [~patterns.choose];
	~graphics.fadeInPattern(actives.first, 10, 1.0);
	rrand(8.0, 12.0).wait;	
	actives = actives ++ ~patterns.choose;
	~graphics.fadeInPattern(actives.last, 5, 1.0);
	rrand(6.0, 12.0).wait;
	loop({
		var newPattern, remove, time, fade;
		~patterns.collect({|patnum|
			[patnum, 0, 1.0, 2.rand, 2.rand, 1.0.rand, 1.0.rand, 1.0.rand] 
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
			~rot = Rotation(rrand(-60.0, 60.0), rrand(0.01, 0.1), rrand(-20.0, 20.0), 
				rrand(-120.0, 120.0), 
				rrand(-pi, pi), rrand(0.01, 0.1), rrand(-pi, pi), rrand(0.01, 0.1));
			~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
			~graphics.rotateCamera;	
			~graphics.mapCodePanel;		
		};
	})
}).play
)
Tdef(\autopilot).clear

~graphics.patternLib

~rot = Rotation(140.0, 0.09, 60.0, 60.0, 0.0, 0.081, 0.0, 0.073);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera

~graphics.mapCodePanel

"THANK YOU!!! :)"

"THIS IS SHINY TOYS SPACE"

~graphics.unmapCodePanel

~graphics.hideCodePanel

~graphics.showCodePanel


Pdef('matrix', Ppar([Pdef('r00'), Pdef('r03'), Pdef('efx')]))

Pdef('matrix', Ppar([ Pdef('c00'), Pdef('b01'), Pdef('b03'), Pdef('b04')]))

Pdef('matrix', Ppar([ Pdef('c00'), Pdef('r01'), Pdef('b03'), Pdef('b04')]))

Pdef('matrix', Ppar([ Pdef('r01'), Pdef('r02'), Pdef('b02'), Pdef('efx') ]))

Pdef('matrix', Ppar([ Pdef('r02'), Pdef('b00'), Pdef('b03'), Pdef('b04') ]))

Pdef('matrix', Ppar([ Pdef('r00'), Pdef('r01'), Pdef('r02'), Pdef('r03'),Pdef('b03'), Pdef('b04'), Pdef('efx') ]))

Pdef('matrix', Ppar([ Pdef('r00'), pdef Pdef('r03'),Pdef('b03'), Pdef('b04'), Pdef('efx') ]))

Pdef('matrix', Ppar([ Pdef('r00'), Pdef('r03'), Pdef('efx') ]))




Pdef('matrix', Ppar([ Pdef('r00'), Pdef('r02'), Pdef('r03'),Pdef('b03'), Pdef('b04'), Pdef('efx') ]))


~matrix.defsAt('b01').setControls(
	{ [0, 1].wchoose([0.5, 0.5]) },
	{ rrand(0.1, 0.5) },
	{ rrand(0.05, 0.2) }
);


~matrix.patterndefs['r00'].groups[0].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.3, 1.0);
	ctr.dur = exprand(0.01, 0.2)
});

~matrix.patterndefs['r00'].groups[1].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.3, 1.0);
	ctr.dur = exprand(0.01, 0.2)
});

~matrix.patterndefs['r00'].groups[2].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.3, 1.0);
	ctr.dur = exprand(0.01, 0.1)
});

~matrix.patterndefs['r00'].groups[3].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.3, 1.0);
	ctr.dur = exprand(0.01, 0.1)
});

~matrix.patterndefs['r00'].groups[4].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.3, 1.0);
	ctr.dur = exprand(0.01, 0.1)
});

~matrix.patterndefs['r00'].groups[5].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.3, 1.0);
	ctr.dur = exprand(0.01, 0.1)
});

~matrix.patterndefs['r00'].groups[6].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.3, 1.0);
	ctr.dur = exprand(0.01, 0.2)
});

~matrix.patterndefs['r00'].groups[7].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.3, 1.0);
	ctr.dur = exprand(0.01, 0.2)
});


~matrix.defsAt('c00').ctrls['c000'].amp = 0.2;
~matrix.defsAt('c00').ctrls['c000'].active = 1

~matrix.defsAt('c00').ctrls['c001'].amp = 0.4;
~matrix.defsAt('c00').ctrls['c001'].active = 1

~matrix.defsAt('c00').ctrls['c002'].amp = 0.4;
~matrix.defsAt('c00').ctrls['c002'].active = 1

~matrix.defsAt('c00').ctrls['c003'].amp = 0.4;
~matrix.defsAt('c00').ctrls['c003'].active = 1

Pdef('matrix', Ppar([ Pdef('r03'), Pdef('r04') ])).quant(128)



Pdef('matrix', Ppar([ Pdef('r04'), Pdef('r03')])).quant(128)



~matrix.defsAt('r02').setControls(
	{ [0, 1].wchoose([0.3, 0.7]) },
	{ rrand(0.1, 0.7) },
	{ rrand(0.1, 0.3) }
);

~matrix.defsAt('r04').setControls(
	{ [0, 1].wchoose([0.5, 0.5]) },
	{ rrand(0.1, 0.7) },
	{ rrand(0.05, 0.1) }
);

~matrix.defsAt('b01').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ rrand(0.1, 0.7) },
	{ rrand(0.05, 0.3) }
);


~matrix.defsAt('b02').setControls(
	{ [0, 1].wchoose([0.5, 0.5]) },
	{ rrand(0.4, 1.0) },
	{ exprand(0.05, 0.3) }
);

~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ rrand(0.2, 0.6) },
	{ exprand(0.01, 0.1) }
);

~matrix.defsAt('r03').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ rrand(0.4, 1.0) },
	{ exprand(0.05, 0.1) }
);

SynthDef(\mtrxbass, {|out, freq, dur, amp, wbl|
	var sig, swp, env, bf;
	swp = SinOsc.ar(wbl).exprange(40, 1000);
	sig = LFSaw.ar(freq*[0.99,1,1.01]).sum;
	sig = LPF.ar(sig, swp);
	sig = Normalizer.ar(sig);
	sig = sig + GVerb.ar(sig,10,0.5,0.7,mul:0.5);
	sig = (sig.distort + tanh(sig**0.8)) 
		* EnvGen.kr(EnvControl.kr, timeScale: dur, doneAction: 2);
	bf = FoaEncode.ar(sig*amp, FoaEncoderMatrix.newStereo);
	Out.ar(out,bf)
}).add

~freqs = Array.geom(12, 22.midicps, 2**(1/12))[Scale.minor.degrees].scramble

Pdef(\bass, 
	Pbind(
		\instrument, \mtrxbass,
		\target, ~decoder.synth,
		\addAction, \addBefore,
		\out, ~decoder.bus,
		\freq, Pseq([Pshuf(~freqs, 7)], inf),
		\dur, ~matrix.beatdur, 
		\amp, Pseq([0.4, 0.2, 0.3], inf),
		\wbl, Pseq([Pshuf(7.fib, 4)], inf),
		\env, Env([0.001, 0.2, 1.0, 0.001],[0.1, 0.8, 0.1], \exp).bubble
	)
)

Pdef('matrix', Ppar([ Pdef('r03'), Pdef('r05'), Pdef('r06') ]))

Pdef('matrix', Ppar([ Pdef('bass'), Pdef('r03'), Pdef('r06'), Pdef('r04') ])).quant(128)

~matrix.defsAt('b02').setControls(
	{ [0, 1].wchoose([0.4, 0.6]) },
	{ exprand(0.1, 0.5) },
	{ rrand(0.05, 0.3) }
);


~matrix.patterndefs['r00'].groups[1].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.3, 1.0);
	ctr.dur = exprand(0.01, 0.2)
});

~matrix.patterndefs['r00'].groups[2].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.2, 0.7);
	ctr.dur = rrand(0.1, 0.2)
});



~matrix.patterndefs['r00'].groups[2].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 0;
	ctr.amp = rrand(0.2, 0.7);
	ctr.dur = rrand(0.01, 0.1)
});

~matrix.patterndefs['r00'].groups[3].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 0;
	ctr.amp = rrand(0.4, 1.0);
	ctr.dur = rrand(0.01, 0.1)
});

~matrix.patterndefs['r00'].groups[4].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 0;
	ctr.amp = rrand(0.4, 1.0);
	ctr.dur = rrand(0.01, 0.3)
});


~matrix.patterndefs['r00'].groups[5].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 0;
	ctr.amp = rrand(0.4, 1.0);
	ctr.dur = exprand(0.01, 0.3)
});


~matrix.patterndefs['r00'].groups[6].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.4, 1.0);
	ctr.dur = exprand(0.01, 0.2)
});


~matrix.patterndefs['r00'].groups[7].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.4, 1.0);
	ctr.dur = exprand(0.01, 0.2)
});

~matrix.patterndefs['r01'].groups[0].do({|name|
	var ctr = ~matrix.patterndefs['r01'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.4, 1.0);
	ctr.dur = exprand(0.01, 0.2)
});

~matrix.patterndefs['r01'].groups[4].do({|name|
	var ctr = ~matrix.patterndefs['r01'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.4, 1.0);
	ctr.dur = exprand(0.01, 0.2)
});

~matrix.patterndefs['r01'].groups[1].do({|name|
	var ctr = ~matrix.patterndefs['r01'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.4, 1.0);
	ctr.dur = exprand(0.01, 0.2)
});


~matrix.patterndefs['r02'].groups[0].do({|name|
	var ctr = ~matrix.patterndefs['r02'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.4, 1.0);
	ctr.dur = exprand(0.01, 0.2)
});

~matrix.patterndefs['r02'].groups[1].do({|name|
	var ctr = ~matrix.patterndefs['r02'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.4, 1.0);
	ctr.dur = exprand(0.01, 0.2)
});

~matrix.patterndefs['r02'].groups[4].do({|name|
	var ctr = ~matrix.patterndefs['r02'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.4, 1.0);
	ctr.dur = exprand(0.01, 0.2)
});


~matrix.patterndefs['r02'].groups[4].do({|name|
	var ctr = ~matrix.patterndefs['r02'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.4, 1.0);
	ctr.dur = exprand(0.01, 0.2)
});

~matrix.patterndefs['r02'].groups[5].do({|name|
	var ctr = ~matrix.patterndefs['r02'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.4, 1.0);
	ctr.dur = exprand(0.01, 0.2)
});





~matrix.patterndefs['r00'].groups[2].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 0;
	ctr.amp = rrand(0.3, 1.0);
	ctr.dur = rrand(0.01, 0.2)
});

~matrix.patterndefs['r00'].groups[3].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 0;
	ctr.amp = rrand(0.3, 1.0);
	ctr.dur = rrand(0.01, 0.2)
});

~matrix.patterndefs['r00'].groups[4].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 0;
	ctr.amp = rrand(0.3, 1.0);
	ctr.dur = rrand(0.01, 0.2)
});

~matrix.patterndefs['r00'].groups[5].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.3, 1.0);
	ctr.dur = rrand(0.01, 0.2)
});

~matrix.patterndefs['r00'].groups[6].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.3, 1.0);
	ctr.dur = rrand(0.01, 0.2)
});


~matrix.patterndefs['r00'].groups[5].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.3, 1.0);
	ctr.dur = rrand(0.01, 0.2)
});


~matrix.patterndefs['r01'].groups[0].do({|name|
	var ctr = ~matrix.patterndefs['r01'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.3, 1.0);
	ctr.dur = rrand(0.01, 0.2)
});

~matrix.patterndefs['r01'].groups[1].do({|name|
	var ctr = ~matrix.patterndefs['r01'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.3, 1.0);
	ctr.dur = rrand(0.01, 0.2)
});

~matrix.patterndefs['r01'].groups[2].do({|name|
	var ctr = ~matrix.patterndefs['r01'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.3, 1.0);
	ctr.dur = rrand(0.01, 0.2)
});

~matrix.patterndefs['r02'].groups[0].do({|name|
	var ctr = ~matrix.patterndefs['r02'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.3, 1.0);
	ctr.dur = rrand(0.01, 0.2)
});

~matrix.patterndefs['r02'].groups[1].do({|name|
	var ctr = ~matrix.patterndefs['r02'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.3, 1.0);
	ctr.dur = rrand(0.01, 0.3)
});


~matrix.defsAt('b02').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ rrand(0.4, 1.0) },
	{ exprand(0.05, 0.3) }
);

Pdef('matrix', Ppar([ Pdef('r06'), Pdef('r05') ])).quant(128)

/// ---> start here

~matrix.defsAt('r05').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ rrand(0.2, 1.0) },
	{ exprand(0.01, 0.1) }
);


~matrix.defsAt('r04').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ rrand(0.1, 0.9) },
	{ exprand(0.05, 0.2) }
);

~matrix.defsAt('r05').setControls(
	{ [0, 1].wchoose([0.9, 0.1]) },
	{ rrand(0.2, 1.0) },
	{ exprand(0.001, 0.1) }
);

~matrix.defsAt('r06').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ rrand(0.2, 1.0) },
	{ exprand(0.001, 0.1) }
);

~matrix.defsAt('r03').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ rrand(0.5, 1.0) },
	{ exprand(0.005, 0.1) }
)



~matrix.defsAt('r06').recall(0);

~matrix.defsAt('r05').recall(0)

~matrix.defsAt('r04').recall(0)

~matrix.defsAt('r03').recall(0)


~matrix.defsAt('b02').recall(0)


~matrix.defsAt('r00').setControls(
	{ [0, 1].wchoose([0.3, 0.7]) },
	{ rrand(0.2, 1.0) },
	{ rrand(0.05, 0.02) }
)

~matrix.defsAt('r03').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.2, 1.0) },
	{ exprand(0.03, 0.2) }
)


~matrix.defsAt('r00').recall(1);
~matrix.defsAt('r03').recall(0)



~matrix.defsAt('b01').setControls(
	{ [0, 1].wchoose([0.5, 0.5]) },
	{ rrand(0.1, 0.5) },
	{ rrand(0.05, 0.4) }
);


~matrix.defsAt('b03').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ rrand(0.01, 0.6) },
	{ rrand(0.05, 0.01) }
);

~matrix.defsAt('b04').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ rrand(0.1, 0.4) },
	{ rrand(0.05, 0.01) }
);

(
// 019 (cool drive), 018 (bass), 017 (like 018, not as cool), 016 (drive, nice), 015 & 014(dry)
// 013 (dry+drive+a bit lo), 012 (low undulation), 011 (high noise), 010 (async tremble)
~gep00 = '018';
~matrix.playGepSynth(~gep00, ~defnames[~gep00], 0.0, 2, 3, 4)
)

~matrix.gepsynths[~gep00].set('amp', 0.8)

~matrix.gepsynths[~gep00].set('amp', 0.0)


~matrix.freeGepSynth(~gep00)

s.queryAllNodes

(
~gep01 = '019';
~matrix.playGepSynth(~gep01, ~defnames[~gep01], 0.0, 2, 3, 4)
)

~matrix.gepsynths[~gep01].set('amp', 0.4)

~matrix.freeGepSynth(~gep01)


~graphics.showCodePanel

~graphics.hideCodePanel



~matrix.addGepPatternDef('gep00', 'kakilambe', ~defnames[~gep00]);


//////////////// GRAPHICS //////////////////////

~graphics.setPattern(5, 1, 1.0, 1, 1, 0.9, 0.1, 0.4);

~graphics.setPattern(6, 0, 1.0, 0, 0, 0.5, 0.9, 0.8);

~graphics.setPattern(7, 0, 1.0, 0, 0, 1.0, 1.0, 1.0);

~graphics.setPattern(8, 0, 1.0, 1, 1, 0.6, 0.7, 0.9);

~graphics.setPattern(8, 0, 0.2, 1, 1, 0.6, 0.7, 0.9);

~graphics.setPattern(9, 1, 1.0, 1, 1, 0.3, 0.7, 0.9);

~graphics.setPattern(10, 0, 1.0, 0, 0, 0.5, 0.8, 1.0);

~graphics.setPattern(11, 0, 1.0, 0, 0, 0.0, 0.3, 0.5);

~graphics.setPattern(12, 1, 1.0, 1, 1, 0.44, 0.32, 0.66);

~graphics.setPattern(13, 0, 0.7, 0, 0, 0.6, 0.8, 1.0);

~graphics.setPattern(14, 0, 1.0, 1, 1, 0.0, 0.5, 0.5);

~graphics.setPattern(15, 0, 1.0,0, 0, 0.0, 0.5, 0.7);

SATOSHI!!!!

~rot = Rotation(40.0, 0.01, 20.0, 100.0, 0.0, 0.02, 0.0, 0.02);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera

~graphics.stopRotation

Server.killAll
////////// SKISM PATCHES /////////////////


~matrix.activateSkismSynth('granularReverb')

~matrix.setSkismAmp('granularReverb', 0.2)

~matrix.deactivateSkismSynth('granularReverb')


~matrix.activateSkismSynth('flangingDecimator')

~matrix.setSkismAmp('flangingDecimator', 0.2)

~matrix.deactivateSkismSynth('flangingDecimator')


~matrix.activateSkismSynth('neuralFilter')

~matrix.setSkismAmp('neuralFilter', 0.1)

~matrix.deactivateSkismSynth('neuralFilter')


~matrix.activateSkismSynth('feedbackSpectrum')

~matrix.setSkismAmp('feedbackSpectrum', 0.1)

~matrix.deactivateSkismSynth('feedbackSpectrum')


~matrix.activateSkismSynth('cyclicWarp')

~matrix.setSkismAmp('cyclicWarp', 0.1)

~matrix.deactivateSkismSynth('cyclicWarp')


~matrix.activateSkismSynth('latchOnset')

~matrix.setSkismAmp('latchOnset',0.0)

~matrix.deactivateSkismSynth('latchOnset')


~matrix.activateSkismSynth('cliqSaw')

~matrix.setSkismAmp('cliqSaw', 0.5)

~matrix.deactivateSkismSynth('cliqSaw')


~matrix.activateSkismSynth('fxGrain')

~matrix.setSkismAmp('fxGrain', 0.4)

~matrix.deactivateSkismSynth('fxGrain')


~matrix.activateSkismSynth('arhythmicGendy')

~matrix.setSkismAmp('arhythmicGendy', 0.2)

~matrix.deactivateSkismSynth('arhythmicGendy')


////////// EFX ///////////////


~matrix.efxamps['rev00'] = 0.2
~matrix.efxamps['rev01'] = 0.1
~matrix.efxamps['del00'] = 0.1
~matrix.efxamps['del01'] = 0.1

SystemClock.seconds - ~seconds / 60


Pdef('matrix').stop

~matrix.quit(false)

~graphics.hideCodePanel

s.queryAllNodes


(
~def00 = '000_000';
~genetic.play(~def00, 8.0, 4.0, 7.0);
~genetic.fade(~def00, 0.0, 0.2, 10)
)

~genetic.fade(~def00, 0.4, 0.0, 20)

~genetic.set(~def00, 0.5)

~genetic.free(~def00)

s.queryAllNodes


(
~def02 = '000_001';
~genetic.play(~def02, 8.0, 4.0, 7.0);
~genetic.fade(~def02, 0.0, 0.2, 8)
)

~genetic.fade(~def02, 0.2, 0.0, 15)

~genetic.set(~def02, 0.3)

~genetic.free(~def02)


s.queryAllNodes


(
~def03 = '000_002';
~genetic.play(~def03, 3.0, 1.5, 4.0);
~genetic.fade(~def03, 0.0, 0.4, 10)
)

~genetic.fade(~def03, 0.4, 0.0, 20)

~genetic.set(~def03, 0.1)

~genetic.free(~def03)


s.queryAllNodes


(
~def04 = '000_004';
~genetic.play(~def04, 2.0, 5.0, 4.0);
~genetic.fade(~def04, 0.0, 0.4, 8)
)

~genetic.fade(~def04, 0.4, 0.0, 1)

~genetic.set(~def04, 0.5)

~genetic.free(~def04)

s.stopRecording

s.queryAllNodes


(
~def05 = '000_051';
~genetic.play(~def05, 2.0, 5.0, 4.0);
~genetic.fade(~def05, 0.0, 0.3, 8)
)

~genetic.fade(~def05, 0.3, 0.0, 10)

~genetic.set(~def05, 0.0)

~genetic.free(~def05)

