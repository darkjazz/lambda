if (~ambiOrder.isNil) {
	~ambiOrder = 3
};

SynthDef(\bit00, {|out, efx, amp, emp, buf, dur, rate=0.25, rotx=0, roty=0, rotz=0|
	var sig, hoa;
	sig = Normalizer.ar(
		PitchShift.ar(
			LeakDC.ar(PlayBuf.ar(1, buf, BufRateScale.ir(buf) * rate)**0.5),
				0.1, 1/rate/2),
		amp
	) * EnvGen.kr(EnvControl.kr, timeScale: dur, doneAction: 2);
	Out.ar(efx, sig * emp);
	hoa = HoaEncodeMatrix.ar(sig * amp, HoaMatrixEncoder.newDirection(order: ~ambiOrder));
	hoa = HoaRTT.ar(hoa, rotx, roty, rotz, ~ambiOrder);
	Out.ar(out, hoa);
}).load(Server.default);

SynthDef(\bit01, {|out, efx, amp, emp, buf, dur, off=0, rate=1, rotx, roty, rotz|
	var sig, hoa;
	sig = Normalizer.ar(LeakDC.ar(PlayBuf.ar(1, buf, BufRateScale.kr(buf) * rate, 1, off) ** 0.5), amp)
		* EnvGen.kr(EnvControl.kr, timeScale: dur, doneAction: 2);
	Out.ar(efx, sig * emp);
	hoa = HoaEncodeMatrix.ar(sig * amp, HoaMatrixEncoder.newDirection(order: ~ambiOrder));
	hoa = HoaRTT.ar(hoa, rotx, roty, rotz, ~ambiOrder);
	Out.ar(out, hoa);
}).load(Server.default);


// SynthDef(\bit00s, {|out, efx, amp, emp, buf, dur, rate=0.25, rotx, roty, rotz|
// 	var sig, crt;
// 	sig = Normalizer.ar(
// 		PitchShift.ar(
// 			LeakDC.ar(Mix(PlayBuf.ar(2, buf, BufRateScale.ir(buf) * rate)**0.5)),
// 		0.1, 1/rate/2),
// 		amp
// 	) * EnvGen.kr(EnvControl.kr, timeScale: dur, doneAction: 2);
// 	Out.ar(efx, sig * emp);
// 	crt = Cartesian(rotx, roty, rotz);
// 	Out.ar(out, ~hoaP.ar(sig * amp, crt.theta, crt.phi));
// }).add;

// SynthDef(\bit01s, {|out, efx, amp, emp, buf, dur, off=0, rate=1, rotx, roty, rotz|
// 	var sig, crt;
// 	sig = Normalizer.ar(LeakDC.ar(Mix(PlayBuf.ar(2, buf, BufRateScale.kr(buf) * rate, 1, off) ** 0.5)), amp)
// 	* EnvGen.kr(EnvControl.kr, timeScale: dur, doneAction: 2);
// 	Out.ar(efx, sig * emp);
// 	crt = Cartesian(rotx, roty, rotz);
// 	Out.ar(out, ~hoaP.ar(sig * amp, crt.theta, crt.phi));
// }).add;

// SynthDef(\bit02, {|out, efx, amp, emp, buf, dur, rotx, roty, rotz|
// 	var sig, crt;
// 	sig = Normalizer.ar(
// 		PlayBuf.ar(1, buf, BufRateScale.ir(buf) * 1.neg, 1, BufFrames.kr(buf)),
// 	amp) * EnvGen.kr(EnvControl.kr, timeScale: dur, doneAction: 2);
// 	Out.ar(efx, sig * emp);
// 	crt = Cartesian(rotx, roty, rotz);
// 	Out.ar(out, ~hoaP.ar(sig * amp, crt.theta, crt.phi));
// }).add;
//
SynthDef(\bitSt0, {|out, efx, amp, emp, buf, dur, rate=0.125, rotx, roty, rotz|
	var sig, hoa;
	rate = Select.kr(IRand(0, 2), [0.0625, 0.125, 0.25, 0.5]);
	sig = Normalizer.ar(
		PitchShift.ar(
			PlayBuf.ar(2, buf, BufRateScale.ir(buf) * rate),
			0.1, 1/rate),
		amp
	) * EnvGen.kr(EnvControl.kr, timeScale: dur, doneAction: 2);
	Out.ar(efx, sig * emp);
	hoa = HoaEncodeMatrix.ar(sig * amp, HoaMatrixEncoder.newDirections([[0, 0], [180, 0]].degrad, order: ~ambiOrder));
	hoa = HoaRTT.ar(hoa, rotx, roty, rotz, ~ambiOrder);
	Out.ar(out, hoa);
}).load(Server.default);

