// süsinik

(

~rdefs = ( {|i| ("r" ++ i.asString.padLeft(2, "0")).asSymbol } ! 18 );
~bdefs = ( {|i| ("b" ++ i.asString.padLeft(2, "0")).asSymbol } ! 18 );
~ddefs = ( {|i| ("d" ++ i.asString.padLeft(2, "0")).asSymbol } ! 16 );
~mdefs = (0..3).collect({|i| ("m0" ++ i.asString).asSymbol });

~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2,
	screenx: 1024, screenY: 768, mode: 1,
	localDecoder: true, ambiOrder: 3,
	decoderType: 'binaural',
	// decoderType: 'hoa', directions: ~directions, distances: ~distances,
	bpm: 119, channels: 2, foa: #[zoom,push], dbname: "ges_ld_00",
	patdefs: "patternDefsMesa.scd",
	initPdefs: ~rdefs ++ ~bdefs ++ ~ddefs ++ ~mdefs, worldDim: 21, ip: "127.0.0.1"
);
e = SpEnvir(~settings)

)

Server.default.record

~decoder.recordBformat

~decoder.stopRecording

~kvbufs.search(88.235).do(_.postln)


(
// ~decoder.recordBformat;
~changewrp = {|activate, kill|
	var ind, pw, rx, ry, rz, num;
	if (kill.notNil) {e.freeWarp(kill)};
	ind = activate.ind;
	num = rrand(6, 23);
	rx = [Pbrown(-pi, pi, 0.125pi, inf), Prand(Array.series(num, 0, 2pi/num) - pi, inf), Pwhite(-pi, pi, inf)].choose;
	ry = [Pbrown(-pi, pi, 0.125pi, inf), Prand(Array.series(num, 0, 2pi/num) - pi, inf), Pwhite(-pi, pi, inf)].choose;
	rz = [Pbrown(-pi, pi, 0.125pi, inf), Prand(Array.series(num, 0, 2pi/num) - pi, inf), Pwhite(-pi, pi, inf)].choose;
	pw = [\rx, rx, \ry, ry, \rz, rz];
	e.playWarp(activate.name, 'revwrpm', ~kvbufs[ind], pw, ~matrix.beatdur*activate.delta, activate.amp);
	e.setWarp(activate.name, ~wrpargs);
};

~grps = [
	[52, 197, 199, 60, 202, 212],
	[52, 12, 13, 20, 21, 25],
	[52, 32, 33, 36, 37, 43],
	[52, 12, 33, 53, 91, 55],
	[52, 50, 52, 53, 55, 57],
	[52, 66, 81, 85, 91, 95],
	[52, 105, 107, 200, 50, 55];
];

~bufnums = ~grps.collect(_.mirror2).do({|arr| arr.swap(7, 10); arr.swap(8, 9) });

Tdef('struct', {
	~start = AppClock.seconds;
	~wrpargs = ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.1, 'iamp', 0.5, 'ramp', 0.05, 'rate', 1.0, 'freq', 1];
	~bufnums.do({|inds, i|
		var deltas, names, kills, amps;
		Post << "starting group " << inds << " index " << i << Char.nl;
		if (i == 1) {
			~wrpargs = ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.2, 'iamp', 0.5, 'ramp', 0.1, 'rate', 1.0, 'freq', 1];
		};
		if (i == 6) {
			~wrpargs = ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.1, 'iamp', 0.4, 'ramp', 0.05, 'rate', 1.0, 'freq', 1];
		};
		deltas = [24, 12, 12, 12, 12, 24].dup.flat * ~matrix.beatdur;
		names = ['w0', 'w1', 'w2', 'w1', 'w2', 'w1'].dup.flat;
		kills = [nil, nil, nil, nil, 'w0', 'w2'].dup.flat;
		amps = (0.5 ! 12);
		inds.do({|ind, i|
			~changewrp.((ind: ind, amp: amps[i], delta: ~matrix.beatdur*2, name: names[i]), kills[i]);
			deltas[i].wait;
		})
	});
	e.freeWarp('w1');
	Post << "Finished in " << (AppClock.seconds - ~start / 60) << " minutes" << Char.nl;
	1.wait;
	~decoder.stopRecording
}).play
)


Tdef('struct').stop;

e.freeWarp('w0'); e.freeWarp('w2'); e.freeWarp('w1');




MasterEQ(2);
Server.default.scope(2);

Server.default.queryAllNodes

// record binaural
(
fork {
	var order = 3;
	thisProcess.platform.recordingsDir = "/Users/kurivari/snd/rec";
	~buf = Buffer.read(Server.default, thisProcess.platform.recordingsDir +/+ "BF_250209_123350.wav");
	HOABinaural.loadbinauralIRs(Server.default);
	HOABinaural.loadHeadphoneCorrections(Server.default);
	Server.default.sync;
	SynthDef('play-bf-3o', {|buf, amp|
		var hoa;
		hoa = HoaNFCtrl.ar(PlayBuf.ar(16, buf, BufRateScale.kr(buf)), AtkHoa.refRadius, 3.25, 3);
		Out.ar(0, Limiter.ar(HOABinaural.ar(3, hoa * amp), 0.99))
	}).add;
	Server.default.sync;
	~recorder = Recorder(Server.default);
	~recorder.filePrefix = "BIN_";
	~recorder.recHeaderFormat = "wav";
	~recorder.recSampleFormat = "int24";
	~recorder.record(bus: 0, numChannels: 2);
	Server.default.sync;
	Synth.head(1, 'play-bf-3o', ['buf', ~buf, 'amp', -1.0.dbamp]);
}
)

