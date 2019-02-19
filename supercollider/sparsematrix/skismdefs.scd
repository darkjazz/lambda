Array.with(
	SynthDef(\granularReverb, {|out, in, iroom, rev, dry, ear, tail, trg, grs, gre, amp, lim=1.0, ang, xng, grainEnvBuf, bps|
		var sig, dels, pchs, trdl, n = 4, bf, af, src;
		dels = Array.geom(n, 0.001, 2**(1/3));
		pchs = Array.geom(n, 1.0, 0.5);
		trdl = Array.geom(n, 0.001, 1.618);
		src = In.ar(in);
		sig = GVerb.ar(src, iroom, rev, 0.5, 0.5, 15, dry, ear, tail);
		af = Array.fill(n, {|i|
			var trig = DelayN.kr(Impulse.kr(trg), 0.01, trdl[i]);
			DelayC.ar(
				Mix(
					PitchShift.ar(
						GrainIn.ar(1, trig, TRand.kr(grs, gre, trig), sig, 0, grainEnvBuf),
						0.1,
						[pchs[i], pchs[i] * LFNoise1.kr(Rand(0.1, 0.4)).range(0.5*35/36, 0.5*36/35)],
						mul: [0, 1].dbamp
					)
				)
				, 0.1, dels[i]
			)
		});
		bf = FoaEncode.ar(Limiter.ar(af * amp, lim), FoaEncoderMatrix.newAtoB);
		bf = FoaTransform.ar(bf, 'zoomX', LFSaw.kr(ang).range(-pi/3, pi/3));
		Out.ar(out,
			FoaTransform.ar(bf, 'rotate', LFNoise1.kr(xng).range(-pi, pi))
		)
	}, metadata: (
		specs: (
			iroom: ControlSpec(50, 200, step: 1, default: 200),
			rev: ControlSpec(1, 15, step: 1, default: 8),
			dry: ControlSpec(0, 1, default: 0),
			ear: ControlSpec(0, 1, default: 0.5),
			tail: ControlSpec(0, 1, default: 0),
			trg: ControlSpec(10, 50, step: 1, default: 20),
			grs: ControlSpec(0.01, 0.1, default: 0.05),
			gre: ControlSpec(0.05, 0.2, default: 0.1),
			ang: ControlSpec(0.1, 1.0, default: 0.25),
			xng: ControlSpec(0.1, 2.0, default: 0.2)
		),
		grainEnvBuf: 'sine'

	)),

	SynthDef(\flangingDecimator, {|out, in, del, rate, bit, dep, rte, fdbk, dec, amp, lim=1.0, ang, xng, bps|
		var sig, loc, pchs, n = 4, af, bf;
		var src = In.ar(in);
		pchs = Array.geom(n, 36/35, 35/36 );
		loc = LocalIn.ar;
		sig = AllpassN.ar(
			Decimator.ar(FreeVerb1.ar(src * 0.05, 1) + src, rate, bit) + (loc * fdbk),
			0.1,
			Select.kr(TIRand.kr(0, 3, Impulse.kr(bps)),
				[
					LFSaw.kr(rte, 0, dep, del),
					LFNoise0.kr(rte, 0, dep, del),
					LFPar.kr(rte, 0, dep, del),
					LFTri.kr(rte, 0, dep, del)
				]
			),
			dec
		);
		LocalOut.ar(DelayN.ar(sig, 0.5, 1/rte));
		af = Array.fill(4, {|i|
			PitchShift.ar(sig.distort, [0.05, 0.1], pchs[i])
		}).tanh;
		bf = FoaEncode.ar(Limiter.ar(af * amp, lim), FoaEncoderMatrix.newAtoB);
		bf = FoaTransform.ar(bf, 'pressX', LFSaw.kr(ang).range(-pi/3, pi/3));
		Out.ar(out, FoaTransform.ar(bf, 'rotate', LFNoise0.kr(xng).range(-pi, pi)))
	}, metadata: (
		specs: (
			del: ControlSpec(0.1, 0.1, default: 0.1),
			rate: ControlSpec(1024, 44100, \exp, 1, 11050),
			bit: ControlSpec(2, 32, \exp, 1, 16),
			dep: ControlSpec(0.1, 0.1, default: 0.1),
			rte: ControlSpec(4, 16, step: 1, default: 5),
			fdbk: ControlSpec(0.0, 0.5, default: 0),
			dec: ControlSpec(0, 8.0, default: 2.0),
			ang: ControlSpec(0.3, 3.0, default: 1.0),
			xng: ControlSpec(0.3, 3.0, default: 1.3)
		)
	)),

/*	SynthDef(\neuralFilter, {|out, in, reset=1, rx=0.05, ry=0.1, b0=1.0, b1=1.0, wrp=0.1, fs=0.5, wz=0.1, dns=4, rnd=0, lpf=8000.0, amp=0.2, lim=0.5, ang, xng, bps|
		var sig, n=4, dels, af, bf;
		var src = In.ar(in);
		dels = Array.series(n, 0, 0.25);
		sig = FitzHughNagumo.ar(Impulse.kr(bps), src.abs.round(0.05), ry, b0, b1);
		af = Array.fill(n, {|i|
			DelayN.ar(
				WarpIn.ar(sig ** Amplitude.kr(src), LocalBuf(SampleRate.ir/4), wrp, fs, wz, -1, dns, rnd, 0.1, 1, 0), 1.0, dels[i]);
		}) + sig;
		af = Limiter.ar(LPF.ar(af.distort, lpf) * amp, lim);
		bf = FoaEncode.ar(af, FoaEncoderMatrix.newAtoB);
		bf = FoaTransform.ar(bf, 'pushX', SinOsc.kr(ang).range(-pi/3, pi/3));
		Out.ar(out, FoaTransform.ar(bf, 'rotate', LFNoise0.kr(xng).range(pi.neg, pi)));
	}, metadata: (
		specs: (
			reset: ControlSpec(0.5, 8.0, step: 0.5, default: 1.0),
			rx: ControlSpec(0.01, 1.0, default: 0.05),
			ry: ControlSpec(0.01, 1.0, default: 0.1),
			b0: ControlSpec(1.0, 1.0, default: 1.0),
			b1: ControlSpec(1.0, 1.0, default: 1.0),
			wrp: ControlSpec(0.01, 1.0, default: 0.1),
			fs: ControlSpec(0.25, 1.0, default: 0.5),
			wz: ControlSpec(0.01, 0.2, default: 0.1),
			dns: ControlSpec(1, 8, default: 4),
			rnd: ControlSpec(0, 0.1, default: 0),
			lpf: ControlSpec(200.0, 10000.0, \exp, default: 8000.0),
			ang: ControlSpec(0.4, 2.0, default: 0.9),
			xng: ControlSpec(0.5, 4.0, default: 1.6)
		)
	)),*/

	SynthDef(\feedbackSpectrum, {|out, in, iroom=100, rev=6, dry=1, ear=0.7, tail=0.1, mrph=0.5, amp=0.5, fdba=0.3, th=0.2, lim=0.5, ang, xng, bps|
		var fftsrc, fftrev, fft, sig, ampctr, mfcc, pch, bf, output, diff;
		var src = In.ar(in).round(0.01);
		ampctr = Amplitude.kr(src);
		sig = GVerb.ar(Dust2.ar(ampctr.expexp(0.001, 1.0, 20.0, 2000.0), ampctr * 10)
			+ (LocalIn.ar * fdba), iroom, rev, 0.5, 0.5, 15, dry, ear, tail).round(0.05);
		fftsrc = FFT(LocalBuf(1024), src);
		fftrev = FFT(LocalBuf(1024), sig.first);
		fft = PV_Morph(fftsrc, fftrev, LFSaw.kr(7).range(0, 1));
		mfcc = MFCC.kr(fftsrc, 4);
		pch = PitchShift.ar(IFFT(fft),
			mfcc[0].clip(0, 1).linlin(0.0, 1.0, 0.01, 0.1),
			mfcc[1].clip(0, 1).linlin(0.0, 1.0, 0.5, 1.0),
			mfcc[2].clip(0, 1).linlin(0.0, 1.0, 0.0, 0.5),
			mfcc[3].clip(0, 1).linlin(0.0, 1.0, 0.0, 0.5)
		);
		LocalOut.ar(pch);
		output = 	Limiter.ar(
			Select.ar(
				TRand.kr(0, 3, Onsets.kr(fftsrc, 0.5)),
				[src, Mix(sig), IFFT(fft), pch]
			) ** 0.3 * amp,
			0.5
		);
		diff = FFT(LocalBuf(1024), output);
		bf = Array.fill(4, {
			IFFT(PV_Diffuser(diff, Dust.kr(20)))
		}) * [(3/2).sqrt, 1, 1, 1];
		bf = FoaTransform.ar(bf, 'focusX', LFTri.kr(ang).range(-pi/3, pi/3));
		Out.ar(out, FoaTransform.ar(bf, 'rotate', LFNoise1.kr(xng).range(pi.neg, pi)));
	}, metadata: (
		specs: (
			iroom: ControlSpec(50, 200, step: 1, default: 100),
			rev: ControlSpec(1.0, 20.0, default: 6.0),
			dry: ControlSpec(0.0, 1.0, default: 1.0),
			ear: ControlSpec(0.0, 1.0, default: 0.7),
			tail: ControlSpec(0.0, 1.0, default: 0.1),
			mrph: ControlSpec(0.0, 1.0, default: 0.5),
			fdba: ControlSpec(0.0, 1.0, default: 0.3),
			th: ControlSpec(0.01, 0.5, default: 0.2),
			ang: ControlSpec(0.25, 2.0, default: 0.5),
			xng: ControlSpec(0.3, 3.0, default: 0.8)
		)
	)),

	SynthDef(\cyclicWarp, {|out, in, iwrp=0.1, ibufscale=0.01, wsz=0.1, dns=1,rnd=0.1, rev=0.1, fdba=0.1, amp=1.0, lim=0.5, grainEnvBuf, ang, xng, bps|
		var delt, n=4, bufs, ptrs, trgs, frqs, sig, fft, bf;
		var src = In.ar(in);
		delt = Array.series(n, 0, 1/iwrp*(1/(n-1)));
		bufs = Array.fill(n, { LocalBuf(SampleRate.ir*(1/bps)) });
		ptrs = Array.fill(n, { LFNoise0.kr(iwrp).range(0, 1) });
		trgs = Array.fill(n, {|i| DelayN.kr(Impulse.kr(iwrp*(2/3)), delt[i], delt[i]) });
		frqs = Array.geom(n, 35/36**(n-1), 36/35 );
		Array.fill(n, {|i|
			RecordBuf.ar(
				Mix(GVerb.ar(src + (Crackle.ar(1.95, src * 2, src*0.1)), 80, 10, 0.5, 0.5, 5, 0.5, 0.4, 0.8)),
				bufs[i],
				loop: 0.0,
				trigger: trgs[i]
			)
		});
		sig = Mix.fill(n, {|i|
			Warp1.ar(1, bufs[i], ptrs[i], frqs[i], wsz, grainEnvBuf, dns, rnd) ** 0.5
			// + PlayBuf.ar(1, bufs[i], 2.0, Impulse.kr(3), 0)
				* EnvGen.kr(Env([0,1,1,0],[0.33,0.33,0.33],\sine,0,3), trgs.rotate(-1)[i], timeScale: 1/iwrp);
		}) * Amplitude.kr(src).expexp(0.001, 1.0, 0.5, 1.0).round(0.1);
		fft = FFT(LocalBuf(1024), sig * amp);
		bf = Array.fill(4, {
			IFFT(PV_Diffuser(fft, Dust.kr(20)))
		}) * [(3/2).sqrt, 1, 1, 1];
		bf = FoaTransform.ar(bf, 'pressX', LFNoise1.kr(ang).range(-pi/3, pi/3) );
		Out.ar(out, FoaTransform.ar(bf, 'rtt', LFNoise2.kr(xng).range(-pi, pi) ))
	}, metadata: (
		specs: (
			iwrp: ControlSpec(0.01, 0.5, default: 0.1),
			ibufscale: ControlSpec(0.01, 1.0, default: 0.25),
			wsz: ControlSpec(0.01, 0.2, step: 0.01, default: 0.1),
			dns: ControlSpec(0.5, 10.0, default: 3),
			rnd: ControlSpec(0.0, 0.2, default: 0.01),
			rev: ControlSpec(0.0, 0.2, default: 0.1),
			fdba: ControlSpec(0.0, 0.5, default: 0.1),
			ang: ControlSpec(0.1, 1.0, default: 0.275),
			xng: ControlSpec(0.2, 0.8, default: 0.3)
		),
		grainEnvBuf: 'perc'
	)),

	SynthDef(\latchOnset, {|out, in, th=0.1, rt=2.0, damp=0.5, bw=0.5, sp=15, dry=0.5, early=0.2, tail=1.0, amp=1.0, xng=0, grainEnvBuf, bps|

		var input, freq, trig, fft, gtrig, gvrb, bf, sig, pitch, af, filt;
		filt = [
			(ugen: BLowShelf, frq: pi**4, rs: 0.5, db: 0.5, shift: 0.5),
			(ugen: BPeakEQ, frq: pi**6, rs: 5.0, db: -16, shift: 35/36),
			(ugen: BHiShelf, frq: pi**8, rs: 1.0, db: 1.0, shift: 2.0),
			(ugen: BPeakEQ, frq: pi**7, rs: 3.0, db: -8, shift: 36/35)
		];
		input = In.ar(in);
		pitch = Tartini.kr(input)[0];
		fft = FFT(LocalBuf(1024), input);
		trig = Onsets.kr(fft, th);
		freq = Latch.ar(pitch, trig);
		gtrig = Dust.kr(SinOsc.kr(LFNoise2.kr(0.5)).range(8, 64));
		sig = SinGrainB.ar(
			gtrig,
			Lag.kr(Amplitude.kr(input), 0.1).linlin(0.0, 1.0, 0.001, 0.01),
			Select.kr(TIRand.kr(0, 6, gtrig),
				freq * Array.geom(7, 0.125, 2**(1/7) ) * (1..7)),
			grainEnvBuf,
			EnvGen.kr(Env([0.001, 1.0], [1], \sine), trig, timeScale: TRand.kr(0.3, 3.0, trig))
		);
		gvrb = GVerb.ar(sig ** 0.5 + input, 500, rt, damp, bw, sp, dry, early, tail, 500);
		af = Array.fill(4, {|i|
			var args = filt[i];
			args.ugen.ar(PitchShift.ar(gvrb.wrapAt(i), pitchRatio: args.shift), args.frq, args.rs, args.db)
		});
		bf = FoaEncode.ar(af * amp, FoaEncoderMatrix.newAtoB);
		Out.ar(out, FoaTransform.ar(bf, 'rotate', LFNoise2.kr(xng).range(-pi, pi)));
	}, metadata: (
		specs: (
			th: ControlSpec(-40.dbamp, -10.dbamp, default: -20.dbamp),
			rt: ControlSpec(1.0, 10.0, default: 2.0),
			damp: ControlSpec(0.1, 0.9, default: 0.5),
			bw: ControlSpec(0.1, 0.9, default: 0.5),
			sp: ControlSpec(1, 20, default: 15),
			dry: ControlSpec(0.0, 1.0, default: 0.5),
			early: ControlSpec(0.0, 1.0, default: 0.2),
			tail: ControlSpec(0.0, 1.0, default: 1.0),
			xng: ControlSpec(0.1, 1.0, default: 0.33)
		),
		grainEnvBuf: 'perc'
	)),

	SynthDef(\cliqSaw, {|out, in, th=0.1, amp=0.5, sdur=0.01, cof=500.0, cdur=0.0001, quant=0.214, bps|

		var bf, input, freq, trig, fft, gtrig, bfr, env, sig, pch, snd, senv, af, filt;
		var ampctr;
		filt = [
			(ugen: BLowShelf, frq: pi**4, rs: 0.5, db: 0.5, shift: 0.5),
			(ugen: BPeakEQ, frq: pi**6, rs: 5.0, db: -16, shift: 35/36),
			(ugen: BHiShelf, frq: pi**8, rs: 1.0, db: 1.0, shift: 2.0),
			(ugen: BPeakEQ, frq: pi**7, rs: 3.0, db: -8, shift: 36/35)
		];
		input = In.ar(in);
		ampctr = Lag2.kr(Amplitude.kr(input), 0.1);
		pch = Tartini.kr(input)[0];
		fft = FFT(LocalBuf(512), input);
		trig = Trig.ar(Onsets.kr(fft, th),
			Select.kr(TRand.kr(0, 3, Dust.kr(4)), [quant*2,quant,quant/2,quant/4]));
		gtrig = Trig.ar(trig, (1/bps)*4);
		senv = EnvGen.kr(Env([0.001, 1.0, 1.0, 0.001], [0.01, sdur, 0.1], \exp), gtrig);
		sig = Mix(
			BPF.ar(
				LFSaw.ar(pch.expexp(20.0, 20000.0, 20.0, cof), 0, Decay.ar(trig, cdur)),
				TRand.kr(pi**5, (pi**5)*(2**(89/17)), trig).round(2**(1/17)),�
				0.2,�
				25 * LFNoise1.ar(4).range(0, 1)�
			).fold(-1, 1)) * ampctr.linlin(0, 1, 0.1, 0.6);
		sig = Mix(sig + GVerb.ar(sig, 100, 20, 0.9, 0.9, 5, 0, 0.05, 0.05));
		sig = Mix(sig) * BinaryOpUGen('==', CheckBadValues.kr(sig, 0, 0), 0);
		af = Array.fill(4, {|i|
			var args = filt[i];
			args.ugen.ar(PitchShift.ar(sig, pitchRatio: args.shift) + sig, args.frq, args.rs, args.db)
		});
		bf = FoaEncode.ar(af * amp, FoaEncoderMatrix.newAtoB);
		Out.ar(out, FoaTransform.ar(bf, 'rotate', TRand.kr(-pi, pi, trig)));
	}, metadata: (
		specs: (
			th: ControlSpec(-40.dbamp, -10.dbamp, default: -6.dbamp),
			amp: ControlSpec(0.001, 1.0, \exp, default: 0.5),
			sdur: ControlSpec(0.001, 0.1, default: 0.01),
			cof: ControlSpec(200.0, 2000.0, default: 500.0),
			cdur: ControlSpec(0.0001, 0.1, default: 0.001),
			quant: ControlSpec((140/60).reciprocal/8, (140/60).reciprocal, step: (140/60).reciprocal/8, default: (140/60).reciprocal/2)
		)
	)),

	SynthDef(\fxGrain, {|out, in, th=0.1, amp=1.0, ang, xng, bps|
		var input, src, trg, fft, bfft, ampctr, bufnums, envbufnums, bf;
		bufnums = ArrayControl.kr(\bufnums, 3, {|i| i });
		envbufnums = ArrayControl.kr(\envbufnums, 4, {|i| i });
		input = In.ar(in);
		fft = FFT(LocalBuf(1024), input);
		trg = Onsets.kr(fft, th);
		ampctr = Amplitude.kr(input, 0.01, 0.1);
		src = GrainBuf.ar(1, trg, ampctr.expexp(0.001, 1.0, 0.2, 2.0),
			Select.kr(TRand.kr(0, 2, trg), bufnums), 1, LFNoise2.kr(ampctr.explin(0.001, 1.0, 1.0, 10.0)), 2, 0,
			Select.kr(TRand.kr(0, 3, trg), envbufnums)
		);
		bfft = FFT(LocalBuf(1024), src * amp);
		bf = Array.fill(4, {
			IFFT(PV_Diffuser(bfft, trg))
		}) * [(3/2).sqrt, 1, 1, 1];
		bf = FoaTransform.ar(bf, 'pushX', LFNoise2.kr(ang).range(-pi/3, pi/3) );
		Out.ar(out, FoaTransform.ar(bf, 'rotate', LFNoise1.kr(xng).range(-pi, pi) ) );
	}, metadata: (
		specs: (
			th: ControlSpec(-40.dbamp, -10.dbamp, default: -12.dbamp),
			ang: ControlSpec(0.5, 4.0, default: 2.0),
			xng: ControlSpec(1.0, 8.0, default: 2.33)
		),
		readbufs: {
			"/Users/alo/sounds/skism/*".pathMatch.collect({|path|
				Buffer.read(s, path)
			})
		},
		envbufnums: {
			[Env.sine,Env.perc,Env([0.001, 1.0, 0.001], [0.99, 0.01], [4, 0]),Env.triangle].collect({|env|
				Buffer.sendCollection(s, env.discretize)
			})
		}
	)),

	SynthDef(\arhythmicGendy, {|out, in, drB=0.125, amp=0.5, th=0.01, quant=0.25, bps|
		var sig, trigs, fft, beat, input, sB, pch, ampctr, bfft;
		var af, bf, trigB;
		input = In.ar(in);
		pch = Tartini.kr(input).first;
		fft = FFT(LocalBuf(1024), input);
		ampctr = Lag.kr(Amplitude.kr(input), 0.25);
		trigB = Trig.kr(Onsets.kr(fft, th), 1/bps);
		sB = Gendy3.ar(2, 5, 0.5, 0.5, pch, 0.25, 0.25, 21, 21)
			* EnvGen.kr(Env([1, 1, 0], [0.25, 0.75], \sine), trigB, timeScale: drB);
		sB = GVerb.ar(sB, LFSaw.kr(LFSaw.kr(1).range(0.5, 2)).range(4, 20),
			Latch.kr(ampctr, trigB)).first;
		sB = DelayN.ar(CombC.ar(sB, 0.25, 0.25, 1), 0.5, LFSaw.kr(1.5).range(0.0625, 0.5).round(0.0625));
		bfft = FFT(LocalBuf(1024), Limiter.ar(sB ** 0.7, 1.0) * amp);
		bf = Array.fill(4, {
			IFFT(PV_Diffuser(bfft, trigB))
		}) * [(3/2).sqrt, 1, 1, 1];
		bf = FoaTransform.ar(bf, 'focusX', TRand.kr(-pi/2, pi/2, trigB));
		Out.ar(out, FoaTransform.ar(bf, 'rotate', TRand.kr(pi, -pi, trigB)));
	}, metadata: (
		specs: (
			drB: ControlSpec(0.0625, 0.5, step: 0.0625, default: 0.125),
			th: ControlSpec(-40.dbamp, -10.dbamp, default: -40.dbamp),
			quant: ControlSpec(0.0625, 1.0, step: 0.0625, default: 0.25)
		)
	))

)