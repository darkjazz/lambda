(
~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2, screenX: 1024, screenY: 768, mode: 1, decoderType: 'binaural', 'localDecoder': true, bpm: 157, channels: 2, foa: #[zoom,push], dbname: "ges_ld_00", patdefs: "patternDefsPoni.scd", initPdefs: ['r00', 'r01', 'r02', 'r03', 'b00', 'b01', 'b04', 'b10', 'b11', 'b12'], worldDim: 21, ip: "127.0.0.1");
e = SpEnvir(~settings)
)

(
{
	SynthDef('bpm', {
		var input, fft, beat;
		input = SoundIn.ar([0]);
		fft = FFT(LocalBuf(1024), input);
		beat = BeatTrack.kr(fft);
		SendReply.kr(beat[0], '/beats', beat[3])
	}).add
	Server.default.sync;
	~synth = Synth('bpm')
}.fork

)


Ndef('imp', { Impulse.ar([1/3, 1/7]) }).play

Ndef('imp').free

~synth.free

Server.killAll


OSCdef('listenBPM', {|ms|
	Post << "Current BPM: " << (ms[3] * 60).round(0.1) << Char.nl;
	~matrix.setBPM((ms[3] * 60).round(0.1))
}, '/beats', s.addr)


~gesbufs[0].size

(
~gespaths = (Paths.soundDir +/+ "evolver/wrp/*").pathMatch;
~gesbufs = GESBufferLoader(~gespaths);
)



~matrix.setBPM(101)



(
~selected = ~drnbufs.select({|buf| buf.duration > 1.0 });
~avgdur = ~matrix.beatdur * 8;
Tdef('drone', {
	loop({
		~args = [
			'out', ~matrix.decoder.bus, 'buf', ~selected.choose,
			'wrp', rrand(0.33, 1.0),
			'freq', [0.5, 1.0, 2.0].choose, 'wsize', rrand(0.05, 0.2),
			'dens', rrand(3, 15), 'randr', rrand(0.01, 0.2),
			'room', rrand(20, 300), 'rtime', rrand(2.0, 10.0),
			'ramp', rrand(0.3, 1.0), 'eamp', rrand(0.5, 1.0),
			'wamp', rrand(0.2, 0.7), 'dur', ~avgdur * rrand(1.0, 4.0),
			'rx', rrand(0.01, 0.3), 'ry', rrand(0.01, 0.3), 'rz', rrand(0.01, 0.3),
			'rng', 1
		];
		Synth.before(~matrix.decoder.synth, 'wrpdrn', ~args);
		([0.5, 0.75, 1.0].choose * ~avgdur).wait;
	})
}).play

)


Tdef('drone').clear



~gesbufs.size

s.scope(2)

s.queryAllNodes

~matrix.setBPM(113)


(
// ~freqs.size = Array.twinPrimes(47, 1001).select({|it, i| it.odd });
~freqs = Array.primeSeries(58, 47, 5);
~ranges = ~freqs.clump((~freqs.size/3).floor);

SynthDef('prsine', {|out, efx, freq, amp, dur, ang|
	var sig, bf;
	sig = SinOsc.ar(freq, 0, 0.5) + Resonz.ar(Dust.ar(1011), freq, 10 / freq, 500) *
	EnvGen.kr(Env.perc, timeScale: dur, doneAction: 2);
	bf = FoaEncode.ar(Mix(sig), FoaEncoderMatrix.newDirection);
	bf = FoaRotate.ar(bf, ang);
	Out.ar(efx, bf[1] * amp);
	Out.ar(out, bf * amp)
}).add;
~sinebus = Bus.audio(Server.default);
)