SynthDef(\bitSt2, {|out, efx, amp, emp, buf, dur, rotx, roty, rotz|
	var sig, hoa;
	sig = Normalizer.ar(
		PlayBuf.ar(2, buf, BufRateScale.ir(buf), 1, BufFrames.kr(buf)),
		amp) * EnvGen.kr(EnvControl.kr, timeScale: dur, doneAction: 2);
	Out.ar(efx, sig * emp);
	hoa = HoaEncodeMatrix.ar(sig * amp, HoaMatrixEncoder.newDirections([[45, 0], [135, 0]].degrad, order: ~ambiOrder));
	hoa = HoaRTT.ar(hoa, rotx, roty, rotz, ~ambiOrder);
	Out.ar(out, hoa);
}).load(Server.default);

SynthDef(\bitSt3, {|out, efx, amp, emp, buf, dur, rotx, roty, rotz|
	var ply, hit, sig, flt, resfr, fund, hoa;
	ply = Normalizer.ar(
		PlayBuf.ar(2, buf, BufRateScale.ir(buf), 1) ** 0.5,
		0.99
	);
	hit = PlayBuf.ar(2, buf, BufRateScale.ir(buf), 1.0, BufSampleRate.ir(buf) ) ** 0.01;
	hit = hit * EnvGen.kr(Env.perc, timeScale: dur/3);
	sig = ply * EnvGen.kr(\env.kr(Env.newClear(8).asArray), timeScale: dur, doneAction: 2);
	sig = sig+hit;
	sig = Compander.ar(sig, sig, 1.0, 1.0, 0.1, 0.002, 0.1);
	Out.ar(efx, sig * emp);
	hoa = HoaEncodeMatrix.ar(sig * amp, HoaMatrixEncoder.newDirections([[45, 0], [135, 0]].degrad, order: ~ambiOrder));
	hoa = HoaRTT.ar(hoa, rotx, roty, rotz, ~ambiOrder);
	Out.ar(out, hoa);
}).add;


SynthDef(\bitSt4, {|out, efx, amp, emp, buf, dur, rotx, roty, rotz|
	var ply, sig, flt, resfr, fund, hoa;
	fund = Control.names([\rfrq]).ir(Array.primesN(17, 73));
	resfr = Array.fill(3, {
		Select.kr(IRand(0, fund.lastIndex), fund)
	});
	ply = Normalizer.ar(
		PitchShift.ar(
			PlayBuf.ar(2, buf, BufRateScale.ir(buf) * XLine.kr(0.5, 1.0, dur), 1),
			0.01, XLine.kr(1.0, 0.5, dur)
		),
		0.99
	) * EnvGen.kr(\env.kr(Env.newClear(8).asArray), timeScale: dur);
	flt = CombC.ar(ply * XLine.kr(amp, 0.001, dur / 2), dur, dur, dur*4);
	sig = (ply + flt) * EnvGen.kr(Env([1.0, 1.0, 0.0], [1.0, 0.0]), timeScale: dur * 3, doneAction: 2);
	sig = Compander.ar(sig, sig, 1.0, 1.0, 0.1, 0.002, 0.1);
	Out.ar(efx, sig * emp);
	hoa = HoaEncodeMatrix.ar(sig * amp, HoaMatrixEncoder.newDirections([[45, 0], [135, 0]].degrad, order: ~ambiOrder));
	hoa = HoaRTT.ar(hoa, rotx, roty, rotz, ~ambiOrder);
	Out.ar(out, hoa);
}).add;


Server.default.sync;

// *** WRP REV ** //

