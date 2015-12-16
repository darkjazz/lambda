~decoder = FoaDecoder(decoderType: 'stereo')

~player = JGepPlayer(~decoder, dbname: "ges_02")


~player.getDefNamesByDateRange("151104", "151106")


~player.defnames.size


~decoder.start

~foa = #[zoom];


~player.start(~foa)


~player.setFoa('zoom', 1.0);


~ind = 151;
~player.play(~ind, 0, 'zoom', 0)
~player.set(~ind, 0.5)

~player.free(~ind)


s.queryAllNodes


(
Tdef('record', {
	s.prepareForRecord("/home/alo/sounds/sparsematrix/ges/" ++ ~player.defnames[~ind].asString ++ ".aif");
	s.sync;
	s.record;
	5.wait;
	s.stopRecording;
	Post << "Wrote " << ~player.defnames[~ind].asString << Char.nl;
}).play
)