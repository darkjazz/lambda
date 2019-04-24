(
~map = ['algiers', 'paso', 'bjelo', 'mono', 'algiers2', 'reveries', 'migrant'];
~file = File("/Users/alo/dev/lambda/supercollider/reveries/reveries.text", "r");
~text = ~file.readAllString;
~file.close;
~words = ();
~text.split($+).do({|text, i|
	~words[~map[i]] = text
});
~poems = Pseq(~text.split($+), 1).asStream;
~sendText = {|key|
	~sendarr = ~words[key].split(Char.nl);
	~sendarr.do({|text|
		~graphics.sendCodeLine(text);
	})
};
~path = "/Users/alo/dev/lambda/xcode/DerivedData/lambdaApp/Build/Products/Release/lambda.app";
~wrldsz = 7;
~initMsg = {
	Tdef(\sendVector, {
		loop({
			~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
			[ 0.0625, 0.125, 0.25].choose.wait;
		});
	}).play;
};
~activatePatch = {|index, switch, alpha|
	switch(index,
		2, { ~graphics.setPattern(index, switch, alpha, 0, 0, 1.0, 1.0, 1.0) },
		4, { ~graphics.setPattern(index, switch, alpha, 0, 0, 1.0, 1.0, 1.0) },
		14, { ~graphics.setPattern(index, switch, alpha, 0, 0, 0.5, 0.5, 0.5) },
		15, { ~graphics.setPattern(index, switch, alpha, 0, 0, 1.0, 1.0, 1.0) },
		28, { ~graphics.setPattern(index, switch, alpha, 0, 0, 1.0, 1.0, 1.0) },
		29, { ~graphics.setPattern(index, switch, alpha, 0, 0, 1.0, 1.0, 1.0) },
		30, { ~graphics.setPattern(index, switch, alpha, 0, 0, 1.0, 1.0, 1.0) },
		31, { ~graphics.setPattern(index, switch, alpha, 0, 0, 1.0, 1.0, 1.0) },
		32, { ~graphics.setPattern(index, switch, alpha, 0, 0, 1.0, 1.0, 1.0) },
		33, { ~graphics.setPattern(index, switch, alpha, 0, 0, 1.0, 1.0, 1.0) },
		34, { ~graphics.setPattern(index, switch, alpha, 0, 0, 1.0, 1.0, 1.0) },
		36, { ~graphics.setPattern(index, switch, alpha, 0, 0, 1.0, 1.0, 1.0) },
		37, { ~graphics.setPattern(index, switch, alpha, 0, 0, 1.0, 1.0, 1.0) },
		38, { ~graphics.setPattern(index, switch, alpha, 0, 0, 0.1, 0.1, 0.1) },
		39, { ~graphics.setPattern(index, switch, alpha, 1, 1, 0.5, 0.5, 0.5) }
	)
};

~decoder = FoaDecoder(decoderType: 'stereo');

SynthDef('wrprevm', {|out, rate, start, wrp, freq, wsize, dens, randr,
		room, rtime, ramp, damp, iamp, buf, amp, wamp, rx, ry, rz |
	var input, warpsig, revsig, bf;
	input = PlayBuf.ar(1, buf, rate, 1, start * BufFrames.kr(buf), 1);
	warpsig = Warp0.ar(
		buffer: buf,
		warpFactor: [wrp, wrp*15/16],
		freqScale: freq,
		windowSize: wsize,
		overlaps: dens,
		windowRandRatio: randr
	);
	revsig = GVerb.ar(warpsig, room, rtime,
		drylevel: damp, earlyreflevel: ramp * 0.5, taillevel: ramp);
	bf = FoaEncode.ar(input * iamp, FoaEncoderMatrix.newDirection) +
	FoaEncode.ar(warpsig * wamp, FoaEncoderMatrix.newStereo) +
	FoaEncode.ar(revsig * amp, FoaEncoderMatrix.newStereo);
	bf = FoaTransform.ar(bf, 'focus', pi/2);
	bf = FoaTransform.ar(bf, 'rtt',
		LFNoise2.kr(rx).range(0, 2pi),
		LFNoise2.kr(ry).range(0, 2pi),
		LFNoise2.kr(rz).range(0, 2pi)
	);
	Out.ar(out, LeakDC.ar(bf));
}).add;

SynthDef('desert', {|out, buf, amp|
	var bf, sig = PlayBuf.ar(1, buf, doneAction: 2) * amp;
	bf = FoaEncode.ar(sig, FoaEncoderMatrix.newDirection);
	Out.ar(out, bf)
}).add;

SynthDef('poem', {|out, buf, amp|
	var bf, sig = PlayBuf.ar(2, buf, doneAction: 2) * amp;
	bf = FoaEncode.ar(sig, FoaEncoderMatrix.newDirection);
	Out.ar(out, bf)
}).add;

SynthDef('frag', {|out, buf, amp, ang, rate=1|
	var bf, sig = PlayBuf.ar(2, buf, rate, doneAction: 2) * amp;
	bf = FoaEncode.ar(sig, FoaEncoderMatrix.newDirection);
	bf = FoaRotate.ar(bf, ang);
	Out.ar(out, bf)
}).add;

SynthDef('mirrors', {|out, buf, amp|
	var del, delbf, bf, sig = PlayBuf.ar(2, buf, doneAction: 2) * amp;
	del = DelayC.ar(
		CombC.ar(sig, 2.0, LFNoise1.kr(0.3).range(1.0, 2.0), 10.0, 0.1), 1.0,
		LFNoise2.kr(0.5).range(0.5, 1.0)
	);
	bf = FoaEncode.ar(sig, FoaEncoderMatrix.newDirection);
	delbf = FoaEncode.ar(del, FoaEncoderMatrix.newDirection);
	Out.ar(out, bf + FoaRotate.ar(delbf, LFNoise0.kr(0.5).range(-pi, pi)))
}).add;

~rbufs = ();
~sndbufs = ();

"/Users/alo/snd/reveries/*.wav".pathMatch.do({|path|
	var key = path.basename.split($.)[0].split(Char.space)[0];
	~rbufs[key.asSymbol] = Buffer.read(s, path)
});

"/Users/alo/snd/reveries/clips/*.wav".pathMatch.do({|path|
	var key = path.basename.split($.)[0].split(Char.space)[0];
	~sndbufs[key.asSymbol] = Buffer.read(s, path)
});

~gespaths = (Paths.soundDir +/+ "evolver/ev/*").pathMatch;
~gesbufs = GESBufferLoader(~gespaths);

~revbus = Bus.audio(s, 4);

Tdef('init', {
	~graphics = CinderApp(800, 600, mode: 0, path: ~path);
	~graphics.open;
	3.wait;
	~graphics.initWorld(~wrldsz, ~wrldsz, ~wrldsz, 20);
	0.3.wait;
	~graphics.initGenerations( [ 4, 7, 14 ], [ 8, 10, 12, 14, 15, 17, 18, 22, 26 ], 16 );
	0.3.wait;
	~graphics.setSymmetry(11);
	~graphics.setViewpoint(0.0, 70.0, 0.0, 0.0, 0.0, 0.0);
	~initMsg.();
	1.wait;
	~graphics.setFrameRate(17.0);
	0.2.wait;
	~graphics.mapImage;
	s.sync;
	~decoder.start;
	s.sync;
	~rev = SynthDef('reverb', {arg out, in, revamp=0.04, dry=0.0, revtime=4.3;
		var sig, bf, input;
		input = In.ar(in, 4);
		sig = GVerb.ar(input[0] * revamp, 150, revtime, drylevel: 0);
		bf = FoaEncode.ar(sig, FoaEncoderMatrix.newStereo);
		Out.ar(out, bf + input)
	}).play(~decoder.synth, ['out', ~decoder.bus, 'in', ~revbus, 'revamp', 0.01], \addBefore);
	Post << "Initialised..." << Char.nl;
}).play
)
























