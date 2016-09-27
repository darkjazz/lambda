~buffers = "/Users/alo/snd/sharon/*".pathMatch.collect({|path|
	Buffer.read(s, path)
});

~numcoef = 13;

SynthDef(\eventDetector, {|in, msgrate|
	var input, chain, mfcc, event, cent, weight;
	input = In.ar(in);
	chain = FFT(LocalBuf(1024), input);
	mfcc = MFCC.kr(chain, ~numcoef);
	cent = SpecCentroid.kr(chain);
	event = Impulse.kr(msgrate);
	weight = Lag.kr(Amplitude.kr(input), 0.3);
	SendReply.kr(event, '/event', mfcc ++ cent ++ weight, 2);
}).add;

SynthDef('playbuf', {|out, buffer|
	var sig;
	sig = PlayBuf.ar(2, buffer);
	Out.ar(out, sig)
}).add;

(
Tdef('playback', {
	var bus, mfcs, bufs;
	bus = Bus.audio(s, 2);
	s.sync;
	mfcs = Synth('eventDetector', [\in, bus, \msgrate, 30]);
	s.sync;
	bufs = Synth.before(mfcs, 'playbuf', [\out, bus, \buffer, ~buffers[0]]);
	~buffers.scramble.do({|buf|
		bufs.set(\buffer, buf);
		buf.duration.wait;
	});
	"finished all buffers".postln;
})
)

~stats = [
	( 'mean': RunningStat(), 'min': 10.0, 'max': 0.0 ),
	( 'mean': RunningStat(), 'min': 10.0, 'max': 0.0 ),
	( 'mean': RunningStat(), 'min': 10.0, 'max': 0.0 ),
	( 'mean': RunningStat(), 'min': 10.0, 'max': 0.0 )
]

OSCdef('mfcc', {|ms, ti|
	var coef;
	var indx = [[0], [1, 2], [3, 4, 5, 6], (7..12)];
	if (ms[2] == 2) {
		indx.do({|inds, i|
			coef = ms[inds+3].sum;
			~stats[i]['mean'].push(coef);
			if (coef < ~stats[i]['min']) { ~stats[i]['min'] = coef };
			if (coef > ~stats[i]['max']) { ~stats[i]['max'] = coef };
		});
	}
}, '/event', s.addr)


Tdef('playback').play

~stats.do({|stat|
	[stat['mean'].mean, stat['mean'].stdDev, stat['min'], stat['max']].postln
})

OSCdef('mfcc').clear

/*
[ 0.60717737426034, 0.28608369692557, -0.62467014789581, 1.4693480730057 ]
[ 0.87439828873962, 0.3089951141615, -0.41313430666924, 1.572798371315 ]
[ 1.2735551173188, 0.39122901294828, -0.10491389036179, 1.8626971840858 ]
[ 1.6279570721718, 0.41444710318977, 0, 2.3803763091564 ]
*/