~cycles = "/Users/alo/sounds/funkt/cycle*".pathMatch.collect({|path| Buffer.read(Server.default, path) });

~frame = 2048;
~hop = 0.5;

~recbufs = ~cycles.collect({|buf| Buffer.alloc(s, buf.duration.calcPVRecSize(~frame, ~hop)) });

SynthDef('pvrec', {|rbuf, pbuf|
	var in, chain;
	in = PlayBuf.ar(1, pbuf, BufRateScale.kr(pbuf), doneAction: 2);
	chain = FFT(LocalBuf(~frame), in, ~hop/2, 1);
	chain = PV_RecordBuf(chain, rbuf, 0, 1, 0, ~hop, 1);
}).add;


~exec = {|index=0|
	Post << "Recording " << ~cycles[index].path.basename << Char.nl;
	Synth('pvrec', [\rbuf, ~recbufs[index], \pbuf, ~cycles[index]]);
	OSCFunc({|ms|
		if (index < ~cycles.size) {
			~exec.(index + 1)
		}
		{
			Post << "process finished" << Char.nl
		}
	}, '/n_end', s.addr).oneShot;	
}

~exec.()


SynthDef('pvply', {|pbuf, rbuf, rate=1, pamp=1, ramp=1| 
	var fft, src;
	src = PlayBuf.ar(1, pbuf, BufRateScale.kr(pbuf) * rate, loop: 1) * pamp;
	fft = IFFT(PV_PlayBuf(LocalBuf(~frame), rbuf, rate, 0, 1 )) * ramp;
	Out.ar(0, [src, fft])
}).add;

x = Synth('pvply', [\pbuf, ~cycles[3], \rbuf, ~recbufs[3], \rate, 0.5])
x.set(\pamp, 1)
x.set(\ramp, 1)
x.free


Routine({
	var path = "/Users/alo/sounds/funkt/fft/";
	~recbufs.do({|buf, i|
		var name = path ++ ~cycles[i].path.basename.split($.).first ++ ".scpv";
		buf.write(name, "wav", "float32");
		s.sync;
		Post << "Wrote " << name << " to disk" << Char.nl;
	})
}).play
