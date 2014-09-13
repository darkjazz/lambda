~ncoef = 20;
~decoder = FoaDecoder(decoderType:'stereo');
~graphics = CinderApp();
~matrix = SparseMatrix(~decoder, ~graphics, 2, ~ncoef);


~sparsedata = UGepLoader().loadFromFile(Paths.devdir +/+ "lambda/supercollider/sparsematrix/2014-01-01/defnames00.scd");

~matrix.setBPM(140);

~matrix.makeEfxProto;

~matrix.prepareGepDefs(~sparsedata)

~matrix.prepareAudio


Pdef('matrix', Ppar([ Pdef('g02') ])).quant(128)

Pdef('matrix').play

Pdef('matrix').stop

~testpat = 'g02';

~matrix.defsAt(~testpat).ctrls.keys(Array).sort

~ctrl = 'g0209';


~matrix.defsAt(~testpat).ctrls[~ctrl].active = 1;
~matrix.defsAt(~testpat).ctrls[~ctrl].amp = 0.1;
~matrix.defsAt(~testpat).ctrls[~ctrl].dur = 0.4;


~matrix.defsAt(~testpat).ctrls[~ctrl].active = 0;


// g01 1, 2, 5, 8, 24, 49, 55, 57, 63

// g02 6,

(

~matrix.defsAt(~testpat).groups[0].do({|key|
	~matrix.defsAt(~testpat).ctrls[key].active = 0;
	~matrix.defsAt(~testpat).ctrls[key].amp = 0.5;
	~matrix.defsAt(~testpat).ctrls[key].dur = 0.3;
	~matrix.defsAt(~testpat).ctrls[key].emp = 0.0;

})

)




// g01 group 1, 6
// g02 group 0, 2(2), 3, 5, 6(3)
// g03 group 0, 1, 2(3), 3, 5, 6(2), 7
// g04 group 1, 4(2), 6, 7(2)
// g05 group 0, 3, 5




~dfile = File.open("/home/alo/development/lambda/supercollider/sparsematrix/2014-01-01/defnames00.scd", "r");
~defarray = ~dfile.readAllString.split(Char.nl).reject(_.isEmpty).collect(_.asSymbol);
~dfile.close;
~dfile = nil;

~defarray[[1, 2, 5, 8, 24, 49, 55, 57, 63, 69]].do(_.postln)
