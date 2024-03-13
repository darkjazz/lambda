// bpm 88.235
( 'rate': 1.0294083333333, 'bpm': 85.714285714286, 'index': 118 )
( 'rate': 1.0294083333333, 'bpm': 85.714285714286, 'index': 72 )
( 'rate': 0.99999666666667, 'bpm': 88.235294117647, 'index': 136 )
( 'rate': 0.99999666666667, 'bpm': 88.235294117647, 'index': 65 )
( 'rate': 1.0294083333333, 'bpm': 85.714285714286, 'index': 51 )
( 'rate': 0.99999666666667, 'bpm': 88.235294117647, 'index': 1 )
( 'rate': 0.970585, 'bpm': 90.909090909091, 'index': 52 )
( 'rate': 1.0147025, 'bpm': 86.95652173913, 'index': 111 )
( 'rate': 1.0294083333333, 'bpm': 85.714285714286, 'index': 61 )
( 'rate': 1.0294083333333, 'bpm': 85.714285714286, 'index': 40 )
( 'rate': 0.99999666666667, 'bpm': 88.235294117647, 'index': 63 )
( 'rate': 0.970585, 'bpm': 90.909090909091, 'index': 157 )
( 'rate': 0.99999666666667, 'bpm': 88.235294117647, 'index': 49 )
( 'rate': 0.970585, 'bpm': 90.909090909091, 'index': 159 )
( 'rate': 1.0294083333333, 'bpm': 85.714285714286, 'index': 66 )
( 'rate': 0.970585, 'bpm': 90.909090909091, 'index': 110 )
( 'rate': 0.99999666666667, 'bpm': 88.235294117647, 'index': 99 )
( 'rate': 0.970585, 'bpm': 90.909090909091, 'index': 56 )
( 'rate': 1.0294083333333, 'bpm': 85.714285714286, 'index': 112 )

~matrix.setBPM(88.235)

Pdef('mx0', Ppar([Pdef('b04'), Pdef('b06')])).play

(
~ind0=157;
~pw0 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf)
	// \wamp, Pseq(((0.1 ! 24) ++ [0.1, 0.4, 0.1, 0.4, 0.2, 0.3, 0.1, 0.3])*4, inf),
	// \rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w0', 'revwrpm', ~mesabufs[~ind0], ~pw0, ~matrix.beatdur/2, 0.5 );
)

e.setPwarp('w0', ~pw0, ~matrix.beatdur / 2)

e.setWarp('w0', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.0, 'iamp', 0.3, 'ramp', 0.0, 'rate', 1, 'freq', 4])

e.setWarp('w0', ['buf', ~mesabufs[136]])

e.freeWarp('w0')

99, 118, 136, 157, 112

65, 51, 118


(
~ind0=112;
~pw0 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	// \wamp, Pseq(((0.1 ! 24) ++ [0.1, 0.4, 0.1, 0.4, 0.2, 0.3, 0.1, 0.3])*4, inf),
	\wamp, Pseq([1, 0]*0.5, inf),
	\rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w0', 'revwrpm', ~mesabufs[~ind0], ~pw0, ~matrix.beatdur/8, 0.0 );
)

e.setPwarp('w0', ~pw0, ~matrix.beatdur)

e.setWarp('w0', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0, 'rate', 1, 'freq', 1])

e.freeWarp('w0')

(
e.setPat('b04', 0.0, [0.2, 0.4], [2.0, 4.0], 0.1);
e.setPat('b06', 0.4, [0.3, 0.4], [2.0, 4.0], 0.1);
)


(
~ind2=65;
~pw2 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	// \iamp, Pseq(([1.0, 0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0].dup.flat ++ (0 ! 16)), inf),
	\wamp, Pseq([1, 0]*0.2, inf),
	\freq, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w2', 'revwrpm', ~mesabufs[~ind2], ~pw2, ~matrix.beatdur/4, 0.0 );
)

(118.058/60).reciprocal

e.setPwarp('w2', ~pw1, ~matrix.beatdur)