SynthDef('wrprevm', {|out, rate=1, start=0, wrp=0.125, freq=1.0, wsize=0.1, dens=6, randr=0.01,
		room=200, rtime=6.0, ramp=0, iamp=0, amp=0, wamp=0, buf, rx=0, ry=0, rz=0|
	var input, warpsig, revsig, hoai, hoaw, hoar;
	input = PlayBuf.ar(1, buf, BufRateScale.kr(buf) * rate, 1, start * BufFrames.kr(buf), 1) * amp;
	warpsig = Warp0.ar(
		buffer: buf,
		warpFactor: [wrp, wrp*15/16],
		freqScale: freq,
		windowSize: wsize,
		overlaps: dens,
		windowRandRatio: randr
	);
	revsig = GVerb.ar(warpsig, room, rtime, drylevel: 0, earlyreflevel: 0.7, taillevel: 1);
	hoai = HoaEncodeMatrix.ar(input * iamp,
		HoaMatrixEncoder.newDirection(order: ~ambiOrder)
	);
	hoai = HoaRTT.ar(hoai, rx, ry, rz, order: ~ambiOrder);
	hoaw = HoaEncodeMatrix.ar(warpsig * wamp,
		HoaMatrixEncoder.newDirections([[0, 0], [180, 0]].degrad, order: ~ambiOrder)
	);
	hoar = HoaEncodeMatrix.ar(revsig * ramp,
		HoaMatrixEncoder.newDirections([[90, 0], [-90, 0]].degrad, order: ~ambiOrder)
	);
	hoaw = HoaRTT.ar(hoaw,
		LFNoise2.kr(pi.reciprocal).range(-pi, pi),
		LFNoise2.kr(pi.reciprocal).range(-pi, pi),
		LFNoise2.kr(pi.reciprocal).range(-pi, pi),
		~ambiOrder
	);
	hoar = HoaRTT.ar(hoar,
		LFNoise2.kr(pi.reciprocal).range(-pi, pi),
		LFNoise2.kr(pi.reciprocal).range(-pi, pi),
		LFNoise2.kr(pi.reciprocal).range(-pi, pi),
		~ambiOrder
	);
	Out.ar(out, LeakDC.ar(hoai+hoaw+hoar));
}).load(Server.default);

SynthDef('revwrpm', {|out, rate=1, start=0, wrp=0.125, freq=1.0, wsize=0.1, dens=6, randr=0.01,
		room=200, rtime=6.0, ramp=0, iamp=0, amp=0, wamp=0, buf, rx=0, ry=0, rz=0|
	var input, warpsig, revsig, hoai, hoaw, hoar;
	input = PlayBuf.ar(1, buf, BufRateScale.kr(buf) * rate, 1, start * BufFrames.kr(buf), 1) * amp;
	revsig = GVerb.ar(input, room, rtime, drylevel: 0, earlyreflevel: 0.7, taillevel: 1);
	warpsig = WarpIn.ar(
		in: revsig,
		buffer: LocalBuf(BufSampleRate.kr(buf), 2),
		warpFactor: [wrp, wrp*15/16],
		freqScale: freq,
		windowSize: wsize,
		overlaps: dens,
		windowRandRatio: randr
	);
	hoai = HoaEncodeMatrix.ar(input * iamp, HoaMatrixEncoder.newDirection(order: ~ambiOrder));
	hoai = HoaRTT.ar(hoai, rx, ry, rz, order: ~ambiOrder);
	hoaw = HoaEncodeMatrix.ar(warpsig * wamp, HoaMatrixEncoder.newDirections([[0, 0], [180, 0]].degrad, order: ~ambiOrder));
	hoar = HoaEncodeMatrix.ar(revsig * ramp, HoaMatrixEncoder.newDirections([[90, 0], [-90, 0]].degrad, order: ~ambiOrder));
	hoaw = HoaRTT.ar(hoaw,
		LFNoise2.kr(pi.reciprocal).range(-pi, pi),
		LFNoise2.kr(pi.reciprocal).range(-pi, pi),
		LFNoise2.kr(pi.reciprocal).range(-pi, pi),
		~ambiOrder
	);
	hoar = HoaRTT.ar(hoar,
		LFNoise2.kr(pi.reciprocal).range(-pi, pi),
		LFNoise2.kr(pi.reciprocal).range(-pi, pi),
		LFNoise2.kr(pi.reciprocal).range(-pi, pi),
		~ambiOrder
	);
	Out.ar(out, LeakDC.ar(hoai+hoaw+hoar));
}).load(Server.default);


