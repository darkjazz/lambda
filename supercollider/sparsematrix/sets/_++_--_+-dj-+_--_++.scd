(
SynthDef('check', {
	var out, sig, trig;
	trig = Impulse.kr(3);
	sig = Mix(GVerb.ar(SinOsc.ar(11777*SinOsc.ar(11).range(0.8, 1.2)) * 0.001, 20, 6)) * EnvGen.kr(Env.perc, trig, timeScale: 0.3);
	out = Demand.kr(trig, 0, Dseq( (0..17) ++ (21..26), 1 ));
	Line.kr(dur:10, doneAction: 2);
	Out.ar(out, sig)
}).play
)


(
~rdefs = ( {|i| ("r" ++ i.asString.padLeft(2, "0")).asSymbol } ! 18 );
~bdefs = ( {|i| ("b" ++ i.asString.padLeft(2, "0")).asSymbol } ! 18 );
~ddefs = ( {|i| ("d" ++ i.asString.padLeft(2, "0")).asSymbol } ! 16 );

~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2, screenX: 1024, screenY: 768, mode: 1, decoderType: 'binaural', 'localDecoder': true, 'ambiOrder': 3, bpm: 123, channels: 2, foa: #[zoom,push], dbname: "ges_ld_00", patdefs: "patternDefsMesa.scd", initPdefs: ~rdefs ++ ~bdefs ++ ~ddefs, worldDim: 21, ip: "127.0.0.1");
e = SpEnvir(~settings, {
	~dj = DjEnvir(e);
})
)



~matrix.setBPM(136.36)


s.queryAllNodes

s.sendMsg("/n_free", 1012)

e.setPwarp('w0', a, ~matrix.beatdur / 2)


~ind = ;
~gesbufs.loops.values.collect(_.bpm)

[~gesbufs[~ind].path.basename.asSymbol].bpm

~matrix.patterndefs


Pdef('mx0',
	Ppar(['w0', 'w1', 'w2', 'd00'].collect({|nm| Pdef(nm) }))
).play


(

~ind=0;
a = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf)
	// \iamp, Pseq((0 ! 32) ++ (1 ! 32) * 0.2, inf),
	// \wamp, Pseq((0 ! 32) ++ (1 ! 32), inf),
	// \freq, Pseq(Scale.minor.ratios.scramble.keep(3), inf ),

	// \buf, Pseq( (~gesbufs[0] ! 32 ) ++ (~gesbufs[4] ! 32 ), inf ),
	// \buf, Pseq([47, 73, 23, 35].collect({|ind| ~gesbufs[ind] }).mirror2, inf)
	// \buf, Pseq([47, 103, 53, 35].collect({|ind| ~gesbufs[ind] }).mirror2, inf)
];
// e.playWarp('w2', 'wrprevm', 0, c, ~matrix.beatdur*2);
e.playWarp('w0', 'wrprevm', ~gesbufs[~ind], a, ~matrix.beatdur, 1);

)

e.setPwarp('w0', a, ~matrix.beatdur)

Pdef('w0').play

e.setWarp('w0', ['wamp', 0.0, 'amp', 1.0])

e.freeWarp('w0')



Pdef('mx1',
	Ppar(
		Array.with(Pdef('r12'), Pdef('r13'))
	)
).play

(
e.setPat('d00', 0.0, [0.6, 1.0], [0.1, 0.2], 0.1);
e.setPat('d01', 0.0, [0.6, 1.0], [0.1, 0.2], 0.1);
e.setPat('b04', 0.0, [0.6, 1.0], [0.3, 0.6], 0.1);
e.setPat('b10', 0.0, [1.0, 1.0], [0.1, 0.3], 0.1);
e.setPat('b13', 0.0, [1.0, 1.0], [0.1, 0.5], 0.1);
)


s.scope(2)

~gesbufs.search(123, 0.05).do(_.postln)

~gesbufs.search(136.36, 0.05).do(_.postln)

~gesbufs.search(78.95, 0.05).do(_.postln)


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
~ind = 158;
e.setWarp('w0', ['buf', ~gesbufs[~ind]])
)


