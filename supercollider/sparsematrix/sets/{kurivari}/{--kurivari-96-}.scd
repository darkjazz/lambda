(
~ind = 96;
a = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pwhite(-pi, pi, inf),
	\rz, Pwhite(-pi, pi, inf)
];
e.playWarp('w0', 'revwrpm', ~kvbufs[~ind], a, ~matrix.beatdur, 1.0, 1 );
)

e.setPwarp('w0', a, ~matrix.beatdur)

e.setWarp('w0', ['amp', 1.0, 'wrp', 0.25, 'wamp', 1.0, 'iamp', 1,
	'ramp', 0.06, 'rate', 1, 'freq', 1])


e.freeWarp('w0')

s.queryAllNodes


(
~ind = 111;
~buf = ~kvbufs[~ind];
~lbpm = ~kvbufs.loops[~buf.path.basename.asSymbol].bpm;
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