SynthDef('wrpdrn', {|out, wrp, freq, wsize, dens, randr,
		room, rtime, ramp, eamp, buf, wamp, rx, ry, rz, dur |
	var input, warpsig, revsig, times, hoaw, hoar;
	times = ArrayControl.kr('times', 3, 1);
	warpsig = Warp0.ar(
		buffer: buf,
		warpFactor: wrp,
		freqScale: freq,
		windowSize: wsize,
		overlaps: dens,
		windowRandRatio: randr,
		interp: 4
	) * EnvGen.kr(
		Env([0.001, 1, 1, 0.001], times, 'exp'),
		timeScale: dur, doneAction: 2);
	revsig = GVerb.ar(warpsig * wamp, room, rtime,
		drylevel: 0, earlyreflevel: eamp, taillevel: ramp);
	hoaw = HoaEncodeMatrix.ar(warpsig * wamp, HoaMatrixEncoder.newDirection(order: ~ambiOrder));
	hoar = HoaEncodeMatrix.ar(revsig * ramp, HoaMatrixEncoder.newDirections([[90, 0], [-90, 0]].degrad, order: ~ambiOrder));
	hoaw = HoaRTT.ar(hoaw,
		LFNoise2.kr(ExpRand(0.001, pi)).range(-pi, pi),
		LFNoise2.kr(ExpRand(0.001, pi)).range(-pi, pi),
		LFNoise2.kr(ExpRand(0.001, pi)).range(-pi, pi),
		order: ~ambiOrder
	);
	hoar = HoaRTT.ar(hoar,
		LFNoise2.kr(ExpRand(0.001, pi)).range(-pi, pi),
		LFNoise2.kr(ExpRand(0.001, pi)).range(-pi, pi),
		LFNoise2.kr(ExpRand(0.001, pi)).range(-pi, pi),
		order: ~ambiOrder
	);
	Out.ar(out, LeakDC.ar(hoaw+hoar));
}).load(Server.default);

SynthDef('pvmwrprevm', {|out, rate=1, start=0, wrp=0.125, freq=1.0, wsize=0.1, dens=6, randr=0.01,
		room=200, rtime=6.0, ramp=0, iamp=0, amp=0, wamp=0, buf1, buf2, rx=0, ry=0, rz=0|
	var input1, input2, warpsig, wrp1, wrp2, revsig, bf, fft1, fft2, fftw1, fftw2, hoai, hoar, hoaw;
	input1 = PlayBuf.ar(1, buf1, rate, 1, start * BufFrames.kr(buf1), 1) ** 0.3 * amp;
	input2 = PlayBuf.ar(1, buf2, rate, 1, start * BufFrames.kr(buf2), 1) ** 0.3 * amp;
	fft1 = FFT(LocalBuf(2048), input1);
	fft2 = FFT(LocalBuf(2048), input2);
	wrp1 = Warp0.ar(
		buffer: buf1,
		warpFactor: wrp,
		freqScale: freq,
		windowSize: wsize,
		overlaps: dens,
		windowRandRatio: randr
	);
	wrp2 = Warp0.ar(
		buffer: buf2,
		warpFactor: wrp,
		freqScale: freq,
		windowSize: wsize,
		overlaps: dens,
		windowRandRatio: randr
	);
	fftw1 = FFT(LocalBuf(2048), wrp1);
	fftw2 = FFT(LocalBuf(2048), wrp2);
	warpsig = IFFT(PV_CopyPhase(fftw1, fftw2));
	revsig = GVerb.ar(warpsig, room, rtime, drylevel: 0, earlyreflevel: 0.7, taillevel: 1);
	hoai = HoaEncodeMatrix.ar(IFFT(PV_CopyPhase(fft1, fft2)) * iamp, HoaMatrixEncoder.newDirection(order: ~ambiOrder));
	hoai = HoaRTT.ar(hoai, rx, ry, rz, order: ~ambiOrder);
	hoaw = HoaEncodeMatrix.ar(warpsig.dup * wamp, HoaMatrixEncoder.newDirections([[0, 0], [180, 0]].degrad, order: ~ambiOrder));
	hoar = HoaEncodeMatrix.ar(revsig * ramp, HoaMatrixEncoder.newDirections([[90, 0], [-90, 0]].degrad, order: ~ambiOrder));
	hoaw = HoaRTT.ar(hoaw,
		LFNoise2.kr(pi.reciprocal).range(-pi, pi),
		LFNoise2.kr(pi.reciprocal).range(-pi, pi),
		LFNoise2.kr(pi.reciprocal).range(-pi, pi),
		~ambiOrder
	);
	hoar = HoaRTT.ar(hoar,
		LFNoise2.kr(pi.reciprocal).range(-pi, pi),
		LFNoise2.kr(pi.reciprocal).range(-pi, pi),
		LFNoise2.kr(pi.reciprocal).range(-pi, pi),
		~ambiOrder
	);
	Out.ar(out, LeakDC.ar(hoai+hoaw+hoar));
}).add;

