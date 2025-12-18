~allbufs = "/Users/kurivari/snd/evolver/wav/*.wav".pathMatch.select({|path| File.fileSize(path) > 1800000 }).collect({|path|
		Buffer.readChannel(Server.default, path, channels: [0]);
});

(
~ncoeffs = 20;
Tdef('extract', {
	~playback_info = Dictionary.newFrom([
		"cols", 3, "data", Dictionary.new
	]);
	~ds = FluidDataSet(Server.default);
	Server.default.sync;
	~allbufs.do({|buf|
		var featbuf, statbuf, flatbuf;
		featbuf = Buffer(Server.default);
		statbuf = Buffer(Server.default);
		flatbuf = Buffer(Server.default);
		Server.default.sync;
		10.do({|i|
			var key = "%-%".format(buf.bufnum, i);
			FluidBufMFCC.processBlocking(Server.default, buf, i*buf.sampleRate, buf.sampleRate, features: featbuf, numCoeffs: ~ncoeffs);
			FluidBufStats.processBlocking(Server.default, featbuf, stats: statbuf);
			FluidBufFlatten.processBlocking(Server.default,statbuf,startFrame:5,numFrames:1,destination:flatbuf);
			Server.default.sync;
			~ds.addPoint(key, flatbuf);
			~playback_info["data"][key] = [buf.bufnum, i*buf.sampleRate, i*buf.sampleRate+buf.sampleRate];
			Server.default.sync;
		});
		featbuf.free;
		statbuf.free;
		flatbuf.free;
		Server.default.sync;
		Post << buf.path.basename << Char.nl;
	});
	~dsplay = FluidDataSet(Server.default).load(~playback_info);
	~ds.print;
	~dsplay.print;
}).play
)

~ds.print
~playback_info["data"].size

~ds.write("/Users/kurivari/Data/kdplayer/ds.json", {
	"done".postln
})

~dsplay.write("/Users/kurivari/Data/kdplayer/dsplay.json", {
	"done".postln
})

~ds = FluidDataSet(Server.default);
~ds.read("/Users/kurivari/Data/kdplayer/ds.json", {"done".postln})

~dsplay = FluidDataSet(Server.default)
~dsplay.read("/Users/kurivari/Data/kdplayer/dsplay.json", {"done".postln})


~tree = FluidKDTree(Server.default).fit(~ds)
~buf.free
~buf = Buffer.read(Server.default, "/Users/kurivari/snd/dj/1138-feat-hyx--corrupt-souls.aiff")

(
~ncoeffs = 20;
SynthDef('kdplayer', {|buf, oamp=0, th=0.5, rtime=3.7, dry=1.0, early=0.2, tail=0.3, intrp=0.5|
	var sig, mfcc, mfccbuf, info, trig, bufnum, start, frames, outsig, outrig, ampctr;
	mfccbuf = LocalBuf(~ncoeffs);
	sig = PlayBuf.ar(2, buf, BufRateScale.ir(buf), loop: 1);
	trig = FluidNoveltySlice.ar(sig[0], 1, 3, th); //Impulse.kr(10);
	mfcc = FluidMFCC.kr(sig[0], numCoeffs: ~ncoeffs, startCoeff: 1, maxNumCoeffs: ~ncoeffs);
	ampctr = FluidLoudness.kr(sig);
	info = LocalBuf(3);
	FluidKrToBuf.kr(mfcc,mfccbuf);
	~tree.kr(trig, mfccbuf, info, 1, lookupDataSet: ~dsplay);
	#bufnum, start, frames = FluidBufToKr.kr(info);
	SendReply.kr(A2K.kr(trig), '/mfcc', [bufnum, start, frames]);
	outsig = PlayBuf.ar(1, bufnum, BufRateScale.kr(bufnum), trig, start, 1);
	outsig = GVerb.ar(outsig, 37, rtime, drylevel: dry, earlyreflevel: early, taillevel: tail);
	Out.ar(0, FluidAudioTransport.ar(outsig, sig, intrp));
	// Out.ar(0, outsig * ampctr.dbamp + (sig*oamp))
}).add;
)
Spawn
~sy = Synth('kdplayer', ['buf', ~buf, 'oamp', 0, 'th', 0.33])
~sy.set('oamp', 0.0, 'th', 0.33, 'intrp', 0.7)

~sy.free

OSCdef('mfcc', {|msg|
	~data = msg.drop(3);
	~data.postln
}, '/mfcc');

OSCdef('mfcc').free

~mfcc.size