~gesbufs.loops[~gesbufs[~ind].path.basename.asSymbol].bpm

109.09 / (~gesbufs.loops[~gesbufs[~ind].path.basename.asSymbol].bpm /2 )

~matrix.bpm   /(~gesbufs.loops[~gesbufs[~ind].path.basename.asSymbol].bpm / 2)

(
~ind = 1;
a = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pwhite(-pi, pi, inf),
	\rz, Pwhite(-pi, pi, inf)
	// \ramp, Pseq(((0 ! 8) ++ [0.1, 0.4, 0.1, 0.4, 0.2, 0.3, 0.1, 0.3])*4, inf),
	// \rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w0', 'revwrpm', ~gesbufs[~ind], a, ~matrix.beatdur, 1.0, 1 );
)

e.setPwarp('w0', a, ~matrix.beatdur)

e.setWarp('w0', ['amp', 1.0, 'wrp', 0.25, 'wamp', 1.0, 'iamp', 0, 'ramp', 1, 'rate', 1, 'freq', 1])


e.freeWarp('w0')

s.queryAllNodes


(
b = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pbrown(0, 2pi, 0.125pi, inf),
	\rz, Pbrown(0, 2pi, 0.125pi, inf),
	// \ramp, Pseq(( (0 ! 24) ++ [1.0, 1.0, 0.1, 1.0, 0.0, 0.3, 0.1, 0.0] )*2, inf),
	\freq, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w1', 'wrprevm', ~gesbufs[13], b, ~matrix.beatdur, 1.0);
)

e.setPwarp('w1', b, ~matrix.beatdur )

e.setWarp('w1', ['amp', 1.0, 'wrp', 0.25, 'wamp', 1, 'iamp', 0, 'ramp', 0, 'rate', 1, 'freq', 1.0, 'randr', 0.01, 'wsize', 0.1, 'dens', 6])

e.freeWarp('w1')

s.scope(2)


// 1, 6, 13, 14, 15, 17, 18, 21, 22, 23

Pseq(Array.series(12, 0, 2pi/12), inf)
Prand(Array.series(17, 0, 2pi/17), inf)

~gesbufs[~ind].path

(
~ind = 0;
e.setWarp('w2', ['buf', ~gesbufs[~ind]])
)

(
c = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\iamp, Pseq((0 ! 32) ++ (1 ! 32) * 0.5, inf),
	\wamp, Pseq((1 ! 32) ++ (0 ! 32), inf),
	// \buf, Pseq( (~gesbufs[0] ! 32 ) ++ (~gesbufs[4] ! 32 ), inf ),
	\buf, Pseq([47, 73, 23, 35].collect({|ind| ~gesbufs[ind] }).mirror2, inf)
];
// e.playWarp('w2', 'wrprevm', 0, c, ~matrix.beatdur*2);
e.playWarp('w2', 'revwrpm', ~gesbufs[47], c, ~matrix.beatdur/2, 1.0);

)

e.setPwarp('w2', c, ~matrix.beatdur/2)

e.setWarp('w2', ['amp', 1, 'wrp', 0.25, 'wamp', 0.9, 'iamp', 0, 'ramp', 0, 'rate', 1, 'freq', 1, 'randr', 0.04, 'wsize', 0.1, 'dens', 4])

e.freeWarp('w2')





(
e.setWarp('w3', ['buf', ~gesbufs.buffers.choose])
)

(
d = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pwhite(0, 2pi,  inf),
	\rz, Pwhite(0, 2pi, inf),
	\buf, Pseq([~gesbufs[47], ~gesbufs[35], ~gesbufs[145], ~gesbufs[47]], inf)
];
e.playWarp('w3', 'wrprevm', ~gesbufs[47], d, ~matrix.beatdur/2);
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


e.setPatInd('d00', 4, 1, 1, 0.2, 0.1)
e.setPatInd('d08', 6, 0, 1, 0.3, 0.1)

e.setPatInd('d01', 3, 0, 1, 0.3, 0.1)

e.setPatInd('r00', 3, 1, 1, 0.05, 0.1)

