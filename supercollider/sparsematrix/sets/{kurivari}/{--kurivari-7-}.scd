(
~ind = 7;
~buf = ~kvbufs[~ind];
~lbpm = ~kvbufs.loops[~buf.path.basename.asSymbol].bpm;
~playpat = false;
a = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pwhite(-pi, pi, inf),
	\rz, Pwhite(-pi, pi, inf),
	\buf, Pseq((7..10).collect({|ind| ~kvbufs[ind] }), inf),
	\ramp, Pseq(SparseMatrix.patterns12['Tiriba'].keep(3).flat + 0.1 * 0.5, inf),
	\wamp, Pseq(SparseMatrix.patterns12['Soli'].drop(3).keep(3).flat + 0.1, inf),
	\fnc, Pfunc({
		~pfnc.()
	})
];
e.playWarp('w0', 'revwrpm', ~kvbufs[~ind], a, ~matrix.beatdur * 2, 0.0, ~bpm / ~lbpm );
)

~playpat = true

e.setPwarp('w0', a, ~matrix.beatdur)

e.setWarp('w0', ['amp', 1.0, 'iamp', 0.7])


e.setWarp('w0', ['buf', ~kvbufs[10]])

e.freeWarp('w0')


Pdef('r00').play


~matrix.defsAt('r00').recall(0);

e.setPat('r05', 0.1, [0.3, 0.5], [0.07, 0.15], 0.1);

e.setPat('r06', 0.1, [0.3, 0.5], [0.07, 0.15], 0.1);



(
~ind = 0;
~buf = ~kvbufs[~ind];
~lbpm = ~kvbufs.loops[~buf.path.basename.asSymbol].bpm;
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


~pfnc = 1

(
~pfnc = {
	Synth.tail(~matrix.group, \bitSt3, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(1.0, 1.5),
		'emp', 0.0, 'buf', ~bufstream.next,
		'dur', exprand(0.5, 0.7), 'rotx', 2pi.rand, 'roty', 2pi.rand, 'rotz', 2pi.rand,
		'env', Env.perc
	] );
}
)


e.freeWarp('w1')