(
~rev = SynthDef('reverb', {arg out, in, revamp=0.05, dry=0.0, revtime=3.1;
	var sig, bf;
	sig = In.ar(in);
	sig = GVerb.ar(sig, 150, revtime, drylevel: dry, earlyreflevel: revamp);
	sig = sig.dup.flat;
	bf = FoaEncode.ar(Array.fill(4, { |i|
			IFFT( PV_Diffuser( FFT( LocalBuf(1024), sig[i]), Dust.kr(200.0) ))
	}), FoaEncoderMatrix.newAtoB('fud'));
	Out.ar(out, bf)
}).play(~matrix.decoder.synth, ['out', ~matrix.decoder.bus], \addBefore)

)

~rev.free


(
~matrix.onsetFunc_({
	if (0.3.coin) {
		Synth.before(~rev, 'prsine', ['out', ~decoder.bus, 'efx', ~sinebuss, 'freq', ~ranges[0].choose, 'amp', 0.6.rand, 'dur', 0.3, 'ang', rrand(-pi, pi)]);
	};
	if (0.1.coin) {
		Synth.before(~rev, 'prsine', ['out', ~decoder.bus, 'efx', ~sinebus, 'freq', ~ranges[1].choose, 'amp', 0.4.rand, 'dur', 0.2, 'ang', rrand(-pi, pi)]);
	};
	if (0.3.coin) {
		Synth.before(~rev, 'prsine', ['out', ~decoder.bus, 'efx', ~sinebuss, 'freq', ~ranges[2].choose, 'amp', 0.5.rand, 'dur', 0.1, 'ang', rrand(-pi, pi)]);
	};
});
)

~matrix.onsetFunc_({})

s.queryAllNodes

s.sendMsg("/n_free", 83645)


// 73, 74, 75, 76, 77

// 19 hih

