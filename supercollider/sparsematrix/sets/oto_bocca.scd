(
~bbus1 = Bus.audio(Server.default, 1);
~bbus2 = Bus.audio(Server.default, 1);
~bbus3 = Bus.audio(Server.default, 1);

SynthDef('in1', {|efx, emp, amp|
	var sig = SoundIn.ar(0);
	Out.ar(efx, sig * emp);
	Out.ar(0, sig.dup * amp)
}).add;

SynthDef('in2', {|efx, emp, amp|
	var sig = SoundIn.ar(1);
	Out.ar(efx, sig * emp);
	Out.ar(0, sig.dup * amp)
}).add;

SynthDef('in3', {|efx, emp, amp|
	var sig = SoundIn.ar(2);
	Out.ar(efx, sig * emp);
	Out.ar(0, sig.dup * amp)
}).add;
)

(
~rev = SynthDef('reverb', {arg out, in, revamp=0.05, dry=0.0, revtime=3.1;
	var sig, bf;
	sig = In.ar(in);
	sig = GVerb.ar(sig, 150, revtime, drylevel: dry, earlyreflevel: revamp);
	sig = sig.dup.flat;
	bf = FoaEncode.ar(Array.fill(4, { |i|
			IFFT( PV_Diffuser( FFT( LocalBuf(1024), sig[i]), Dust.kr(200.0) ))
	}), FoaEncoderMatrix.newAtoB('fud'));
	Out.ar(out, bf)
}).play(~matrix.efxgroup, ['out', ~matrix.decoder.bus, 'in', ~bbus1], \addToTail)

)
~rev3 = SynthDef('reverb', {arg out, in, revamp=0.05, dry=0.0, revtime=3.1;
	var sig, bf;
	sig = In.ar(in);
	sig = GVerb.ar(sig, 150, revtime, drylevel: dry, earlyreflevel: revamp);
	sig = sig.dup.flat;
	bf = FoaEncode.ar(Array.fill(4, { |i|
			IFFT( PV_Diffuser( FFT( LocalBuf(1024), sig[i]), Dust.kr(200.0) ))
	}), FoaEncoderMatrix.newAtoB('fud'));
	Out.ar(out, bf)
}).play(~matrix.efxgroup, ['out', ~matrix.decoder.bus, 'in', ~bbus3], \addToTail)


~in1.set('emp', 1.0)

~rev.set('revamp', 0.1, 'revtime', 1.0, 'dry', 0.0)

(
~in1 = Synth.head(~matrix.efxgroup, 'in1', [\efx, ~bbus1, \emp, 1.0, \amp, 0.0]);
~in2 = Synth.head(~matrix.efxgroup, 'in2', [\efx, ~bbus2, \emp, 1.0, \amp, 1.0]);
~in3 = Synth.head(~matrix.efxgroup, 'in3', [\efx, ~bbus3, \emp, 1.0, \amp, 0.0]);
)

~in1.set('amp', 0.0)

~voice.free

~in2.set('amp', 1.0)

~in3.set('emp', 10.0)



~matrix.skismSynths['cyclicWarp'].set('wrp', 0.25, 'dns', 8, 'wsz', 0.1, 'rnd', 0.1)

~matrix.activateBoccaSynth('cyclicWarp', ~bbus1);

~matrix.setSkismAmp('cyclicWarp', 0.0)

~matrix.deactivateSkismSynth('cyclicWarp')



~matrix.activateBoccaSynth('neuralFilter', ~bbus1);

~matrix.setSkismAmp('neuralFilter', 0.6)

~matrix.deactivateSkismSynth('neuralFilter')




~matrix.activateBoccaSynth('granularReverb', ~bbus1);

~matrix.setSkismAmp('granularReverb', 1.0)

~matrix.deactivateSkismSynth('granularReverb')


~matrix.activateBoccaSynth('feedbackSpectrum', ~bbus2)

~matrix.setSkismAmp('feedbackSpectrum', 0.2)

~matrix.deactivateSkismSynth('feedbackSpectrum')



~matrix.activateBoccaSynth('flangingDecimator', ~bbus2)

~matrix.setSkismAmp('flangingDecimator', 0.3 )

~matrix.deactivateSkismSynth('flangingDecimator')



~matrix.activateBoccaSynth('latchOnset', ~bbus3)

~matrix.setSkismAmp('latchOnset', 0.9)

~matrix.deactivateSkismSynth('latchOnset')



~matrix.activateBoccaSynth('cliqSaw', ~bbus3)

~matrix.setSkismAmp('cliqSaw', 0.3)

~matrix.deactivateSkismSynth('cliqSaw')


(
~recbufs = Array.fill(20, {
	Buffer.alloc(Server.default, Server.default.sampleRate * ~matrix.beatdur * 2, 1)
});

SynthDef(\record, {|buffer, in|
	var input;
	input = SoundIn.ar(in);
	RecordBuf.ar(input, buffer, loop: 0, doneAction: 2);
}).add;
)


Tdef('rec').clear



(

~source = [0];
Tdef('rec', {
	loop({
		Synth(\record, [\buffer, ~recbufs.choose, \in, ~source.choose]);
		1.wait;
	})
}).play

)


Tdef('rec').clear

(
SynthDef(\shiftSample, {|buffer, rate, winsize, shift, roomsize, revtime|
	var sig;
	sig = PlayBuf.ar(1, buffer, rate, loop: 1);
	sig = GVerb.ar(sig, roomsize, revtime);
	sig = PitchShift.ar(sig, winsize, shift);
	Out.ar(0, sig)
}).add;

SynthDef(\playSample, {| buffer, rate, amp |
	Out.ar(0, Pan2.ar(PlayBuf.ar(1, buffer, rate, doneAction: 2) * amp, Rand(-1.0, 1.0)))
}).add;

)


(
~shift1 = Synth(\shiftSample, [\buffer, ~recbufs.choose, \rate, 0.5, \winsize, 0.1, \shift, 1.0, \roomsize, 100, \revtime, 4]);
~shift2 = Synth(\shiftSample, [\buffer, ~recbufs.choose, \rate, 1.0, \winsize, 0.1, \shift, 4.0, \roomsize, 100, \revtime, 4]);
~shift3 = Synth(\shiftSample, [\buffer, ~recbufs.choose, \rate, 0.25, \winsize, 0.1, \shift, 1.0, \roomsize, 100, \revtime, 4]);
)


(
~shift1.set('rate', 2.0);
~shift2.set('rate', 1.0);
~shift3.set('rate', 4.0);
~shift1.set('shift', 0.5);
~shift2.set('shift', 0.5);
~shift3.set('shift', 0.5);
)



(
Tdef(\playshift, {
	loop({
		[~shift1, ~shift2].choose.set('buffer', ~recbufs.choose);
		rrand(3, 10).wait;
	})
}).play
)

(
Tdef(\playsamp, {
	loop({
		Synth('playSample', ['buffer', ~recbufs.choose,
			'rate', [0.5, -2.0, -1.0, 0.25].choose,
			'amp', rrand(0.5, 1.0)
		]
		);
		rrand(0.25, 2.0).round(0.25).wait
	})
}).play
)

Tdef(\playshift).clear

Tdef(\playsamp).clear

s.queryAllNodes

s.sendMsg("/n_free", 1012)


(
~shift1.free;
~shift2.free;
~shift3.free

)

Tdef(\playshift).clear