e.setWarp('w2', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0, 'rate', 0.5, 'freq', 1])

e.freeWarp('w2')




(
~ind1=111;
~pw1 = [
	\rx, Pbrown(-pi, pi, 0.125pi, inf),
	\ry, Pbrown(-pi, pi, 0.125pi, inf),
	\rz, Pbrown(-pi, pi, 0.125pi, inf),
	// \iamp, Pseq([1.0, 0.0, 1.0, 0.0, 0.0, 1.0, 1.0, 0.0].dup.flat * 0.7 ++ ( 0 ! 24), inf),
	// \rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w1', 'revwrpm', ~mesabufs[~ind1], ~pw1, ~matrix.beatdur/2, 0.8 );
)

e.setPwarp('w1', ~pw1, ~matrix.beatdur)

e.setWarp('w1', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.0, 'iamp', 0.4, 'ramp', 0.0, 'rate', 1.0294083333333, 'freq', 1])

e.freeWarp('w1')

Pdef('mx0').clear


/// BPM 123

( 'rate': 1.025, 'bpm': 120, 'index': 34 )
( 'rate': 1.025, 'bpm': 120, 'index': 114 )
( 'rate': 1.025, 'bpm': 120, 'index': 25 )
( 'rate': 1.025, 'bpm': 120, 'index': 123 )
( 'rate': 1.025, 'bpm': 120, 'index': 36 )
( 'rate': 1.025, 'bpm': 120, 'index': 161 )
( 'rate': 1.025, 'bpm': 120, 'index': 8 )
( 'rate': 1.025, 'bpm': 120, 'index': 74 )
( 'rate': 1.025, 'bpm': 120, 'index': 133 )
( 'rate': 1.025, 'bpm': 120, 'index': 119 )
( 'rate': 1.025, 'bpm': 120, 'index': 152 )
( 'rate': 1.0045, 'bpm': 122.44897959184, 'index': 73 )
( 'rate': 1.025, 'bpm': 120, 'index': 141 )
( 'rate': 1.0455, 'bpm': 117.64705882353, 'index': 68 )
( 'rate': 1.025, 'bpm': 120, 'index': 162 )
( 'rate': 1.025, 'bpm': 120, 'index': 89 )
( 'rate': 1.0455, 'bpm': 117.64705882353, 'index': 134 )
( 'rate': 1.025, 'bpm': 120, 'index': 23 )
( 'rate': 1.025, 'bpm': 120, 'index': 102 )
( 'rate': 1.025, 'bpm': 120, 'index': 90 )
( 'rate': 1.025, 'bpm': 120, 'index': 104 )
( 'rate': 1.025, 'bpm': 120, 'index': 35 )
( 'rate': 1.025, 'bpm': 120, 'index': 59 )
( 'rate': 1.025, 'bpm': 120, 'index': 69 )
( 'rate': 1.025, 'bpm': 120, 'index': 113 )
( 'rate': 1.025, 'bpm': 120, 'index': 124 )
( 'rate': 1.025, 'bpm': 120, 'index': 10 )
( 'rate': 1.025, 'bpm': 120, 'index': 11 )
( 'rate': 1.025, 'bpm': 120, 'index': 46 )
( 'rate': 1.025, 'bpm': 120, 'index': 145 )
( 'rate': 1.025, 'bpm': 120, 'index': 62 )
( 'rate': 1.0045, 'bpm': 122.44897959184, 'index': 75 )

~matrix.setBPM(123)


(
~pw2 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf)
	// \iamp, Pseq((0 ! 32) ++ (1 ! 32) * 0.5, inf),
	// \wamp, Pseq((1 ! 32) ++ (0 ! 32), inf),
	// \buf, Pseq( (~mesabufs[0] ! 32 ) ++ (~mesabufs[4] ! 32 ), inf ),
	// \buf, Pseq([47, 73, 23].collect({|ind| ~mesabufs[ind] }).mirror2, inf)
];
// e.playWarp('w2', 'wrprevm', 0, c, ~matrix.beatdur*2);
e.playWarp('w2', 'revwrpm', ~mesabufs[113], ~pw2, ~matrix.beatdur, 1);

)