(
~wrp0 = Synth.tail(~matrix.group, 'wrprevm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.0, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[23], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

Pdef('swrp0',
	Pbind(
		\type, \set, \id, ~wrp0.nodeID, \delta, Pn(~matrix.beatdur * 4, inf),
		\rx, Pwhite(-pi, pi, inf),
		\ry, Pbrown(0, 2pi, 0.125pi, inf),
		\rz, Pbrown(0, 2pi, 0.125pi, inf),
		\ramp, Pseq([0.0, 0.4, 0.0, 0.8, 0.0, 0.6], inf),
		\args, #[rx, ry, rz, ramp]
	)
).play
)

~wrp0.set('amp', 1.0, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.1)

~wrp0.free; Pdef('swrp0').clear


s.record

s.scope(2)

s.stopRecording

// 145 of perc i know you are not going to remember but if you ever want to be bathed in bass again

(
~wrp1 = Synth.tail(~matrix.group, 'wrprevm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.0, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[29], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

Pdef('swrp1',
	Pbind(
		\type, \set, \id, ~wrp1.nodeID, \delta, Pn(~matrix.beatdur, inf),
		\rx, Pwhite(-pi, pi, inf),
		\ry, Pbrown(0, 2pi, 0.125pi, inf),
		\rz, Pbrown(0, 2pi, 0.125pi, inf),
		\freq, Prand([0.5, 0.7, 1.4, 1.0, 2.0], inf),
		\rate, Pseq([0.25, 2.0, 0.125, 0.5, 1.0], inf),
		\iamp, Pseq([1.0, 1.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.0, 0.0, 0.0] * 0.7, inf),
		\ramp, Pseq([0.0, 0.0, 1.0, 1.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0] * 0.8, inf),
		\args, #[rx, ry, rz, freq, rate]
	)
).play
)

~wrp1.set('amp', 1.0, 'wamp', 0.0, 'iamp', 0.1, 'ramp', 0.1, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.125)

~wrp1.free; Pdef('swrp1').clear

s.queryAllNodes

(
~wrp2 = Synth.tail(~matrix.group, 'revwrpm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[35], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

Pdef('swrp2',
	Pbind(
		\type, \set, \id, ~wrp2.nodeID, \delta, Pn(~matrix.beatdur / 4, inf),
		\rx, Pwhite(-0.5pi, 0.5pi, inf),
		\ry, Pbrown(0, 2pi, 2pi/16, inf),
		\rz, Pbrown(0, 2pi, 2pi/16, inf),
		\rate, Prand(Array.geom(5, 0.125, 2**(1/5)), inf),
		\wrp, Prand(Array.geom(7, 0.125, 2**(1/7)), inf),
		\args, #[rx, ry, rz, rate, wrp]
	)
).play
)

~wrp2.set('amp', 1.0, 'wamp', 0.03, 'iamp', 0.1, 'ramp', 0.3, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.125)

~wrp2.free; Pdef('swrp2').clear

// for hackpact 10, 12, 13, 15

// 10 & 24 & 15
// 27, 30, 35, 39, 40, 44



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

~wrp3.free; Pdef('swrp3').clear

s.queryAllNodes


Pdef('matrix', Ppar([ Pdef('b02'), Pdef('b03'), Pdef('b04'), Pdef('b05'), Pdef('b07'), Pdef('b08'), Pdef('b09'), Pdef('b10'), Pdef('b11'), Pdef('b12'), Pdef('d00'), Pdef('d01'), Pdef('d02'), Pdef('d03'), Pdef('d10'), Pdef('d11'), Pdef('d12'), Pdef('d13'), Pdef('p01') ]))


Pdef('matrix', Ppar([ Pdef('r00'), Pdef('r01'), Pdef('r02'), Pdef('r03')  ]))


['b02', 'b03', 'b04', 'b05', 'b07', 'b08', 'b09', 'b10', 'b11', 'b12', 'd00', 'd01', 'd02', 'd03', 'd10', 'd11', 'd12', 'd13']



~matrix.defsAt('r00').setActives(nil, { rrand(0.1, 0.01) });
~matrix.defsAt('r01').setActives(nil, { rrand(0.1, 0.01) });
~matrix.defsAt('r02').setActives(nil, { rrand(0.1, 0.01) });


~matrix.defsAt('b10').setActives(nil, { rrand(0.1, 0.01) });


~matrix.defsAt('b11').setActives(nil, { rrand(0.1, 0.01) });
~matrix.defsAt('b12').setActives(nil, { rrand(0.1, 0.01) });



~matrix.defsAt('b08').setActives(nil, { rrand(0.1, 0.01) });
~matrix.defsAt('d00').setActives(nil, { rrand(0.1, 0.01) });


~matrix.defsAt('b03').recall(0);
~matrix.defsAt('b09').recall(0);

~matrix.defsAt('b05').recall(0);

LFPulse.kr(


(
~matrix.defsAt('r00').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.2, 1.0) },
	{ exprand(0.05, 0.2) },
	0.1
);

~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ exprand(0.2, 1.0) },
	{ exprand(0.05, 0.4) },
	0.1
);

~matrix.defsAt('r02').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.1, 0.1) },
	0.1
);

~matrix.defsAt('r03').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.1, 0.2) },
	0.1
);

)

~matrix.set(['dur'], ['b03', 'b09', 'b05'], 0.1)
~matrix.undo(['b03', 'b05', 'b09'])

~matrix.kill(['b03', 'b05', 'b09'])

~matrix.defsAt('b03').setActives({rrand(0.4, 1.0)});

~matrix.defsAt('b05').setActives(nil, { rrand(0.1, 0.01) });
~matrix.defsAt('b09').setActives(nil, { rrand(0.1, 0.01) });


~matrix.defsAt('r00').recall(0);
~matrix.defsAt('r01').recall(0);
~matrix.defsAt('r02').recall(0);
~matrix.defsAt('r03').recall(0);

~matrix.defsAt('b09').recall(0);



(
~matrix.defsAt('b10').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.3, 1.0) },
	{ exprand(0.1, 0.4) },
	0.1
);

~matrix.defsAt('b11').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.3, 0.7) },
	{ exprand(0.1, 0.3) },
	0.1
);

~matrix.defsAt('b12').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.6, 1.0) },
	{ exprand(0.1, 0.3) },
	0.1
);

)




