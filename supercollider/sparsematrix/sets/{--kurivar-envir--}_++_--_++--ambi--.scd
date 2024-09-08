(
~rdefs = ( {|i| ("r" ++ i.asString.padLeft(2, "0")).asSymbol } ! 18 );
~bdefs = ( {|i| ("b" ++ i.asString.padLeft(2, "0")).asSymbol } ! 18 );
~ddefs = ( {|i| ("d" ++ i.asString.padLeft(2, "0")).asSymbol } ! 16 );
~mdefs = (0..3).collect({|i| ("m0" ++ i.asString).asSymbol });

~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2,
	screenX: 1024, screenY: 768, mode: 1, decoderType: 'hoa',
	localDecoder: true, ambiOrder: 3,
	decoderFilePath: (Paths.matrixDir +/+ "sets" +/+ "smcTHSC.json"),
	bpm: 119, channels: 2, foa: #[zoom,push], dbname: "ges_ld_00",
	patdefs: "patternDefsMesa.scd",
	initPdefs: ~rdefs ++ ~bdefs ++ ~ddefs ++ ~mdefs, worldDim: 21, ip: "127.0.0.1"
);
e = SpEnvir(~settings)

)




~decoder.channelCheck(0, 1, 0.5)
~decoder.runChannelCheck((0..11) ++ 15, 1.0, 0.6)

~decoder.synth.set(\subamp, 1.0)



s.queryAllNodes

Tdef(\channelcheck).stop

FoaDecoder

s.scope(2)
~matrix.decoder.numChannels


Server.killAll

PanAmbi3O
e.setPat('r12', 1.0, [0.5, 0.7], [0.05, 0.1], 0.0);



Pdef('r12').play



SparseMatrix


(
[ 'r08', 'r09', 'r10', 'r11', 'r15', 'r16', 'r17' ].do({|name|
	var pat = e.getPat(name);
	e.setPat(name, 0.0, [0.7, 0.7], [0.1, 0.1], 0.1);
	pat.ctrls.keysValuesDo({|key, ctrl|
		var on = pat.patterns[key].select(_.odd).size;
		ctrl.dur = 0.3 / on;
		ctrl.amp = ctrl.dur.linlin(0, 1, 0.5, 0.0);
		// key.post; "  ".post; ctrl.dur.postln;
		// ctrl.dur.linlin(0, 1, 0.5, 0.0).postln
	})

})
)




(
~ind = 2;
~buf = ~kvbufs.loops[~kvbufs[~ind]];
~lbpm = ~kvbufs.loops[~kvbufs[~ind].path.basename.asSymbol].bpm;
)

~loops = ~kvbufs.search(~lbpm, 0.05).do(_.postln)

~matrix.setBPM(~lbpm)

~matrix.setBPM(123)

~matrix.beatfuncs


~loops.collect({|loop| (
	'index': loop.index,
	'name': ~kvbufs[loop['index']].path.basename,
	'dur': ~kvbufs[loop['index']].duration
)
}).do(_.postln)


~matrix.addBeatfunc('beat', {

})

Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', 0.5, 'emp', 0.0, 'buf', ~matrix.buffers['evo'][19], 'dur', 0.5, 'env', Env.perc] );

})

Tdef('downbeat', {
	loop({
		Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', 3, 'emp', 0.0, 'buf', ~matrix.buffers['evo'][9], 'dur', 0.3, 'env', Env.perc] );
		(119 / 60).reciprocal.wait;

	})
}).play

Tdef('downbeat').clear

146.34146341463*0.95348837209302

~matrix.onsetFunc = {
	// if (~beaton.not) {
	// 	Tdef('downbeat', {
	// 		loop({
	// 			Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', 3, 'emp', 0.0, 'buf', ~matrix.buffers['evo'][9], 'dur', 0.3, 'env', Env.perc] );
	// 			(119 / 60).reciprocal.wait;
	//
	// 		})
	// 	}).play;
	// 	~beaton = true;
	// }
}

