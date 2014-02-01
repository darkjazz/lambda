~ncoef = 20;
~mode = 1;
~decoder = FoaDecoder(decoderType:'stereo');
~graphics = CinderApp(800, 600, mode: ~mode);

~matrix = SparseMatrix(~decoder, ~graphics, 2, ~ncoef);

MasterEQ(2)

(
~ncoef = 20;
~rate = 20;
~headsize = 16;
~numgenes = 4;

~dfile = File.open(Document.current.dir +/+ "defnames.scd", "r");
~defarray = ~dfile.readAllString.split(Char.nl).collect(_.asSymbol);
~dfile.close;
~dfile = nil;

~data = ~defarray.collect({|defname|
	var path, meta, data;
	path = UGEP.archDir +/+ defname.asString ++ "." ++ UGEP.fileExt;
	if (File.exists(path)) { data = UGEP.loadData(path) };
	meta = UGenExpressionTree.loadMetadata(defname);
	data['defname'] = defname;
	data['args'] = meta.args.args;
	data['stats'] = meta.stats;
	data
});
~foa = #[zoom,focus,push,press];
~player = GepPlayer(~data, ~decoder, ~graphics);

)

Document.open("/Users/alo/Development/lambda/supercollider/sparsematrix/2014-01-01/l_v_c_d.scd")