e.setPwarp('w2', ~pw2, ~matrix.beatdur)

e.setWarp('w2', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0, 'iamp', 0.0, 'ramp', 0, 'rate', 1, 'freq', 1, 'randr', 0.04, 'wsize', 0.1, 'dens', 8])

e.freeWarp('w2')


[1, 0].lace(32)

(
~pw3 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf)
	// \iamp, Pseq((0 ! 32) ++ [1, 0].lace(32) * 0.5, inf),
];
e.playWarp('w3', 'wrprevm', ~mesabufs[75], ~pw3, ~matrix.beatdur/2, 1, 1.025);
)

e.setPwarp('w3', ~pw3, ~matrix.beatdur*2)

e.setWarp('w3', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0, 'iamp', 0.03, 'ramp', 0, 'rate', 1.025, 'freq', 1, 'randr', 0.1, 'wsize', 0.1, 'dens', 6])

e.freeWarp('w3')


(
~pw4 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf)
];
e.playWarp('w4', 'wrprevm', ~mesabufs[152], ~pw4, ~matrix.beatdur*2, 0.5, 1.025);
)

e.setPwarp('w4', ~pw4, ~matrix.beatdur*2)

e.setWarp('w4', ['amp', 1.0, 'wrp', 0.25, 'wamp', 1.0, 'iamp', 1.0, 'ramp', 1, 'rate', 1.025, 'freq', 1, 'randr', 0.1, 'wsize', 0.1, 'dens', 6])

e.freeWarp('w4')





( 'rate': 0.9945, 'bpm': 76.923076923077, 'index': 4 )
( 'rate': 1.0455, 'bpm': 73.170731707317, 'index': 84 )
( 'rate': 0.9945, 'bpm': 76.923076923077, 'index': 120 )
( 'rate': 0.969, 'bpm': 78.947368421053, 'index': 98 )
( 'rate': 1.0455, 'bpm': 73.170731707317, 'index': 57 )
( 'rate': 0.9945, 'bpm': 76.923076923077, 'index': 33 )
( 'rate': 0.9945, 'bpm': 76.923076923077, 'index': 45 )
( 'rate': 0.969, 'bpm': 78.947368421053, 'index': 76 )
( 'rate': 1.02, 'bpm': 75, 'index': 19 )
( 'rate': 0.9945, 'bpm': 76.923076923077, 'index': 12 )
( 'rate': 1.0455, 'bpm': 73.170731707317, 'index': 6 )
( 'rate': 1.02, 'bpm': 75, 'index': 109 )
( 'rate': 0.969, 'bpm': 78.947368421053, 'index': 81 )
( 'rate': 0.9945, 'bpm': 76.923076923077, 'index': 93 )
( 'rate': 0.969, 'bpm': 78.947368421053, 'index': 158 )
( 'rate': 0.9945, 'bpm': 76.923076923077, 'index': 151 )
( 'rate': 1.02, 'bpm': 75, 'index': 28 )


~matrix.setBPM(76.5)

Pdef('mx1', Ppar([Pdef('r05'), Pdef('r02'), Pdef('r03'), Pdef('r06'), Pdef('r07')])).play


(
~ind0=57;
~rt0 = 0.9945;
~pw0 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\ramp, Pseq(((0 ! 24) ++ [1.0, 0.2, 0.3, 1.0, 0.2, 0.8, 0.1, 0.7]), inf),
	\ramp, Pseq(((0 ! 8) ++ [1.0, 0.2, 0.3, 1.0, 0.2, 0.8, 0.1, 0.7]), inf),
	\rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w0', 'wrprevm', ~mesabufs[~ind0], ~pw0, ~matrix.beatdur, 0.0, ~rt0 );
)

e.setPwarp('w0', ~pw0, ~matrix.beatdur / 2)

