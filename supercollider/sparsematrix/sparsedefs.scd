SynthDef(\bit00, {|out, efx, amp, emp, buf, rate=1, rotx, roty, rotz|
	var sig;
	sig = Normalizer.ar(PlayBuf.ar(1, buf, BufRateScale.ir(buf) * rate, doneAction: 2), amp);
	Out.ar(efx, sig * emp);
	Out.ar(out, FoaTransform.ar(
		FoaEncode.ar(sig * amp, FoaEncoderMatrix.newDirection), 'rtt', rotx, roty, rotz)
	)
}).add;

SynthDef(\bit01, {|out, efx, amp, emp, buf, dur, off=0, rate=1, rotx, roty, rotz|
	var sig;
	sig = Normalizer.ar(PlayBuf.ar(1, buf, BufRateScale.ir(buf) * rate, 1, off), amp)
		* EnvGen.kr(EnvControl.kr, timeScale: dur, doneAction: 2);
	Out.ar(efx, sig * emp);
	Out.ar(out, FoaTransform.ar(
		FoaEncode.ar(sig * amp, FoaEncoderMatrix.newDirection), 'rtt', rotx, roty, rotz)
	)
}).add;

/** EFX **/

SynthDef(\rev00, {|out, in, amp, rtime, hf|
	var input, sig, bf, fft;
	input = In.ar(in) * amp;
	sig = LPF.ar(Reverb.ar(input, rtime, hf), 800.0);
	fft = FFT( LocalBuf(1024), sig);
	bf = FoaEncode.ar(Array.fill(4, { |i|
			IFFT( PV_Diffuser( fft, Dust.kr(200.0) ))
		}), FoaEncoderMatrix.newAtoB('fud')
	);
	Out.ar(out, bf)
}).add;

SynthDef(\rev01, {|out, in, amp, room, rtime, damp, bw, spr, dry, early, tail|
	var input, sig, bf;
	input = In.ar(in) * amp;
	sig = GVerb.ar(input, room, rtime, damp, bw, spr, dry, early, tail).dup(2).flat;
	sig = RLPF.ar(sig, 1000.0, 1.0);
	bf = FoaEncode.ar(Array.fill(4, { |i|
			IFFT( PV_Diffuser( FFT( LocalBuf(1024), sig[i]), Dust.kr(200.0) ))
		}), FoaEncoderMatrix.newAtoB('fud')
	);
	bf = FoaRotate.ar(bf, LFNoise0.kr(2.5).range(-pi, pi));
	Out.ar(out, bf)
}).add;


SynthDef(\rev02, {|out, in, amp, room, rtime, wsz, pch, pds, tds|
	var input, sig, bf;
	input = In.ar(in) * amp;
	sig = GVerb.ar(input, room, rtime, drylevel: 0, earlyreflevel: 0.3, taillevel: 1.0).dup(2).flat;
	sig = sig + PitchShift.ar(sig, wsz, pch, pds, tds);
	bf = FoaEncode.ar(Array.fill(4, { |i|
			IFFT( PV_Diffuser( FFT( LocalBuf(1024), sig[i]), Dust.kr(200.0) ))
		}), FoaEncoderMatrix.newAtoB('fud')
	);
	bf = FoaRotate.ar(bf, LFNoise0.kr(2.5).range(-pi, pi));
	Out.ar(out, bf)
}).add;

SynthDef(\del00, {|out, in, amp, del, dec, room, rtime, ramp|
	var input, sig, bf;
	input = In.ar(in) * amp;
	sig = CombL.ar(input,del,del,dec*4.0);
	sig = LPF.ar(GVerb.ar(sig, room, rtime, drylevel: 0)) * ramp + sig;
	sig = sig.dup(2).flat;
	bf = FoaEncode.ar(Array.fill(4, { |i|
			IFFT( PV_Diffuser( FFT( LocalBuf(1024), sig[i]), Dust.kr(200.0) ))
		}), FoaEncoderMatrix.newAtoB('fud')
	);
	bf = FoaRotate.ar(bf, LFNoise0.kr(2.5).range(-pi, pi));
	Out.ar(out, bf)
}).add;

