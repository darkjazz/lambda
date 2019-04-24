// 0. PLAY DESERT
Synth.before(~rev, 'desert', ['buf', ~rbufs['desert'], 'amp', 1.0, 'out', ~revbus])


~graphics.unmapImage;


// 1. ALGIERS
(
~activatePatch.(37, 1, 0.7);
~sendText.('algiers');
~graphics.showCodePanel;

~sound = Synth.before(~decoder.synth, 'poem', ['buf', ~sndbufs['algiers'], 'amp', 0.8, 'out', ~decoder.bus])

)

// ~sound.set('amp', 1.0)

// ~activatePatch.(37, 1, 0.2);


// ~sound.free

(
~activatePatch.(37, 0, 1.0);
~graphics.hideCodePanel;
)


~poem = Synth.before(~rev, 'poem', ['buf', ~rbufs['Alzirsja'], 'amp', 3.5, 'out', ~revbus]);




// In the room (Emily)

// Paso (All)








// 2. PASO
(
~activatePatch.(37, 0, 1.0);
~activatePatch.(34, 1, 0.6);
~sendText.('paso');
~graphics.showCodePanel;
~sound = Synth.before(~decoder.synth, 'poem', ['buf', ~sndbufs['paso'], 'amp', 0.8, 'out', ~decoder.bus])

)


~sound.free

s.scope(2)

~activatePatch.(34, 1, 0.1);


// Mirrors
(
~activatePatch.(34, 0, 0.6);
~graphics.setViewpoint(0.0, 120.0, 0.0, 0.0, 0.0, 0.0);
~activatePatch.(28, 1, 1.0);
~graphics.hideCodePanel;

Tdef('mirrors', {
	var buffers, total = 0;
	buffers = Array();
	~mirrors = Synth.before(~decoder.synth, 'mirrors',
		['buf', ~rbufs['Mirrors'], 'amp', 4.0, 'out', ~decoder.bus]);
	loop({
		var buf, time = rrand(0.3, 1.0);
		time.wait;
		total = total + time;
		if (total < (~rbufs['Mirrors'].duration - 1.0)) {
			buf = Buffer.read(s, "/Users/alo/snd/reveries/Mirrors.wav",
				rrand(total * 0.8, total) * s.sampleRate, rrand(0.7, 1.0) * s.sampleRate);
			buffers = buffers.add(buf);
		};
		s.sync;
		Synth.before(~decoder.synth, 'frag', ['amp', rrand(0.4, 0.8), 'out', ~decoder.bus, 'ang', 2pi.rand, 'buf', buffers.choose, 'rate', [1.0, -1.0].wchoose([0.7, 0.3])])
	})

}).play
)

~rev.free

~mirrors.free

(
Tdef('mirrors').clear;
~activatePatch.(28, 0, 1.0);

)

// reveries (Emily)

// stranger (All)


// 3. Bijelo
(
~activatePatch.(28, 0, 0.6);
~graphics.setViewpoint(40.0, 120.0, 0.0, 0.0, 0.0, 0.0);
~graphics.sendPredefined3DRule(\nova);
~activatePatch.(31, 1, 0.8);
~sendText.('bjelo');
~graphics.showCodePanel;

~sound = Synth.before(~decoder.synth, 'poem', ['buf', ~sndbufs['bjelo'], 'amp', 0.8, 'out', ~decoder.bus])


)


~sound.free

(
~graphics.hideCodePanel;
~activatePatch.(31, 0, 0.8);
)




// white (Pierre)


~read = Synth.before(~rev, 'poem', ['buf', ~rbufs['Bjelo'], 'amp', 3.5, 'out', ~revbus])

// ~read.free



// blanc (Emily)



// 4. monologues

(
~graphics.setViewpoint(0.0, 80.0, 0.0, 0.0, 0.0, 0.0);
~activatePatch.(33, 1, 1.0);
~sendText.('mono');
~graphics.showCodePanel;

~sound = Synth.before(~decoder.synth, 'poem', ['buf', ~sndbufs['mono'], 'amp', 1.0, 'out', ~decoder.bus])

)

~sound.free

(
~graphics.hideCodePanel;
~activatePatch.(33, 0, 0.8);
)



// ~sound.free

// all monologues

// all





// 5. ALGIERS
(
~activatePatch.(37, 1, 1.0);
~sendText.('algiers2');
~graphics.showCodePanel;
~graphics.setViewpoint(0.0, 0.0, 120.0, 0.0, 0.0, 0.0);


~sound = Synth.before(~decoder.synth, 'poem', ['buf', ~sndbufs['algiers2'], 'amp', 1.0, 'out', ~decoder.bus])

)



(
~graphics.hideCodePanel;
~activatePatch.(37, 0, 0.8);
)


// Robert

// Emily

// Pierre


// 6. reveries

