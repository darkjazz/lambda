(
~ncoef = 20;
~headsize = 10;
~numgenes = 4;
~decoder = FoaDecoder(decoderType:'stereo');
)

MasterEQ(2)

(
~foa = #[zoom,push];
~player = JGepPlayer(~decoder, dbname: "ges_ld_00");
~player.getDefNamesByHeader(~headsize, ~numgenes);
)

~defnames = ~player.defnames.select({|name|
	name.asString.drop(15).keep(2) == "16"
})


~defindices = ~player.data.selectIndices({|it| it.notNil })



Tdef('data', {
	~defindices.do({|ind|
		{ ~player.loadData(ind) }.try({ ind.postln });
		1.wait;
	})
}).play



~player.setBPM(142);

~decoder.start

~player.start(~foa)

~player.setFoa('zoom', 1.0)
~player.setFoa('push', 1.0)


~ind0 = ~defindices[0]

~player.loadData(~ind0)

~player.play(~ind0, 0, 'zoom', 0)

~player.set(~ind0, 1.0)

~player.free(~ind0)

Tdef('rec', {
	~defindices.do({|ind, i|
		Server.default.prepareForRecord("/Users/alo/snd/evolver/ev_" ++ (i + 100).asString ++ ".aif");
		Server.default.sync;
		Server.default.record;
		~player.play(ind, 0.7, 'zoom', 0);
		7.wait;
		~player.free(ind);
		Server.default.stopRecording;
		1.wait;
	})
})



Tdef('rec').play

Tdef('rec').clear

~player.data[1022]

~player.loadData(1022)