SynthDef('pvmrevwrpm', {|out, rate=1, start=0, wrp=0.125, freq=1.0, wsize=0.1, dens=6, randr=0.01,
		room=200, rtime=6.0, ramp=0, iamp=0, amp=0, wamp=0, buf1, buf2, rx=0, ry=0, rz=0|
	var input1, input2, warpsig, revsig, wrp1, wrp2, rev1, rev2, bf, tr, fft1, fft2, fftw1, fftw2, fftr1, fftr2;
	var hoai, hoar, hoaw;
	input1 = PlayBuf.ar(1, buf1, rate, 1, start * BufFrames.kr(buf1), 1) ** 0.3 * amp;
	input2 = PlayBuf.ar(1, buf2, rate, 1, start * BufFrames.kr(buf2), 1) ** 0.3 * amp;
	fft1 = FFT(LocalBuf(2048), input1);
	fft2 = FFT(LocalBuf(2048), input2);
	rev1 = GVerb.ar(input1, room, rtime, drylevel: 0, earlyreflevel: 0.7, taillevel: 1);
	rev2 = GVerb.ar(input2, room, rtime, drylevel: 0, earlyreflevel: 0.7, taillevel: 1);
	wrp1 = WarpIn.ar(
		in: rev1,
		buffer: LocalBuf(BufSampleRate.kr(buf1), 2),
		warpFactor: [wrp, wrp*15/16],
		freqScale: freq,
		windowSize: wsize,
		overlaps: dens,
		windowRandRatio: randr
	);
	wrp2 = WarpIn.ar(
		in: rev2,
		buffer: LocalBuf(BufSampleRate.kr(buf2), 2),
		warpFactor: [wrp, wrp*15/16],
		freqScale: freq,
		windowSize: wsize,
		overlaps: dens,
		windowRandRatio: randr
	);
	fftw1 = FFT(LocalBuf(2048, 2), wrp1);
	fftw2 = FFT(LocalBuf(2048, 2), wrp2);
	warpsig = IFFT(PV_CopyPhase(fftw1, fftw2));
	fftr1 = FFT(LocalBuf(2048, 2), rev1);
	fftr2 = FFT(LocalBuf(2048, 2), rev2);
	revsig = IFFT(PV_CopyPhase(fftr1, fftr2));
	hoai = HoaEncodeMatrix.ar(IFFT(PV_CopyPhase(fft1, fft2)) * iamp, HoaMatrixEncoder.newDirection(order: ~ambiOrder));
	hoai = HoaRTT.ar(hoai, rx, ry, rz, order: ~ambiOrder);
	hoaw = HoaEncodeMatrix.ar(warpsig * wamp, HoaMatrixEncoder.newDirections([[0, 0], [180, 0]].degrad, order: ~ambiOrder));
	hoar = HoaEncodeMatrix.ar(revsig * ramp, HoaMatrixEncoder.newDirections([[90, 0], [-90, 0]].degrad, order: ~ambiOrder));
	hoaw = HoaRTT.ar(hoaw,
		LFNoise2.kr(pi.reciprocal).range(-pi, pi),
		LFNoise2.kr(pi.reciprocal).range(-pi, pi),
		LFNoise2.kr(pi.reciprocal).range(-pi, pi),
		~ambiOrder
	);
	hoar = HoaRTT.ar(hoar,
		LFNoise2.kr(pi.reciprocal).range(-pi, pi),
		LFNoise2.kr(pi.reciprocal).range(-pi, pi),
		LFNoise2.kr(pi.reciprocal).range(-pi, pi),
		~ambiOrder
	);
	Out.ar(out, LeakDC.ar(hoai+hoaw+hoar));
}).add;