[

(

~file = File("/Users/alo/dev/lambda/supercollider/reveries/reveries.text", "r");
~text = ~file.readAllString;
~file.close;
~poems = Pseq(~text.split($+), 1).asStream;
~sendText = {
	~sendarr = ~poems.next.split(Char.nl);
	~sendarr.do({|text|
		~graphics.sendCodeLine(text);
	})
};
~path = "/Users/alo/dev/lambda/xcode/DerivedData/lambdaApp/Build/Products/Release/lambda.app";
~wrldsz = 7;
~initMsg = {
	Tdef(\sendVector, {
		loop({
			~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
			[ 0.0625, 0.125, 0.25].choose.wait;
		});
	}).play;
};
~activatePatch = {|index, switch, alpha|
	switch(index,
		2, { ~graphics.setPattern(index, switch, alpha, 0, 0, 1.0, 1.0, 1.0) },
		4, { ~graphics.setPattern(index, switch, alpha, 0, 0, 1.0, 1.0, 1.0) },
		14, { ~graphics.setPattern(index, switch, alpha, 0, 0, 0.5, 0.5, 0.5) },
		15, { ~graphics.setPattern(index, switch, alpha, 0, 0, 1.0, 1.0, 1.0) },
		28, { ~graphics.setPattern(index, switch, alpha, 0, 0, 1.0, 1.0, 1.0) },
		29, { ~graphics.setPattern(index, switch, alpha, 0, 0, 1.0, 1.0, 1.0) },
		30, { ~graphics.setPattern(index, switch, alpha, 0, 0, 1.0, 1.0, 1.0) },
		31, { ~graphics.setPattern(index, switch, alpha, 0, 0, 1.0, 1.0, 1.0) },
		32, { ~graphics.setPattern(index, switch, alpha, 0, 0, 1.0, 1.0, 1.0) },
		33, { ~graphics.setPattern(index, switch, alpha, 0, 0, 1.0, 1.0, 1.0) },
		34, { ~graphics.setPattern(index, switch, alpha, 0, 0, 1.0, 1.0, 1.0) },
		36, { ~graphics.setPattern(index, switch, alpha, 0, 0, 1.0, 1.0, 1.0) },
		37, { ~graphics.setPattern(index, switch, alpha, 0, 0, 1.0, 1.0, 1.0) },
		38, { ~graphics.setPattern(index, switch, alpha, 0, 0, 0.1, 0.1, 0.1) },
		39, { ~graphics.setPattern(index, switch, alpha, 1, 1, 0.5, 0.5, 0.5) }
	)
};

~decoder = FoaDecoder(decoderType: 'stereo');

~rbufs = ();

"/Users/alo/snd/reveries/*.wav".pathMatch.do({|path|
	var key = path.basename.split($.)[0].split(Char.space)[0];
	~rbufs[key.asSymbol] = Buffer.read(s, path)
});

~gespaths = (Paths.soundDir +/+ "evolver/ev/*").pathMatch;
~gesbufs = GESBufferLoader(~gespaths);

Tdef('init', {
	~graphics = CinderApp(800, 800, mode: 0, path: ~path);
	~graphics.open;
	3.wait;
	~decoder.start;
	~graphics.initWorld(~wrldsz, ~wrldsz, ~wrldsz, 20);
	0.3.wait;
	~graphics.initGenerations( [ 4, 7, 14 ], [ 8, 10, 12, 14, 15, 17, 18, 22, 26 ], 16 );
	0.3.wait;
	~graphics.setSymmetry(11);
	~graphics.setViewpoint(0.0, 140.0, 0.0, 0.0, 0.0, 0.0);
	~initMsg.();
	1.wait;
	~graphics.setFrameRate(17.0);
	0.2.wait;
	~graphics.mapImage;
	Post << "Initialised..." << Char.nl;
}).play
)


~graphics.setPattern(9, 1, 0.4, 1, 1, 0.3, 0.3, 0.3);



~graphics.sendPredefined3DRule(\nova);


~sendText.();

~graphics.unmapImage

~graphics.unmapCodePanel

~graphics.setInterpolation(0, 8)

~graphics.setBackground(0.0, 0.0, 0.0)

~graphics.setViewpoint(0.0, 120.0, 0.0, 0.0, 0.0, 0.0);


(


)



(
~activatePatch.(~activePattern, 0, 0.0);
~activePattern = 37;
~activatePatch.(~activePattern, 1, 1.0);
)

~activatePatch.(4, 0, 0.5)


~graphics.unmapCodePanel

Tdef('ciAuto').clear

(

~patches.do({|arr, i|
	~graphics.setPattern(i, 0, 1.0, 0, 0, 1.0, 1.0, 1.0);
});
)

(
~ruleWeight = 0.05;
~changeWeight = 0.05;
~initWaitTime = 0;
~rotWeight = 0.2;
)

(
~graphPatterns = [2, 4, 14, 36, 37, 38, 39];
~lasttime = SystemClock.seconds;
~meanamp = 0;
~meandur = 0;
~rules = [
	[ [ 4, 5, 6, 7, 26 ], [ 3, 6, 7, 11, 12, 13, 18, 23, 24, 25 ], 16 ],
	[ [ 4, 7, 14 ], [ 8, 10, 12, 14, 15, 17, 18, 22, 26 ], 16 ],
	[ [ 4, 6, 9, 18, 24 ], [ 1, 4, 6, 8, 17, 23, 24, 26 ], 11 ],
	[ [ 4, 8, 11, 16, 19, 23, 26 ], [ 2, 3, 5, 13, 18, 20, 24 ], 15 ],
	[ [ 4, 25 ], [ 10, 26 ], 19 ],
	[ [ 4, 8, 9, 10, 12, 13, 26 ], [ 6, 8, 15, 16, 20 ], 18 ],
	[ [ 4, 8, 14, 17, 21, 22, 24 ], [ 8, 9, 15, 18, 20 ], 14 ],
	[ [ 4, 10, 11, 13, 14, 15, 18 ], [ 3, 7, 13 ], 22 ],
	[ [ 4, 6, 18, 20, 21, 24, 25, 26 ], [ 6, 10, 13, 15, 16, 18, 23, 26 ], 13 ],
	[ [ 4, 13, 16, 18, 19, 23 ], [ 6, 9, 14, 19, 20, 21 ], 19 ],
	[ [ 4, 6, 13, 14, 18, 24 ], [ 5, 6, 8, 15, 17 ], 9 ],
	[ [ 4, 5, 12, 15, 16, 21, 26 ], [ 10, 20, 26 ], 17 ],
	[ [ 4, 14, 18, 23, 25 ], [ 4, 6, 13 ], 13 ],
	[ [ 4, 10, 17, 21, 24, 25 ], [ 12, 19, 20, 26 ], 10 ],
	[ [ 4, 7, 17 ], [ 5, 8 ], 16 ],
	[ [ 4, 6, 13, 26 ], [ 18 ], 8 ],
	[ [ 4, 6, 9, 13, 20, 23, 24, 25 ], [ 8, 14, 18 ], 23 ],
	[ [ 4, 22, 23, 24 ], [ 4, 6, 11, 17, 24, 26 ], 7 ],
	[ [ 4, 8 ], [ 3, 13, 14 ], 23 ],
	[ [ 4, 11 ], [ 3, 5, 10, 12, 13, 22, 23, 26 ], 15 ],
	[ [ 4, 10, 14, 15, 21, 23 ], [ 6, 13, 25, 26 ], 23 ],
	[ [ 4, 12, 20 ], [ 8, 10, 20 ], 24 ],
	[ [ 4, 6, 7, 10, 14, 19, 22 ], [ 3, 13, 15, 17, 18, 25, 26 ], 19 ],
	[ [ 4, 22, 24 ], [ 14, 24 ], 24 ],
	[ [ 4, 5 ], [ 13, 17, 20, 26 ], 13 ],
	[ [ 4, 9, 11, 13, 14, 19, 25 ], [ 23, 26 ], 19 ],
	[ [ 4, 10, 14 ], [ 7, 12, 17, 18, 25 ], 19 ],
	[ [ 4, 6, 8, 10, 19 ], [ 14, 21 ], 14 ]
];
~getRule = {|index|
	var rule = ~rules[index];
	~maxState = rule.last;
	rule
};
Tdef('ciAuto', {|mfcc|
	~initWaitTime.wait;
	~graphics.sendBoidPattern(3, 1, 0);
	loop({
		var delta, curr, args;
		delta = SystemClock.seconds - ~lasttime;
		~lasttime = SystemClock.seconds;
		if (~changeWeight.coin)
		{
			~activatePatch.(~activePattern, 0);
			~activePattern = ~graphPatterns.choose;
			~activatePatch.(~activePattern, 1);
		};
		if (~ruleWeight.coin) {
			~graphics.sendGenRule(*~getRule.(~rules.size.rand));
		};

		if (~rotWeight.coin) {
			~graphics.stopRotation;
			~graphics.setViewpoint(
				rrand(30.0, 60.0)*[1.0,-1.0].choose,
				rrand(30.0, 60.0)*[1.0,-1.0].choose,
				rrand(30.0, 60.0)*[1.0,-1.0].choose,
				0.0, 0.0, 0.0
			);
			~graphics.unmapCodePanel;
		}{
			if (~rotWeight.coin) {
				~rot = Rotation(rrand(-100.0, 100.0), rrand(0.05, 0.1), rrand(-20.0, 20.0),
					rrand(-120.0, 120.0),
				rrand(-pi, pi), rrand(0.1, 0.8), rrand(-pi, pi), rrand(0.1, 0.7));
			}
			{
				~rot = Rotation(rrand(60.0, 120.0).neg, 0.0, rrand(60.0, 120.0).neg, 0.0, 0.0, -0.02, 0.0, 0.0);
			};
			~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
			~graphics.rotateCamera;
			~graphics.mapCodePanel;
		};

		rrand(0.2, 0.6).round(0.1).wait;
	})
}).play
)