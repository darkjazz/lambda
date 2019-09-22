~lizzie = {
	Out.ar(0, SoundIn.ar([0, 1]))
}.play



SynthDef('bpm', {
	var input, fft, beat;
	input = SoundIn.ar([0]);
	fft = FFT(LocalBuf(1024), input);
	beat = BeatTrack.kr(fft);
	SendReply.kr(beat[0], '/beats', beat[3])
}).add

~synth = Synth('bpm')

~synth.free



OSCdef('listen', {|ms|
	Post << "Current BPM: " << (ms[3] * 60).round(0.1) << Char.nl;
	~matrix.setBPM((ms[3] * 60).round(0.1))

}, '/beats', s.addr)




SynthDef(\bitSt2, {|out, efx, amp, emp, buf, dur|
	var sig;
	sig = Normalizer.ar(
		PlayBuf.ar(2, buf, BufRateScale.ir(buf) * 1.neg, 1, BufFrames.kr(buf)),
		amp) * EnvGen.kr(\env.kr(Env.newClear(8).asArray), timeScale: dur, doneAction: 2);
	Out.ar(efx, sig * emp);
	Out.ar(out, sig * amp)
}).add;

(

Synth(\bitSt2, ['out', ~decoder.bus, 'efx', 512, 'amp', rrand(0.3, 0.7), 'emp', 0.0, 'buf', ~matrix.buffers['evo'][rrand(0, 11)], 'dur', exprand(0.5, 2.0), 'env', [Env.perc, Env.sine].choose] );
)




// VIDEO CUES

// VIDEO 1
03:13 - 08:30
14:00 - 16:00

// VIDEO 2
00:50 - 02:25
04:56 - 05:25
07:12 - 08:45
19:40 - 22:40
25:45 - 26:50



300 + 120 + 70 + 25 + 4 + 25 + 60 + 33 + 180 + 60/ 60