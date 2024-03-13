(
~rdefs = ( {|i| ("r" ++ i.asString.padLeft(2, "0")).asSymbol } ! 18 );
~bdefs = ( {|i| ("b" ++ i.asString.padLeft(2, "0")).asSymbol } ! 18 );
~ddefs = ( {|i| ("d" ++ i.asString.padLeft(2, "0")).asSymbol } ! 16 );

~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2,
	screenX: 1024, screenY: 768, mode: 1, decoderType: 'binaural',
	'localDecoder': true, 'ambiOrder': 3, bpm: 119, channels: 2,
	foa: #[zoom,push], dbname: "ges_ld_00", patdefs: "patternDefsMesa.scd",
	initPdefs: ~rdefs ++ ~bdefs ++ ~ddefs, worldDim: 21, ip: "127.0.0.1"
);
e = SpEnvir(~settings)
)

Tdef('init', {
	~graphics = CinderApp(1000, 800, mode: 1, path: ~path);
	~graphics.open;
	3.wait;
	~graphics.initWorld(~wrldsz, ~wrldsz, ~wrldsz, 20);
	1.wait;
	~graphics.initGenerations([ 4, 10, 14, 15, 21, 23 ], [ 6, 13, 25, 26 ], 23);
	1.wait;
	~graphics.setSymmetry(11);
	~graphics.setViewpoint(0.0, 0.0, -100.0, 0.0, 0.0, 0.0);
	~initMsg.();
	1.wait;
	~activePatterns = Array();
	~graphics.activateSwarm(13, 200.0, 200.0, 200.0, 0.8, 50.0, 8.0, 15.0, 100.0);
	0.2.wait;
	~graphics.sendCodeTitle("roosa poni");
	Post << "Initialised..." << Char.nl;
}).play

(
~ind = 7;
~buf = ~gesbufs[~ind];
~lbpm = ~gesbufs.loops[~buf.path.basename.asSymbol].bpm;
~playpat = false;
a = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pwhite(-pi, pi, inf),
	\rz, Pwhite(-pi, pi, inf),
	\buf, Pseq((7..10).collect({|ind| ~gesbufs[ind] }), inf),
	\ramp, Pseq(SparseMatrix.patterns12['Tiriba'].keep(3).flat + 0.1 * 0.5, inf),
	\wamp, Pseq(SparseMatrix.patterns12['Soli'].drop(3).keep(3).flat + 0.1, inf),
	\fnc, Pfunc({
		1
	})
];
e.playWarp('w0', 'revwrpm', ~gesbufs[~ind], a, ~matrix.beatdur * 2, 0.0, ~bpm / ~lbpm );
)

~playpat = true
e.setPwarp('w0', a, ~matrix.beatdur)
e.setWarp('w0', ['amp', 1.0, 'iamp', 0.7])

e.setWarp('w0', ['buf', ~gesbufs[10]])
e.freeWarp('w0')

Pdef('r00').play

~matrix.defsAt('r00').recall(0);

e.setPat('r05', 0.1, [0.3, 0.5], [0.07, 0.15], 0.1);

e.setPat('r06', 0.1, [0.3, 0.5], [0.07, 0.15], 0.1);

(
~ind = 0;
~buf = ~gesbufs[~ind];
~lbpm = ~gesbufs.loops[~buf.path.basename.asSymbol].bpm;
~pfnc = {1};
~bufstr = Pseq(~matrix.buffers['evo'][(2..9)], inf).asStream;
b = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pbrown(0, 2pi, 0.125pi, inf),
	\rz, Pbrown(0, 2pi, 0.125pi, inf),
	\fnc, Pfunc({
		~pfnc.()
	})
];
e.playWarp('w1', 'revwrpm', ~buf, b, ~matrix.beatdur, 1.0, ~bpm / ~lbpm);
)