~beaton = false

s.queryAllNodes

x.free

e.setPwarp('w0', a, ~matrix.beatdur / 2)







SparseMatrix.patterns12

['Yanvalou'][(1..6)].flat.keep(64)

e.setWarp('w0', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.0, 'iamp', 1, 'ramp', 0, 'rate', 0.5, 'freq', 1.0])

(
~ind = 7;
~buf = ~kvbufs[~ind];
~lbpm = ~kvbufs.loops[~buf.path.basename.asSymbol].bpm;
~rate = ~bpm / ~lbpm;
Post << "rate: " << ~rate << Char.nl;
e.setWarp('w0', ['buf', ~buf, 'rate', ~rate])
)


// 85, 86 intermitttent

// 96 bass + loop + microbeats

// 101, 110

// 111 high cliqs

// 146 sparse + 147

e.setPwarp('w0', a, ~matrix.beatdur/2)


e.freeWarp('w0')

Pdef(~rdefs[8]).play


Pdef('mx0',
	Ppar(~rdefs.drop(8).collect({|nm| Pdef(nm) }))
).play


Pdef('mx1',
	Ppar(~rdefs.keep(8).collect({|nm| Pdef(nm) }))
).play


Pdef('r12').play

Pdef('r09').isPlaying

e.setPat('r12', 0.4, [0.4, 0.6], [0.1, 0.3], 0.0);



(
e.setPat('r00', 0.0, [0.5, 0.5], [0.01, 0.05], 0.0);
e.setPat('r01', 0.1, [0.5, 0.5], [0.01, 0.4], 0.0);
e.setPat('r02', 0.1, [0.4, 0.7], [0.01, 0.2], 0.0);
e.setPat('r03', 0.1, [0.4, 0.7], [0.01, 0.2], 0.0);

e.setPat('r05', 0.1, [0.4, 0.7], [0.02, 0.04], 0.0);

)



Pdef('mx2',
	Ppar(['b05', 'b06', 'b07'].collect({|nm| Pdef(nm) }))
).play




e.getPat('r09').ctrls.select({|ctr| ctr.active.booleanValue.not }).do({|ctr| ctr.postln })

	.patterns.values()

(
[ 'r08', 'r09', 'r10', 'r11', 'r15', 'r16', 'r17' ].do({|name|
	var pat = e.getPat(name);
	e.setPat(name, 0.0, [0.7, 0.7], [0.1, 0.1], 0.1);
	pat.ctrls.keysValuesDo({|key, ctrl|
		var on = pat.patterns[key].select(_.odd).size;
		ctrl.dur = 0.3 / on
	})

})
)

~matrix.decoder.type

(
e.setPat('r08', 0.0, [0.5, 0.5], nil, 0.0);
e.setPat('r09', 0.0, [0.5, 0.5], nil, 0.0);
e.setPat('r10', 0.0, [0.7, 0.7], nil, 0.0);
e.setPat('r11', 0.0, [0.7, 0.7], nil, 0.0);
)


(
e.setPat('r12', 0.0, [0.7, 1.0], [0.05, 0.2], 0.1);
e.setPat('r13', 0.0, [0.4, 0.7], [0.05, 0.2], 0.1);
e.setPat('r14', 0.0, [0.4, 0.7], [0.01, 0.2], 0.1);
)


(
e.setPat('r15', 0.0, [0.5, 0.5], nil, 0.1);
e.setPat('r16', 0.0, [0.5, 0.5], nil, 0.1);
e.setPat('r17', 0.0, [0.5, 0.5], nil, 0.1);
)


s.scope(2)


~kvbufs.search(222.222222222, 0.05).do(_.postln)

~kvbufs.search(78.95, 0.05).do(_.postln)


SparseMatrix.patternsDub.keysValuesDo({|key, val|
	Post << key << ": " << val.size << Char.nl
})


