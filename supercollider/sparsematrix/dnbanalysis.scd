~file = File.open("/Users/alo/Data/sonic-annotator/jams/dnb-qm-onsets/1783038_Afterlife_Original_Mix.json", "r");
~str = ~file.readAllString
~file.close
~file = nil

~data = ~str.replace(${.asString, $(.asString).replace($}.asString, $).asString).replace($".asString, $'.asString).interpret

~deltas = Array();
~data['annotations'][0]['data'].doAdjacentPairs({|timeA, timeB|
	~deltas = ~deltas.add(timeB['time'] - timeA['time'])
});

~deltas = ~deltas.collect({|dlt| dlt.round(0.0001) });
~distinct = Array();

~deltas.do({|dlt|
	if (~distinct.includes(dlt).not)
	{
		~distinct = ~distinct.add(dlt)
	}
})

~chain = PPMC(3)

~chain.train(~deltas)

~seq = Array();
~nextseq = ~deltas[0..2];
64.do({
	~nextval = ~chain.generate(~nextseq);
	~nextseq.addFirst(~nextval);
	~nextseq.pop;
	~seq = ~seq.add(~nextval);
})

~seq

(
~ncoef = 20;
~rate = 20;
~headsize = 14;
~numgenes = 4;

~decoder = FoaDecoder(decoderType:'stereo');
~graphics = CinderApp(1024, 768, mode: 1);

~matrix = SparseMatrix(~decoder, ~graphics, 2, ~ncoef);
)

~matrix.prepareAudio

Pdef('r00').source

Pdef('r08',
	Pbind(
		\instrument, Pseq(8.collect({|i| SparseMatrix.makeDefName(i, "d") }), inf),
		\group, ~matrix.group, \addAction, \addToHead,
		\delta, Pseq(~seq, inf), \amp, Pwhite(0.2, 0.3, inf), \emp, 0.0, \out, ~matrix.decoder.bus,
		\freq, Pseq(8.collect({|defindex| ~matrix.deffuncs[defindex].def.makeEnvirFromArgs[\freq] }), inf),
		\dur, Pwhite(0.08, 0.2, inf),
		*~matrix.argproto[\argproto][\default].asKeyValuePairs
	)
)


Pdef('r08').play

Pdef('r08').stop