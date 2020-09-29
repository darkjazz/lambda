(
~lib = MadmomFeatureLib("/Users/alo/dev/reveries/audio.json");

~keys = #[tiersen, idioteque, lorelei, everything];
~intervalKeys = ['afx', 'blue-world'];

~lib.trainChordSets(~keys, 3);
~lib.trainIntervalSets(~intervalKeys, 3);

~chords = ~lib.generateChordSequence(64, nil, 6);
~intervals = ~lib.generateIntervalSequence(64, nil);

~primeChords = ~chords.collect({|chord| chord.collect(_.nearestPrime) }).collect(_.asFloat);

)


~primeChords.do(_.postln)


(
~num = 3;
~buffers = Array();
~decoder = FoaDecoder(decoderType: 'binaural');

SynthDef('posc', {|out, dur, amp, rtm, rot, til, tum|
	var chord, sig, env, bufnums, bf, indexes, rev, att;
	chord = ArrayControl.kr('chord', ~num, 0);
	env = EnvControl.kr(size: 16);
	bufnums = ArrayControl.kr('bufnums', ~num, 0);
	indexes = ArrayControl.kr('indexes', ~num, 0);
	sig = Mix.fill(~num, {|i|
		Osc.ar(bufnums[i], chord[i], SinOsc.ar(chord[i], 0, 11), 0.5)
		+ BPF.ar(Crackle.ar(1.98), chord[i], 11/chord[i], 73) ** 0.5
	}) * EnvGen.kr(env, timeScale: dur);
	Line.kr(dur: dur, doneAction: 2);
	rev = 0.1 * GVerb.ar(sig, 300, rtm, drylevel: 0) + sig;
	bf = FoaEncode.ar(rev * amp, FoaEncoderMatrix.newStereo);
	bf = FoaRTT.ar(bf, rot, til, tum);
	Out.ar(out, bf)
}).add;
)


(
{
	~buffers = Array.fill(~num, {|i|
		var frq, amp, buf = Buffer.alloc(Server.default, 2048);
		Server.default.sync;
		frq = [1] ++ Array.primeSeries(i+4, i+1, i+1);
		amp = Array.geom(i+7, 1.0, 71/73);
		buf.sine2(frq, amp);
	});
}.fork
);


~buffers.do(_.plot)

~decoder.start

(
Pdef('playChords',
	Pbind('instrument', 'posc', 'addAction', 'addBefore', 'target', ~decoder.synth,
		'out', ~decoder.bus, 'dur', Pseq(~intervals * 1.1, inf), 'amp', 0.2,
		'rot', Pwhite(-pi, pi, inf), 'til', Pwhite(-pi, pi, inf), 'tum', Pwhite(-pi, pi, inf),
		'delta', Pseq(~intervals, inf), 'chord', Pseq(~primeChords.collect(_.bubble), inf),
		// 'env', Env([0.001, 1.0, 1.0, 0.001], [0.1, 0.8, 0.1], 'sine').asArray.bubble,
		'env', Env.perc.asArray.bubble,
		'bufnums', ~buffers.collect(_.bufnum).bubble, 'rtm', 20.0
	)
).play
)

Pdef('playChords').clear




MasterEQ(2)

Tdef('playChords').clear

s.scope(2)

FreqScope()

s.queryAllNodes




SynthDef('gliss', {|out, dur, amp, rtm, rot, til, tum|
	var chord, sig, env, bufnums, bf, indexes, rev, att;
	chord = ArrayControl.kr('chord', ~num, 0);
	env = EnvControl.kr(size: 16);
	bufnums = ArrayControl.kr('bufnums', ~num*2, 0);
	indexes = ArrayControl.kr('indexes', ~num, 0);
	sig = Mix.fill(~num, {|i|
		VOsc.ar(bufnums[i], chord[i], SinOsc.ar(chord[i], 0, 11), 0.5)
	}) * EnvGen.kr(env, timeScale: dur);
	Line.kr(dur: dur, doneAction: 2);
	rev = 0.1 * GVerb.ar(sig, 300, rtm, drylevel: 0) + sig;
	bf = FoaEncode.ar(rev * amp, FoaEncoderMatrix.newStereo);
	bf = FoaRTT.ar(bf, rot, til, tum);
	Out.ar(out, bf)
}).add