SparseMatrix.patternsDnB.keys(Array).sort().do({|key|
	Post << key << ": " << SparseMatrix.patternsDnB[key].size << Char.nl
})


Pseq(([0.1, 0.4, 0.1, 0.4, 0.2, 0.3, 0.1, 0.3] ++ (0 ! 24))*4, inf)
Pseq(((0 ! 16) ++ [0.1, 0.4, 0.1, 0.4, 0.2, 0.3, 0.1, 0.3] ++ (0 ! 8))*4, inf)
Pseq(((0 ! 8) ++ [0.1, 0.4, 0.1, 0.4, 0.2, 0.3, 0.1, 0.3] ++ (0 ! 16))*4, inf)
Pseq(((0 ! 24) ++ [0.1, 0.4, 0.1, 0.4, 0.2, 0.3, 0.1, 0.3])*4, inf)


/* BASS: 18 bpm 115 | 25 120 (superlo)


( 'rate': 0.9975, 'bpm': 133, 'index': 132 )
( 'rate': 0.95316666666667, 'bpm': 133, 'index': 150 )
( 'rate': 0.9975, 'bpm': 133, 'index': 13 )
( 'rate': 0.97533333333333, 'bpm': 133, 'index': 47 )
( 'rate': 0.9975, 'bpm': 133, 'index': 139 )
( 'rate': 0.9975, 'bpm': 133, 'index': 127 )
*/
123/120

// LOOPS: 90

// track buf 12 bpm 76.5 | buf 16, rate 0.944 | ?? buf 19 rate 1.02, ramp > iamp



// improv bpm 123 - 18: rate 1.069 | 20 rate 1.066 w/ rarp | 22 rate 1.066 | 23 rate 1.025


// bpm 109.09: 21, 24 | 26 rate 0.945



(
~ind = 2;
e.setWarp('w0', ['buf', ~kvbufs[~ind]])
)


~kvbufs.loops[~kvbufs[~ind].path.basename.asSymbol].bpm

109.09 / (~kvbufs.loops[~kvbufs[~ind].path.basename.asSymbol].bpm /2 )

~matrix.bpm   /(~kvbufs.loops[~kvbufs[~ind].path.basename.asSymbol].bpm / 2)

(
~ind = 3;
a = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pwhite(-pi, pi, inf),
	\rz, Pwhite(-pi, pi, inf)
	// \ramp, Pseq(((0 ! 8) ++ [0.1, 0.4, 0.1, 0.4, 0.2, 0.3, 0.1, 0.3])*4, inf),
	// \rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w0', 'revwrpm', ~kvbufs[~ind], a, ~matrix.beatdur, 1.0, 1 );
)

e.setPwarp('w0', a, ~matrix.beatdur)

e.setWarp('w0', ['amp', 1.0, 'wrp', 0.25, 'wamp', 1.0, 'iamp', 1, 'ramp', 0.06, 'rate', 1, 'freq', 1])


e.setWarp('w0', ['buf', ~kvbufs[10]])

e.freeWarp('w0')

s.queryAllNodes


(
~ind = 0;
~buf = ~kvbufs[~ind];
~lbpm = ~kvbufs.loops[~buf.path.basename.asSymbol].bpm;
b = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pbrown(0, 2pi, 0.125pi, inf),
	\rz, Pbrown(0, 2pi, 0.125pi, inf),
	\ramp, Pseq(( (0.05 ! 8) ++ [1.0, 1.0, 0.1, 0.1, 1.0, 0.3, 0.1, 0.0].dup(3).flat * 0.4 ), inf),
	\wamp, Pseq(( [1.0, 1.0, 0.1, 0.1, 0.1, 0.3, 1.0, 0.0].dup(3).flat * 0.5 ++ (0.05 ! 8) ), inf),
	\freq, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w1', 'revwrpm', ~buf, b, ~matrix.beatdur, 0.7, ~bpm / ~lbpm);
)

