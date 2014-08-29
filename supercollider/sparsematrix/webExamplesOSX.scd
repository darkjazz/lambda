(
~ncoef = 20;
~decoder = FoaDecoder(decoderType:'stereo');
~graphics = CinderApp(1024, 768);
)

MasterEQ(2)


(
~ncoef = 20;
~rate = 20;
~headsize = 16;
~numgenes = 4;

~dfile = File.open("/Users/alo/Development/lambda/supercollider/sparsematrix/2014-01-01/defnames.scd", "r");
~defarray = ~dfile.readAllString.split(Char.nl).collect(_.asSymbol);
~dfile.close;
~dfile = nil;

~data = ~defarray.collect({|defname|
	var path, meta, data;
	path = Paths.gepArchDir +/+ defname.asString ++ "." ++ UGEP.fileExt;
	if (File.exists(path)) { data = UGEP.loadData(path) };
	meta = UGenExpressionTree.loadMetadata(defname);
	data['data'] = data;
	data['defname'] = defname;
	data['args'] = meta.args;
	data['stats'] = meta.stats;
	data
});
~foa = #[zoom,focus,push,press];
~player = GepPlayer(~data, ~decoder);

)

(
~data = UGepLoader(12, 4).load;
~foa = #[zoom,focus,push,press];
~player = GepPlayer(~data, ~decoder);

)

~data.size.do({|i|
	~player.compilePanDefString(i)
})


~ind = 103;

~defstr = ~player.defStrings[~data[~ind].defname.asSymbol] ++ ".play(args: #" ++ ~data[~ind].args.args++ ")";

~synth = ~defstr.interpret

~synth.set('amp', 0.2)

~synth.free



~data.do({|data| data.args.class.postln })

~data.size

~decoder.start

~player.start(~foa)

~player.setFoa('zoom', 1.0)
~player.setFoa('push', 1.0)
~player.setFoa('press', 1.0)
~player.setFoa('focus', 1.0)


~data[5].code.postcs

~data.selectIndices({|data| data.defname == 'gep_gen000_151_130721_204123' })
57
// zoom 0 //
~indZoom = 57

~defstr = ~player.defStrings[~data[~indZoom].defname]; 

~synth = ~player.defStrings[~data[~indZoom].defname].interpret.play(args: ~data[~indZoom].args)

~synth.set()

~player.play(~indZoom, 0, 'zoom', 0)

~player.set(~indZoom, 0.3)

~player.free(~indZoom)


~synth = ~player.defStrings[~data[~indZoom].defname].interpret.play(args: ~data[~indZoom].args)

~data[~indZoom].args.args.postcs

~synth.set(\amp, 0.2)

~synth.free

// focus 1 //
~indFocus = 1

~player.play(~indFocus, 0, 'focus', 0)


~player.set(~indFocus, 0.2)

~player.setWithPattern(~indFocus, Pwhite(0.01, 0.4, inf), Pbrown(0.03125, 0.25, 0.03125, inf))


~player.free(~indFocus)


~pan = ~player.defStrings[~data[~indFocus].defname].interpret.play(args: ~data[~indFocus].args)

~pan.set(\amp, 0.1)

~pan.free


// push 2 //
~indPush = 2

~player.play(~indPush, 0, 'push', 0)


~player.set(~indPush, 1.0)

~player.setWithPattern(~indPush, Pseq(Array.rand(8, 0.0, 1.0).round(0.1), inf), 0.125)

~player.free(~indPush)





// press 3 //
~indPress = 3

~player.play(~indPress, 0, 'push', 0)


~player.set(~indPress, 0.5)

~player.setWithPattern(~indPress, Pseq(Array.rand(16, 0.0, 1.0).round(0.1), inf), 0.25)

~player.free(~indPress)

