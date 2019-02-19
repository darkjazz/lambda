SynthDef('decode-stereo', {|out, amp|
	var input, bf;
	input = SoundIn.ar([0, 1]) * amp;
	bf = FoaEncode.ar(input, FoaEncoderMatrix.newStereo);
	bf = FoaFocus.ar(bf, pi/4);
	bf = FoaRotate.ar(bf, LFNoise2.kr(SinOsc.kr(0.1).range(0.1, 2.0)).range(-pi, pi));
	Out.ar(out, FoaDecode.ar(bf, FoaDecoderMatrix.newQuad));
}).add

~synth = Synth('decode-stereo', ['out', 0, 'amp', 0.0])

~synth.set('amp', 1.2)

~synth.free