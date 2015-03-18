(
~ncoef = 20;
~decoder = FoaDecoder(decoderType:'stereo');
~data = UGepLoader(16, 4).load;
~foa = #[zoom,focus];
~player = GepPlayer(~data, ~decoder);

)

~decoder.start

~player.start(~foa)

~player.setFoa('zoom', 1.0)
~player.setFoa('focus', 1.0)


~indZoom = 0

~player.play(~indZoom, 0, 'zoom', 0)

~player.set(~indZoom, 0.3)

~player.free(~indZoom)

~defstr = ~player.defStrings[~data[~indZoom].defname.asSymbol]; 

~synth = ~player.defStrings[~data[~indZoom].defname.asSymbol].interpret
	.play(args: ~data[~indZoom].args.args.postcs)


~data[~indZoom].data.methods.postcs

~data[~indZoom].data.terminals.postcs