e.setWarp('w0', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.0, 'iamp', 0.5, 'ramp', 0, 'rate', ~rt0, 'freq', 1])

e.freeWarp('w0')


(
e.setPat('r05', 0.0, [0.7, 1.0], [0.07, 0.15], 0.1);
e.setPat('r02', 0.0, [0.7, 1.0], [0.07, 0.15], 0.1);
e.setPat('r03', 0.0, [0.7, 1.0], [0.07, 0.15], 0.1);
e.setPat('r06', 0.0, [0.7, 1.0], [0.07, 0.15], 0.1);
e.setPat('r07', 0.0, [0.7, 1.0], [0.07, 0.15], 0.1);
)



(
~ind1=98;
~rt1 = 0.944;
~pw1 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	// \ramp, Pseq(((0 ! 8) ++ [0.3, 1.0, 0.3, 1.0, 0.3, 0.6, 0.3, 1.0]) * 0.3, inf),
	// \rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w1', 'revwrpm', ~mesabufs[~ind1], ~pw1, ~matrix.beatdur, 1.0, ~rt1 );
)

e.setPwarp('w1', ~pw1, ~matrix.beatdur)

e.setWarp('w1', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.5, 'iamp', 0.0, 'ramp', 0.0, 'rate', ~rt1, 'freq', 1])

e.freeWarp('w1')



(
~ind2=93;
~rt2 = 1.02;
~pw2 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	// \iamp, Pseq(((0 ! 16) ++ (1 ! 16)) * 0.5, inf),
	\rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w2', 'revwrpm', ~mesabufs[~ind2], ~pw2, ~matrix.beatdur, 0.0, ~rt2 );
)

e.setPwarp('w2', ~pw2, ~matrix.beatdur)

e.setWarp('w2', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.0, 'iamp', 1.0, 'ramp', 0.04, 'rate', ~rt2, 'freq', 1])



e.freeWarp('w2')


// track buf 13 bpm 133
( 'rate': 0.9975, 'bpm': 133.33333333333, 'index': 132 )
( 'rate': 0.95316666666667, 'bpm': 139.53488372093, 'index': 150 )
( 'rate': 0.9975, 'bpm': 133.33333333333, 'index': 13 )
( 'rate': 0.97533333333333, 'bpm': 136.36363636364, 'index': 47 )
( 'rate': 0.9975, 'bpm': 133.33333333333, 'index': 139 )
( 'rate': 0.9975, 'bpm': 133.33333333333, 'index': 127 )



~matrix.setBPM(133)



(
~ind0=13;
~rt0 = 0.9975;
~pw0 = [
	\rx, Pbrown(0, 2pi, 0.125pi, inf),
	\ry, Pbrown(0, 2pi, 0.125pi, inf),
	\rz, Pbrown(0, 2pi, 0.125pi, inf)
];
e.playWarp('w0', 'revwrpm', ~mesabufs[~ind0], ~pw0, ~matrix.beatdur, 1.0, ~rt0 );

)

e.setPwarp('w0', ~pw0, ~matrix.beatdur)

e.setWarp('w0', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.0, 'iamp', 1.0, 'ramp', 0.0, 'rate', ~rt0, 'freq', 1])

e.freeWarp('w0')





(
~ind1=139; // 150
~rt1 = 0.9975;
~pw1 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\wamp, Pseq(((0 ! 16) ++ [0.3, 1.0, 0.3, 1.0, 0.3, 0.6, 0.3, 1.0].mirror2), inf),
	\ramp, Pseq(((0 ! 24) ++ [0.3, 1.0, 0.3, 1.0, 0.3, 0.6, 0.3, 1.0]), inf)
];
e.playWarp('w1', 'wrprevm', ~mesabufs[~ind1], ~pw1, ~matrix.beatdur, 1.0, ~rt1 );
)

e.setPwarp('w1', ~pw1, ~matrix.beatdur * 2)

e.setWarp('w1', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.0, 'iamp', 0, 'ramp', 0, 'rate', ~rt1, 'freq', 1])

