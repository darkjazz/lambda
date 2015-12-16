(
SynthDef('wrprev', {|out, rate, start, wrp, freq, wsize, dens, randr,
		room, rtime, ramp, damp, iamp, buf, amp |
	var input, warpsig, revsig;
	input = PlayBuf.ar(1, buf, rate, 1, start * BufFrames.kr(buf), 1).dup;
	warpsig = Warp0.ar(
		buffer: buf,
		warpFactor: [wrp, wrp*15/16],
		freqScale: freq,
		windowSize: wsize,
		overlaps: dens,
		windowRandRatio: randr
	);
	revsig = GVerb.ar(warpsig * amp, room, rtime,
		drylevel: damp, earlyreflevel: ramp * 0.5, taillevel: ramp);
	Out.ar(out, revsig + (input * iamp));
}).add;

SynthDef('revwrp', {|out, rate, start, wrp, freq, wsize, dens, randr,
		room, rtime, ramp, damp, iamp, buf, amp |
	var input, warpsig, revsig;
	input = PlayBuf.ar(1, buf, rate, 1, start * BufFrames.kr(buf), 1).dup;
	revsig = GVerb.ar(input[0], room, rtime,
		drylevel: damp, earlyreflevel: ramp * 0.5, taillevel: ramp);
	warpsig = Warp0.ar(
		buffer: buf,
		warpFactor: [wrp, wrp*15/16],
		freqScale: freq,
		windowSize: wsize,
		overlaps: dens,
		windowRandRatio: randr
	) * amp;
	Out.ar(out, warpsig + (input * iamp));
}).add;
)

