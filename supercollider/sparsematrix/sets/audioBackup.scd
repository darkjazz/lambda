~path = "/Users/alo/Music/iTunes/iTunes Media/Music/alo allik/kciner rof/";

~bufs = (~path ++ "*").pathMatch.collect({|path|
	Buffer.read(Server.default, path)
})

Tdef('playbufs', {
	Ndef('ply', {
			var buf = ~bufs.choose;
			PlayBuf.ar(2, buf, BufRateScale.kr(buf), 1, Rand(0, BufFrames.kr(buf)), 1)
	}).play;
	loop({
		var bdr = (140/60).reciprocal;
		rrand(4, 30).round(bdr).wait;
		Ndef('ply', {
			var buf = ~bufs.choose;
			PlayBuf.ar(2, buf, BufRateScale.kr(buf), 1, Rand(0, BufFrames.kr(buf)), 1)
		});
	})
}).play