e.setPwarp('w1', b, ~matrix.beatdur )


(
e.setPat('b05', 0.3, [0.3, 0.3], [0.2, 0.4], 0.1);
e.setPat('b06', 0.2, [0.5, 0.5], [1.0, 3.0], 0.1);
e.setPat('b07', 0.2, [0.5, 0.5], [0.1, 0.3], 0.1);
)




e.setWarp('w1', ['iamp', 1])

e.freeWarp('w1')


// 1, 6, 13, 14, 15, 17, 18, 21, 22, 23

Pseq(Array.series(12, 0, 2pi/12), inf)
Prand(Array.series(17, 0, 2pi/17), inf)

~kvbufs[~ind].path

(
~ind = 0;
e.setWarp('w2', ['buf', ~kvbufs[~ind]])
)

(
c = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\iamp, Pseq((0 ! 32) ++ (1 ! 32) * 0.5, inf),
	\wamp, Pseq((1 ! 32) ++ (0 ! 32), inf),
	// \buf, Pseq( (~kvbufs[0] ! 32 ) ++ (~kvbufs[4] ! 32 ), inf ),
	\buf, Pseq([1, 2].collect({|ind| ~kvbufs[ind] }).mirror2, inf)
];
// e.playWarp('w2', 'wrprevm', 0, c, ~matrix.beatdur*2);
e.playWarp('w2', 'revwrpm', ~kvbufs[1], c, ~matrix.beatdur/2, 1.0);

)

e.setPwarp('w2', c, ~matrix.beatdur/2)

e.setWarp('w2', ['amp', 1, 'wrp', 0.25, 'wamp', 0.9, 'iamp', 0, 'ramp', 0, 'rate', 1, 'freq', 1, 'randr', 0.04, 'wsize', 0.1, 'dens', 4])

e.freeWarp('w2')






(
e.setWarp('w3', ['buf', ~kvbufs.buffers.choose])
)

(
d = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pwhite(0, 2pi,  inf),
	\rz, Pwhite(0, 2pi, inf),
	\buf, Pseq([~kvbufs[47], ~kvbufs[35], ~kvbufs[145], ~kvbufs[47]], inf)
];
e.playWarp('w3', 'wrprevm', ~kvbufs[47], d, ~matrix.beatdur/2);
)

e.setPwarp('w3', d, ~matrix.beatdur*4)

e.setWarp('w3', ['amp', 1.0, 'wrp', 0.25, 'wamp', 2, 'iamp', 0.5, 'ramp', 1, 'rate', 1.0, 'freq', 2, 'randr', 0.1, 'wsize', 0.1, 'dens', 7])

e.freeWarp('w3')

s.scope(2)

s.sendMsg("/n_free", 1014)2


s.queryAllNodes


Pdef('efx').play

~matrix.efxamps['efx1'] = 0.2

~matrix.defsAt('r01').assignEfx(
	(efx1: (0..31))
)


~matrix.efxamps['efx0'] = 0.3

~matrix.defsAt('r00').assignEfx(
	(efx0: (0..31))
)


e.setPatInd('d08', 1, 0, 2, 0.3, 0.1)
e.setPatInd('d08', 6, 0, 1, 0.3, 0.1)

e.setPatInd('d01', 3, 0, 1, 0.3, 0.1)

e.setPatInd('r00', 3, 1, 1, 0.05, 0.1)

e.setPatInd('r01', 2, 1, 1, 0.3, 0.1)


