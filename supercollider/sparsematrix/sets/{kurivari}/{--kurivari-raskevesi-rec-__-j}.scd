
Pdef('efx').play

~matrix.efxamps['efx3'] = 0.1

~matrix.defsAt('r17').assignEfx(
	(efx3: (0..15))
)


~matrix.efxamps['efx2'] = 0.0

~matrix.defsAt('r17').assignEfx(
	(efx2: (0..15))
)


~matrix.efxamps['efx1'] = 0.1

~matrix.defsAt('r17').assignEfx(
	(efx1: (16..31))
)

~matrix.beatdur * 4 / 60

Scale.minor.ratios.reciprocal[2]



(
// Server.default.record;
~setpat = {|name|
	var pat = e.getPat(name);
	pat.ctrls.keysValuesDo({|key, ctrl|
		var on = pat.patterns[key].select(_.odd).size;
		if (on == 1) {
			ctrl.dur = rrand(0.07, 0.13)
		}
		{
			ctrl.dur = exprand(on.reciprocal*0.25,on.reciprocal*2.0)
		};
		ctrl.amp = ctrl.dur.linlin(0, 1, 0.5, 0.0);
	});
	e.setPat(name, 1.0, nil, nil, 0.1);
};
~ind = 146;
~buf = ~kvbufs[~ind];
~lbpm = ~kvbufs.loops[~buf.path.basename.asSymbol].bpm;
~kvbufs.search(~lbpm ).do(_.postln);
~bpm = ~lbpm+(~lbpm/2);
~matrix.setBPM(~bpm);
~ind2 = 72;
~buf2 = ~mesabufs[~ind2];
~loop2 = ~mesabufs.loopsAtBuf(~buf2);
~bpm2 = ~loop2.bpm;
~bpm2 = if (~bpm2 > 100.0) {~bpm2 / 2} { ~bpm2 };
~ind2 = 145;
~buf2 = ~kvbufs[~ind2];
~rbpm2 = ~kvbufs.loops[~buf2.path.basename.asSymbol].bpm;
~rbpm2 = if (~rbpm2 > 100.0) {~rbpm2 / 2} { ~rbpm2 };
~counter = 0;
~pw1 = [
	[
		\buf, Pseq((~buf ! 32) ++ (~buf1 ! 32) ++ (~buf2 ! 32) ++ (~buf ! 32), 1),
		\rate, Pseq((1 ! 32) ++ (1 ! 32) ++ (~rbpm2/~lbpm ! 32) ++ (1 ! 32), 1),
		\fnc, Pfunc({
			if ((~counter >= 64).and(~counter < 128)) {
				Post << "HIT r17" << Char.nl;
				~setpat.('r17');
				Pdef('r17').play;
			};
			if ((~counter >= 164).and(~counter < 256)) {
				Post << "HIT r17" << Char.nl;
				~setpat.('r17');
				Pdef('r17').play;
			};
			if ((~counter >= 292).and(~counter < 440)) {
				Post << "HIT r17" << Char.nl;
				~setpat.('r17');
				Pdef('r17').play;
			};
			if (~counter == 256) {
				~matrix.activateSkismSynth('magFreeze');
				~matrix.setSkismAmp('magFreeze', 0.5);
			};
			if (~counter == 444) {
				~matrix.setSkismAmp('magFreeze', 1.0);
			};
			if (~counter == 508) {
				e.freeWarp('w1');
				SystemClock.sched(~matrix.beatdur * 8, {
					e.freeWarp('w2');
					~matrix.deactivateSkismSynth('magFreeze');
					// Server.default.stopRecording;
					nil
				})
			};
			Post << "BAR " << ~counter << Char.nl;
			~counter = ~counter + 4;
		}),
		\delta, ~matrix.beatdur * 4
	],
	[
		\wctr, Pseq((0 ! 32) ++ (0.4 ! (256-32)) ++ [0], 1),
		\ramp, Pseq(( (0.0 ! 16) ++ [0.05, 1.0, 0.1, 1.0, 0.1, 1.0, 0.1, 1.0].mirror2 ) * 0.5, inf),
		\wamp, Pseq(( [1.0, 1.0, 0.1, 1.0, 0.1, 0.3, 0.1, 0.1].mirror2 ++ (0.0 ! 16)), inf) * Pkey('wctr', inf),
		\delta, ~matrix.beatdur * 2
	],
	[
		\rx, Pwhite(-pi, pi, inf),
		\ry, Pwhite(-pi, pi, inf),
		\rz, Pwhite(-pi, pi, inf),
		\delta, ~matrix.beatdur
	]
];
e.playParWarp('w1', 'wrprevm', ~buf, ~pw1, 1.0, 1);
~ind3 = 43;
~buf3 = ~kvbufs[~ind3];
~rbpm3 = ~kvbufs.loops[~buf3.path.basename.asSymbol].bpm;
~rbpm3 = if (~rbpm3 > 100.0) {~rbpm3 / 2} { ~rbpm3 };
~pw2 = [
	[
		\iamp, Pseq((0 ! 256) ++ (0.7 ! 768) ++ [0], 1),
		\ramp, Pseq([0, 0.3], inf) * Pkey('iamp', inf),
		\delta, ~matrix.beatdur/2
	],
	[
		\rx, Prand(Array.series(17, 0, 2pi/17), inf),
		\ry, Prand(Array.series(17, 0, 2pi/17), inf),
		\rz, Prand(Array.series(17, 0, 2pi/17), inf),
		\delta, ~matrix.beatdur
	]
];
e.playParWarp('w2', 'revwrpm', ~buf3, ~pw2, 0.5, ~rbpm3 / ~lbpm);

)