~matrix.defsAt('b10').setActives(nil, { rrand(0.1, 0.01) });
~matrix.defsAt('b11').setActives(nil, { rrand(0.1, 0.01) });
~matrix.defsAt('b12').setActives(nil, { rrand(0.1, 0.01) });


~matrix.defsAt('b10').recall(0);
~matrix.defsAt('b11').recall(0);
~matrix.defsAt('b12').recall(0);



~matrix.set(['dur'], ['b11'], 1.5)
~matrix.undo(['b03', 'b05', 'b09'])


(
~matrix.defsAt('b00').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 0.7) },
	{ exprand(0.06, 0.1) },
	0.1
);

~matrix.defsAt('b01').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 0.7) },
	{ exprand(0.1, 0.3) },
	0.1
);

)

~matrix.defsAt('b02').setActives(nil, { rrand(0.1, 0.01) });
~matrix.defsAt('b08').setActives(nil, { rrand(0.1, 0.01) });


~matrix.defsAt('b00').recall(0);
~matrix.defsAt('b08').recall(0);




~matrix.defsAt('b04').recall(0);


~matrix.defsAt('b04').ctrls.select({|ctrl| ctrl.active.booleanValue  })


(
~matrix.defsAt('b04').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.6, 1.0) },
	{ exprand(2.0, 4.0) },
	0.1
);

~matrix.defsAt('b02').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.4, 0.8) },
	{ exprand(0.1, 0.3) },
	0.1
);

)


~matrix.defsAt('b10').setActives(nil, { rrand(0.1, 0.01) });
~matrix.defsAt('b11').setActives(nil, { rrand(0.1, 0.01) });


~matrix.defsAt('b11').recall(0);
~matrix.defsAt('b10').recall(0);



(
~matrix.defsAt('d00').setControls(
	{ [0, 1].wchoose([0.5, 0.5]) },
	{ exprand(0.3, 0.7) },
	{ exprand(0.1, 0.3) },
	0.1
);

~matrix.defsAt('d01').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.6, 1.0) },
	{ exprand(0.1, 0.2) },
	0.1
);

)

~matrix.defsAt('d00').setActives(nil, { rrand(0.1, 0.01) });
~matrix.defsAt('d01').setActives(nil, { rrand(0.1, 0.01) });


~matrix.defsAt('d00').recall(0);
~matrix.defsAt('d01').recall(0);






(
~matrix.defsAt('d02').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.1, 0.3) },
	0.1
);

~matrix.defsAt('d03').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.4, 1.0) },
	{ exprand(0.1, 0.3) },
	0.1
);

)

~matrix.defsAt('d02').setActives(nil, { rrand(0.1, 0.01) });
~matrix.defsAt('d03').setActives(nil, { rrand(0.1, 0.01) });


~matrix.defsAt('d02').recall(2);
~matrix.defsAt('d11').recall(0);

~matrix.defsAt('d12').recall(0);
~matrix.defsAt('d13').recall(0);



(
~matrix.defsAt('d04').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.1, 0.2) },
	0.1
);

~matrix.defsAt('d05').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.07, 0.2) },
	0.1
);
)

~matrix.defsAt('d12').setActives(nil, { rrand(0.1, 0.01) });
~matrix.defsAt('d13').setActives(nil, { rrand(0.1, 0.01) });





~matrix.defsAt('b0

	6').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.3, 0.8) },
	{ exprand(2.0, 4.0) },
	0.1
);

~matrix.defsAt('r01').setActives(nil, { rrand(0.1, 0.01) });
~matrix.defsAt('r02').setActives(nil, { rrand(0.1, 0.01) });


~matrix.defsAt('b00').recall(0);
~matrix.defsAt('b08').recall(0);

~matrix.defsAt('b10').recall(0);

~matrix.defsAt('b11').recall(1);
~matrix.defsAt('b12').recall(0);

~matrix.defsAt('r01').recall(0);
~matrix.defsAt('r02').recall(0)