(
e.setPat('r00', 0.0, [0.7, 1.0], [0.07, 0.15], 0.1);
e.setPat('r01', 0.0, [0.7, 1.0], [0.07, 0.15], 0.1);
e.setPat('r02', 0.0, [0.7, 1.0], [0.07, 0.15], 0.1);
e.setPat('r03', 0.0, [0.7, 1.0], [0.07, 0.15], 0.1);
e.setPat('r04', 0.0, [0.7, 1.0], [0.07, 0.15], 0.1);
e.setPat('r05', 0.0, [0.7, 1.0], [0.07, 0.15], 0.1);
e.setPat('r06', 0.0, [0.7, 1.0], [0.07, 0.15], 0.1);
e.setPat('r07', 0.0, [0.7, 1.0], [0.07, 0.15], 0.1);
)





(
Pdef('mxb', Ppar(
	["b02", "b03", "b05", "b07", "b09", "b13", "b14", "b15", "b16", "b17"].collect({|name|
		Pdef(name.asSymbol)
	})
)
).play
)

Pdef('mxb').clear


(
e.setPat('b02', 0.0, [0.7, 1.0], [0.1, 0.4], 0.1);
e.setPat('b03', 0.0, [0.7, 1.0], [0.1, 0.2], 0.1);
e.setPat('b05', 0.0, [0.7, 1.0], [0.1, 0.2], 0.1);
e.setPat('b07', 0.0, [0.7, 1.0], [0.1, 0.2], 0.1);
e.setPat('b08', 0.0, [0.7, 1.0], [0.1, 0.2], 0.1);
e.setPat('b09', 0.0, [0.4, 1.0], [0.1, 0.2], 0.1);
e.setPat('b13', 0.0, [0.7, 1.0], [0.1, 0.2], 0.1);
e.setPat('b14', 0.0, [0.3, 0.7], [0.5, 1.0], 0.1);
e.setPat('b15', 0.0, [0.3, 0.7], [0.5, 1.0], 0.1);
e.setPat('b16', 0.0, [0.4, 0.7], [0.5, 1.0], 0.1);
e.setPat('b17', 0.0, [0.4, 0.7], [0.5, 1.0], 0.1);
)


~matrix.defsAt('r00').setActives(nil, { rrand(0.01, 0.02) });

~matrix.defsAt('b14').setActives(nil, { rrand(0.01, 0.02) });
~matrix.defsAt('b15').setActives(nil, { rrand(0.01, 0.02) });
~matrix.defsAt('b16').setActives(nil, { rrand(0.01, 0.02) });




(
e.setPat('b10', 0.0, [1.0, 1.0], [0.1, 0.2], 0.1);
e.setPat('b11', 0.0, [1.0, 1.0], [0.1, 0.2], 0.1);
e.setPat('b12', 0.0, [1.0, 1.0], [0.1, 0.4], 0.1);

)



(
e.setPat('b04', 0.0, [0.2, 0.4], [2.0, 4.0], 0.1);
e.setPat('b06', 0.0, [0.2, 0.4], [2.0, 4.0], 0.1);
)



(
e.setPat('d00', 0.0, [1.0, 2.0], [0.1, 0.2], 0.1);
e.setPat('d01', 0.0, [1.0, 2.0], [0.1, 0.3], 0.1);
e.setPat('d02', 0.0, [1.0, 2.0], [0.1, 0.3], 0.1);
e.setPat('d03', 0.0, [1.0, 2.0], [0.1, 0.2], 0.1);
e.setPat('d04', 0.0, [1.0, 2.0], [0.1, 0.2], 0.1);
e.setPat('d05', 0.0, [1.0, 2.0], [0.1, 0.2], 0.1);
e.setPat('d06', 0.0, [1.0, 2.0], [0.1, 0.2], 0.1);
e.setPat('d07', 0.0, [1.0, 2.0], [0.1, 0.2], 0.1);

)


~matrix.defsAt('d03').buffers



