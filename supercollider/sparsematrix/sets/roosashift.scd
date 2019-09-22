SynthDef('roosashift', {|out, in, shift, del, dec, rate, amp|
	var input, fft, sig;
	input = SoundIn.ar(in);
	fft = FFT(LocalBuf(1024), input);
	fft = PV_PitchShift(fft, shift);
	sig = IFFT(fft);
	sig = PitchShift.ar(sig, 0.1, 1.0 / shift * SinOsc.kr(1.0/rate).range(0.8, 1.25));
	sig = CombC.ar(sig, 2.0, del * SinOsc.kr(rate).range(0.5, 2.0), dec);
	Out.ar(out, sig.dup);
}).add

~synth = Synth('roosashift', ['out', 0, 'in', 0, 'shift', 2.0, 'del', 0.7, 'dec', 10, 'rate', 10, 'amp', 2.0])

~synth.set( 'shift', 0.5, 'del', 0.2, 'rate', 11, 'amp', 1.0)

~synth.free


SynthDef('roosashift', {|out, in, shift=0.5, del=0.2, dec=10, rate=11, amp=0, ang, xng|
	var input, fft, sig, bf;
	input = SoundIn.ar(in) * amp;
	fft = FFT(LocalBuf(1024), input);
	fft = PV_PitchShift(fft, shift);
	sig = IFFT(fft);
	sig = PitchShift.ar(sig, 0.1, 1.0 / shift * SinOsc.kr(1.0/rate).range(0.8, 1.25));
	sig = CombC.ar(sig, 2.0, del * SinOsc.kr(rate).range(0.5, 2.0), dec);
	fft = FFT(LocalBuf(1024), sig);
	bf = Array.fill(4, {
		IFFT(PV_Diffuser(fft, Dust.kr(47)))
	}) * [(3/2).sqrt, 1, 1, 1];
	bf = FoaTransform.ar(bf, 'focusX', LFTri.kr(ang).range(-pi/3, pi/3));
	Out.ar(out, FoaTransform.ar(bf, 'rotate', LFNoise1.kr(xng).range(pi.neg, pi)));
}, metadata: (
		specs: (
			ang: ControlSpec(0.25, 2.0, default: 0.5),
			xng: ControlSpec(0.3, 3.0, default: 0.8)
		)
))

1/0.8