SynthDef(\del01, {|out, in, amp, del, dec|
	var input, sig, bf;
	input = In.ar(in) * amp;
	sig = CombL.ar(input,del, [del,del*0.5,del*0.33,del],
		[dec,dec*Rand(0.8, 1.2), dec*Rand(0.8,1.2),dec*Rand(0.8,1.2)]
	);
	bf = FoaEncode.ar(Array.fill(4, { |i|
			IFFT( PV_Diffuser( FFT( LocalBuf(1024), sig[i]), Dust.kr(200.0) ))
		}), FoaEncoderMatrix.newAtoB('fud')
	);
	bf = FoaRotate.ar(bf, LFNoise0.kr(2.5).range(-pi, pi));
	Out.ar(out, bf)
}).add;

SynthDef(\del02, {|out, in, amp, rtime, del, dec|
	var input, sig, bf;
	input = In.ar(in) * amp;
	sig = LPF.ar(Reverb.ar(input, rtime), 800.0);
	sig = CombL.ar(input,del, [del,del*0.5,del*0.33,del],
		[dec,dec*Rand(0.8, 1.2), dec*Rand(0.8,1.2),dec*Rand(0.8,1.2)]
	);
	bf = FoaEncode.ar(Array.fill(4, { |i|
			IFFT( PV_Diffuser( FFT( LocalBuf(1024), sig[i]), Dust.kr(200.0) ))
		}), FoaEncoderMatrix.newAtoB('fud')
	);
	bf = FoaRotate.ar(bf, LFNoise0.kr(2.5).range(-pi, pi));
	Out.ar(out, bf)
}).add;

/** END EFX **/


SynthDef(\frag00, {|out, buf, rate, loop=0, dur, ffrq, fwid, fflo, ffhi, amp=1, rotx, roty, rotz, done=2|
	var sig, enc, env;
	env = EnvGen.kr(EnvControl.kr, timeScale: dur, levelScale: amp, doneAction: 2);
	sig = PlayBuf.ar(1, buf, rate, loop: loop, doneAction: done) ** 0.5 * LFPulse.kr(ffrq, 0, fwid).range(fflo, ffhi) * env;
	enc = FoaEncode.ar(sig, FoaEncoderMatrix.newDirection);
	enc = FoaTransform.ar(enc, 'rtt', rotx, roty, rotz );
	Out.ar(out, enc);
}).add;

SynthDef(\frag01, {|out, buf, grate, gdlo, gdhi, rate, ffrq, fwid, fflo, ffhi, rmz, rev, ear, tai, dur, amp, rotx, roty, rotz, done=2|
	var env, sig, fft, enc, trg;
	trg = Impulse.kr(grate);
	env = EnvGen.kr(EnvControl.kr, timeScale: dur, levelScale: amp, doneAction: 2);
	sig = BufGrain.ar(trg, LFSaw.kr(grate).range(gdlo, gdhi), buf, rate, TRand.kr(0.0, 1.0, trg), 1);
	sig = GVerb.ar(sig, rmz, rev, earlyreflevel: ear, taillevel: tai) * env;
	enc = FoaEncode.ar(sig, FoaEncoderMatrix.newStereo);
	enc = FoaTransform.ar(enc, 'rtt', rotx, roty, rotz );
	Out.ar(out, enc)
}).add;

SynthDef(\frag02, {|out, buf, rate, warp, wisz, genv, wrnd, dens, intr, ffrq, fwid, fflo, ffhi, amp=1, dur, rotx, roty, rotz, done=2|
	var env, sig, fft, enc;
	env = EnvGen.kr(EnvControl.kr, timeScale: dur, levelScale: amp, doneAction: 2);
	sig = Disintegrator.ar(
		Warp1.ar(1, buf, LFSaw.kr(warp, 1).range(0, 1), rate, wisz, genv, dens, wrnd, intr),
		0.5, -1
	) * LFPulse.kr(ffrq, 0, fwid).range(fflo, ffhi) * env;
	enc = FoaEncode.ar(sig, FoaEncoderMatrix.newDirection);
	enc = FoaTransform.ar(enc, 'rtt', rotx, roty, rotz );
	Out.ar(out, enc);
}).add;