(
~activatePatch.(4, 1, 1.0);
~sendText.('reveries');
~graphics.showCodePanel;
~graphics.setViewpoint(0.0, 80.0, 0.0, 0.0, 0.0, 0.0);

~sound = Synth.before(~decoder.synth, 'poem', ['buf', ~sndbufs['reveries'], 'amp', 1.3, 'out', ~decoder.bus])


)



~sound.free


(
~graphics.hideCodePanel;
~activatePatch.(4, 0, 0.8);
)



// Emily

// Robert

// All - round infinity

~read = Synth.before(~rev, 'poem', ['buf', ~rbufs['Reveries'], 'amp', 3.5, 'out', ~revbus])



// ~read.free


// 7. migrant

(
~activatePatch.(32, 1, 1.0);
~sendText.('reveries');
~graphics.showCodePanel;

~sound = Synth.before(~decoder.synth, 'poem', ['buf', ~sndbufs['migrant'], 'amp', 1.0, 'out', ~decoder.bus])


)


~sound.free

~graphics.unmapCodePanel

~graphics.hideCodePanel;


~activatePatch.(32, 1, 0.2);

~activatePatch.(32, 0, 0.4);
~graphics.mapImage;


~sound.free


s.sendMsg("/n_free", 1011)




Server.killAll












~graphics.sendPredefined3DRule(\nova);

s.queryAllNodes
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
~activePattern = 38;
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
}).play(~decoder.synth, ['out', ~decoder.bus], \addBefore)

)

~poem2.sampleRate

~rev.free
Tdef('mirrors').clear

(

Tdef('mirrors', {
	var buffers, total = 0;
	buffers = Array();
	~read = Synth.before(~matrix.decoder.synth, 'desert',
		['amp', 7.0, 'out', ~matrix.decoder.bus, 'buf', ~poem2]);
	loop({
		var buf, time = rrand(1.0, 2.0);
		time.wait;
		total = total + time;
		total.postln;
		buf = Buffer.read(s, "/Users/alo/snd/reveries/Mirrors.wav",
			rrand(total * 0.8, total) * s.sampleRate, rrand(0.3, 1.0) * s.sampleRate);
		buffers = buffers.add(buf);
		s.sync;
		Synth.before(~matrix.decoder.synth, 'frag', ['amp', rrand(2.0, 4.0), 'out', ~matrix.decoder.bus, 'ang', 2pi.rand, 'buf', buffers.choose, 'rate', [1.0, -1.0].wchoose([0.7, 0.3])])
	})

}).play
)

~read.free



~read.set('amp', 8.0)

s.sendMsg("/n_free", 1001)


(
~wrp0 = Synth.tail(~matrix.group, 'wrprevm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[10], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

Pdef('swrp0',
	Pbind(
		\type, \set, \id, ~wrp0.nodeID, \delta, Pn(0.2, inf),
		\rx, Pbrown(-0.5pi, 0.5pi, 0.125pi, inf),
		\ry, Pbrown(0, 2pi, 0.125pi, inf),
		\rz, Pbrown(0, 2pi, 0.125pi, inf),
		\args, #[rx, ry, rz]
	)
).play
)

~wrp0.set('amp', 1.0, 'wamp', 0.0, 'iamp', 0.3, 'ramp', 0.0, 'rate', 0.25, 'freq', 2.0, 'wrp', 0.125)

~wrp0.free; Pdef('swrp0').clear


(
~wrp1 = Synth.tail(~matrix.group, 'wrprevm', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 100, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~gesbufs[5], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0]);

Pdef('swrp1',
	Pbind(
		\type, \set, \id, ~wrp1.nodeID, \delta, Pn(0.2, inf),
		\rx, Pbrown(-0.5pi, 0.5pi, 0.125pi, inf),
		\ry, Pbrown(0, 2pi, 0.125pi, inf),
		\rz, Pbrown(0, 2pi, 0.125pi, inf),
		\args, #[rx, ry, rz]
	)
).play
)

~wrp1.set('amp', 1.0, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.125)


~wrp1.free; Pdef('swrp1').clear




SynthDef(\bitSt2, {|out, efx, amp, emp, buf, dur|
	var sig;
	sig = Normalizer.ar(
		PlayBuf.ar(2, buf, BufRateScale.ir(buf) * 1.neg, 1, BufFrames.kr(buf)),
		amp) * EnvGen.kr(\env.kr(Env.newClear(8).asArray), timeScale: dur, doneAction: 2);
	Out.ar(efx, sig * emp);
	Out.ar(out, sig * amp)
}).add;

(
Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.3, 0.5), 'emp', 0.0, 'buf', ~gesbufs[rrand(30, 33)], 'dur', exprand(0.7, 2.0), 'env', [Env.perc, Env.sine].choose] );
)

(
Tdef('tex', {
	loop({
		Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.4, 0.7), 'emp', 0.0, 'buf', ~gesbufs[rrand(100, 104)], 'dur', exprand(0.4, 0.9), 'env', [Env.perc, Env.sine].choose] );
		rrand(0.1, 0.4).wait
	})
})
.play
)

Tdef('tex').clear

Server.killAll