(
e.setPat('d08', 0.0, [0.5, 1.0], [0.1, 0.2], 0.1);
e.setPat('d09', 0.0, [0.5, 1.0], [0.1, 0.1], 0.1);
e.setPat('d10', 0.0, [0.5, 1.0], [0.1, 0.2], 0.1);
e.setPat('d11', 0.0, [0.5, 1.0], [0.1, 0.2], 0.1);
e.setPat('d12', 0.0, [0.5, 1.0], [0.1, 0.2], 0.1);
e.setPat('d13', 0.0, [0.5, 1.0], [0.1, 0.2], 0.1);
e.setPat('d14', 0.0, [0.5, 1.0], [0.1, 0.2], 0.1);
e.setPat('d15', 0.0, [0.5, 1.0], [0.1, 0.2], 0.1);

)

( {|i| ("d" ++ i.asString.padLeft(2, "0")).asSymbol } ! 16 ).do({|name|
	e.setPat(name, 0.0, [0.5, 2.0], [0.1, 0.2], 0.1)
})


s.stopRecording


~matrix.defsAt('r01').recall(0);
~matrix.defsAt('r00').recall(0);

~matrix.defsAt('r02').recall(0);
~matrix.defsAt('b02').recall(0);


~matrix.defsAt('r00').setActives(nil, { rrand(0.01, 0.02) });
~matrix.defsAt('r01').setActives(nil, { rrand(0.01, 0.02) });
~matrix.defsAt('r02').setActives(nil, { rrand(0.01, 0.02) });
~matrix.defsAt('r03').setActives(nil, { rrand(0.01, 0.02) });



~matrix.defsAt('b02').recall(0);
~matrix.defsAt('b09').recall(0);



(
~matrix.defsAt('b05').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.7, 1.0) },
	{ exprand(0.1, 0.2) },
	0.1
);

~matrix.defsAt('b11').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.4, 1.0) },
	{ exprand(0.02, 0.1) },
	0.1
);

~matrix.defsAt('b10').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.8, 1.0) },
	{ exprand(0.1, 0.3) },
	0.1
);

~matrix.defsAt('b04').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.5, 1.0) },
	0.1
);

~matrix.defsAt('b17').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.3, 1.0) },
	{ exprand(0.2, 0.4) },
	0.1
);

)


MasterEQ(2)

SparseMatrix

~matrix.defsAt('d01').setActives(nil, { rrand(0.1, 0.01) });


~matrix.defsAt('r00').recall(0);
~matrix.defsAt('d01').recall(0);


~matrix.defsAt('d04').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.8, 1.0) },
	{ exprand(0.1, 0.3) },
	0.1
);


~matrix.defsAt('d07').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(1.0, 1.0) },
	{ exprand(0.1, 0.4) },
	0.1
);

~matrix.defsAt('b07').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.23, 0.6) },
	{ exprand(0.2, 0.5) },
	0.1
);


~matrix.defsAt('b').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.2, 0.4) },
	0.1
);



~drnbufs = "/Users/alo/snd/drn/poni/*.wav".pathMatch.collect({|path|
	Buffer.read(s, path)
})


(
~selected = ~drnbufs.select({|buf| buf.duration > 0.0 });
~avgdur = ~matrix.beatdur*8;
Tdef('drone', {
	loop({
		~args = [
			'out', ~decoder.bus, 'buf', ~selected.choose,
			'wrp', rrand(0.33, 1.0),
			'freq', [0.5, 1.0, 2.0].choose, 'wsize', rrand(0.05, 0.2),
			'dens', rrand(3, 15), 'randr', rrand(0.01, 0.2),
			'room', rrand(20, 300), 'rtime', rrand(2.0, 10.0),
			'ramp', rrand(0.3, 1.0), 'eamp', rrand(0.5, 1.0),
			'wamp', rrand(0.2, 0.7), 'dur', ~avgdur * rrand(1.0, 4.0),
			'rx', rrand(0.01, 0.3), 'ry', rrand(0.01, 0.3), 'rz', rrand(0.01, 0.3),
			'rng', 1
		];
		Synth.before(~decoder.synth, 'wrpdrn', ~args);
		rrand(~avgdur*0.7, ~avgdur*1.3).wait;
	})
}).play

)


