~bufs = "/Users/alo/snd/evolver/ev_*".pathMatch.collect({|path|
	Buffer.read(Server.default, path)
});

SynthDef('nois', {|buffer|
	Out.ar(0, PlayBuf.ar(2, buffer, BufRateScale.ir(buffer), loop: 1))
}).add;

~buf = ~bufs[64]

~synth = Synth('nois', ['buffer', ~buf])

~synth.free

~buf.path



(
[
100,
101,
103,
104,
105,
107,
109,
110,
111,
112,
113,
115,
117,
118,
119,
120,
123,
124,
125,
126,
127,
128,
139,
142,
144,
145,
147,
153,
159,
160,
161,
164
].do({|num|
	("mv /Users/alo/snd/sparsematrix/ev_" ++ num.asString ++ ".aif /Users/alo/snd/sparsematrix/ges/").unixCmd
})
)