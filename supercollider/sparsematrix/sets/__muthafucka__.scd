(
~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2,
	screenX: 1024, screenY: 768, mode: 1, decoderType: 'binaural',
	'localDecoder': true, 'ambiOrder': 3,
	bpm: 136.7762208841, channels: 2, foa: #[zoom,push], dbname: "ges_ld_00",
	patdefs: "patternDefsMesa.scd", worldDim: 21, ip: "127.0.0.1"
);
e = SpEnvir(~settings)

)

Server.killAll


(
~matrix.patterndefs.keys.select({|key| key.asString.contains("u")}).do({|name|
	var pat = e.getPat(name);
	pat.ctrls.keysValuesDo({|key, ctrl|
		var len, on;
		on = pat.patterns[key].select(_.odd).size;
		len = pat.patterns[key].size;
		ctrl.dur = (1.0 / on).linlin(1/len, 1, 0.07, 0.23);
	})
});
)



~rkeys = ~ukeys.keep(8)


Pdef('mx00',
	Ppar(~rkeys.collect({|name|
		Pdef(name)
	}))
).play;

(
~ind = 146; // 4
~buf = ~kvbufs[~ind];
~loop = ~kvbufs.loopsAtBuf(~buf);

~bpm = 60 * 16 / (~loop.dur / 1.5);
~matrix.setBPM(~bpm);

)



(
~ind = 146; // 4
~buf = ~kvbufs[~ind];
~loop = ~kvbufs.loopsAtBuf(~buf);

~bpm = 60 * 16 / (~loop.dur / 1.5);
~matrix.setBPM(~bpm);

~ukeys = ~matrix.patterndefs.keys.select({|key| key.asString.contains("u")}).asArray.sort;

~rkeys = ~ukeys.drop(8).keep(8);
// ~matrix.patterndefs.keys.select({|key| key.asString.contains("u")}).asArray.scramble.keep(8);

Pdef('mx00',
	Ppar(~rkeys.collect({|name|
		Pdef(name)
	}))
).play;

// Pdef('mx00',
// 	Ppar(['b07', 'b08', 'b09', 'b10'].collect({|name|
// 		Pdef(name)
// 	}))
// ).play;

~patterns = ~matrix.patterndefs.keys.select({|key| key.asString.contains("u") }).asArray.collect({|name|
	~matrix.patterndefs[name].patterns.values.select({|arr|
		(arr.occurrencesOf(1) > 8).and(arr.occurrencesOf(1) < 32)
	})
}).flatten(1);
~ratios = Scale.minor.ratios.mirror * ((1 ! 7) ++ (0.6 ! 6));

// ~ratios = Array.geom(7, 0.5, 6/5);

// ~ind0 = 118; ~ind1 = 115; ~ind2 = 110; ~ind3 = 11;

~ind0 = ~mesabufs.size.rand;
~ind1 = ~mesabufs.size.rand;
~ind2 = ~mesabufs.size.rand;
~ind3 = ~mesabufs.size.rand;

// ~ind0 = 160; ~ind1 = 57; ~ind2 = 1; ~ind3 = 60;

// ~ind0 = ~mesabufs.size.rand;
~buf0 = ~mesabufs[~ind0];
~loop0 = ~mesabufs.loopsAtBuf(~buf0);
~rate0 = (~loop.dur / 1.5).reciprocal / ~loop0.dur.reciprocal;
~patchoice = Array.fill(8, { ~patterns.choose });
~pw0 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\wamp, Pdefn('w0w', Pseq(~patchoice[0] * 0.4, inf)),
	\iamp, Pdefn('w0i', Pseq([0], inf)),
	\freq, Pseq(~ratios.scramble.keep(4.rand + 1), inf)
];
// e.playWarp('w0', 'wrprevm', ~buf0, ~pw0, 1/2, 0.0, ~rate0 );
e.playWarp('w0', 'revwrpm', ~buf0, ~pw0, 1/4, 0.0, ~rate0 );

// ~ind1=~mesabufs.size.rand;
~buf1 = ~mesabufs[~ind1];
~loop1 = ~mesabufs.loopsAtBuf(~buf1);
~rate1 = (~loop.dur / 1.5).reciprocal / ~loop1.dur.reciprocal;
~pw1 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\wamp, Pdefn('w1w', Pseq(~patchoice[2] * 0.4, inf)),
	\iamp, Pdefn('w1i', Pseq([0], inf)),
	\freq, Pseq(~ratios.scramble.keep(4.rand + 1), inf)
];
e.playWarp('w1', 'wrprevm', ~buf1, ~pw1, 1/4, 0.0, ~rate1 );