Tdef('drone').clear



~matrix.skismDefs.collect(_.name)

[ granularReverb, flangingDecimator, neuralFilter, feedbackSpectrum, cyclicWarp, latchOnset, cliqSaw, fxGrain, arhythmicGendy, roosaShift, primeTam, roosaBufPlay, roosaBufWrp, magFreeze ]


~matrix.activateSkismSynth('primeTam')

~matrix.setSkismAmp('primeTam', 0.2 )

~matrix.deactivateSkismSynth('primeTam')



~matrix.activateSkismSynth('magFreeze')

~matrix.setSkismAmp('magFreeze', 0.1)

~matrix.deactivateSkismSynth('magFreeze')





~matrix.activateSkismSynth('cliqSaw')

~matrix.setSkismAmp('cliqSaw', 0.1)

~matrix.deactivateSkismSynth('cliqSaw')


~matrix.buffers['evo'].size



SynthDef(\bitSt3, {|out, efx, amp, emp, buf, dur|
	var ply, sig, flt, resfr, fund;
	fund = Control.names([\rfrq]).ir(Array.primesN(17, 73));
	resfr = Array.fill(3, {
		Select.kr(IRand(0, fund.lastIndex), fund)
	});
	ply = Normalizer.ar(
		PlayBuf.ar(1, buf, BufRateScale.ir(buf), 1)**0.5,0.99
		 );
	// flt = FreeVerb.ar(Mix(Resonz.ar(ply*1111,resfr, 9.neg.dbamp )),0.1)
	// * EnvGen.kr(Env.perc(0.005, 1, 1, -32), timeScale: dur*0.5);
	sig = ply * EnvGen.kr(\env.kr(Env.newClear(8).asArray), timeScale: dur, doneAction: 2);
	Out.ar(efx, sig * emp);
	Out.ar(out, sig * amp)
}).add;



(
Tdef('tex') {
	loop({
		Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.4, 0.7),
			'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(1, 4)],
			'dur', exprand(0.4, 0.9), 'env', [Env.perc, Env.sine].choose] );
		rrand(0.1, 0.4).wait
	})
})
.play
)


(
Synth.tail(~matrix.group, \bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.4, 0.7),
	'emp', 0.0, 'buf', ~matrix.buffers['evo'][12],
	'dur', exprand(0.5, 1.0), 'rotx', 2pi.rand, 'roty', 2pi.rand, 'rotz', 2pi.rand,
	'env', Env.perc
] );
)

Pseq([3, 3, 3, 6, 3, 3, 3, 12].collect({|num| ~matrix.buffers['evo'][num]}), inf).asStream


Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.4, 0.6),
	'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(1, 3)],
	'dur', exprand(2.0, 4.0), 'env', [Env.perc, Env.sine].choose] );



~player.start(~foa)


~player.setFoa('zoom', 1.0)
~player.setFoa('push', 1.0)


// 38 niice

// 30, 42 fuck yeah

~ind0 = 38;
~player.loadData(~ind0);
~player.play(~ind0, 0, ['zoom', 'push'].choose, 0);
~player.set(~ind0, 0.3);

~player.free(~ind0)

s.queryAllNodes


// 53 fuck yeah!!!!

// 271

~ind1 = 53

~player.loadData(~ind1)

~player.play(~ind1, 0, ['zoom', 'push'].choose, 0)

~player.set(~ind1, 1.0)

~player.free(~ind1)


// 249 sick!

~ind2 = 249

~player.loadData(~ind2)

~player.play(~ind2, 0, ['zoom', 'push'].choose, 0)

~player.set(~ind2, 0.6);

~player.free(~ind2)




//

~ind3 = 34

~player.loadData(~ind3)

~player.play(~ind3, 0, ['zoom', 'push'].choose, 0)

~player.set(~ind3, 1.0)

~player.free(~ind3)


