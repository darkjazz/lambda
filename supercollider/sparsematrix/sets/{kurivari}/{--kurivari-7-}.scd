(
~bpm = 119;
~matrix.setBPM(~bpm);
~ind1 = 48;
~buf1 = ~kvbufs[~ind1];
~loop1 = ~kvbufs.loopsAtBuf(~buf1);
~lbpm1 = ~loop1.bpm;
a = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pwhite(-pi, pi, inf),
	\rz, Pwhite(-pi, pi, inf)
];
e.playWarp('w0', 'revwrpm', ~buf1, a, ~matrix.beatdur * 4, 0.5, ~bpm / ~lbpm1 * 2 );

~ind2 = 22;
~buf2 = ~kvbufs[~ind2];
~loop2 = ~kvbufs.loopsAtBuf(~buf2);
~lbpm2 = ~loop2.bpm;
b = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pwhite(-pi, pi, inf),
	\rz, Pwhite(-pi, pi, inf)
];
e.playWarp('w1', 'revwrpm', ~buf2, b, ~matrix.beatdur * 4, 0.3, ~bpm / ~lbpm2 );

~ind3 = 40;
~buf3 = ~kvbufs[~ind3];
~lbpm3 = ~kvbufs.loopsAtBuf(~buf3).bpm;
c = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pwhite(-pi, pi, inf),
	\rz, Pwhite(-pi, pi, inf)
];
e.playWarp('w2', 'revwrpm', ~buf3, c, ~matrix.beatdur * 4, 0.4, ~bpm / ~lbpm3 * 2 );

~ind4 = 66;
~buf4 = ~kvbufs[~ind4];
~lbpm4 = ~kvbufs.loopsAtBuf(~buf4).bpm;
d = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pwhite(-pi, pi, inf),
	\rz, Pwhite(-pi, pi, inf)
];
e.playWarp('w3', 'revwrpm', ~buf4, d, ~matrix.beatdur * 4, 0.0, ~bpm / ~lbpm4 * 2 );
)

~kvbufs.loops
~kvbufs.searchDuration( ~loop2.start + ~loop2.nframes / ~buf2.sampleRate)
~kvbufs.search(60.0).do(_.postln)

~kvbufs.loopsAtBuf(~buf2)


Scale.minor.ratios.scramble.keep(3)

~kvbufs.search(~lbpm).do(_.postln)

e.setPwarp('w0', a, ~matrix.beatdur)

e.setWarp('w1', ['amp', 1.0, 'iamp', 0.7])


e.setWarp('w0', ['wamp', 1.0, 'ramp', 0.0, 'iamp', 0.0])
e.setWarp('w1', ['wamp', 0.0, 'ramp', 0.0, 'iamp', 1.0])
e.setWarp('w2', ['wamp', 0.4, 'ramp', 0.05, 'iamp', 0.0, 'wrp', 0.5, 'freq', 0.5])
e.setWarp('w3', ['wamp', 1.0, 'ramp', 0.1, 'iamp', 0.0, 'wrp', 0.25])


e.freeWarp('w0');
e.freeWarp('w1');
e.freeWarp('w2');
e.freeWarp('w3');


Pdef('r00').play


~matrix.defsAt('r00').recall(0);

e.setPat('r05', 0.1, [0.3, 0.5], [0.07, 0.15], 0.1);

e.setPat('r06', 0.1, [0.3, 0.5], [0.07, 0.15], 0.1);



(
~ind = 138;
~buf = ~kvbufs[~ind];
// ~lbpm = ~kvbufs.loops[~buf.path.basename.asSymbol].bpm;
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
e.playWarp('w1', 'revwrpm', ~buf, b, ~matrix.beatdur, 1.0, 1);
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






