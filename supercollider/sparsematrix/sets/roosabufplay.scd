SynthDef('roosabufplay', {|out, in, iamp=0.5, dns=4.0, amp=1.0|
	var bufs, sig, n=11, input, sdur=0.3;
	bufs = Array.fill(n, {
		LocalBuf(SampleRate.ir*sdur)
	});
	input = SoundIn.ar(in) * iamp;
	sig = Mix.fill(n, {|i|
		var rtr, tr, rt, pb, bf, angs;
		tr = Dust.kr(dns);
		rtr = Impulse.kr(dns*0.01);
		RecordBuf.ar(input, bufs[i], trigger: TDelay.kr(tr, sdur*2, sdur*2));
		rt = Demand.kr(tr, 0, Dseq(Array.geom(5, 0.125, 2).mirror2.dup.flat, inf));
		angs = Array.fill(3, { Demand.kr(tr, 0, Dwhite(-pi, pi, inf)) });
		pb = LeakDC.ar(PlayBuf.ar(1, bufs[i], rt, tr, SinOsc.kr(dns).range(0, BufFrames.kr(bufs[i])), 2 ));
		pb = PitchShift.ar(pb, 0.1, 1.0/rt);
		bf = FoaEncode.ar(pb, FoaEncoderMatrix.newDirection);
		FoaTransform.ar(bf, 'rtt', angs[0], angs[1], angs[2] );
	});
	Out.ar(out, sig * amp)
}).add






Array.geom(5, 0.125, 2).mirror2.dup.flat * ((-1!10)++(1!10))

~synth = Synth.before(~decoder.synth, 'roosabufplay', ['out', ~decoder.bus, 'in', 0])

~synth.set('dns', 3.0)

~synth.free

s.sendMsg("/n_free",28047)




SynthDef('roosaBufWrp', {|out, in, iamp=0.5, dns=4.0, amp=1.0|
	var bufs, sig, n=3, input, sdur=0.3;
	bufs = Array.fill(n, {
		LocalBuf(SampleRate.ir*sdur)
	});
	input = SoundIn.ar(in) * iamp;
	sig = Mix.fill(n, {|i|
		var rtr, tr, rt, wp, bf, angs, dn, am;
		tr = Impulse.kr(dns);
		rtr = Impulse.kr(dns*0.01);
		RecordBuf.ar(input, bufs[i], trigger: TDelay.kr(tr, sdur*2, sdur*2));
		rt = Demand.kr(tr, 0, Drand(Scale.minor.ratios * [0.5, 1]));
		angs = Array.fill(3, { Demand.kr(tr, 0, Dwhite(-pi, pi, inf)) });
		dn = LFNoise0.kr(pi).range(3, 10);
		am = 1.0 / dn;
		wp = DelayN.ar(
			Warp0.ar(1, bufs[i], 1.0 , rt, 0.2, -1, dn),
			1.0, LFNoise2.kr(TRand.kr(0.1, 0.5, tr)).range(0.1, 1.0)
		);
		bf = FoaEncode.ar(wp, FoaEncoderMatrix.newDirection);
		FoaTransform.ar(bf, 'rtt', angs[0], angs[1], angs[2] );
	});
	Out.ar(out, sig * amp)
}).add


Scale.minor.ratios * [0.5, 1]

~synth = Synth.before(~decoder.synth, 'roosaBufWrp', ['out', ~decoder.bus, 'in', 0])

~synth.set('dns', 2.0, 'amp', 0.7)

~synth.free


Server.killAll



s.queryAllNodes

SynthDef('magFreeze', {|out, in, amp, iamp, thr, pulse, depth|
	var input, sig, trg, fft, ampc, n=3, onsets;
	input = SoundIn.ar(in) * iamp;
	ampc = Lag.kr(Amplitude.kr(input, 0.1, 0.1), 0.1);
	fft = FFT(LocalBuf(1024), input);
	onsets = Onsets.kr(fft, thr);
	sig = Mix.fill(n, {|i|
		var proc, angs, bf;
		proc = PV_MagFreeze(fft, LFPulse.kr(4, 0, 0.99).range(0, 1));
		proc = PV_MagShift(proc, LinLin.kr(ampc, 0, 1, 0.5, 2.0), SinOsc.kr(0.25).range(0.5, 2.0));
		angs = Array.fill(3, { Demand.kr(onsets, 0, Dwhite(-pi, pi, inf)) });
		bf = FoaEncode.ar(DelayN.ar(IFFT(proc) * LFPulse.kr(pulse).range(depth, 1.0), i*0.3, i*0.3), FoaEncoderMatrix.newDirection);
		FoaTransform.ar(bf, 'rtt', angs[0], angs[1], angs[2] );
	});
	Out.ar(out, sig * amp)
}).add


~synth = Synth.before(~decoder.synth, 'magFreeze', ['out', ~decoder.bus, 'in', 0, 'iamp', 0.5, 'amp', 0.7, 'thr', 0.1, 'pulse': pi*pi, 'depth', 0.1])


~synth.set('depth', 0.7)


~synth.free