['b02', 'r01'].do({|name|
	~matrix.defsAt(name).setActives(nil, { rrand(0.05, 0.01) });
})


['b02', 'r01'].do({|name|
	~matrix.defsAt(name).recall(3)
})


['b07', 'b10', 'b11', 'b12', 'b08', 'r01', 'b02'].do({|name|
	~matrix.defsAt(name).recall(0)
})



['b10', 'b11', 'b12', 'b08', 'r01'].do({|name|
	~matrix.defsAt(name).setActives(nil, { rrand(0.01, 0.1) });
})


['b10', 'b11', 'b12', 'b08', 'r01'].do({|name|
	~matrix.defsAt(name).setControls({ [0, 1].wchoose([0.8, 0.2]) }, { rrand(0.04, 0.2) });
})


(
Tdef('check', {
	var keys = ~matrix.defsAt('r02').ctrls.keys(Array);
	keys.do({|key|
		key.postln;
		~matrix.defsAt('r02').ctrls[key]['amp'] = 0.5;
		~matrix.defsAt('r02').ctrls[key]['dur'] = 0.1;
		~matrix.defsAt('r02').ctrls[key]['active'] = 1;
		(~matrix.beatdur * 16).wait;
		~matrix.defsAt('r02').ctrls[key]['active'] = 0;
	})
}).play
)

~key = 'r000'

(
~matrix.defsAt('r00').ctrls[~key]['amp'] = 1.0;
~matrix.defsAt('r00').ctrls[~key]['dur'] = 0.5;
~matrix.defsAt('r00').ctrls[~key]['active'] = 1
)

~matrix.defsAt(~pat).ctrls.keys(Array).size


[0, 1, 3, 4, 7, 10, 12, 14, 15, 22, 24, 28, 30, 31]

~instr = [0, 1, 3, 4, 7, 10, 12, 14, 22, 24, 28, 30, 31]

[0, 1, 3, 4, 7, 10, 12, 14, 15, 22, 24, 28, 30, 31]
[0, 1, 3, 4, 7, 10]

(
~pat = 'r00';
~keys = ~matrix.defsAt(~pat).ctrls.keys(Array).sort[~instr];
~keys.do({|key|
	~matrix.defsAt(~pat).ctrls[key]['amp'] = rrand(0.2, 0.3);
	~matrix.defsAt(~pat).ctrls[key]['dur'] = 0.2;
	~matrix.defsAt(~pat).ctrls[key]['active'] = 0
})

)

~matrix.defsAt(~pat).ctrls[~keys.first]['active'] = 0



~matrix.defsAt('d02').recall(0);



(

~matrix.defsAt('d00').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.07, 0.2) },
	0.1
);

~matrix.defsAt('d01').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.6, 1.0) },
	{ exprand(0.07, 0.2) },
	0.1
);

~matrix.defsAt('d02').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.6, 1.0) },
	{ exprand(0.05, 0.3) },
	0.1
);

~matrix.defsAt('d03').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.4, 1.0) },
	{ exprand(0.05, 0.2) },
	0.1
);

)




(
~matrix.patterndefs.do({|def| def.setActives(0) });
~hold = Synth.before(~decoder.synth, \hold, ['out', ~decoder.bus, 'buf', ~holdbufs.choose, 'amp', 1.0])
)

(
~matrix.patterndefs.do({|def| def.recall(0)  });
~hold.free; ~hold = nil;
)

(

~matrix.defsAt('b08').setControls(
	{ [0, 1].wchoose([1.0, 0.0 ]) },
	{ exprand(0.4, 1.0) },
	{ exprand(0.04, 0.2) },
	0.1
);

~matrix.defsAt('b07').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.3, 0.8) },
	{ exprand(0.05, 0.3) },
	0.1
);
)



~matrix.defsAt('b11').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.6, 1.0) },
	{ exprand(0.5, 1.0) },
	0.1
);


~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.05, 0.2) },
	0.1
);