(
b = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pbrown(0, 2pi, 0.125pi, inf),
	\rz, Pbrown(0, 2pi, 0.125pi, inf),
	\ramp, Pseq((
		(0.05 ! 8) ++ [1.0, 1.0, 0.1, 0.1, 1.0, 0.3, 0.1, 0.0].dup(3).flat * 0.4 ),
	inf),
	\wamp, Pseq(( [1.0, 1.0, 0.1, 0.1, 0.1, 0.3, 1.0, 0.0].dup(3).flat * 0.5
		++ (0.05 ! 8) ), inf),
	\freq, Pseq(Scale.minor.ratios.scramble.keep(3), inf ),
	\fnc, Pfunc({
		~pfnc.()
	})
];

e.setPwarp('w1', b, ~matrix.beatdur )
)

(
~pfnc = {
	if (0.5.coin) {
		Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.3, 0.5),
			'emp', 0.0, 'buf', ~bufstr.next, 'dur', rrand(0.5, 1.0),
			'env', [ Env.perc, Env([0.001, 1.0], [1], 'exp') ].wchoose([0.8, 0.2])
		]);
	} { 1 }
}
)

e.freeWarp('w1')

(
~ind = 96;
a = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pwhite(-pi, pi, inf),
	\rz, Pwhite(-pi, pi, inf)
];
e.playWarp('w0', 'revwrpm', ~gesbufs[~ind], a, ~matrix.beatdur, 1.0, 1 );
)

e.setPwarp('w0', a, ~matrix.beatdur)

e.setWarp('w0', ['amp', 1.0, 'wrp', 0.25, 'wamp', 1.0, 'iamp', 1,
	'ramp', 0.06, 'rate', 1, 'freq', 1])

e.freeWarp('w0')
s.queryAllNodes

(
~ind = 111;
~buf = ~gesbufs[~ind];
~lbpm = ~gesbufs.loops[~buf.path.basename.asSymbol].bpm;
b = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pbrown(0, 2pi, 0.125pi, inf),
	\rz, Pbrown(0, 2pi, 0.125pi, inf),
	\ramp, Pseq(( (0.05 ! 8) ++ [1.0, 1.0, 0.1, 0.1, 1.0, 0.3, 0.1, 0.0].dup(3).flat
		* 0.4 ), inf),
	\freq, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w1', 'revwrpm', ~buf, b, ~matrix.beatdur, 0.7, ~bpm / ~lbpm);
)

e.setPwarp('w1', b, ~matrix.beatdur )
e.freeWarp('w1')

(
~ind = 47;
~buf = ~gesbufs[~ind];
~lbpm = ~gesbufs.loops[~buf.path.basename.asSymbol].bpm;
~rate = ~bpm/~lbpm;
~counter = 0;
~ampk = 1;
~amps = 1;
a = [
	\rx, Pbrown(-pi, pi, 0.125pi, inf),
	\ry, Pbrown(-pi, pi, 0.125pi, inf),
	\rz, Pbrown(-pi, pi, 0.125pi, inf),
	\buf, Pseq([47, 47, 47, 73, 73, 47, 47, 23, 23, 35, 35, 35 ].collect({|ind|
		~gesbufs[ind] }).mirror2, inf),
	\fnc, Pfunc({|ev|
		if (~counter % 8 == 0) {
			Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', ~ampk,
				'emp', 0.0, 'buf', ~matrix.buffers['evo'][19], 'dur', 0.5,
				'env', Env.perc] );
		};
		if (~counter % 6 == 0) {
			Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', ~amps,
				'emp', 0.0, 'buf', ~matrix.buffers['evo'][22], 'dur', 0.5,
				'env', Env.perc] );
		};
		if (~counter % 2 == 0) {
			Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', 1.0,
				'emp', 0.0, 'buf', ~matrix.buffers['evo'][24], 'dur', 0.1,
				'env', Env.perc] );
		};
		~counter = ~counter + 1;
	})
];
e.playWarp('w0', 'revwrpm', ~buf, a, ~matrix.beatdur / 2, 1, ~rate);

)

