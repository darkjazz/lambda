(
~rdefs = ( {|i| ("r" ++ i.asString.padLeft(2, "0")).asSymbol } ! 8 );
~bdefs = ( {|i| ("b" ++ i.asString.padLeft(2, "0")).asSymbol } ! 18 );
~ddefs = ( {|i| ("d" ++ i.asString.padLeft(2, "0")).asSymbol } ! 16 );

~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2, screenX: 1024, screenY: 768, mode: 1, decoderType: 'binaural', 'localDecoder': true, bpm: 123, channels: 2, foa: #[zoom,push], dbname: "ges_ld_00", patdefs: "patternDefsMesa.scd", initPdefs: ~rdefs ++ ~bdefs ++ ~ddefs, worldDim: 21, ip: "127.0.0.1");
e = SpEnvir(~settings)

)


Server.killAll

~matrix.setBPM(123)

s.scope(2)

~gesbufs.search(171.43, 0.05).do(_.postln)

~gesbufs.search(109, 0.05).do(_.postln)

~gesbufs.search(176.47, 0.05).do(_.postln)


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
~ind = 72;
e.setWarp('w0', ['buf', ~gesbufs[~ind]])
)


109.09 / (~gesbufs.loops[~gesbufs[~ind].path.basename.asSymbol].bpm /2 )

~matrix.bpm   /(~gesbufs.loops[~gesbufs[~ind].path.basename.asSymbol].bpm / 2)

(
~ind = 72;
a = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pwhite(-pi, pi, inf),
	\rz, Pwhite(-pi, pi, inf)
	// \ramp, Pseq(((0 ! 24) ++ [0.1, 0.4, 0.1, 0.4, 0.2, 0.3, 0.1, 0.3])*4, inf),
	// \rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w0', 'revwrpm', ~gesbufs[~ind], a, ~matrix.beatdur, 1.0, 1 );
)

e.setPwarp('w0', a, ~matrix.beatdur / 2)

e.setWarp('w0', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.0, 'iamp', 0.7, 'ramp', 0.3, 'rate', 1, 'freq', 1])

e.freeWarp('w0')

s.queryAllNodes


(
b = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pbrown(0, 2pi, 0.125pi, inf),
	\rz, Pbrown(0, 2pi, 0.125pi, inf),
	\ramp, Pseq(( (0 ! 24) ++ [1.0, 1.0, 0.1, 1.0, 0.0, 0.3, 0.1, 0.0] )*2, inf),
	\freq, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w1', 'revwrpm', ~gesbufs[61], b, ~matrix.beatdur, 0.5);
)

e.setPwarp('w1', b, ~matrix.beatdur )

e.setWarp('w1', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.4, 'iamp', 0.0, 'ramp', 0.0, 'rate', 1, 'freq', 1.0, 'randr', 0.01, 'wsize', 0.1, 'dens', 6])

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

e.setWarp('w2', ['amp', 1, 'wrp', 0.25, 'wamp', 0, 'iamp', 0, 'ramp', 0, 'rate', 1, 'freq', 1, 'randr', 0.04, 'wsize', 0.1, 'dens', 4])

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
e.setPat('b02', 0.0, [1.0, 2.0], [0.1, 0.2], 0.1);
e.setPat('b03', 0.0, [1.0, 2.0], [0.1, 0.2], 0.1);
e.setPat('b05', 0.0, [1.0, 2.0], [0.1, 0.2], 0.1);
e.setPat('b07', 0.3, [1.0, 2.0], [0.1, 0.2], 0.1);
e.setPat('b08', 0.3, [1.0, 2.0], [0.1, 0.2], 0.1);
e.setPat('b09', 0.0, [0.4, 1.0], [0.1, 0.2], 0.1);
e.setPat('b13', 0.0, [1.0, 1.0], [0.1, 0.2], 0.1);
e.setPat('b14', 0.0, [1.0, 1.0], [0.1, 0.2], 0.1);
e.setPat('b15', 0.0, [0.4, 1.0], [0.1, 0.4], 0.1);
e.setPat('b16', 0.0, [0.4, 1.0], [0.1, 0.4], 0.1);
e.setPat('b17', 0.0, [0.4, 1.0], [0.1, 0.4], 0.1);

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





['flangingDecimator', 'granularReverb', 'feedbackSpectrum', 'cyclicWarp', 'latchOnset', 'cliqSaw', 'fxGrain', 'arhythmicGendy']

~matrix.activateSkismSynth('primeTam')

~matrix.setSkismAmp('primeTam', 0.4)

~matrix.deactivateSkismSynth('primeTam')



~matrix.activateSkismSynth('cliqSaw')

~matrix.setSkismAmp('cliqSaw', 0.0)

~matrix.deactivateSkismSynth('cliqSaw')



~matrix.activateSkismSynth('feedbackSpectrum')

~matrix.setSkismAmp('feedbackSpectrum', 0.4)

~matrix.deactivateSkismSynth('feedbackSpectrum')


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



~player.start(~foa)


~player.setFoa('zoom', 1.0)
~player.setFoa('push', 1.0)


// 38 niice

// 30, 42 fuck yeah

~ind0 = 38

~player.loadData(~ind0)

~player.play(~ind0, 0, ['zoom', 'push'].choose, 0)

~player.set(~ind0, 0.2);

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


