(
~chordloader = ChordLoader("/Users/alo/Data/pixies/pixieschords.csv");

~chordloader.load;

~durset = MarkovSet();
~deltaset = MarkovSet();
~chordset = MarkovSet();

~uchords = ();

~chordloader.chords.do({|chord|
	~uchords[chord.getKey] = chord.getFreqs
});

~deltas = [];

~chordloader.chords.doAdjacentPairs({|chA, chB|
	~chordset.read(chA.getKey, chB.getKey);
	~durset.read(chA.getDur.round(1/16), chB.getDur.round(1/16));
	~deltas = ~deltas.add((chB.getStartTime - chA.getStartTime).round(1/16));
});

~deltas.doAdjacentPairs({|dA, dB| ~deltaset.read(dA, dB) });

)


(
~len = 17;
~key = ~uchords.keys(Array).choose;
~chords = ~len.collect({
	~key = ~chordset.next(~key)
});

~freqs = ~chords.collect({|key| ~uchords[key].collect(_.asInt)
	.collect(_.nearestPrime) });
~dur = ~chordloader.chords.choose.getDur.round(1/16);
~durs = ~len.collect({ ~dur = ~durset.next(~dur) });
~delta = ~deltas.choose;
~deltas = ~len.collect({ ~delta = ~deltaset.next(~dur) });
~amps = ~len.collect({ rrand(0.2, 0.4) });
)

(
~decoder = FoaDecoder(decoderType: 'stereo');
)
~decoder.start

(
SynthDef('nested_fm_sin', {|out, amp, dur, pct, rate, angle|
	var bf, sig, freqs, next, inds;
	freqs = ArrayControl.kr('freqs', 3, 1);
	inds = ArrayControl.kr('inds', 3, 1);
	sig = SinOsc.ar(freqs[0] * XLine.kr(1, 16/15, dur*0.9)
		+ SinOsc.ar(freqs[1] * XLine.kr(1, 15/16, dur*0.9)
			+ SinOsc.ar(freqs[2] * XLine.kr(1, 16/15, dur*0.9), 0, inds[2] * freqs[2]),
			0, inds[1] * freqs[1]
		), 0, inds[0] * freqs[0]
	);
	sig = sig * amp * SinOsc.kr(rate).range((amp * pct).neg, amp * pct);
	sig = sig * EnvGen.kr(Env.perc, timeScale: dur, doneAction: 2);
	bf = FoaEncode.ar(sig, FoaEncoderMatrix.newDirection);
	bf = FoaRotate.ar(bf, angle);
	Out.ar(out, bf)
}).add;
)

(
Pdef('pxs',
	Pbind(
		'instrument', 'nested_fm_sin',
		'target', ~decoder.synth,
		'addAction', 'addBefore',
		'out', ~decoder.bus,
		'amp', Pseq(~amps, inf),
		'dur', Pseq(~deltas * 0.2, inf),
		'freqs', Pseq(~freqs, inf),
		'angle', Pwhite(-pi, pi),
		'rate', Pfunc({|ev| ev.dur.reciprocal * 4 }),
		'pct', 1.0,
		'inds', [3, 7, 11]
	)
).play
)

Pdef('pxs').clear