Server.default.sync;



// SynthDef('nested_pm', {|out, efx, amp, emp, dur, lpf=700, az=0, el=0|
// 	var sig, freqs, inds;
// 	freqs = ArrayControl.kr('freqs', 5, 1);
// 	inds = ArrayControl.kr('inds', 5, 1);
// 	sig = SinOsc.ar(freqs[0],
// 		SinOsc.ar(freqs[1],
// 			SinOsc.ar(freqs[2], inds[2]),
// 			inds[1]
// 		), inds[0]
// 	) + ( SinOsc.ar(freqs[3], SinOsc.ar(freqs[4], 0, inds[4]), inds[3] * freqs[3]) );
// 	sig = LPF.ar(sig.distort, lpf)
// 	* EnvGen.kr(Env.perc, timeScale: dur, doneAction: 2);
// 	Out.ar(efx, sig * emp);
// 	Out.ar(out, PanB.ar(sig * amp, az, el))
// }).add;

// EFX

// SynthDef(\rev00, {|out, in, amp, rtime, hf|
// 	var input, sig, bf, fft;
// 	input = In.ar(in) * amp;
// 	sig = LPF.ar(FreeVerb1.ar(input, rtime, hf), 800.0);
// 	fft = FFT( LocalBuf(1024), sig);
// 	bf = FoaEncode.ar(Array.fill(4, { |i|
// 		IFFT( PV_Diffuser( fft, Dust.kr(200.0) ))
// 		}), FoaEncoderMatrix.newAtoB('fud')
// 	);
// 	Out.ar(out, bf)
// }).add;



SynthDef(\rev01, {|out, in, amp, room, rtime, damp, bw, spr, dry, early, tail|
	var input, sig, af, hoa;
	input = In.ar(in) * amp;
	sig = GVerb.ar(input, room, rtime, damp, bw, spr, dry, early, tail);
	af = Array.fill(6, { |i|
		IFFT( PV_Diffuser( FFT( LocalBuf(1024), sig.wrapAt(i)), Dust.kr(pi.exp*pi) ))
	});
	hoa = HoaEncodeMatrix.ar(
		af,
		HoaMatrixEncoder.newDirections(Array.with([0, 0], [90, 0], [180, 0], [270, 0], [0, 90], [0, -90]).degrad, order: ~ambiOrder),
	);
	hoa = HoaRTT.ar(
		hoa,
		LFNoise2.kr(ExpRand(0.001, pi)).range(-pi, pi),
		LFNoise2.kr(ExpRand(0.001, pi)).range(-pi, pi),
		LFNoise2.kr(ExpRand(0.001, pi)).range(-pi, pi)
	);
	Out.ar(out, hoa)
}).add;


SynthDef(\rev02, {|out, in, amp, room, rtime, wsz, pch, pds, tds|
	var input, sig, hoa, af;
	input = In.ar(in) * amp;
	sig = GVerb.ar(input, room, rtime, drylevel: 0, earlyreflevel: 0.3, taillevel: 1.0);
	sig = sig + PitchShift.ar(sig, wsz, pch, pds, tds);
	af = Array.fill(6, { |i|
		IFFT( PV_Diffuser( FFT( LocalBuf(1024), sig.wrapAt(i)), Dust.kr(pi.exp*pi) ))
	});
	hoa = HoaEncodeMatrix.ar(
		af,
		HoaMatrixEncoder.newDirections(Array.with([0, 0], [90, 0], [180, 0], [270, 0], [0, 90], [0, -90]).degrad, order: ~ambiOrder),
	);
	hoa = HoaRTT.ar(
		hoa,
		LFNoise2.kr(ExpRand(0.001, pi)).range(-pi, pi),
		LFNoise2.kr(ExpRand(0.001, pi)).range(-pi, pi),
		LFNoise2.kr(ExpRand(0.001, pi)).range(-pi, pi)
	);
	Out.ar(out, hoa)
}).add;