e.setPatInd('r01', 2, 1, 1, 0.3, 0.1)



Pdef('mx0',
	Ppar(['r02', 'r04', 'r05', 'b04', 'r04', 'r03', 'r05', 'b06', 'b03', 'b10', 'b11', 'b12'].collect({|nm| Pdef(nm) }))
).play


e.setPat('b04', 0.0, [0.4, 0.5], [2.0, 4.0], 0.1);

e.setPat('b06', 0.0, [0.2, 0.6], [2.0, 4.0], 0.1);


(
e.setPat('r00', 0.3, [0.05, 0.1], [0.07, 0.15], 0.1);
e.setPat('r01', 0.3, [0.01, 0.1], [0.07, 0.15], 0.1);
e.setPat('r02', 0.3, [0.7, 1.0], [0.07, 0.15], 0.1);
e.setPat('r03', 0.0, [0.1, 0.2], [0.07, 0.15], 0.1);
e.setPat('r04', 0.0, [0.1, 0.2], [0.07, 0.15], 0.1);
e.setPat('r05', 0.2, [0.4, 0.7], [0.07, 0.15], 0.1);
e.setPat('b12', 0.0, [0.1, 1.0], [0.07, 0.4], 0.1);
e.setPat('b10', 0.0, [0.1, 0.5], [0.07, 0.4], 0.1);
e.setPat('b11', 0.0, [0.5, 0.7], [0.07, 0.3], 0.1);


e.setPat('b03', 0.0, [0.1, 0.7], [0.07, 0.3], 0.1);

)









(
e.setPat('b02', 0.0, [1.0, 2.0], [0.1, 0.2], 0.1);
e.setPat('b03', 0.0, [1.0, 2.0], [0.1, 0.2], 0.1);
e.setPat('b05', 0.0, [1.0, 2.0], [0.1, 0.2], 0.1);
e.setPat('b07', 0.3, [1.0, 2.0], [0.1, 0.2], 0.1);
e.setPat('b08', 0.3, [1.0, 2.0], [0.1, 0.2], 0.1);
e.setPat('b10', 0.3, [0.4, 1.0], [0.1, 0.4], 0.1);
e.setPat('b12', 0.3, [1.0, 1.0], [0.1, 0.2], 0.1);
e.setPat('b14', 0.0, [1.0, 1.0], [0.1, 0.2], 0.1);
e.setPat('b15', 0.0, [0.4, 1.0], [0.1, 0.4], 0.1);
e.setPat('b16', 0.0, [0.4, 1.0], [0.1, 0.4], 0.1);
e.setPat('b17', 0.0, [0.4, 1.0], [0.1, 0.4], 0.1);

)


~matrix.defsAt('r01').setActives(nil, { rrand(0.01, 0.02) });

~matrix.defsAt('b14').setActives(nil, { rrand(0.01, 0.02) });
~matrix.defsAt('b15').setActives(nil, { rrand(0.01, 0.02) });
~matrix.defsAt('b16').setActives(nil, { rrand(0.01, 0.02) });




(
e.setPat('b10', 0.0, [1.0, 1.0], [0.1, 0.2], 0.1);
e.setPat('b11', 0.0, [1.0, 1.0], [0.1, 0.2], 0.1);
e.setPat('b12', 0.0, [1.0, 1.0], [0.1, 0.4], 0.1);

)



