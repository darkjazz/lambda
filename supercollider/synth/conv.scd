(
~gespaths = (Paths.soundDir +/+ "evolver/wrp/*").pathMatch;
~gespaths.size.postln;
~gesbufs = GESBufferLoader(~gespaths);
)

~gesbufs.size

SynthDef(\conv, {|buf, vamp, iamp, camp|
	var sig, kernel, conv;
	sig = PlayBuf.ar(1, buf, BufRateScale.kr(buf), loop: 1).dup * iamp;
	kernel = SoundIn.ar([0, 1]) * vamp;
	conv = DelayC.ar(Convolution.ar(sig, kernel, 1024) * camp, 1.0, 1.0);
	Out.ar(0, sig + kernel + conv)
}).add

~synth.free

~synth = Synth(\conv, ['buf', ~gesbufs[1], 'iamp', 0.0, 'vamp', 0.0, 'camp', 0.0])

~synth.set('iamp', 0.3, 'vamp', 0.0, 'camp', 0.0)



~freqs = (Array.geom(12, pi**pi, 2**(1/12))[Scale.minor.degrees]).dup(7).flat * Array.geom(7, 1, 2).stutter(7)

~primes = ~freqs.collect(_.nearestPrime)

~primes.size


(
Pdef('primeminor',
	Ppar( [
		Pbind('freq', Pstutter(Prand((1..3), inf), Prand(~primes[(10..17)], inf)), 'delta', 0.5),
		Pbind('freq', Pstutter(Prand((1..3), inf), Prand(~primes[(13..31)], inf)), 'delta', 0.25)
	])
).play
)

Pdef('primeminor').clear


Pstutter

Scale.minor.degrees.size

Server.killAll