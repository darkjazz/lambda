(
~ncoef = 20;
~dur = 8 * 60;

~decoder = FoaDecoder(decoderType:'stereo');
~graphics = CinderApp(800, 600, mode: 0);

~matrix = SparseMatrix(~decoder, ~graphics, 2, ~ncoef);

Document.open("/Users/alo/Development/lambda/supercollider/sparsematrix/_-_LamBdaMaTrIx_-_.scd")
)
