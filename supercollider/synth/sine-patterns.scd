~decoder = FoaDecoder(decoderType: 'stereo')
~decoder.start

~freqs = Array.twinPrimes(103, 2001).select({|it, i| it.odd });

~base = 347;
~scale = Scale.minor;
~freqs = (Array.geom(12, ~base, 2**(1/12))[~scale.degrees].dup(4) * (1..13)).flat.collect({|f|
	f.nearestPrime
})

~freqs.size
~freqs.last

~ranges = ~freqs.clump((~freqs.size/3).floor);

(
SynthDef('prsine', {|out, efx, freq, amp, dur, rot, til, tum|
	var sig, bf;
	sig = SinOsc.ar([freq, freq + 2]) *
	EnvGen.kr(Env.perc, timeScale: dur, doneAction: 2);
	bf = FoaEncode.ar(Mix(sig), FoaEncoderMatrix.newDirection);
	bf = FoaRTT.ar(bf, rot, til, tum);
	Out.ar(efx, bf[1] * amp);
	Out.ar(out, bf * amp)
}).add;
)

(
~sinebus = Bus.audio(Server.default);
~rev = SynthDef('reverb', {arg out, in, revamp=0.05, tail=0.0, dry=0.0, revtime=3.1;
	var sig, bf;
	sig = In.ar(in);
	sig = GVerb.ar(sig, 150, revtime, drylevel: dry, earlyreflevel: revamp,
		taillevel: tail
	);
	sig = sig.dup.flat;
	bf = FoaEncode.ar(Array.fill(4, { |i|
			IFFT( PV_Diffuser( FFT( LocalBuf(1024), sig[i]), Dust.kr(200.0) ))
	}), FoaEncoderMatrix.newAtoB('fud'));
	Out.ar(out, bf)
}).play(~decoder.synth, ['out', ~decoder.bus, 'in', ~sinebus], \addBefore)

)

~rev.set('revamp', 0.1, 'tail', 0.05)

~rev.free
s.queryAllNodes

(
Pdef('pr-pat', Pbind(
	'instrument', 'prsine',
	'out', ~matrix.decoder.bus,
	'efx', ~sinebus,
	'amp', Prand(Array.rand(7, 0.01, 0.03), inf),
	'dur', Prand(Array.series(5, 0.5, -0.05), inf),
	'rot', Pwhite(-pi, pi), 'til', Pwhite(-pi, pi),
	'tum', Pwhite(-pi, pi),
	'type', Pwrand(['note', 'rest'], [0.7, 0.3], inf),
	'freq', Pseq([
		Prand(~ranges[0], Pwhite(1, 4, 4)),
		Prand(~ranges[1], Pwhite(1, 4, 5)),
		Prand(~ranges[2], Pwhite(1, 4, 6))
	], inf),
	'delta', ~matrix.beatdur / 4
)).play
)

~matrix.beatdur / 4

Pdef('pr-pat').clear



Server.killAll