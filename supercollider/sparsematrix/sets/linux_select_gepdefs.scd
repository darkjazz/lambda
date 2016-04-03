~decoder = FoaDecoder(decoderType: 'stereo')

~player = JGepPlayer.newWithLoader(~decoder, loader: JsonLDLoader("ges_ld_00"))


~player.getDefNamesByDateRange("151220", "151230")


~player.defnames.size


~decoder.start

~foa = #[zoom];


~player.start(~foa)


SparseMatrix

~player.setFoa('zoom', 1.0);


~ind = 99;
~player.play(~ind, 0, 'zoom', 0)
~player.set(~ind, 0.5)

~player.free(~ind)


s.prepareForRecord("/home/alo/sounds/sparsematrix/ges/" ++ ~player.defnames[~ind].asString ++ ".aif");

s.record;

s.stopRecording;


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