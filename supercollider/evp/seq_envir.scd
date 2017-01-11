~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2, screenX: 1024, screenY: 768, mode: 1, decoderType: 'stereo', bpm: 140, channels: 2, foa: #[zoom,push], dbname: "ges_ld_00", patdefs: "patternDefsAppendLnx.scd", initPdefs: ['r99', 'b03', 'b04', 'b05'], worldDim: 17, ip: "127.0.0.1");

e = SpEnvir(~settings)

~matrix.assignCodeWindow(, "@alo ")

s.queryAllNodes
// voice thru
SynthDef('vox', {|efx, amp|
	var input;
	input = SoundIn.ar(0) * amp;
	Out.ar(efx, input);
	// Out.ar(0, input.dup)
}).add

z = Synth.tail(~matrix.efxgroup, 'vox', ['efx', ~decoder.bus, 'amp', 0.0])

z.set('amp', 0.0)

s.sendMsg("/n_free", 7702)


z.free



~wrp0 = Synth.tail(~matrix.group, 'wrprev', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 30, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][159], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])

~wrp0.set('amp', 0.0, 'wamp', 0.0, 'iamp', 1.0, 'ramp', 0.3, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.1)

~wrp0.free



~wrp0 = Synth.tail(~matrix.group, 'wrprev', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 30, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][26], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])


~wrp0.set('amp', 0.0, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.8, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.05)

~wrp0.free


~wrp1 = Synth.tail(~matrix.group, 'revwrp', ['out', ~decoder.bus, 'rate', 0.5, 'start', 0, 'wrp', 0.1, 'freq', 2.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 40, 'rtime', 12.0, 'ramp', 0.0, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][27], 'amp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])

~wrp1.set('amp', 0.0, 'wamp', 0.0, 'iamp', 0.0, 'ramp', 0.0, 'freq', 1.0, 'rate', 1.0, 'wrp', 0.1)

~wrp1.free


~wrp2 = Synth.tail(~matrix.group, 'revwrp', ['out', ~decoder.bus, 'rate', 0.5, 'start', 0, 'wrp', 0.1, 'freq', 2.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 40, 'rtime', 12.0, 'ramp', 0.0, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][23], 'amp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])

~wrp2.set('amp', 0.6 , 'iamp', 0.8, 'ramp', 0.0, 'freq', 0.5, 'rate', 1.0, 'wrp', 0.1)

~wrp2.free


~wrp2 = Synth.tail(~matrix.group, 'revwrp', ['out', ~decoder.bus, 'rate', 0.5, 'start', 0, 'wrp', 0.1, 'freq', 2.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 40, 'rtime', 12.0, 'ramp', 0.0, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][24], 'amp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])

~wrp2.set('amp', 0.6 , 'iamp', 0.1, 'ramp', 0.0, 'freq', 0.5, 'rate', 1.0, 'wrp', 0.1)

~wrp2.free





~wrp4 = Synth.tail(~matrix.group, 'revwrp', ['out', ~decoder.bus, 'rate', 0.5, 'start', 0, 'wrp', 0.1, 'freq', 2.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 40, 'rtime', 12.0, 'ramp', 0.0, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][72], 'amp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])

~wrp4.set('amp', 0.0, 'iamp', 0.0, 'ramp', 0.0, 'freq', 0.9, 'rate', 1.0, 'wrp', 0.1)

~wrp4.free


~wrp5 = Synth.tail(~matrix.group, 'revwrp', ['out', ~decoder.bus, 'rate', 0.5, 'start', 0, 'wrp', 0.1, 'freq', 2.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 40, 'rtime', 12.0, 'ramp', 0.0, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][74], 'amp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])

~wrp5.set('amp', 0.0, 'iamp', 0.0, 'ramp', 0.0, 'freq', 0.9, 'rate', 1.0, 'wrp', 0.1)
~wrp5.free



SynthDef(\bitSt2, {|out, efx, amp, emp, buf, dur|
	var sig;
	sig = Normalizer.ar(
		PlayBuf.ar(2, buf, BufRateScale.ir(buf) * 1.neg, 1, BufFrames.kr(buf)),
		amp) * EnvGen.kr(\env.kr(Env.newClear(8).asArray), timeScale: dur, doneAction: 2);
	Out.ar(efx, sig * emp);
	Out.ar(out, sig * amp)
}).add;


Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.2, 1.0), 'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(62, 69)], 'dur', exprand(0.7, 2.0), 'env', [Env.sine, Env.perc].choose] );


Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.7, 1.3), 'emp', 0.0, 'dur', exprand(0.4, 2.0), 'env', [Env.perc, Env.sine].choose] );


['flangingDecimator', 'granularReverb', 'feedbackSpectrum', 'cyclicWarp', 'latchOnset', 'cliqSaw', 'fxGrain', 'arhythmicGendy', 'neuralFilter']

~matrix.activateSkismSynth('latchOnset')

~matrix.setSkismAmp('latchOnset', 0.6)

~matrix.deactivateSkismSynth('latchOnset')



~matrix.activateSkismSynth('cliqSaw')

~matrix.setSkismAmp('cliqSaw', 0.0)

~matrix.deactivateSkismSynth('cliqSaw')


Pdef('matrix', Ppar([ Pdef('b00'), Pdef('r01'), Pdef('b03'), Pdef('b04'), Pdef('b06')]))


~matrix.defsAt('b04').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.3, 1.0) },
	{ exprand(2.0, 5.0) },
	0.1
);