// ~ind2=~mesabufs.size.rand;
~buf2 = ~mesabufs[~ind2];
~loop2 = ~mesabufs.loopsAtBuf(~buf2);
~rate2 = (~loop.dur / 1.5).reciprocal / ~loop2.dur.reciprocal;
~pw2 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\wamp, Pdefn('w2w', Pseq([0], inf)),
	\iamp, Pdefn('w2i', Pseq(~patchoice[5] * 0.4, inf)),
	\freq, Pseq(~ratios.scramble.keep(4.rand + 1), inf)
];
e.playWarp('w2', 'wrprevm', ~buf2, ~pw2, 1/4, 0.0, ~rate2 );

// ~ind3=~mesabufs.size.rand;
~buf3 = ~mesabufs[~ind3];
~loop3 = ~mesabufs.loopsAtBuf(~buf3);
~rate3 = (~loop.dur / 1.5).reciprocal / ~loop3.dur.reciprocal;
~pw3 = [
	\rx, Prand(Array.series(17, 0, 2pi/17), inf),
	\ry, Prand(Array.series(17, 0, 2pi/17), inf),
	\rz, Prand(Array.series(17, 0, 2pi/17), inf),
	\wamp, Pdefn('w3w', Pseq([0], inf)),
	\iamp, Pdefn('w3i', Pseq(~patchoice[7] * 0.4, inf)),
	\freq, Pseq(~ratios.scramble.keep(4.rand + 1), inf),

];
e.playWarp('w3', 'wrprevm', ~buf3, ~pw3, 1/2, 0.0, ~rate3 );
Post << "~ind0 = " << ~ind0 << "; ~ind1 = " << ~ind1 << "; ~ind2 = " << ~ind2 << "; ~ind3 = " << ~ind3 << Char.nl;

)

~mesabufs.choose


e.setWarp('w0', ['buf', ~mesabufs.choose]);
Pdefn('w0w', Pseq(~patterns.choose * 0.4, inf));
Pdefn('w0i', Pseq(~patterns.choose * 0.4, inf));


e.setWarp('w1', ['buf', ~mesabufs.choose]);
Pdefn('w1w', Pseq(~patterns.choose * 0.4, inf));
Pdefn('w1i', Pseq(~patterns.choose * 0.4, inf));


e.setWarp('w2', ['buf', ~mesabufs.choose]);
Pdefn('w2w', Pseq(~patterns.choose * 0.4, inf));
Pdefn('w2i', Pseq(~patterns.choose * 0.4, inf));


e.setWarp('w3', ['buf', ~mesabufs.choose]);
Pdefn('w3w', Pseq(~patterns.choose * 0.4, inf));
Pdefn('w3i', Pseq(~patterns.choose * 0.4, inf));






e.setWarp('w0', ['buf', ~mesabufs.choose]);
Pdefn('w0w', Pseq(~patchoice[0] * 0.4, inf));
Pdefn('w0i', Pseq(~patchoice[1] * 0.4, inf));

Pdefn('w0w', Pseq([0], inf));
Pdefn('w0i', Pseq([0], inf));


e.setWarp('w1', ['buf', ~mesabufs.choose]);
Pdefn('w1w', Pseq(~patchoice[2] * 0.4, inf));
Pdefn('w1i', Pseq(~patchoice[3] * 0.4, inf));

Pdefn('w1w', Pseq([0], inf));
Pdefn('w1i', Pseq([0], inf));



e.setWarp('w2', ['buf', ~mesabufs.choose]);
Pdefn('w2w', Pseq(~patchoice[4] * 0.4, inf));
Pdefn('w2i', Pseq(~patchoice[5] * 0.4, inf));

Pdefn('w2w', Pseq([0], inf));
Pdefn('w2i', Pseq([0], inf));


e.setWarp('w3', ['buf', ~mesabufs.choose]);
Pdefn('w3w', Pseq(~patchoice[6] * 0.4, inf));
Pdefn('w3i', Pseq(~patchoice[7] * 0.4, inf));

Pdefn('w3w', Pseq([0], inf));
Pdefn('w3i', Pseq([0], inf));


Pdefn('w3w', Pseq(~patters * 0.4, inf));
Pdefn('w3i', Pseq(~patterns.choose * 0.2, inf));


Pdefn('w2w', Pseq([0], inf));





Pseq([0], inf)
Pseq(~patterns.choose * 0.4)


e.setWarp('w0', ['ramp', 0.1]);
e.setWarp('w1', ['ramp', 0.0]);
e.setWarp('w2', ['ramp', 0.0]);
e.setWarp('w3', ['ramp', 0.0]);



