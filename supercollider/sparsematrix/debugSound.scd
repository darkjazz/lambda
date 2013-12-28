~ncoef = 20;
~mode = 0;
~decoder = FoaDecoder(decoderType:'stereo');
~graphics = CinderApp(800, 600, mode: ~mode);

~matrix = SparseMatrix(~decoder, ~graphics, 2, ~ncoef);

~matrix.setBPM(135)

~matrix.preparePatternDefs;

~matrix.prepareAudio

Pdef('matrix').play

Pdef('matrix').stop

Pdef('matrix', Ppar([Pdef('r00')])).quant(128)

~matrix.patterndefs['r00'].groups.first.do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 1;
	ctr.amp = rrand(0.2, 0.7);
	ctr.dur = rrand(0.007, 0.07)
});

~matrix.patterndefs['r00'].groups[1].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 0;
	ctr.amp = 0.3;
	ctr.dur = rrand(0.01, 0.1)
})

~matrix.patterndefs['r00'].groups[2].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 0;
	ctr.amp = 0.3;
	ctr.dur = rrand(0.01, 0.1)
})

~matrix.patterndefs['r00'].groups[3].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 0;
	ctr.amp = 0.6;
	ctr.dur = rrand(0.1, 0.2)
})

~matrix.patterndefs['r00'].groups[4].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.3, 0.7);
	ctr.dur = rrand(0.05, 0.2)
})

~matrix.patterndefs['r00'].groups[5].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.3, 0.7);
	ctr.dur = rrand(0.05, 0.2)
})

~matrix.patterndefs['r00'].groups[6].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.3, 0.7);
	ctr.dur = rrand(0.05, 0.2)
})

