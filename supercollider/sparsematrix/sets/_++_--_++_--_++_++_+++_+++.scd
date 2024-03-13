// tracks


( 'rate': 1.02635, 'bpm': 76.923076923077, 'index': 4 )
( 'rate': 0.97371666666667, 'bpm': 81.081081081081, 'index': 30 )
( 'rate': 1.02635, 'bpm': 76.923076923077, 'index': 120 )
( 'rate': 1.0000333333333, 'bpm': 78.947368421053, 'index': 98 )
( 'rate': 1.02635, 'bpm': 76.923076923077, 'index': 33 )
( 'rate': 1.02635, 'bpm': 76.923076923077, 'index': 45 )
( 'rate': 1.0000333333333, 'bpm': 78.947368421053, 'index': 76 )
( 'rate': 1.02635, 'bpm': 76.923076923077, 'index': 12 )
( 'rate': 0.97371666666667, 'bpm': 81.081081081081, 'index': 135 )
( 'rate': 0.97371666666667, 'bpm': 81.081081081081, 'index': 16 )
( 'rate': 0.97371666666667, 'bpm': 81.081081081081, 'index': 31 )
( 'rate': 0.97371666666667, 'bpm': 81.081081081081, 'index': 85 )
( 'rate': 1.0000333333333, 'bpm': 78.947368421053, 'index': 81 )
( 'rate': 1.02635, 'bpm': 76.923076923077, 'index': 93 )
( 'rate': 1.0000333333333, 'bpm': 78.947368421053, 'index': 158 )
( 'rate': 0.97371666666667, 'bpm': 81.081081081081, 'index': 48 )
( 'rate': 1.02635, 'bpm': 76.923076923077, 'index': 151 )

~matrix.setBPM(78.95)



(
~ind = 72;
a = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pwhite(-pi, pi, inf),
	\rz, Pwhite(-pi, pi, inf)
	// \iamp, Pseq( (0 ! 24)  ++ ( [0.1, 0.4, 0.1, 0.4, 0.2, 0.3, 0.1, 0.3]), inf),
	// \rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w0', 'revwrpm', ~gesbufs[~ind], a, ~matrix.beatdur, 1, 1.02635 );
)

e.setPwarp('w0', a, ~matrix.beatdur)


(
~ind = 93;
e.setWarp('w1', ['buf', ~gesbufs[~ind]])
)

e.freeWarp('w0')


(
~ind = 48;
b = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pwhite(-pi, pi, inf),
	\rz, Pwhite(-pi, pi, inf),
	// \ramp, Pseq(( [0.1, 0.4, 0.1, 0.4, 0.2, 0.3, 0.1, 0.3]), inf),
	// \rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w1', 'revwrpm', ~gesbufs[~ind], b, ~matrix.beatdur, 1, 1.02635 );
)


e.setWarp('w1', ['iamp', 1])


c = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	// \iamp, Pseq((0 ! 32) ++ (0 ! 32) * 0.2, inf),
	\wamp, Pseq((0 ! 32) ++ (1 ! 32), inf),
	\freq, Pseq(Scale.minor.ratios.scramble.keep(3), inf ),
	// \buf, Pseq( (~gesbufs[0] ! 32 ) ++ (~gesbufs[4] ! 32 ), inf ),
	\buf, Pseq([47, 73, 23, 35].collect({|ind| ~gesbufs[ind] }).mirror2, inf)
];


(
~ind = 48;
b = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pwhite(-pi, pi, inf),
	\rz, Pwhite(-pi, pi, inf),
	// \ramp, Pseq(( [0.1, 0.4, 0.1, 0.4, 0.2, 0.3, 0.1, 0.3]), inf),
	// \rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w1', 'revwrpm', ~gesbufs[~ind], b, ~matrix.beatdur, 0.4, 1.02635 );
)



Pdef('mx0').clear

Pdef('mx0').play

(
~pat0 = Array.with(
	Pdef('r03'),
	Pdef('r06'),
	Pdef('r07'),
	Pdef('w0'),
	Pdef('w1')
);
Pdef('mx0', Ppar(
	~pat0
)).play
)

e.freeWarp('w0')

~matrix.defsAt('r03').recall(0);
~matrix.defsAt('r06').recall(0);

~matrix.defsAt('r07').recall(0);




e.setPat('r03', 0.0, [0.7, 2.0], [0.07, 0.3], 0.1);

e.setPat('r06', 0.0, [0.7, 2.0], [0.07, 0.2], 0.1);

e.setPat('r07', 0.0, [0.7, 1.0], [0.07, 0.1], 0.1);

(
~ind = 158;
a = [
	\rx, Pwhite(-pi, pi, inf),
	\ry, Pwhite(-pi, pi, inf),
	\rz, Pwhite(-pi, pi, inf),
	\ramp, Pseq(((0 ! 8) ++ [0.1, 0.4, 0.1, 0.4, 0.2, 0.3, 0.1, 0.3])*4, inf),
	\rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w0', 'revwrpm', ~gesbufs[~ind], a, ~matrix.beatdur, 1.0, 1 );
)

e.setWarp('w0', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.0, 'iamp', 1.0, 'ramp', 0.3, 'rate', 1, 'freq', 1])