SynthDef(\del00, {|out, in, amp, del, dec, room, rtime, ramp|
	var input, sig, hoa, af;
	input = In.ar(in) * amp;
	sig = CombL.ar(input,del,del,dec*4.0);
	sig = LPF.ar(GVerb.ar(sig, room, rtime, drylevel: 0)) * ramp + sig;
	af = Array.fill(6, { |i|
		IFFT( PV_Diffuser( FFT( LocalBuf(1024), sig.wrapAt(i)), Dust.kr(pi.exp*pi) ))
	});
	hoa = HoaEncodeMatrix.ar(
		af,
		HoaMatrixEncoder.newDirections(Array.with([0, 0], [90, 0], [180, 0], [270, 0], [0, 90], [0, -90]).degrad, order: ~ambiOrder)
	);
	hoa = HoaRTT.ar(
		hoa,
		LFNoise2.kr(ExpRand(0.001, pi)).range(-pi, pi),
		LFNoise2.kr(ExpRand(0.001, pi)).range(-pi, pi),
		LFNoise2.kr(ExpRand(0.001, pi)).range(-pi, pi)
	);
	Out.ar(out, hoa)
}).add;

// SynthDef(\del01, {|out, in, amp, del, dec|
// 	var input, sig, bf;
// 	input = In.ar(in) * amp;
// 	sig = CombL.ar(input,del, [del,del*0.5,del*0.33,del],
// 		[dec,dec*Rand(0.8, 1.2), dec*Rand(0.8,1.2),dec*Rand(0.8,1.2)]
// 	);
// 	bf = FoaEncode.ar(Array.fill(4, { |i|
// 		IFFT( PV_Diffuser( FFT( LocalBuf(1024), sig[i]), Dust.kr(200.0) ))
// 		}), FoaEncoderMatrix.newAtoB('fud')
// 	);
// 	bf = FoaRotate.ar(bf, LFNoise0.kr(2.5).range(-pi, pi));
// 	Out.ar(out, bf)
// }).add;
//
// SynthDef(\del02, {|out, in, amp, rtime, del, dec|
// 	var input, sig, bf;
// 	input = In.ar(in) * amp;
// 	sig = LPF.ar(FreeVerb1.ar(input, rtime), 800.0);
// 	sig = CombL.ar(input,del, [del,del*0.5,del*0.33,del],
// 		[dec,dec*Rand(0.8, 1.2), dec*Rand(0.8,1.2),dec*Rand(0.8,1.2)]
// 	);
// 	bf = FoaEncode.ar(Array.fill(4, { |i|
// 		IFFT( PV_Diffuser( FFT( LocalBuf(1024), sig[i]), Dust.kr(200.0) ))
// 		}), FoaEncoderMatrix.newAtoB('fud')
// 	);
// 	bf = FoaRotate.ar(bf, LFNoise0.kr(2.5).range(-pi, pi));
// 	Out.ar(out, bf)
// }).add;

// END EFX

/*
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

*/

SynthDef(\mfcc, {|in, th|
	var fft, mfcc, onsets;
	fft = FFT(LocalBuf(1024), In.ar(in));
	mfcc = MFCC.kr(fft, ~ncoef ? 8);
	onsets = Onsets.kr(fft, th);
	SendReply.kr(onsets, '/mfcc', mfcc);
}).load(Server.default);

SynthDef(\beat, {|in|
	var fft, tq, te, ts, bpm;
	fft = FFT(LocalBuf(1024), In.ar(in));
	#tq, te, ts, bpm = BeatTrack.kr(fft);
	SendReply.kr(tq, '/bpm', bpm)
}).add;

// SynthDef(\mtrxbass, {|out, freq, dur, amp, wbl|
// 	var sig, swp, env, bf;
// 	swp = SinOsc.ar(wbl).exprange(40, 500);
// 	sig = LFSaw.ar(freq*[0.99,1,1.01]).sum;
// 	sig = LPF.ar(sig, swp);
// 	sig = Normalizer.ar(sig);
// 	sig = sig + GVerb.ar(sig,10,0.5,0.7,mul:0.5);
// 	sig = (sig.distort + tanh(sig**0.8)) *
// 	EnvGen.kr(EnvControl.kr, timeScale: dur, doneAction: 2);
// 	bf = FoaEncode.ar(sig*amp, FoaEncoderMatrix.newStereo);
// 	Out.ar(out,bf)
// }).add;

