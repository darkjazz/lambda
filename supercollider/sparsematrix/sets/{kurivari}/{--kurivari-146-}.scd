~matrix.setBPM(90.566+(90.566/2))


~kvbufs.search(~lbpm ).do(_.postln)

(
~ind = 146;
~buf = ~kvbufs[~ind];
~lbpm = ~kvbufs.loops[~buf.path.basename.asSymbol].bpm;
b = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pbrown(0, 2pi, 0.125pi, inf),
	\rz, Pbrown(0, 2pi, 0.125pi, inf),
	\ramp, Pseq(( (0.05 ! 24) ++ [1.0, 1.0, 0.1, 1.0, 0.0, 0.3, 0.1, 0.0] ) * 0.7, inf),
	\fnc, Pfunc({
		Pdef('r17').play;
		1
	})

];
e.playWarp('w1', 'wrprevm', ~buf, b, ~matrix.beatdur*4, 2.0, 1.0);
)

(
e.setWarp('w1', ['amp', 1, 'wrp', 0.25, 'wamp', 0.6])
)


e.setPwarp('w1', b, ~matrix.beatdur )


Pdef('mx2',
	Ppar(['r02', 'b05', 'b04', 'b07'].collect({|nm| Pdef(nm) }))
).play

e.setPat('r17', 1.0, [0.3, 0.3], nil, 0.1);

Pdef('r17').stop

(
e.setPat('r17', 1.0, [0.3, 0.3], [0.07, 0.07], 0.1);
e.setPat('r08', 0.4, [0.3, 0.3], nil, 0.1);
e.setPat('r12', 1.0, [0.1, 0.2], [0.05, 0.1], 0.1);
)




e.freeWarp('w1')

2.65.reciprocal*60*4

92.31+(92.31/2)



// 3, 4, 5, 147

(
~ind = 56;
~buf = ~kvbufs[~ind];
~lbpm = ~kvbufs.loops[~buf.path.basename.asSymbol].bpm;
c = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf)
];
e.playWarp('w2', 'revwrpm', ~buf, c, ~matrix.beatdur/2, 1.0, ~bpm / ~lbpm);
// e.setWarp('w2', ['wamp', 0.5]);
)

e.setPwarp('w2', c, ~matrix.beatdur/2)

(
e.setWarp('w2', ['amp', 1, 'wrp', 0.25, 'wamp', 1.0, 'iamp', 0.0, 'ramp', 0,
	'rate',  ~bpm / ~lbpm, 'freq', 1, 'randr', 0.04, 'wsize', 0.1, 'dens', 4])
)

e.freeWarp('w2')





(
~ind = 4;
~buf = ~kvbufs[~ind];
~lbpm = ~kvbufs.loops[~buf.path.basename.asSymbol].bpm;
d = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf)
];
e.playWarp('w3', 'revwrpm', ~buf, d, ~matrix.beatdur/2, 1.0, ~bpm / ~lbpm);

)

e.setPwarp('w3', c, ~matrix.beatdur/2)

(
e.setWarp('w3', ['amp', 1, 'wrp', 0.25, 'wamp', 0.5, 'iamp', 0.0, 'ramp', 0,
	'rate',  ~bpm / ~lbpm, 'freq', 1, 'randr', 0.04, 'wsize', 0.1, 'dens', 4])
)

e.freeWarp('w3')