~recorder.stopRecording


Server.killAll

// record 16 channel

(
~loc =  [
	(x: -0.88, y: 3.65, z: 1.1),
	(x: 0.88, y: 3.65, z: 1.1),
	(x: -2.2, y: 1.2, z: 1.1),
	(x: 2.2, y: 1.2, z: 1.1),
	(x: - 2.2, y: -1.3, z: 1.1),
	(x: 2.2, y: - 1.3, z: 1.1),
	(x: - 0.7, y: - 3.65, z: 1.1),
	(x: 0.7, y: - 3.65, z: 1.1),
	(x: - 1, y: 2.75, z: 1.72),
	(x: 2.78, y: 3.78, z: 1.72),
	(x: - 2.01, y: 0 , z: 1.72),
	(x: 1.99, y: 0 , z: 1.72),
	(x: -1, y: -2.75, z: 1.72),
	(x: 1, y: -2.75, z: 1.72),
	(x: 0, y: 1.96, z: 2.2),
	(x: 0, y: -1.96, z: 2.2)
];

~spheres = ~loc.collect({|args| Cartesian(*args.asArray).asSpherical });


~spkrmap = [
	(out: 1, dec: 0),
	(out: 3, dec: 1),
	(out: 5, dec: 2),
	(out: 7, dec: 3),
	(out: 6, dec: 4),
	(out: 4, dec: 5),
	(out: 2, dec: 6),
	(out: 0, dec: 7),
	(out: 9, dec: 8),
	(out: 11, dec: 9),
	(out: 13, dec: 10),
	(out: 12, dec: 11),
	(out: 10, dec: 12),
	(out: 8, dec: 13),
	(out: 14, dec: 14),
	(out: 15, dec: 15)
];

~directions = ~spkrmap.collect({|ev|
	[~spheres[ev.out].theta, ~spheres[ev.out].phi]
});

// ~azim = ~spkrmap.collect({|ev| ~spheres[ev.out].theta });
// ~elev = ~spkrmap.collect({|ev| ~spheres[ev.out].phi });

~distances = ~spkrmap.collect({|ev| ~spheres[ev.out].rho });

// DecodeAmbi3O.addSetup('Sala_de_Madeira', ~azim, ~elev);

SynthDef('decoder-3o', {|buf, amp=1.0|
	var hoa, bf;
	bf = PlayBuf.ar(16, buf, BufRateScale.kr(buf), doneAction: 2);
	hoa = HoaDecodeMatrix.ar(
		HoaNFCtrl.ar(bf, AtkHoa.refRadius, AtkHoa.refRadius, 3),
		HoaMatrixDecoder.newProjection(~directions, beamShape: 'energy', match: 'energy', order: 3)
	);
	hoa = DegreeDist.ar(hoa, ~distances);
	Out.ar(0, Limiter.ar(hoa * amp, 0.99));
}).add;

MasterEQ(16);
Server.default.scope(16);

thisProcess.platform.recordingsDir = "/Users/kurivari/snd/rec";
~recorder = Recorder(Server.default);
~recorder.filePrefix = "DEC_";
~recorder.recHeaderFormat = "wav";
~recorder.recSampleFormat = "int24";
~buf = Buffer.read(Server.default, thisProcess.platform.recordingsDir +/+ "BF_250209_123350.wav");
)

(
fork {
	~recorder.record(bus: 0, numChannels: 16);
	Server.default.sync;
	Synth.head(1, 'decoder-3o', ['buf', ~buf, 'amp', 3.0.dbamp]);
}
)

~recorder.stopRecording






Server.default.sendMsg("/n_free", 1003)

-1.0.dbamp


(
~filename = "DEC_250209_152823.wav";
thisProcess.platform.recordingsDir = "/Users/kurivari/snd/rec";
~path = thisProcess.platform.recordingsDir +/+ ~filename;
fork {
	16.do({|i|
		var buf;
		buf = Buffer.readChannel(Server.default, ~path, channels: [i]);
		Server.default.sync;
		buf.write(~path.replace(~filename, "süsinik_ch_" ++ (i+1).asString ++ ".wav"), headerFormat: "wav", sampleFormat: "int24");
		Post << "Channel " << (i+1).asString << " written" << Char.nl;
	})
}
)