Synth(\bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', 0.5, 'emp', 0.0, 'buf', ~matrix.buffers['evo'][48], 'dur', 2.0, 'env', Env.sine] );

~amps = 1;
~ampk = 1

e.freeWarp('w0')

(
~ind = 146;
~buf = ~gesbufs[~ind];
~lbpm = ~gesbufs.loops[~buf.path.basename.asSymbol].bpm;
b = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pbrown(0, 2pi, 0.125pi, inf),
	\rz, Pbrown(0, 2pi, 0.125pi, inf),
	\ramp, Pseq(( (0.05 ! 24) ++ [1.0, 1.0, 0.1, 1.0, 0.0, 0.3, 0.1, 0.0] ) * 0.7, inf),
	\freq, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w1', 'revwrpm', ~buf, b, ~matrix.beatdur, 0.7, ~bpm / ~lbpm);
)

e.setPwarp('w1', b, ~matrix.beatdur )


Pdef('mx2',
	Ppar(['r02', 'b05', 'b04', 'b07'].collect({|nm| Pdef(nm) }))
).play



(
e.setPat('r02', 0.0, [0.3, 0.3], [0.05, 0.3], 0.1);
e.setPat('b05', 0.0, [0.3, 0.3], [0.05, 0.1], 0.1);
e.setPat('b04', 0.0, [0.2, 0.5], [2.0, 4.0], 0.1);
e.setPat('b07', 0.0, [0.5, 0.5], [0.1, 0.3], 0.1);
)


e.freeWarp('w1')

(
c = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf)
];
// e.playWarp('w2', 'wrprevm', 0, c, ~matrix.beatdur*2);
e.playWarp('w2', 'revwrpm', ~gesbufs[147], c, ~matrix.beatdur/2, 1.0);

)

e.setPwarp('w2', c, ~matrix.beatdur/2)

(
e.setWarp('w2', ['amp', 1, 'wrp', 0.25, 'wamp', 0.9, 'iamp', 0, 'ramp', 0,
	'rate', 1, 'freq', 1, 'randr', 0.04, 'wsize', 0.1, 'dens', 4])
)

e.freeWarp('w2')

(
e.setPat('r08', 0.4, [0.5, 0.5], nil, 0.0);
e.setPat('r09', 0.2, [0.5, 0.5], nil, 0.0);
e.setPat('r10', 0.1, [0.7, 0.7], nil, 0.0);
e.setPat('r11', 0.1, [0.7, 0.7], nil, 0.0);
)

(
c = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\iamp, Pseq((0 ! 32) ++ (1 ! 32) * 0.5, inf),
	\wamp, Pseq((1 ! 32) ++ (0 ! 32), inf),
	\buf, Pseq([1, 2].collect({|ind| ~gesbufs[ind] }).mirror2, inf)
];
e.playWarp('w2', 'revwrpm', ~gesbufs[1], c, ~matrix.beatdur/2, 1.0);
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

(
e.setPat('r08', 0.4, [0.5, 0.5], nil, 0.0);
e.setPat('r09', 0.2, [0.5, 0.5], nil, 0.0);
e.setPat('r10', 0.1, [0.7, 0.7], nil, 0.0);
e.setPat('r11', 0.1, [0.7, 0.7], nil, 0.0);
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

~matrix.defsAt('r00').recall(0);
~matrix.defsAt('d01').recall(0);

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

~matrix.activateSkismSynth('primeTam');
~matrix.setSkismAmp('primeTam', 0.3);

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

~ind0 = 38;
~player.loadData(~ind0);
~player.play(~ind0, 0, ['zoom', 'push'].choose, 0);
~player.set(~ind0, 0.3);

~ind1 = 105;
~player.loadData(~ind1);
~player.play(~ind1, 0, ['zoom', 'push'].choose, 0);
~player.set(~ind1, 0.3);

(
e.setPat('r08', 0.4, [0.5, 0.5], nil, 0.0);
e.setPat('r09', 0.2, [0.5, 0.5], nil, 0.0);
e.setPat('r10', 0.1, [0.7, 0.7], nil, 0.0);
e.setPat('r11', 0.1, [0.7, 0.7], nil, 0.0);
)