SynthDef(\frag03, {|out, buf, ffrq=1, fwid=0.5, fflo=0.5, ffhi=1, beatdur=0.5, amp=0.5, dur, rotx, roty, rotz, done=2|
	var env, sig, frq, n = 5, rate, fft, enc;
	env = EnvGen.kr(EnvControl.kr, timeScale: dur, doneAction: 2);
	frq = Array.geom(n, 1/n, 2);
	dur = BufDur.kr(buf);
	rate = dur/dur.round(beatdur).clip(beatdur/4, beatdur*4);
	sig = Mix(PlayBuf.ar(1, buf, frq * BufRateScale.kr(buf) * rate, loop: 1) * (-3.dbamp ! n))
		* LFPulse.kr(ffrq, 0, fwid).range(fflo, ffhi);
	fft = FFT(LocalBuf(1024), sig);
	enc = Array.fill(4, { IFFT(PV_Diffuser(fft, Dust.kr(1/beatdur))) }) * [(3/2).sqrt, 1, 1, 1];
	enc = FoaTransform.ar(enc * amp, 'rtt', rotx, roty, rotz );
	Out.ar(out, enc * env)
}).add;

SynthDef(\frag04, {|out, in, efx, amp, dur, rate=1, emp, buf, rotx, roty, rotz|
	var sig;
	sig = PlayBuf.ar(1, buf, BufRateScale.ir(buf) * rate)
		* EnvGen.kr(EnvControl.kr, timeScale: dur, doneAction: 2);
	Out.ar(efx, sig * emp);
	Out.ar(out, FoaTransform.ar(
		FoaEncode.ar(sig * amp, FoaEncoderMatrix.newDirection), 'rtt', rotx, roty, rotz)
	)
}).add;

SynthDef(\frag05, {|out, amp, dur, rate, buf, rmp, rtm, early, tail, rotx, roty, rotz|
	var sig, fft, afr, bfr, rvb;
	sig = PlayBuf.ar(1, buf, BufRateScale.ir(buf) * rate) * amp;
	fft = FFT(LocalBuf(1024), sig);
	afr = Array.fill(4, { IFFT(PV_Diffuser(fft, Dust.kr(10))) });
	bfr = FoaEncode.ar(afr, FoaEncoderMatrix.newAtoB);
	rvb = GVerb.ar(bfr.first * rmp, 299.0, rtm, drylevel: 0, earlyreflevel: early, taillevel: tail );
	bfr = FoaTransform.ar(bfr, 'rtt', rotx, roty, rotz);
	Out.ar(out, (bfr + rvb.dup.flat) * EnvGen.kr(EnvControl.kr, timeScale: dur, doneAction: 2))
}).add;

SynthDef(\mfcc, {|in, th|
	var fft, mfcc, onsets;
	fft = FFT(LocalBuf(1024), In.ar(in));
	mfcc = MFCC.kr(fft, ~ncoef ? 8);
	onsets = Onsets.kr(fft, th);
	SendReply.kr(onsets, '/mfcc', mfcc);
}).add;

SynthDef(\mtrxbass, {|out, freq, dur, amp, wbl|
	var sig, swp, env, bf;
	swp = SinOsc.ar(wbl).exprange(40, 500);
	sig = LFSaw.ar(freq*[0.99,1,1.01]).sum;
	sig = LPF.ar(sig, swp);
	sig = Normalizer.ar(sig);
	sig = sig + GVerb.ar(sig,10,0.5,0.7,mul:0.5);
	sig = (sig.distort + tanh(sig**0.8)) *
		EnvGen.kr(EnvControl.kr, timeScale: dur, doneAction: 2);
	bf = FoaEncode.ar(sig*amp, FoaEncoderMatrix.newStereo);
	Out.ar(out,bf)
}).add;

