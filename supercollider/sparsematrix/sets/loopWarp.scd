
(
Tdef('d0', {
	a = [
		\rx, Pwhite(-pi, pi, inf),
		\ry, Pbrown(0, 2pi, 0.125pi, inf),
		\rz, Pbrown(0, 2pi, 0.125pi, inf)
	];
	loop({
		var buf = ~strm.next;
		buf.postln;
		e.playWarp('w0', 'wrprevm', buf, a, 1);
		s.sync;
		e.setWarp('w0', ['amp', 1.0, 'wamp', 0, 'iamp', 1.0, 'ramp', rrand(0.0, 0.3), 'rate', 1.0, 'freq', [0.5, 1.0, 2.0].choose ]);
		(~matrix.beatdur * 64).wait;
		e.freeWarp('w0');
		s.sync;
	})
}).play
)


Tdef('d0').clear;e.freeWarp('w0')

(
~playWarp = {|buf, beats=4, name|
	Routine({
		var ctr = [
			\rx, Pwhite(-pi, pi, inf),
			\ry, Pbrown(0, 2pi, 0.125pi, inf),
			\rz, Pbrown(0, 2pi, 0.125pi, inf),
			\ramp, Pseq(Array.rand([4, 8, 16].choose, 0.3, 1.0 ), inf),
			\freq, Pseq(Scale.minor.ratios.scramble.keep(rrand(2, 4)), inf )
		];
		buf.postln;
		e.playWarp(name, 'wrprevm', buf, ctr, [0.25, 0.5, 1, 2].choose);
		s.sync;
		e.setWarp(name, ['amp', 1.0, 'wamp', 0, 'iamp', 0.5.rand, 'ramp', 0.0, 'rate', 1.0, 'freq', 1.0 ]);
		(~matrix.beatdur * beats).wait;
		e.freeWarp(name);
	}).play
}
)


104..108 - beginning

~strm = Pseq(~gesbufs.buffers[(118..122)], inf).asStream;
~beats = Pstutter(Prand([2, 3, 4], inf), Pseq([16, 32], inf), inf).asStream;
~wrps = Pseq(['w0', 'w1', 'w2', 'w3', 'w5'], inf).asStream;


(
Tdef('d1', {
	loop({
		var buf, beats;
		beats = ~beats.next;
		buf = ~strm.next;
		~playWarp.(buf, beats, ~wrps.next);
		(~matrix.beatdur * beats / 2).wait;
		beats = ~beats.next;
		buf = ~strm.next;
		~playWarp.(buf, beats, ~wrps.next);
		(~matrix.beatdur * beats / 2).wait;
	})
}).play
)

Tdef('d1').clear