e.setWarp('w1', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.0, 'iamp', 1.0, 'ramp', 0.3, 'rate', 1, 'freq', 1])



~matrix.activateSkismSynth('primeTam')

~matrix.setSkismAmp('primeTam', 1)

~matrix.deactivateSkismSynth('primeTam')


~matrix.activateSkismSynth('cliqSaw')


~matrix.setSkismAmp('cliqSaw', 0.5)

~matrix.deactivateSkismSynth('cliqSaw')



~matrix.activateSkismSynth('latchOnset')

~matrix.setSkismAmp('latchOnset', 1.0)

~matrix.deactivateSkismSynth('latchOnset')



['flangingDecimator', 'granularReverb', 'feedbackSpectrum', 'cyclicWarp', 'latchOnset', 'cliqSaw', 'fxGrain', 'arhythmicGendy']



// next




~matrix.setBPM(131)

Pdef('mx1').clear

Pdef('mx1').play


e.setPat('b06', 0.0, [0.7, 1.0], [1.0, 2.0], 0.1);



e.setPat('b13', 0.0, [0.7, 1.0], [0.1, 0.3], 0.1);

e.setPat('b10', 0.0, [0.7, 2.0], [0.1, 0.3], 0.1);

e.setPat('b11', 0.0, [0.7, 2.0], [0.1, 0.3], 0.1);

e.setPat('b01', 0.0, [0.7, 2.0], [0.07, 0.2], 0.1);


e.setPat('r14', 0.0 [0.7, 2.0], [0.07, 0.1], 0.1);

e.setPat('r03', 0.0, [0.7, 2.0], [0.07, 0.1], 0.1);

e.setPat('r06', 0.0, [0.7, 2.0], [0.07, 0.2], 0.1);

e.setPat('r15', 0.0, [0.7, 2.0], [0.07, 0.1], 0.1);



~matrix.defsAt('r03').recall(0);
~matrix.defsAt('r06').recall(0);


~pat1 = ['b06', 'b10', 'b11', 'b13', 'b14','r12', 'r13', 'r14', 'r03', 'r06', 'r15', 'b01', 'b02', 'b03'].collect({|name|
	Pdef(name)
});

Pdef('mx1', Ppar(
	~pat1
)).play



Pdef('mx1').play

e.freeWarp('w1')


(
~ind = 152;
c = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\iamp, Pseq((0 ! 32) ++ (0 ! 32) * 0.2, inf),
	// \wamp, Pseq((0 ! 24) ++ (1 ! 8), inf),
	\freq, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
	// \buf, Pseq( (~gesbufs[0] ! 32 ) ++ (~gesbufs[4] ! 32 ), inf ),
	// \buf, Pseq([47, 73, 23, 35].collect({|ind| ~gesbufs[ind] }).mirror2, inf)
];
e.playWarp('w0', 'revwrpm', ~gesbufs[~ind], c, ~matrix.beatdur, 1, 1 );

)

e.freeWarp('w0')

(
~ind = 134;
d = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\iamp, Pseq((0 ! 32) ++ (0 ! 32) * 0.2, inf),
	// \wamp, Pseq((0 ! 24) ++ (1 ! 8), inf),
	\freq, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
	// \buf, Pseq( (~gesbufs[0] ! 32 ) ++ (~gesbufs[4] ! 32 ), inf ),
	// \buf, Pseq([47, 73, 23, 35].collect({|ind| ~gesbufs[ind] }).mirror2, inf)
];
e.playWarp('w1', 'revwrpm', ~gesbufs[~ind], d, ~matrix.beatdur, 1, 1 );

)

e.setWarp('w0', ['iamp', 0])

e.freeWarp('w1')

s.queryAllNodes

( 'rate': 1.025, 'bpm': 120.0, 'index': 74 )
( 'rate': 1.025, 'bpm': 120.0, 'index': 133 )
( 'rate': 1.025, 'bpm': 120, 'index': 119 )
( 'rate': 1.025, 'bpm': 120.0, 'index': 152 )

// final


~player.start(~foa)


~player.setFoa('zoom', 1.0)
~player.setFoa('push', 1.0)


// 38 niice

// 30, 42 fuck yeah

~ind0 = 38

~player.loadData(~ind0)

~player.play(~ind0, 0, ['zoom', 'push'].choose, 0)

~player.set(~ind0, 1);

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

~player.set(~ind2, 1);

~player.free(~ind2)




//

~ind3 = 34

~player.loadData(~ind3)

~player.play(~ind3, 0, ['zoom', 'push'].choose, 0)

~player.set(~ind3, 1.0)

~player.free(~ind3)