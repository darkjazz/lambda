// rum mixed_envir.scd first

~buffers = "/Users/alo/snd/sharon/*".pathMatch.collect({|path|
	Buffer.read(s, path)
});

SynthDef('playbuf', {|out,efx, buffer|
	var sig;
	sig = PlayBuf.ar(2, buffer);
	Out.ar(efx, sig[0]);
	Out.ar(out, sig);
}).add;

~bufs = Synth.tail(~matrix.efxgroup, 'playbuf', [\out, 0, \efx, ~decoder.bus, \buffer, ~buffers[0]]);

Tdef('playback', {
	~buffers.scramble.do({|buf|
		~bufs.set(\buffer, buf);
		buf.duration.wait;
	})
})

Tdef('playback').play

Tdef('playback').clear

~bufs.free

['flangingDecimator', 'granularReverb', 'feedbackSpectrum', 'cyclicWarp', 'latchOnset', 'cliqSaw', 'fxGrain', 'arhythmicGendy']

~matrix.activateSkismSynth('arhythmicGendy')

~matrix.setSkismAmp('arhythmicGendy', 0.0)

~matrix.deactivateSkismSynth('arhythmicGendy')





~matrix.activateSkismSynth('cliqSaw')

~matrix.setSkismAmp('cliqSaw', 0.0)

~matrix.deactivateSkismSynth('cliqSaw')




~matrix.activateSkismSynth('fxGrain')

~matrix.setSkismAmp('fxGrain', 0.8)

~matrix.deactivateSkismSynth('fxGrain')



~matrix.activateSkismSynth('flangingDecimator')

~matrix.setSkismAmp('flangingDecimator', 0.0)

~matrix.deactivateSkismSynth('flangingDecimator')