(
Tdef('fm', {
	var deltas, delta, freqs = Pseq(~freqs, inf).asStream;
	deltas = Pseq(~deltas
	loop({
		Synth.before(~decoder.synth, 'nested_fm_sin', ['out', ~decoder.bus,
			'amp', rrand(0.05, 0.5), 'dur', ~delta, 'angle', rrand(-pi, pi),
			'rate', ~delta.reciprocal * 8, 'pct', 0.3
		])
		.setn('freqs', ~freqs.next)
		.setn('inds', [1, 1, 1].collect(_.nearestPrime));
		~delta.wait
	})
}).play
)

Tdef('fm').clear




SynthDef('pluck', {|freq, amp, dur|
	var sig;
	sig = Mix(SinOsc.ar([freq * 0.5, freq, freq * 64],
		LFSaw.kr(8).range(0, 2), [amp * 0.5, amp, amp * 0.2]))
		* EnvGen.kr(Env.perc, timeScale: dur, doneAction: 2);
	Out.ar(0, Pan2.ar(sig))
}).add


SynthDef('pluck', {|freq, amp, dur|
	var sig;
	sig = LPF.ar(PMOsc.ar(freq, freq * 4, 100) * amp, freq * 4 )
		+ Mix(SinOsc.ar([freq * 0.5, freq * 0.25], 0, amp))
		* EnvGen.kr(Env.perc, timeScale: dur, doneAction: 2);
	Out.ar(0, Pan2.ar(sig))
}).add

SynthDef('pluck', {|freq, amp, dur|
	var sig;
	sig = Pluck.ar(PinkNoise.ar, freq)
		* EnvGen.kr(Env.perc, timeScale: dur, doneAction: 2);
	Out.ar(0, Pan2.ar(sig))
}).add


(
Pdef('caribou',
	Pbind(
		\instrument, 'pluck',
		\freq, Pseq(~freqs, inf),
		\amp, Pseq(~amps, inf), \dur, Pseq(~durs * 0.25, inf),
		\delta, Pseq(~deltas * 0.25, inf)
	)
)
)

Pdef('caribou').play;

Pdef('caribou').clear

SynthDef('nested_fm_sin', {|out, amp, dur|
	var sig, freqs, inds;
	freqs = ArrayControl.kr('freqs', 5, 1);
	inds = ArrayControl.kr('inds', 5, 1);
	sig = SinOsc.ar(freqs[0]
		+ SinOsc.ar(freqs[1]
			+ SinOsc.ar(freqs[2]
			), 0, inds[1] * freqs[1]
		), 0, inds[0] * freqs[0]
	) + SinOsc.ar(freqs[3]
		+ SinOsc.ar(freqs[4], 0, inds[4] * freqs[4]), 0, inds[3] * freqs[3]
	), 0, inds[2] * freqs[2];
	Out.ar(out, Pan2.ar(sig * EnvGen.kr(Env.perc, timeScale: dur, doneAction: 2), 0, amp))
}).add


f = ~freqs.collect(_.at(0)).scramble

p = Ppar( [ Pbind(\freq, z, \amp, 0.5, \dur, 0.24), Pbind(\freq, b, \amp, 0.7, \dur, 0.72)]).play

0.24 * 6 / 2

p.stop

(

SynthDef('sindust', {|out, amp, dur|
	var freqs, amps, sig, n = 5;
	freqs = ArrayControl.kr('freqs', n, 0);
	amps = ArrayControl.kr('amps', n, 0);
	sig = Mix.fill(n, {|i|
		Softclip.ar(Sqrt.ar(SinOsc.ar(freqs[i]))) * amps[i]
	}) * EnvGen.kr(Env.perc, timeScale: dur, doneAction: 2);
	Out.ar(out, Pan2.ar(sig))
}).add

)

Pdef('sindust', Pbind('instrument', 'sindust', 'out', 0, 'freqs', Pseq(~freqs.collect(_.bubble), inf),
	'amps', Array.primeSeries(5, 7, 2).reciprocal.reverse.bubble, 'amp', Pwhite(0.2, 0.4, inf),
	'dur', Pseq(~durs, inf), 'delta', Pseq(~deltas * 0.5, inf), 'post', Pfunc({|ev| ev.freqs.postln })
)).play

Pdef('sindust').clear

Pdef('seq', Ppar([ Pdef('sindust'), Pdef('primeosc') ])).play

Pdef('seq').clear

~rev = SynthDef('reverb', {arg revamp=0.01, dry=0.8, revtime=0.5;
	var sig;
	sig = In.ar(0, 2);
	ReplaceOut.ar(0, GVerb.ar(sig, 150, revtime, drylevel: dry, earlyreflevel: revamp))
}).play(1, nil, \addAfter)

~rev.free

~rev.set('revamp', 0.3, 'revtime', 1.6, 'dry', 1.0)


~buf.free
~buf = Buffer.alloc(s, 512, 1)
~buf.sine2(Array.primeSeries(5, 7, 1), Array.geom(5, 1.0, 0.9), false)


SynthDef('primeosc', {|buf, freq, amp, dur|
	var sig;
	sig = Osc.ar(buf, freq) * EnvGen.kr(Env.perc, 1, amp, 0, dur, doneAction: 2);
	sig = LPF.ar(sig, );
	Out.ar(0, Pan2.ar(sig))
}).add

Pdef('primeosc', Pbind('instrument', 'primeosc', 'buf', ~buf, 'freq', Pshuf(Array.primeSeries(5, 7, 3), inf), 'amp', Pwhite(0.06, 0.09, inf), 'dur', Pwhite(0.4, 0.8), 'delta', 0.25))
.play

Pdef('primeosc').clear


z = Pseq([
	Pseq([ 463, 193, 367, 389, 409, 109, 113, 367, 311, 587, 523 ], 3),
	Pn(0, 22)
], inf)


z = Pseq([
	Pseq([ 463, 193, 367, 389, 409, 109, 113, 367, 311, 587, 523 ], 3),
	Pseq([ 389, 193, 439, 439, 311, 523, 463, 463, 389, 389, 127 ], 3),
	Pseq([ 389, 587, 439, 317, 199, 367, 587, 181, 151, 389, 317 ], 2)
], inf)
b = Pseq([ 109, 199, 151, 181, 113, 127, 193, 139, 109, 127, 193 ], inf)





~freqs = [ [ 109, 389, 491, 587 ], [ 109, 331, 439, 557 ], [ 173, 349, 439, 523, 587 ], [ 113, 349, 389, 467, 557 ], [ 197, 389, 491, 587 ], [ 109, 331, 439, 557 ], [ 149, 367, 439, 587 ], [ 197, 389, 491, 587 ], [ 109, 331, 389, 439, 557 ], [ 197, 331, 389, 491, 587 ], [ 163, 331, 419, 491 ], [ 109, 331, 439, 557 ], [ 139, 349, 419, 557 ] ];
~deltas = [ 2.9375, 0.25, 1.375, 1.8125, 1.6875, 1.625, 0.6875, 1.875, 1.5625, 1.75, 0.8125, 0.625, 1.3125 ]





(
    {
        var freq, numparts;
        numparts = 50;
        freq = SinOsc.kr(Array.fill(numparts, {Rand(0.05, 0.2)}),
            Array.fill(numparts, {Rand(0, 1.0)})).range(1000, 3000);
        LeakDC.ar(
            Pan2.ar(
                Pluck.ar(
                    WhiteNoise.ar(0.1).dup(numparts),
                    Impulse.kr(Array.fill(numparts, {Rand(10, 12)})),
                    100.reciprocal, freq.reciprocal, 2, Rand(0.01, 0.2), mul: 1),
                Array.fill(numparts, {Rand.new(-1.0, 1.0)}))
            .sum
            );
        }.play(s);
)