~matrix.defsAt('r02').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.1, 0.3) },
	{ exprand(0.2, 0.5) },
	0.1
);


~matrix.defsAt('r05').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.3, 1.0) },
	{ exprand(0.05, 0.1) },
	0.1
);


~matrix.defsAt('b06').setControls(
	{ [0, 1].wchoose([1.0, 0.2]) },
	{ exprand(0.3, 0.7) },
	{ exprand(2.0, 4.0) },
	0.1
);


~matrix.hold



~matrix.defsAt('b06').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.1, 0.5) },
	{ exprand(3.0, 6.0) },
	0.1
);


~matrix.defsAt('b07').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 0.7) },
	{ exprand(0.1, 0.2) },
	0.1
);


~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.2, 1.0) },
	{ exprand(0.02, 0.2) },
	0.1
);

~matrix.defsAt('b02').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.3, 0.8) },
	{ exprand(0.3, 0.4) },
	0.1
);

~matrix.defsAt('b11').recall(0);
~matrix.defsAt('b02').recall(0);

~matrix.defsAt('b06').recall(0);

// ~matrix.defsAt('b08').recall(0);


~matrix.defsAt('r01').recall(0);

s.queryAllNodes

Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.3, 0.6), 'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(50, 45)], 'dur', exprand(0.7, 3.0), 'env', [Env.perc, Env.sine].choose] );


~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([0.9, 0.1]) },
	{ exprand(0.1, 0.5) },
	{ exprand(0.05, 0.1) },
	0.1
);

~matrix.defsAt('b10').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.1, 0.3) },
	0.1
);

~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ exprand(0.3, 0.6) },
	{ exprand(0.1, 0.4) },
	0.1
);

~matrix.defsAt('b06').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.3, 0.8) },
	{ exprand(2.0, 4.0) },
	0.1
);

~matrix.defsAt('b04').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.2, 0.6) },
	{ exprand(2.0, 4.0) },
	0.1
);

~matrix.defsAt('b12').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.3, 0.8) },
	{ exprand(0.1, 0.3) },
	0.1
);

~matrix.defsAt('b12').recall(0);

~matrix.defsAt('b11').recall(0);


~matrix.defsAt('b05').recall(0)


~matrix.addPatternBufferDef('b02', (64..127), 8, 4,
		['kpanilogo', 'yole', 'diansa', 'kokou', 'kakilambe', 'soli', 'mandiani'].reverse,
		2, "b2", 'bufproto', ~matrix.buffers.bits, 'bit01', true
	);

ctrls.select({|ctr| ctr.active == 1 }).postcs

s.record

s.stopRecording

~graphics = CinderApp(800, 600, mode: 0, path:"/Users/alo/dev/lambda/xcode/DerivedData/lambdaApp/Build/Products/Debug/lambda.app")

~graphics.open
~graphics.initWorld(19, 19, 19, 20);
~graphics.initGenerations([4,6],[4,6],17);

~graphics.setViewpoint(0.0, -100.0, 0.0, 0.0, 0.0, -20.0)

~graphics.setSymmetry(11)

~graphics.setPattern(6, 1, 1.0, 1, 1, 0.5, 0.9, 0.8);

~graphics.setPattern(22, 1, 0.7, 0, 0, 1.0, 0.0, 1.0);

~graphics.setPattern(12, 1, 0.7, 1, 1, 0.2, 0.4, 0.6);



~graphics.setPattern(9, 1, 1.0, 1, 1, 0.2, 0.9, 1.0);

// ~graphics.setPattern(10, 0, 1.0, 1, 1, 0.2, 0.2, 0.0);


~graphics.setPattern(13, 0, 1.0, 1, 1, 0.6, 0.7, 1.0);

~graphics.setPattern(14, 0, 1.0, 0, 1, 0.0, 1.0, 1.0);

~graphics.setPattern(19, 1, 1.0, 1, 0, 0.3, 0.4, 0.2);

