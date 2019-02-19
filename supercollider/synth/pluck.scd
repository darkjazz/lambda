~freqs = Array.twinPrimes(19, 1001).select({|it, i| it.odd })
~freqs.size

~freqs.clump(21)

Ndef('pluck', {arg freq=201, amp=0.3, dur=0.5, rate=2, decay=10, coef=0.5, rmsz=10, rtm=0.5;
	GVerb.ar(
		Mix(
			Distort.ar(
				Pluck.ar(
					PinkNoise.ar(0.1),
					InTrig.kr(~bus), 19.reciprocal, [freq, freq + 2].reciprocal, decay, coef
				)
			)
		) * amp,
		rmsz, rtm
	)
})
.play


Tdef('setPluck', {
	loop({
		Ndef('pluck').set('freq', ~freqs.choose);
		0.125.wait
	})
}).play



Ndef('pluck').set('decay', 8, 'coef', 0.2, 'rmsz', 5, 'rtm', 2.0, 'amp', 0.7)

Ndef('pluck').clear

Tdef('setPluck').clear


SynthDef('pluck', {arg freq=201, amp=0.3, dur=0.5, rate=2, decay=10, coef=0.5, rmsz=10, rtm=0.5;
	var sig;
	sig = GVerb.ar(
		Mix(
			Distort.ar(
				Pluck.ar(
					PinkNoise.ar(0.1),
					InTrig.kr(~bus), 19.reciprocal, [freq, freq + 2].reciprocal, decay, coef
				)
			)
		) * amp,
		rmsz, rtm
	);
	Out.ar(0, sig)
}).add


~synth = Synth('pluck')

~synth.set('decay', 8, 'coef', 0.2, 'rmsz', 5, 'rtm', 2.0, 'amp', 0.7)


SynthDef('pluck', {arg dur=0.5, decay=10, rmsz=10, rtm=2.0, amp=0.7, intr;
	var freqs, amps, coefs, sig, trig, input, n = 3;
	// trig = InTrig.kr(intr);
	// input = PinkNoise.ar(0.1);
	freqs = ArrayControl.kr('freqs', n, 1);
	amps = ArrayControl.kr('amps', n, 0);
	coefs = ArrayControl.kr('coefs', n, 0);
	sig = Mix.fill(n, {arg i;
		Pluck.ar(PinkNoise.ar(0.1), InTrig.kr(intr), 19.reciprocal, freqs[i].reciprocal, decay, coefs[i]).range(-1, 1)
	}) * amp;
	Out.ar(0, GVerb.ar(sig, rmsz, rtm))
}).add


~bus = Bus.control(Server.default);
~synth = Synth('pluck', ['intr', ~bus])
~bindfreqs = Array.fill(7, {arg i; ~freqs.clump((~freqs.size/3).floor).keep(3).collect(_.choose) })
~amps  = Array.geom(3, 1.0, 11/13);
~coefs = Array.fill(3, {arg i; Array.geom(11, 0.5+((i+1)*0.1), 0.9).mirror }).flop;

~synth.setn('freqs', ~bindfreqs.first, 'amps', ~amps, 'coefs', ~coefs[0])

~bus.set(1.0)
(
Pdef('pluck', Pbind(
	'type', 'set',
	'args', #[freqs, amps, coefs],
	'amp', 1.0,
	'instrument', 'pluck',
	'amps', ~amps.bubble,
	'decay', 10,
	'freqs', Pseq(~bindfreqs.collect(_.bubble), inf),
	'coefs', Pseq(~coefs.collect(_.bubble), inf),
	'trig', Pfunc({ ~bus.set(1.0) }),
	'delta', ~matrix.beatdur,
	'dur', ~matrix.beatdur * 0.25
))

.play
)
~bindfreqs =

~bindfreqs = [ [ 59, 349, 643 ], [ 71, 313, 859 ], [ 193, 461, 857 ], [ 103, 241, 821 ], [ 71, 421, 823 ], [ 73, 239, 521 ], [ 31, 197, 827 ] ]


s.scope(2)

Pdef('pluck').clear

~synth.free
