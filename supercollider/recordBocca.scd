(
~ncoef = 20;
~dur = 8 * 60;

~decoder = FoaDecoder(decoderType: 'stereo');
~graphics = CinderApp(800, 600);
)

~graphics.open

//// GEEN /////

(
~input = MikroFoaInput(~decoder, "/Users/alo/sounds/voice/2012/8MinVersion1.aiff");

~analyzer = MikroAnalyzer(maxdur: ~dur, numcoef: ~ncoef, recordInput: false, isMono: false);

~mikro = Mikro(~input, ~graphics, ~analyzer);
~geenLambda = GeenLambda(~mikro, ~decoder, ~dur);

~geenLambda.prepare

)

~analyzer.elapsedTime / 60

~mikro.initPerformance(0);

~geenLambda.start

~analyzer.onsetAction

//// clear GEEN ////
~geenLambda.clear


~graphics.setBackground(0.1, 0.1, 0.1)