e.freeWarp('w0');
e.freeWarp('w1');
e.freeWarp('w2');
e.freeWarp('w3');




(
~rkeys = ~ukeys.keep(8); //drop(24).keep(8);

Pdef('mx00',
	Ppar(~rkeys.collect({|name|
		Pdef(name)
	}))
).play;
)

(
e.setPat(~rkeys[0], 0.0, [0.3, 0.35], nil, 0.0);
e.setPat(~rkeys[1], 0.0, [0.2, 0.35], nil, 0.0);
e.setPat(~rkeys[2], 0.0, [0.2, 0.35], nil, 0.0);
e.setPat(~rkeys[3], 0.0, [0.2, 0.35], nil, 0.0);
e.setPat(~rkeys[4], 0.0, [0.2, 0.35], nil, 0.0);
e.setPat(~rkeys[5], 0.0, [0.2, 0.35], nil, 0.0);
e.setPat(~rkeys[6], 0.0, [0.2, 0.35], nil, 0.0);
e.setPat(~rkeys[7], 0.0, [0.2, 0.35], nil, 0.0);
)






(

// ~ind0 = 136; ~ind1 = 52; ~ind2 = 77; ~ind3 = 55;
// ~ind0 = 67; ~ind1 = 139; ~ind2 = 118; ~ind3 = 148;

// ~ind0 = 134; ~ind1 = 110; ~ind2 = 13; ~ind3 = 131;

~ind0 = ~mesabufs.size.rand;
~ind1 = ~mesabufs.size.rand;
~ind2 = ~mesabufs.size.rand;
~ind3 = ~mesabufs.size.rand;


// ~ind0 = ~mesabufs.size.rand;
~buf0 = ~mesabufs[~ind0];
~loop0 = ~mesabufs.loopsAtBuf(~buf0);
~rate0 = (~loop.dur / 1.5).reciprocal / ~loop0.dur.reciprocal;
e.setWarp('w0', ['buf', ~buf0, 'rate', ~rate0]);


// ~ind1 = ~mesabufs.size.rand;
~buf1 = ~mesabufs[~ind1];
~loop1 = ~mesabufs.loopsAtBuf(~buf1);
~rate0 = (~loop.dur / 1.5).reciprocal / ~loop1.dur.reciprocal;
e.setWarp('w1', ['buf', ~buf1, 'rate', ~rate1]);

)


(
// ~ind2 = ~mesabufs.size.rand;
~buf2 = ~mesabufs[~ind2];
~loop2 = ~mesabufs.loopsAtBuf(~buf2);
~rate2 = (~loop.dur / 1.5).reciprocal / ~loop2.dur.reciprocal;
e.setWarp('w2', ['buf', ~buf2, 'rate', ~rate2]);

// ~ind3 = ~mesabufs.size.rand;
~buf3 = ~mesabufs[~ind3];
~loop3 = ~mesabufs.loopsAtBuf(~buf3);
~rate3 = (~loop.dur / 1.5).reciprocal / ~loop3.dur.reciprocal;
e.setWarp('w3', ['buf', ~buf3, 'rate', ~rate3]);

)




~ind0 = 5; ~ind1 = 121; ~ind2 = 32;
~ind0 = 50; ~ind1 = 37; ~ind2 = 58; ~ind3 = 114;
~ind0 = 74; ~ind1 = 22; ~ind2 = 124; ~ind3 = 151;
~ind0 = 136; ~ind1 = 52; ~ind2 = 77; ~ind3 = 55;
~ind0 = 91; ~ind1 = 103; ~ind2 = 124; ~ind3 = 41;
~ind0 = 159; ~ind1 = 130; ~ind2 = 61; ~ind3 = 132;
~ind0 = 111; ~ind1 = 60; ~ind2 = 42; ~ind3 = 16;
~ind0 = 160; ~ind1 = 57; ~ind2 = 1; ~ind3 = 60;
~ind0 = 118; ~ind1 = 115; ~ind2 = 110; ~ind3 = 11;
~ind0 = 38; ~ind1 = 49; ~ind2 = 133; ~ind3 = 152;
~ind0 = 67; ~ind1 = 139; ~ind2 = 118; ~ind3 = 148
~ind0 = 59; ~ind1 = 64; ~ind2 = 117; ~ind3 = 51;
~ind0 = 91; ~ind1 = 98; ~ind2 = 90; ~ind3 = 68;
~ind0 = 144; ~ind1 = 12; ~ind2 = 160; ~ind3 = 118;
~ind0 = 134; ~ind1 = 110; ~ind2 = 13; ~ind3 = 131;