(
// e.freeWarp('w1');
// e.freeWarp('w2');
~ind0=90;
~pw0 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf)
	// \wamp, Pseq((0.7 ! 16) ++ (0.1 ! 16), inf),
	// \iamp, Pseq((0.1 ! 16) ++ (0.8 ! 16), inf),
	// \freq, Prand(Scale.minor.ratios.scramble.keep(3), inf),
	// // \wamp, Pseq( [0.05, 0.4, 0.05, 0.4, 0.2, 0.3, 0.05, 0.3]*2, inf),
	// \rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w0', 'revwrpm', ~kvbufs[~ind0], ~pw0, ~matrix.beatdur*2, 0.7 );
e.setWarp('w0', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.1, 'iamp', 0.7, 'ramp', 0.0, 'rate', 1.0, 'freq', 1]);
)

e.setWarp('w0', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.3, 'iamp', 0.7, 'ramp', 0.1, 'rate', 1.0, 'freq', 1]);




e.setPwarp('w0', ~pw0, ~matrix.beatdur / 2)

e.setWarp('w0', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.4, 'iamp', 0.7, 'ramp', 0.1, 'rate', 1.0, 'freq', 1])

e.setWarp('w0', ['buf', ~mesabufs[1]])

e.freeWarp('w0')


200, 197, 199, 60, 202, 212

3, 4, 5, 6, 7, 8

9, 12, 13, 20, 21, 25

29, 32, 33, 36, 37, 43

49, 50, 52, 53, 55, 57

66, 81, 85, 90, 91, 95

105, 107 - end

(
e.freeWarp('w0');
~ind1=9;
~pw1 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf)
	// \wamp, Pseq((0.7 ! 16) ++ (0.1 ! 16), inf),
	// \iamp, Pseq((0.1 ! 16) ++ (0.8 ! 16), inf),
	// \freq, Prand(Scale.minor.ratios.scramble.keep(3), inf),
	// // \wamp, Pseq( [0.05, 0.4, 0.05, 0.4, 0.2, 0.3, 0.05, 0.3]*2, inf),
	// \rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w1', 'revwrpm', ~kvbufs[~ind1], ~pw1, ~matrix.beatdur*2, 0.6 );
e.setWarp('w1', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.1, 'iamp', 0.7, 'ramp', 0.0, 'rate', 1.0, 'freq', 1]);

~ind2=202;
~pw2 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf)
	// \wamp, Pseq((0.7 ! 16) ++ (0.1 ! 16), inf),
	// \iamp, Pseq((0.1 ! 16) ++ (0.8 ! 16), inf),
	// \freq, Prand(Scale.minor.ratios.scramble.keep(3), inf),
	// // \wamp, Pseq( [0.05, 0.4, 0.05, 0.4, 0.2, 0.3, 0.05, 0.3]*2, inf),
	// \rate, Pseq(Scale.minor.ratios.scramble.keep(3), inf )
];
e.playWarp('w2', 'revwrpm', ~kvbufs[~ind2], ~pw2, ~matrix.beatdur*2, 0.6 );
e.setWarp('w2', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.3, 'iamp', 0.7, 'ramp', 0.0, 'rate', 1.0, 'freq', 1]);
)

e.setWarp('w2', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.3, 'iamp', 0.7, 'ramp', 0.1, 'rate', 1.0, 'freq', 1]);




e.setPwarp('w1', ~pw0, ~matrix.beatdur / 2)

e.setWarp('w1', ['amp', 1.0, 'wrp', 0.25, 'wamp', 0.4, 'iamp', 0.7, 'ramp', 0.1, 'rate', 1.0, 'freq', 1])

e.setWarp('w1', ['buf', ~mesabufs[1]])

e.freeWarp('w1');
e.freeWarp('w2')



(
~ratesc = 2.0;
~ind1 = 146;
~buf1 = ~kvbufs[~ind1];
~loop1 = ~kvbufs.loopsAtBuf(~buf1);
~lbpm1 = ~loop1.dur.reciprocal*16*60*~ratesc;
~matrix.setBPM(~lbpm1);
~pw1 = [
	[
		\rx, Prand(Array.series(17, 0, 2pi/17), inf),
		\ry, Prand(Array.series(17, 0, 2pi/17), inf),
		\rz, Prand(Array.series(17, 0, 2pi/17), inf),
		\delta, Pn(~matrix.beatdur / 2)
	],
	[
		\freq, Pseq(Scale.minor.ratios.keep(3).scramble.stutter(3).dup(3).flat, inf),
		\delta, Pn(~matrix.beatdur * 32),
		\fnc, Pfunc({
		})
	],
	[
		\wamp, Pseq(SparseMatrix.patterns16['Lolo'].flat + 0.1 * 0.3, inf),
		\delta, Pn(~matrix.beatdur * 2)
	]
];
e.playParWarp('w0', 'revwrpm', ~buf1, ~pw1, 1.0, ~ratesc, false );
e.setPat('r00', 0.0, [0.2, 0.7], [0.01, 0.2], 0.1);
e.setPat('r01', 0.0, [0.2, 0.7], [0.07, 0.1], 0.1);
Pdef('mx0',
	Ppar(['r00', 'r01', 'w0'].collect({|nm| Pdef(nm) }))
).play
)