e.setPat('r10', 0.0, nil, nil, 0.1);
e.setPat('r17', 0.0, nil, nil, 0.1);


(
e.setWarp('w1', ['amp', 1, 'wrp', 0.25, 'wamp', 0.6])
)


e.freeWarp('w1');

e.freeWarp('w2')



e.setPwarp('w1', b, ~matrix.beatdur*4 )


Pdef('mx2',
	Ppar(['r02', 'b05', 'b04', 'b07'].collect({|nm| Pdef(nm) }))
).play

e.setPat('r17', 1.0, [0.3, 0.3], nil, 0.1);

Pdef('r17').play

~matrix.activateSkismSynth('magFreeze')

~matrix.setSkismAmp('magFreeze', 0.5)

~matrix.deactivateSkismSynth('magFreeze')


~matrix.activateSkismSynth('roosaShift')

~matrix.setSkismAmp('roosaShift', 0.1)

~matrix.deactivateSkismSynth('roosaShift')

s.queryAllNodes

s.sendMsg("/n_free", 6379)

(
)

(
[ 'r08', 'r09', 'r10', 'r11', 'r15', 'r16', 'r17' ].do({|name|
	var pat = e.getPat(name);
	e.setPat(name, 0.0, [0.7, 0.7], [0.1, 0.1], 0.1);
	pat.ctrls.keysValuesDo({|key, ctrl|
		var on = pat.patterns[key].select(_.odd).size;
		if (on == 1) {
			ctrl.dur = rrand(0.07, 0.13)
		}
		{
			ctrl.dur = exprand(on.reciprocal*0.25,on.reciprocal*2.0)
		};
		ctrl.amp = ctrl.dur.linlin(0, 1, 0.5, 0.0);
	})

})
)

(
// e.setPat('r08', 1.0, [0.1, 0.6], [0.04, 0.07], 0.1);
// e.setPat('r09', 0.5, [0.1, 0.6], [0.04, 0.1], 0.1);
e.setPat('r16', 0.7, [0.1, 0.6], [0.04, 0.1], 0.1);
e.setPat('r15', 1.0, [0.1, 0.6], [0.05, 0.1], 0.1);
)

Pdef('r15').play

~matrix.loadDefFuncs

~occ = ~matrix.patterndefs['r17'].patterns.collect(_.occurrencesOf(1));
Pdef('r17').source.list.collect(_.patternpairs).collect({|it|
	[it[1], it[19].key, ~occ[it[19].key]].postln
})

Pdef('r17').source.list.collect(_.patterns)


2.65.reciprocal*60*4

92.31+(92.31/2)



// 56, 43, 108, 118, 88, 140, 145, 101

(
~ind = 145;
~buf = ~kvbufs[~ind];
~rbpm = ~kvbufs.loops[~buf.path.basename.asSymbol].bpm;
~rbpm = if (~rbpm > 100.0) {~rbpm / 2} { ~rbpm };
c = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf)
];
e.playWarp('w2', 'revwrpm', ~buf, c, ~matrix.beatdur/2, 1.0, ~rbpm / ~lbpm);
// e.setWarp('w2', ['wamp', 0.5]);
)


e.setPwarp('w2', c, ~matrix.beatdur/2)

(
e.setWarp('w2', ['amp', 1, 'wrp', 0.25, 'wamp', 0.0, 'iamp', 0.4, 'ramp', 0.5,
	'rate', ~rbpm / ~lbpm, 'freq', 1, 'randr', 0.04, 'wsize', 0.1, 'dens', 4])
)

e.freeWarp('w2')