(
~ncoef = 20;
~dur = 8 * 60;
~dim = 20;
~decoder = FoaDecoder(decoderType: 'quad');
~input = MikroFoaInput(~decoder, "/Users/alo/sounds/voice/2012/8MinVersion1.aiff");

~graphics = CinderApp();
~analyzer = MikroAnalyzer(maxdur: ~dur, numcoef: ~ncoef, recordInput: false, isMono: false);

~mikro = Mikro(~input, ~graphics, ~analyzer);
~geenLambda = GeenLambda(~mikro, ~decoder, ~dur);

~geenLambda.prepare

)


~mikro.initPerformance(0);

~geenLambda.start
