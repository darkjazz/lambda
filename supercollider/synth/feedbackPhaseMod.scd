SynthDef('grain', {|out, efx, amp, emp, dur, theta=0, phi=0|
	var osc1, osc2, osc3, freqs, amps, inds, mono, bf, env, n = 3;
	freqs = ArrayControl.kr('freqs', n, 1.0);
	amps = ArrayControl.kr('amps', n, 1.0);
	inds = ArrayControl.kr('inds', n, 1.0);
	env = EnvControl.kr;
	osc1 = SinOsc.ar(freqs[0], LocalIn.ar * inds[0], amps[0]);
	osc2 = SinOsc.ar(freqs[1], osc1 * inds[1], amps[1]);
	osc3 = SinOsc.ar(freqs[2], osc2 * inds[2], amps[2]);
	LocalOut.ar(osc3);
	mono = (osc1 + osc2 + osc3) * EnvGen.kr(env, timeScale: dur, doneAction: 2);
	bf = PanB.ar(mono * amp, theta, phi);
	Out.ar(efx, mono * emp);
	Out.ar(out, bf)
}).add;

~decoder = FoaDecoder(decoderType: 'stereo');
~freqmap = Array.primeSeries(18, 47, 19).clump(6);
~rbus = Bus.audio;
~bpm = 111;
~bps = ~bpm/60;
~beatdur = ~bps.reciprocal


Pdef('x00',
	Pbind('instrument', 'grain', 'addAction', 'addBefore', 'target', ~decoder.synth,
		'out', ~decoder.bus, 'amp', Pwhite(0.05, 0.1), 'efx', ~rbus, 'emp', 0.01,
		'dur', Pfunc({ ~beatdur * [0.2, 0.4] }),
		'theta', Pwhite(-pi, pi), 'phi', Pwhite(-0.5pi, 0.5pi),
		'inds', Pfunc({ [1, 1, 3].bubble }), 'amps', Pfunc({ Array.rand(3, 0.5, 1.0).bubble }),
		'env', Pfunc({ Env.perc.asArray.bubble }),
		'delta', ~beatdur / 5.4, 'type', Pwrand([\note, \rest], [0.7, 0.3], inf),
		'freqs', Pfunc({|ev| var freqs = ~freqmap.collect(_.choose).scramble; if (ev['type'] == \note) { freqs.postln} ; freqs.bubble }),
	)
)


(
~rev = SynthDef('reverb', {arg in, revamp=0.01, dry=0.8, revtime=0.5, max=2.0, del=2.0, dec=1.0, delamp=0.2;
	var sig, rev, delsig;
	sig = In.ar(in, 1);
	delsig = CombL.ar(sig * delamp, max, del, dec);
	rev = GVerb.ar(sig + delsig, 50, revtime, drylevel: dry, earlyreflevel: revamp);
	Out.ar(0, Limiter.ar(rev, 0.9))
}).play(~decoder.synth, ['in', ~rbus, 'revamp', 0.01, 'revtime', 4.4, 'dry', 0.0, 'del', ~beatdur / 8, 'dec', ~beatdur], 'addAfter')
)


(
~rev = SynthDef('reverb', {arg revamp=0.01, dry=0.8, revtime=0.5;
	var sig;
	sig = In.ar(0, ~decoder.numChannels);
	ReplaceOut.ar(0, GVerb.ar(sig, 150, revtime, drylevel: dry, earlyreflevel: revamp))
}).play(~decoder.synth, nil, \addAfter)
)
~rev.free

~rev.set('revamp', 0.03, 'revtime', 5.0, 'dry', 1.0)

~rev.free

~rev.set('revamp', 1.0, 'revtime', 2.5, 'dry', 0.0, 'delamp', 1.0, 'del', ~beatdur / 2);


~decoder.start

Tdef('cloud', {
	var delta = Pstutter(Pwhite(1, 4), Prand([1/3, 1/5, 1/7, 1/11], inf)).asStream;
	loop({
		~freqs = ~freqmap.collect(_.choose);
		~inds = Array.rand(3, 1, 1);
		[~freqs, ~inds].postln;
		Synth.before(~decoder.synth, 'grain', ['out', ~decoder.bus, 'amp', rrand(0.05, 0.1), 'dur', rrand(0.3, 1.0), 'theta', rrand(-pi, pi), 'phi', rrand(-0.5pi, 0.5pi)]).setn('freqs', ~freqs).setn('amps', Array.rand(3, 0.5, 1.0)).setn('inds', ~inds).setn('env', Env.perc);
		// .setn('env', Env([0.0, 1.0, 0.0], Array.rand(2, 0.1, 1.0).normalizeSum, Array.rand(2, 1.0, 4.0)));
		delta.next.wait;
	})
}).play



p.next

Tdef('cloud').clear

Pdef('x00').play

Pdef('x00').stop


Array.primes(7000, 7999).