~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.2, 0.8) },
	{ exprand(0.05, 0.3) },
	0.1
);

~matrix.defsAt('b03').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.2, 0.8) },
	{ exprand(0.05, 0.3) },
	0.1
);


~matrix.defsAt('b00').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.1, 0.4) },
	0.1
);



(
b = Buffer.alloc(s,1024);
)

// compare PV_Freeze with PV_MagFreeze
(
SynthDef(\pvfreeze, { arg out=0, amp = 0;
	var in, chain;
	in = SoundIn.ar(0) * 3.0;
	chain = FFT(LocalBuf(1024), in);
	chain = PV_Freeze(chain, LFPulse.kr(4, 0, 0.9, 0.5, 0.5) );
	Out.ar(out, amp * IFFT(chain).dup);
}).add

)

z =Synth('pvfreeze', ['out', 0, 'amp', 1.0])

z.free

(
SynthDef(\cyclicWarp, {|out, iwrp=0.3, ibufscale=0.01, wsz=0.2, dns=2,rnd=0.01, rev=0.1, fdba=0.1, amp=0.0, lim=0.5, ang=0.3, xng=0.2|
	var delt, n=4, bufs, ptrs, trgs, frqs, sig, fft, bf;
	var src = DelayN.ar(SoundIn.ar(0), 1.0, 1.0);
	delt = Array.series(n, 0, 1/iwrp*(1/(n-1)));
	bufs = Array.fill(n, { LocalBuf(SampleRate.ir * 0.4) });
	trgs = Array.fill(n, {|i| DelayN.kr(Impulse.kr(iwrp*(2/3)), delt[i], delt[i]) });
	ptrs = Array.fill(n, {|i| LFSaw.kr(EnvGen.kr(Env([1.0, iwrp], [1/iwrp], 'lin'), trgs[i])).range(0, -1) });
	frqs = Array.geom(n, 15/16**(n-1), 16/15 );
	Array.fill(n, {|i| RecordBuf.ar(src, bufs[i], loop: 0.0, trigger: trgs[i] )});
	sig = Mix.fill(n, {|i|
		Warp1.ar(1, bufs[i], ptrs[i], frqs[i], wsz, -1, dns, rnd)
		* EnvGen.kr(Env([0,1,1,0],[0.33,0.33,0.33],\sine,0,3), trgs.rotate(-1)[i], timeScale: 1/iwrp);
	});
	fft = FFT(LocalBuf(1024), sig * amp);
	bf = Array.fill(4, {
		IFFT(PV_Diffuser(fft, Dust.kr(20)))
	}) * [(3/2).sqrt, 1, 1, 1];
	bf = FoaTransform.ar(bf, 'pressX', LFNoise1.kr(ang).range(-pi/3, pi/3) );
	Out.ar(out, FoaTransform.ar(bf, 'rtt', LFNoise2.kr(xng).range(-pi, pi) ))
	}
).add
)

z = Synth.tail(~matrix.group, 'cyclicWarp', ['out', ~decoder.bus])

z.set('amp', 0.1, 'iwrp', 0.3)

z.free







~wrp5 = Synth.tail(~matrix.group, 'revwrp', ['out', ~decoder.bus, 'rate', 0.5, 'start', 0, 'wrp', 0.1, 'freq', 2.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 40, 'rtime', 12.0, 'ramp', 0.0, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][0], 'amp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])

~wrp5.set('amp', 0.5, 'iamp', 0.8, 'ramp', 0.0, 'freq', 0.9, 'rate', 1.0, 'wrp', 0.1)
~wrp5.free



~wrp0 = Synth.tail(~matrix.group, 'wrprev', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 30, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][2], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])


~wrp0.set('amp', 0.0, 'wamp', 1.0, 'iamp', 0.7, 'ramp', 0.0, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.05)

~wrp0.free


~wrp1 = Synth.tail(~matrix.group, 'wrprev', ['out', ~decoder.bus, 'rate', 1, 'start', 0, 'wrp', 0.1, 'freq', 1.0, 'wsize', 0.1, 'dens', 6, 'randr', 0.03, 'room', 30, 'rtime', 6.0, 'ramp', 0.1, 'damp', 0, 'iamp', 0.0, 'buf', ~matrix.buffers['evo'][3], 'amp', 0.0, 'wamp', 0.0, 'rx', 0, 'ry', 0, 'rz', 0])


~wrp1.set('amp', 0.0, 'wamp', 0.5, 'iamp', 0.5, 'ramp', 0.0, 'rate', 1.0, 'freq', 1.0, 'wrp', 0.05)

~wrp1.free
