(
~freqs = Array.twinPrimes(47, 1001).select({|it, i| it.odd });
~ranges = ~freqs.clump((~freqs.size/3).floor);

SynthDef('prsine', {|out, efx, freq, amp, dur, ang|
	var sig, bf;
	sig = SinOsc.ar([freq, freq + 2]) * EnvGen.kr(Env.perc, timeScale: dur, doneAction: 2);
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
}).play(~matrix.decoder.synth, ['out', ~matrix.decoder.bus, 'in'], \addBefore)

)

~rev.free

~rev.set('revamp', 0.05, 'revtime', 2.0, 'dry', 0.0)

(
~matrix.onsetFunc_({
	if (0.4.coin) {
		Synth.before(~rev, 'prsine', ['out', ~decoder.bus, 'efx', ~sinebuss, 'freq', ~ranges[0].choose, 'amp', 0.7.rand, 'dur', 0.2, 'ang', rrand(-pi, pi)]);
	};
	if (0.6.coin) {
		Synth.before(~rev, 'prsine', ['out', ~decoder.bus, 'efx', ~sinebus, 'freq', ~ranges[1].choose, 'amp', 0.9.rand, 'dur', 0.2, 'ang', rrand(-pi, pi)]);
	};
	if (0.2.coin) {
		Synth.before(~rev, 'prsine', ['out', ~decoder.bus, 'efx', ~sinebuss, 'freq', ~ranges[2].choose, 'amp', 0.9.rand, 'dur', 0.2, 'ang', rrand(-pi, pi)]);
	};
});
)

~matrix.onsetFunc_({})

Synth('prsine', ['out', ~decoder.bus, 'freq', ~freqs.choose, 'amp', 0.4, 'dur', 0.2], ~decoder.synth, 'addBefore');

Synth('prsine', ['out', ~decoder.bus, 'freq', ~freqs.choose, 'amp', 0.4, 'dur', 0.2], ~decoder.synth, 'addBefore');

Synth('prsine', ['out', ~decoder.bus, 'freq', ~freqs.choose, 'amp', 0.4, 'dur', 0.2], ~decoder.synth, 'addBefore');

s.scope(2)