~matrix.patterndefs['r00'].groups[7].do({|name|
	var ctr = ~matrix.patterndefs['r00'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.3, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})



~matrix.patterndefs['r01'].groups[0].do({|name|
	var ctr = ~matrix.patterndefs['r01'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.3, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})

~matrix.patterndefs['r01'].groups[1].do({|name|
	var ctr = ~matrix.patterndefs['r01'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.3, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})

~matrix.patterndefs['r01'].groups[2].do({|name|
	var ctr = ~matrix.patterndefs['r01'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.3, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})

~matrix.patterndefs['r01'].groups[3].do({|name|
	var ctr = ~matrix.patterndefs['r01'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.3, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})

~matrix.patterndefs['r01'].groups[4].do({|name|
	var ctr = ~matrix.patterndefs['r01'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.3, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})

~matrix.patterndefs['r01'].groups[5].do({|name|
	var ctr = ~matrix.patterndefs['r01'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.3, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})

~matrix.patterndefs['r01'].groups[6].do({|name|
	var ctr = ~matrix.patterndefs['r01'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.3, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})

~matrix.patterndefs['r01'].groups[7].do({|name|
	var ctr = ~matrix.patterndefs['r01'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.3, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})


~matrix.patterndefs['r02'].groups[0].do({|name|
	var ctr = ~matrix.patterndefs['r02'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.3, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})

~matrix.patterndefs['r02'].groups[1].do({|name|
	var ctr = ~matrix.patterndefs['r02'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.3, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})

~matrix.patterndefs['r02'].groups[2].do({|name|
	var ctr = ~matrix.patterndefs['r02'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.3, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})

~matrix.patterndefs['r02'].groups[3].do({|name|
	var ctr = ~matrix.patterndefs['r02'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.3, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})

~matrix.patterndefs['r02'].groups[4].do({|name|
	var ctr = ~matrix.patterndefs['r02'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.1, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})


~matrix.patterndefs['r02'].groups[5].do({|name|
	var ctr = ~matrix.patterndefs['r02'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.1, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})





~matrix.patterndefs['r03'].groups[0].do({|name|
	var ctr = ~matrix.patterndefs['r03'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.1, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})

~matrix.patterndefs['r03'].groups[1].do({|name|
	var ctr = ~matrix.patterndefs['r03'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.1, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})

~matrix.patterndefs['r03'].groups[2].do({|name|
	var ctr = ~matrix.patterndefs['r03'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.1, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})

~matrix.patterndefs['r03'].groups[3].do({|name|
	var ctr = ~matrix.patterndefs['r03'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.1, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})


~matrix.patterndefs['r03'].groups[4].do({|name|
	var ctr = ~matrix.patterndefs['r03'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.1, 1.0);
	ctr.dur = rrand(0.05, 0.2)
});

Pdef('matrix', Ppar([Pdef('r06'), Pdef('r05')])).quant(128)


~matrix.patterndefs['r04'].groups[0].do({|name|
	var ctr = ~matrix.patterndefs['r04'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.1, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})

~matrix.patterndefs['r04'].groups[1].do({|name|
	var ctr = ~matrix.patterndefs['r04'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.1, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})

~matrix.patterndefs['r04'].groups[2].do({|name|
	var ctr = ~matrix.patterndefs['r04'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.1, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})

~matrix.patterndefs['r04'].groups[3].do({|name|
	var ctr = ~matrix.patterndefs['r04'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.1, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})

~matrix.patterndefs['r04'].groups[4].do({|name|
	var ctr = ~matrix.patterndefs['r04'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.1, 1.0);
	ctr.dur = rrand(0.05, 0.01)
})

~matrix.patterndefs['r04'].groups[5].do({|name|
	var ctr = ~matrix.patterndefs['r04'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.1, 1.0);
	ctr.dur = rrand(0.05, 0.01)
})

~matrix.patterndefs['r04'].groups[6].do({|name|
	var ctr = ~matrix.patterndefs['r04'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.1, 1.0);
	ctr.dur = rrand(0.05, 0.01)
})

~matrix.patterndefs['r04'].groups[7].do({|name|
	var ctr = ~matrix.patterndefs['r04'].ctrls[name];
	ctr.active = 0;
	ctr.amp = exprand(0.1, 1.0);
	ctr.dur = rrand(0.05, 0.01)
})


~matrix.patterndefs['r05'].groups[0].do({|name|
	var ctr = ~matrix.patterndefs['r05'].ctrls[name];
	ctr.active = 1;
	ctr.amp = exprand(0.1, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})

~matrix.patterndefs['r05'].groups[1].do({|name|
	var ctr = ~matrix.patterndefs['r05'].ctrls[name];
	ctr.active = 1;
	ctr.amp = exprand(0.1, 1.0);
	ctr.dur = rrand(0.01, 0.1)
})

~matrix.patterndefs['r05'].groups[2].do({|name|
	var ctr = ~matrix.patterndefs['r05'].ctrls[name];
	ctr.active = 1;
	ctr.amp = exprand(0.1, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})

~matrix.patterndefs['r05'].groups[3].do({|name|
	var ctr = ~matrix.patterndefs['r05'].ctrls[name];
	ctr.active = 1;
	ctr.amp = exprand(0.1, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})

~matrix.patterndefs['r05'].groups[4].do({|name|
	var ctr = ~matrix.patterndefs['r05'].ctrls[name];
	ctr.active = 1;
	ctr.amp = exprand(0.1, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})

~matrix.patterndefs['r05'].groups[5].do({|name|
	var ctr = ~matrix.patterndefs['r05'].ctrls[name];
	ctr.active = 1;
	ctr.amp = exprand(0.1, 1.0);
	ctr.dur = rrand(0.05, 0.1)
})

~matrix.patterndefs['r05'].groups[6].do({|name|
	var ctr = ~matrix.patterndefs['r05'].ctrls[name];
	ctr.active = 1;
	ctr.amp = exprand(0.1, 1.0);
	ctr.dur = rrand(0.05, 0.1)
})

~matrix.patterndefs['r05'].groups[7].do({|name|
	var ctr = ~matrix.patterndefs['r05'].ctrls[name];
	ctr.active = 1;
	ctr.amp = exprand(0.1, 1.0);
	ctr.dur = rrand(0.05, 0.1)
})

~matrix.patterndefs['r05'].ctrls.keys(Array).do({|name|
	~matrix.patterndefs['r05'].ctrls[name].active = 0;
	
})


~matrix.patterndefs['r06'].groups[0].do({|name|
	var ctr = ~matrix.patterndefs['r06'].ctrls[name];
	ctr.active = 1;
	ctr.amp = exprand(0.1, 1.0);
	ctr.dur = rrand(0.05, 0.1)
})

~matrix.patterndefs['r06'].groups[1].do({|name|
	var ctr = ~matrix.patterndefs['r06'].ctrls[name];
	ctr.active = 1;
	ctr.amp = exprand(0.1, 1.0);
	ctr.dur = rrand(0.05, 0.2)
});

~matrix.patterndefs['r06'].groups[2].do({|name|
	var ctr = ~matrix.patterndefs['r06'].ctrls[name];
	ctr.active = 1;
	ctr.amp = exprand(0.1, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})

~matrix.patterndefs['r06'].groups[3].do({|name|
	var ctr = ~matrix.patterndefs['r06'].ctrls[name];
	ctr.active = 1;
	ctr.amp = exprand(0.1, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})

~matrix.patterndefs['r06'].groups[4].do({|name|
	var ctr = ~matrix.patterndefs['r06'].ctrls[name];
	ctr.active = 1;
	ctr.amp = exprand(0.1, 1.0);
	ctr.dur = rrand(0.05, 0.2)
})

~matrix.patterndefs['r06'].ctrls.keys(Array).do({|name|
	~matrix.patterndefs['r06'].ctrls[name].dur = rrand(0.005, 0.01);
})

~matrix.patterndefs['r06'].ctrls.keys(Array).do({|name|
	~matrix.patterndefs['r06'].ctrls[name].active = 0;
})



~ctrl = ~matrix.patterndefs['r00'].ctrls['r005']

~ctrl = ~matrix.patterndefs['r00'].ctrls.keys(Array).sort

~ctrl.active = 0;
~ctrl.amp = 1.0
~ctrl.dur = 0.2