(
e.setPat('b04', 0.5, [0.2, 0.4], [2.0, 4.0], 0.1);
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


~matrix.defsAt('r02').recall(0);
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


~matrix.buffers.evo

(
~selected = ~matrix.buffers.evo;
~avgdur = ~matrix.beatdur*8;
Tdef('drone', {
	loop({
		~args = [
			'out', ~decoder.bus, 'buf', ~selected.choose,
			'wrp', rrand(0.1, 0.5),
			'freq', [0.5, 1.0, 2.0].choose, 'wsize', rrand(0.05, 0.2),
			'dens', rrand(3, 15), 'randr', rrand(0.01, 0.1),
			'room', rrand(20, 300), 'rtime', rrand(6.0, 10.0),
			'ramp', rrand(0.01, 0.1), 'eamp', rrand(0.01, 0.03),
			'wamp', rrand(0.01, 0.15), 'dur', ~avgdur * rrand(1.0, 3.0),
			'rx', rrand(0.01, 0.3), 'ry', rrand(0.01, 0.3), 'rz', rrand(0.01, 0.3),
			'rng', 1
		];
		Synth.before(~decoder.synth, 'wrpdrn', ~args);
		rrand(~avgdur*0.7, ~avgdur*2.0).wait;
	})
}).play

)


Tdef('drone').clear





['flangingDecimator', 'granularReverb', 'feedbackSpectrum', 'cyclicWarp', 'latchOnset', 'cliqSaw', 'fxGrain', 'arhythmicGendy']

~matrix.activateSkismSynth('latchOnset')

~matrix.setSkismAmp('latchOnset', 0.3)

~matrix.deactivateSkismSynth('latchOnset')



~matrix.activateSkismSynth('cyclicWarp')

~matrix.setSkismAmp('cyclicWarp', 0.0)

~matrix.deactivateSkismSynth('cyclicWarp')



~matrix.activateSkismSynth('feedbackSpectrum')

~matrix.setSkismAmp('feedbackSpectrum', 0.1)

~matrix.deactivateSkismSynth('feedbackSpectrum')



s.queryAllNodes

s.sendMsg("/n_free", 17808)



~matrix.buffers['evo'].size

SynthDef(\bitSt3, {|out, efx, amp, emp, buf, dur|
	var ply, sig, flt, resfr, fund;
	fund = Control.names([\rfrq]).ir(Array.primesN(17, 73));
	resfr = Array.fill(3, {
		Select.kr(IRand(0, fund.lastIndex), fund)
	});
	ply = Normalizer.ar(
		PlayBuf.ar(2, buf, BufRateScale.ir(buf), 1)**0.5,0.99
		 );
	flt = FreeVerb.ar(Mix(Resonz.ar(ply*1111,resfr, 9.neg.dbamp )),0.1)
	* EnvGen.kr(Env.perc(0.005, 1, 1, -32), timeScale: dur*0.5);
	sig = (ply + flt) * EnvGen.kr(\env.kr(Env.newClear(8).asArray), timeScale: dur, doneAction: 2);
	Out.ar(efx, sig * emp);
	Out.ar(out, sig * amp)
}).add;

Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', 1, 'emp', 0.0, 'buf', ~matrix.buffers['evo'][1], 'dur', 0.3, 'env', Env.perc] );


(
Tdef('tex') {
	loop({
		Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.4, 0.7), 'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(100, 104)], 'dur', exprand(0.4, 0.9), 'env', [Env.perc, Env.sine].choose] );
		rrand(0.1, 0.4).wait
	})
})
.play
)




// **** DJ ****

~dj.print

~n1 = "ssssssssssssssssss--shxcxchcxsh.aiff"


~n1 = "falling_leaf--goth-trad.aiff"
~n2 = "buddha_machine_5_loop_02--fm3.aiff"
~n3 = "lesclandre--oake.aiff"
~n4 = "fragments_of_a_hologram_rose--access_to_arasaka.aiff"


~n3 = "ritual--eomac.aiff"

~n0 = "in_tr07_04k--evala.aiff";

~n1 = "recovery--rival_consoles.aiff"

~dj.play(~n0, 0.2, 'pDj')

~dj.play(~n4, 0.2, 'pDj')

~dj.synths[~n3].set('amp', 0.3, 'pow', 1.0)

~dj.synths[~n1].set('amp', 0.3, 'pow', 1.0)


~dj.free(~n0)


~dj.query(~n4)



s.queryAllNodes

// GEP player

~player.start(~foa)


~player.setFoa('zoom', 1.0)
~player.setFoa('push', 1.0)


// 38 niice

// 30, 42 fuck yeah

~ind0 = 38

~player.loadData(~ind0)

~player.play(~ind0, 0, ['zoom', 'push'].choose, 0)

~player.set(~ind0, 1.0);

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