e.freeWarp('w1')


(
e.setPat('b04', 0.1, [0.2, 0.4], [2.0, 4.0], 0.1);
e.setPat('b06', 0.1, [0.5, 0.8], [2.0, 4.0], 0.1);
)




(
Tdef('slowdown', {
	var step, bpm, start, end, time=~matrix.beatdur*48;
	time = ~matrix.beatdur * 48;
	start = bpm = ~matrix.bpm;
	end = 109;
	step = (start - end) / 100.0;
	100.do({
		bpm = bpm - step;
		~matrix.setBPM(bpm);
		(~matrix.beatdur*48/100).wait;
	});
	"finished".postln;
	"BPM: ".post; ~matrix.bpm.postln;
}).play;
)

// bpm 109.09: 21, 24 | 26 rate 0.945

( 'rate': 1.0173333333333, 'bpm': 107.14285714286, 'index': 125 )
( 'rate': 0.99916666666667, 'bpm': 109.09090909091, 'index': 21 )
( 'rate': 0.981, 'bpm': 111.11111111111, 'index': 106 )
( 'rate': 0.981, 'bpm': 111.11111111111, 'index': 83 )
( 'rate': 1.0173333333333, 'bpm': 107.14285714286, 'index': 39 )
( 'rate': 0.96283333333333, 'bpm': 113.20754716981, 'index': 38 )
( 'rate': 0.99916666666667, 'bpm': 109.09090909091, 'index': 24 )
( 'rate': 0.981, 'bpm': 111.11111111111, 'index': 0 )
( 'rate': 0.981, 'bpm': 111.11111111111, 'index': 50 )
( 'rate': 1.0173333333333, 'bpm': 107.14285714286, 'index': 144 )
( 'rate': 0.981, 'bpm': 111.11111111111, 'index': 54 )
( 'rate': 0.981, 'bpm': 111.11111111111, 'index': 96 )
( 'rate': 0.981, 'bpm': 111.11111111111, 'index': 126 )
( 'rate': 0.981, 'bpm': 111.11111111111, 'index': 155 )
( 'rate': 1.0355, 'bpm': 105.26315789474, 'index': 32 )
( 'rate': 1.0173333333333, 'bpm': 107.14285714286, 'index': 70 )
( 'rate': 0.981, 'bpm': 111.11111111111, 'index': 138 )
( 'rate': 0.981, 'bpm': 111.11111111111, 'index': 131 )
( 'rate': 1.0173333333333, 'bpm': 107.14285714286, 'index': 41 )
( 'rate': 1.0173333333333, 'bpm': 107.14285714286, 'index': 82 )


(
~ind0=0;
~rt0 = 0.9991;
~pw0 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf)
	// \ramp, Pseq(((0 ! 24) ++ [0.1, 0.4, 0.1, 0.4, 0.2, 0.3, 0.1, 0.3])*4, inf),
	// \rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w0', 'wrprevm', ~mesabufs[~ind0], ~pw0, ~matrix.beatdur/2, 0.5, ~rt0 );
)

e.setPwarp('w0', ~pw0, ~matrix.beatdur)

e.setWarp('w0', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.0, 'iamp', 1, 'ramp', 0.8, 'rate', ~rt0, 'freq', 1])

e.freeWarp('w0')




(
~ind1=24;
~rt1 = 0.999;
~pw1 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\ramp, Pseq(((0 ! 16) ++ [0.3, 1.0, 0.3, 1.0, 0.3, 0.6, 0.3, 1.0].mirror2) * 1.0, inf),
	\freq, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w1', 'revwrpm', ~mesabufs[~ind1], ~pw1, ~matrix.beatdur, 0.0, ~rt1 );
)

e.setPwarp('w1', ~pw1, ~matrix.beatdur)

e.setWarp('w1', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.1, 'iamp', 0.0, 'ramp', 1, 'rate', ~rt1, 'freq', 1])

e.freeWarp('w1')
