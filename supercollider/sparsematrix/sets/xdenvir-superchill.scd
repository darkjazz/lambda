( 'b408': ( 'durdev': 0, 'emp': 0.1, 'active': 1, 'ampdev': 0,
  'amp': 0.31470966069434, 'dur': 2.2049514416595 ), 'b419': ( 'durdev': 0, 'emp': 0.1, 'active': 1, 'ampdev': 0,
  'amp': 0.38713603442681, 'dur': 3.5362825964613 ), 'b425': ( 'durdev': 0, 'emp': 0.1, 'active': 1, 'ampdev': 0,
  'amp': 0.39926438422674, 'dur': 2.5366011852434 ), 'b428': ( 'durdev': 0, 'emp': 0.1, 'active': 1, 'ampdev': 0,
	'amp': 0.38673625641925, 'dur': 2.2686794284848 ) )


(
~ind = 46;
~wrp3 = Synth.tail(~matrix.group, 'wrprevm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[~ind], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

Pdef('swrp3',
	Pbind(
		\type, \set, \id, ~wrp3.nodeID, \delta, Pn(~matrix.beatdur/4, inf),
		\rx, Pwhite(-0.5pi, 0.5pi, inf),
		\ry, Pbrown(0, 2pi, 0.125pi, inf),
		\rz, Pbrown(0, 2pi, 0.125pi, inf),
		\args, #[rx, ry, rz]
	)
).play;

)

~wrp3.set('amp', 1.0, 'wamp', 0.0, 'iamp', 0.1, 'ramp', 0.2, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.125)