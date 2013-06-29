s.loadDirectory(UGenExpressionTree.defDir)

(
~metadata = UGenExpressionTree.loadMetadataFromDir.select({|data|
	(data.stats.mfcc.size == 20).and(data.stats.amp.mean <= 1.0)
		.and(data.stats.mfcc.collect(_.mean).sum.isNaN.not)
});
)

(
~decoder = FoaDecoder(decoderType: 'stereo');

SynthDef(\dynamics, {|out, in, amp, ra, rt, er, tl|
	var eq, input, sig, rev;
	eq = (
		ugen: [BLowShelf, (BPeakEQ ! 3), BHiShelf].flat,
		freq: Array.geom(5, "c 3".notemidi.midicps, 3.6),
		bw: [0.65, 1, 3.5, 1.5, 1],
		db: [4, 0, -4, 2, 6]
	);
	input = Limiter.ar(In.ar(in, 4), -1.0.dbamp, 0.1);
	sig = Mix.fill(5, {|i| eq.ugen[i].ar(input, eq.freq[i], eq.bw[i], eq.db[i]) });
	rev = GVerb.ar(sig[0] * ra, 6, rt, drylevel: 0, earlyreflevel: er, taillevel: tl);
	Out.ar(out, (sig.pow(0.2) + rev.dup.flat) * amp)
}).add;

SynthDef(\procgen, {|out, in, gate=1, dur, amp|
	var env, input, sig, fft, bf, rot, til, tum;
	env = EnvControl.kr(size: 16);
	input = Mix(In.ar(in, 2)).tanh * EnvGen.kr(env, gate, timeScale: dur, levelScale: amp, doneAction: 3);
	fft = FFT(LocalBuf(1024), input);
	bf = FoaEncode.ar(Array.fill(4, {IFFT(PV_Diffuser(fft, Dust.ar(10.0))) }), FoaEncoderMatrix.newAtoB );
	rot = LFNoise2.kr(bf[0].explin(0.001, 1.0, 0.5, 20.0)).range(-pi, pi);
	til = LFNoise2.kr(bf[1].explin(0.001, 1.0, 0.5, 20.0)).range(-pi, pi);
	tum = LFNoise2.kr(bf[2].explin(0.001, 1.0, 0.5, 20.0)).range(-pi, pi);
	bf = FoaTransform.ar(bf, 'rtt', rot, til, tum );
	Out.ar(out, bf)
}).add;

~playnext = {|index|
	var args, name, env, synth;
	~currentIndex = index;
	args = ~metadata[index].args;
	name = ~metadata[index].defname;
	env = Env([0.001, 1.0, 1.0, 0.001], [0.3, 0.4, 0.3], \sine, 2, 1);
	synth = Synth.before(~dyn, name, [\out, ~lcbus] ++ args);
	~currentSynth = Synth.after(synth, \procgen, [\out, ~bfbus, \in, ~lcbus, \dur, 1, \amp, 1.0])
		.setn(\env, env);
};

~releaseAndPlay = {|time, saveCurrent=false|
	if (saveCurrent) {	
		~selectedIndices = ~selectedIndices.add(~currentIndex);
		Post << "Saved " << ~currentIndex << Char.nl;
	};
	~currentSynth.set(\gate, time.neg);
	SystemClock.sched(time + 0.5, {
		~playnext.(~indices.next);
		nil
	})
};

~selectedIndices = [];

~bfbus = Bus.audio(s, 4);
~lcbus = Bus.audio(s, 2);
~indices = Pseq((0..~metadata.lastIndex), 1).asStream;
)

~decoder.start;
~dyn = Synth.before(~decoder.synth, \dynamics, [\out, ~decoder.bus, \in, ~bfbus, \amp, 0.7, \ra, 0.1, \rt, 2, \er, 0.7, \tl, 0.4]);

~playnext.(~indices.next)


~releaseAndPlay.(1, true)