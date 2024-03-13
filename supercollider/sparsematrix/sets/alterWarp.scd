e.playWarp('w0', 'wrprevm', 0, a, 4);
e.freeWarp('w0')


(
~bufstream = Pseq(~gesbufs.buffers, inf).asStream;
Tdef('d0', {
	var c = 0;
	a = [
		\rx, Pwhite(-pi, pi, inf),
		\ry, Pbrown(0, 2pi, 0.125pi, inf),
		\rz, Pbrown(0, 2pi, 0.125pi, inf)
	];

	loop({
		var buf = ~bufstream.next;
		e.setWarp('w0', ['buf', buf, 'amp', 1.0, 'wamp', [1, 0].choose, 'iamp', rrand(0.5, 1.0), 'ramp', [1, 0].choose,  'rate', [0.5, 1.0, 2.0].choose, 'freq', [0.5, 1.0, 2.0].choose ]);
		e.setPwarp('w0', a, ~matrix.beatdur / 2);
		Post << c << " " << buf << Char.nl;
		c = c + 1;
		(~matrix.beatdur * [16, 32].choose).wait;
	})
}).play
)



Tdef('d0').clear

e.playWarp('w1', 'revwrpm', 0, b, 4);
e.freeWarp('w1')
(
Tdef('d1', {
	b = [
		\rx, Pwhite(-pi, pi, inf),
		\ry, Pbrown(0, 2pi, 0.125pi, inf),
		\rz, Pbrown(0, 2pi, 0.125pi, inf)
	];
	loop({
		var buf = ~gesbufs.buffers.choose;
		e.setWarp('w1', ['buf', buf, 'amp', 1.0, 'wamp', rrand(0.4, 0.7), 'iamp', rrand(0.3, 0.6), 'ramp', 0,  'rate', [0.5, 1.0, 2.0].choose, 'freq', [0.5, 1.0, 2.0].choose ]);
		(~matrix.beatdur * [8, 16].choose).wait;
	})
}).play
)



(
Tdef('d2', {
	c = [
		\rx, Pwhite(-pi, pi, inf),
		\ry, Pbrown(0, 2pi, 0.125pi, inf),
		\rz, Pbrown(0, 2pi, 0.125pi, inf)
	];
	loop({
		var buf = ~gesbufs.buffers.choose;
		buf.postln;
		e.playWarp('w2', 'revwrpm', buf, c, [0.25, 0.5, 1, 2].choose);
		s.sync;
		e.setWarp('w2', ['amp', 1.0, 'wamp', rrand(0.5, 0.7), 'iamp', 0, 'ramp', rrand(0.3, 0.7),  'rate', [0.5, 1.0, 2.0].choose, 'freq', [0.5, 1.0, 2.0].choose ]);
		(~matrix.beatdur * [32, 64].choose).wait;
		e.freeWarp('w2');
		s.sync;
	})
}).play
)


Tdef('d0').clear;
Tdef('d1').clear;
Tdef('d2').clear


s.queryAllNodes

s.sendMsg("/n_free", 1234)