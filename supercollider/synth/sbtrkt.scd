~base = Paths.soundDir +/+ "evolver";
~buffers = (~base +/+ "sbt/*").pathMatch.collect({|path| Buffer.read(Server.default, path) })

~buffers.size

(
SynthDef('sbt_rsnz', {|out, buf, amp|
	var src, sig, af, frqs, bws, amps, bf, n = 3;
	src = Mix(PlayBuf.ar(2, buf, BufRateScale.kr(buf), loop: 1)**0.5) * amp;
	frqs = ArrayControl.kr('frqs', n, 0);
	bws = ArrayControl.kr('bws', n, 0);
	amps = ArrayControl.kr('amps', n, 0);
	af = Array.fill(n , {|i|
		DelayL.ar(
			Resonz.ar(src, frqs[i], bws[i] / frqs[i] * SinOsc.kr(frqs[0]*0.125).range(1, 2)),
			0.01, IRand(0.005, 0.01)
		)
	});
	bf = FoaEncode.ar(af, FoaEncoderMatrix.newDirections(Array.series(3, 0, 2pi/3)));
	Out.ar(out, bf)
}).add;

SynthDef('sbt_bqbnd', {|out, buf, amp|
	var src, sig, af, frqs, bws, amps, bf, n = 3;
	src = Mix(PlayBuf.ar(2, buf, BufRateScale.kr(buf), loop: 1)**0.5) * amp;
	frqs = ArrayControl.kr('frqs', n, 0);
	bws = ArrayControl.kr('bws', n, 0);
	amps = ArrayControl.kr('amps', n, 0);
	af = Array.fill(n , {|i|
		DelayL.ar(
			BBandPass.ar(src, frqs[i], bws[i] / frqs[i] * SinOsc.kr(frqs[0]*0.125).range(0.01, 0.02)),
			0.01, IRand(0.005, 0.01)
		)
	});
	bf = FoaEncode.ar(af, FoaEncoderMatrix.newDirections(Array.series(3, 0, 2pi/3)));
	Out.ar(out, bf)
}).add;
)


~decoder = FoaDecoder(decoderType: 'binaural')
~decoder.start

~makeScale = {|note = "a", octave = 0|
	var degs, freqs, fund, mul;
	mul = 2**octave;
	fund = (note ++ " 3").notemidi.midicps;
	degs = Scale.minor.degrees;
	freqs = Array.geom(12, fund, 2**(1/12))[degs] * mul;
	freqs.collect(_.nearestPrime)
}

Tdef('scales', {
	"cdefgab".do({|l|
		var scale, dur;
		dur = 0.5;
		scale = ~makeScale.(l, 1);
		Pbind('freq', Pseq(scale), 'dur', dur).play;
		(scale.size * dur + 1).wait
	})
}).play


Tdef('chords', {
	var keys, dur = 0.25;
	keys = "abcdefg".scramble.keep(3);
	keys = Pseq(keys ++ keys[0], inf).asStream;
	loop({
		var scale;
		scale = ~makeScale.(keys.next, 1);
		Pbind('freq', Pseq(scale.scramble.keep(3) ! 4), 'dur', dur).play;
		(dur * 4).wait
	})
}).play


~scale = ~makeScale.("f", 1);
~prms =  Array.primes( 0, 11);


(
~synth = Synth.before(~decoder.synth, 'sbt_rsnz', ['out', ~decoder.bus, 'buf', ~buffers[3], 'amp', 1])
.setn('frqs', ~scale.scramble.keep(4)).setn('bws', ~prms).setn('amps', 1 / ~prms);

Tdef('chords', {
	var bufs, keys, dur = 0.5;
	keys = "abcdefg".scramble.keep(3);
	keys = Pseq(keys ++ keys[0], inf).asStream;
	dur.wait;
	loop({
		var scale, chord;
		scale = ~makeScale.(keys.next, 2);
		chord = scale.scramble.keep(4).sort;
		chord.postln;
		~synth.setn('frqs', chord);
		dur.wait
	})
}).play
)

~synth.free;
Tdef('chords').clear

s.sendMsg("/n_free", 1290)

s.queryAllNodes


SynthDef('sbt_bpf', {|out, buf|
	var src, sig, af, frqs, rqs, bf, n = 4;
	src = PlayBuf.ar(1, buf, BufRateScale.kr(buf), loop: 1);
	frqs = ArrayControl.kr('frqs', 4, 0);
	rqs = ArrayControl.kr('rqs', 4, 0);
	af = Array.fill(4, {
		DelayL.ar(BPF.ar(src, frqs[i], rqs[i]), 0.01, IRand(0.005, 0.01))
	});
	bf = FoaEncode.ar(af, FoaEncoderMatrix.newAtoB);
	Out.ar(out, bf)
}).add;

SynthDef('sbt_bqbnd', {|out, buf|
	var src, sig, af, n = 4;
	src = PlayBuf.ar(1, buf, BufRateScale.kr(buf), loop: 1);
	frqs = ArrayControl.kr('frqs', 4, 0);
	bwrs = ArrayControl.kr('bdws', 4, 0);
	af = Array.fill(4, {
		DelayL.ar(BBandPass.ar(src, frqs[i], bws[i]), 0.01, IRand(0.005, 0.01))
	});
	bf = FoaEncode.ar(af, FoaEncoderMatrix.newAtoB);
	Out.ar(out, bf)
}).add;

SynthDef('sbt_klnk', {|out, buf|
	var src, sig, af, n = 4;
	src = PlayBuf.ar(1, buf, BufRateScale.kr(buf), loop: 1);
	frqs = ArrayControl.kr('frqs', 4, 0);
	bwrs = ArrayControl.kr('bwrs', 4, 0);
	af = Array.fill(4, {
		DelayL.ar(BPF.ar(src, frqs[i], bwrs[i]), 0.01, IRand(0.005, 0.01))
	});
	bf = FoaEncode.ar(af, FoaEncoderMatrix.newAtoB);
	Out.ar(out, bf)
}).add;