~graphics.setPattern(20, 0, 0.3, 0, 0, 0.5, 0.9, 0.8);



(
~graphics.setViewpoint(0.0, 30.0, 0.0, 0.0, 0.0, 0.0);

~graphics.setPattern(2, 1, 1.0, 0, 0, 1.0, 1.0, 1.0);
)

~graphics.sendPredefined3DRule(\worms)

~graphics.sendPredefined3DRule(\sedimental)



(
Tdef(\sendVector, {
	loop({
		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		[ 0.0625, 0.125, 0.25].choose.wait;
	});
}).play;
)


['flangingDecimator', 'granularReverb', 'feedbackSpectrum', 'cyclicWarp', 'latchOnset', 'cliqSaw', 'fxGrain', 'arhythmicGendy']

~matrix.activateSkismSynth('primeTam')

~matrix.setSkismAmp('primeTam', 0.6)

~matrix.deactivateSkismSynth('primeTam')



~matrix.activateSkismSynth('latchOnset')

~matrix.setSkismAmp('latchOnset', 0.0)

~matrix.deactivateSkismSynth('latchOnset')



~matrix.activateSkismSynth('feedbackSpectrum')

~matrix.setSkismAmp('feedbackSpectrum', 0.8)

~matrix.deactivateSkismSynth('feedbackSpectrum')


s.queryAllNodes

s.sendMsg("/n_free", 1076)

~matrix.buffers['evo'].size

SynthDef(\bitSt2, {|out, efx, amp, emp, buf, dur|
	var sig;
	sig = Normalizer.ar(
		PlayBuf.ar(2, buf, BufRateScale.ir(buf) * 1.neg, 1, BufFrames.kr(buf)),
		amp) * EnvGen.kr(\env.kr(Env.newClear(8).asArray), timeScale: dur, doneAction: 2);
	Out.ar(efx, sig * emp);
	Out.ar(out, sig * amp)
}).add;

(

Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.3, 0.7), 'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(250, 248)], 'dur', exprand(0.5, 2.0), 'env', [Env.perc, Env.sine].choose] );
)

(
Tdef('tex', {
	loop({
		Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.4, 0.7), 'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(100, 104)], 'dur', exprand(0.4, 0.9), 'env', [Env.perc, Env.sine].choose] );
		rrand(0.1, 0.4).wait
	})
})
.play
)

Tdef('tex').clear

Server.killAll

~matrix.buffers['evo'].size

Quarks.gui

x=SynthDef('test', { Out.ar(0, Dust.ar(30)) }).play
x.free


o=SynthDef('out34', {|amp=0.3| Out.ar([2, 3], SoundIn.ar([0, 1]) * amp) }).play
o.set('amp', 0.03)
o.free


SparseMatrix.allPatterns['Dalah']


Archive.global[\matrix][\presets]



~player.defnames.size.rand

~player.start(~foa)


~player.setFoa('zoom', 1.0)
~player.setFoa('push', 1.0)


// 38 niice

// 30, 42 fuck yeah

~ind0 = 227

~player.loadData(~ind0)

~player.play(~ind0, 0, ['zoom', 'push'].choose, 0)

~player.set(~ind0, 1.0);

~player.free(~ind0)

s.queryAllNodes

// 53 fuck yeah!!!!

// 271

~ind1 = 21

~player.loadData(~ind1)

~player.play(~ind1, 0, ['zoom', 'push'].choose, 0)

~player.set(~ind1, 1.0)

~player.free(~ind1)


// 249 sick!

~ind2 = 249

~player.loadData(~ind2)

~player.play(~ind2, 0, ['zoom', 'push'].choose, 0)

~player.set(~ind2, 1.0);

~player.free(~ind2)



//

~ind3 = 34

~player.loadData(~ind3)

~player.play(~ind3, 0, ['zoom', 'push'].choose, 0)

~player.set(~ind3, 1.0)

~player.free(~ind3)




s.sendMsg("/n_free", 100953)

s.queryAllNodes