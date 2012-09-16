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

~cycles = "/Users/alo/sounds/funkt/cycle*".pathMatch.collect({|path| Buffer.read(Server.default, path) });

~decoder = FoaDecoder(decoderType: 'stereo')

~decoder.start

~setBPM = {|bpm|
	~bpm = bpm;
	~bps = bpm/60;
	~beatdur = ~bps.reciprocal;
}

~setBPM.(138)

p=Pbind(
	'instrument', 'frag05', 'target', ~decoder.bus, 'addAction', 'addBefore', 
	'buf', ~cycles[11], 'amp', 1, 'dur', Pfunc({|ev| ev.buf.duration.round(~beatdur) }), 
	'out', ~decoder.bus, 'env', Env([0.0, 1.0, 1.0, 0.0], [0.2, 0.6, 0.2], 'sine').asArray.bubble,
	'rate', Pfunc({|ev| ev.buf.duration / ev.buf.duration.round(~beatdur) }),
	'rtm', Pbrown(3.0, 12.0, 2.0, inf), 'early', Pbrown(0.3, 0.6, 0.01, inf), 
	'tail', Pbrown(0.4, 0.8, 0.01, inf), 'rmp', Pbrown(0.5, 1.0, 0.05, inf),
	'rotx', Pwhite(-pi, pi, inf), 'roty', Pwhite(-pi, pi, inf), 
	'rotz', Pwhite(-pi, pi, inf), 'delta', Pfunc({|ev| ev.dur / 1.5 }) 
)

q=Pbind(
	'instrument', 'frag05', 'target', ~decoder.bus, 'addAction', 'addBefore', 
	'buf', ~cycles[2], 'amp', 1, 'dur', Pfunc({|ev| ev.buf.duration.round(~beatdur) }), 
	'out', ~decoder.bus, 'env', Env([0.0, 1.0, 1.0, 0.0], [0.2, 0.6, 0.2], 'sine').asArray.bubble,
	'rate', Pfunc({|ev| ev.buf.duration / ev.buf.duration.round(~beatdur) }),
	'rtm', Pbrown(3.0, 12.0, 2.0, inf), 'early', Pbrown(0.3, 0.6, 0.01, inf), 
	'tail', Pbrown(0.4, 0.8, 0.01, inf), 'rmp', Pbrown(0.05, 0.2, 0.01, inf),
	'rotx', Pwhite(-pi, pi, inf), 'roty', Pwhite(-pi, pi, inf), 
	'rotz', Pwhite(-pi, pi, inf), 'delta', Pfunc({|ev| ev.dur / 1.5 }) 
)

z = p.asStream;

z.next(())

Pdef('d00', p)

Pdef('d00', Ppar([p, q]))

Pdef('d00').play

Pdef('d00').stop

~matrix = SparseMatrix()


z = Pwrand(['r06', 'r01', 'r02', 'r08'].collect({|key| var pat = ~matrix.rDB[key].(); if (pat.isKindOf(ListPattern)) { pat.repeats_(1) } { pat.length_(1) } }), Array.rand(4, 0.0, 1.0).normalizeSum, inf)
z.next

m=['r06', 'r01', 'r02', 'r08'].collect({|key| ~matrix.rDB[key].().length_(1) })

m[0].length

~matrix.rDB['r06'].().length


z = Pwrand([Pwhite(0.0, 1.0, inf), Prand((2..6), inf), Pxrand((10..20), inf), Pbrown(100.0, 200.0, 10.0, inf)].collect({|pat|  if (pat.isKindOf(ListPattern)) { pat.repeats_(1) } { pat.length_(1) } }), [0.4, 0.1, 0.2, 0.3], inf).asStream

z.next