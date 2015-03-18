~buf = Buffer.read(s, Paths.soundDir +/+ "tehishing/tehishing_ch1-2_stereo.aif")
//~buf = Buffer.read(s, Paths.soundDir +/+ "aloallik_at_stubnitz.wav")
//~buf = Buffer.read(s, Paths.soundDir +/+ "collideroscope_I.aif")
//~buf = Buffer.read(s, Paths.soundDir +/+ "memor(2007).aif")
//~buf = Buffer.read(s, Paths.soundDir +/+ "oopium/nimetu_oopium")
//~buf = Buffer.read(s, Paths.soundDir +/+ "sparsematrix01.aif")


~tbus = Bus.control;

Ndef('meander', {|pos|
	var trig = InTrig.kr(~tbus);
	PlayBuf.ar(2, ~buf, 1.0, trig, trig, loop: 1);
})

s.record

s.stopRecording


Ndef('meander').play; ~tbus.value = 0;

Ndef('meander').set(\buffer, ~buf, \t_bus, ~tbus)

Ndef('meander').stop

Tdef('jump', {
	var delta, pos = Pstutter(
		Pwrand([1, 2, 4, 6, 8, 12, 16], (1..7).reciprocal.normalizeSum, inf), 
		Pwhite(0, ~buf.numFrames, inf)
	).asStream;
	delta = Pexprand(0.01, 4.0, inf).asStream;
	delta = Pstutter(
		Pwrand([1, 2, 4, 6, 8, 12, 16], (1..7).reciprocal.normalizeSum, inf),
		Pexprand(0.01, 4.0, inf)
	).asStream;
	loop({
		~tbus.value = pos.next;
		delta.next.round(64.reciprocal).wait
	})
})

Tdef('jump').play

Tdef('jump').clear

p = Pexprand(0.01, 4.0, inf).asStream

100.collect({ exprand(0.01, 4.0) }).mean
100.collect({ p.next }).mean



0.01.round(64.reciprocal)


Tdef('jump').stop

d = Pstutter(
	Pwrand([1, 2, 4, 8, 16, 32, 64].reciprocal, (1..7).reciprocal.normalizeSum, inf),
	Pexprand(0.0001, 4, inf)
).asStream;
