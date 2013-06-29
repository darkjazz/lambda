//// SETUP ////

(
~ncoef = 20;
~dur = 8 * 60;

~nano = NanoKONTROL();
//~decoder = FoaDecoder(decoderType: 'quad');
~decoder = FoaDecoder(false);
~graphics = CinderApp();
)


~graphics.open

//// GEEN /////

(
// BUFFER INPUT
~input = MikroFoaInput(~decoder, "/Users/alo/sounds/voice/2012/8MinVersion1.aiff");
//~input = MikroFoaInput(~decoder, "/Users/alo/sounds/voice/2012/Dark+VOICE1");

~analyzer = MikroAnalyzer(maxdur: ~dur, numcoef: ~ncoef, recordInput: false, isMono: false);

~mikro = Mikro(~input, ~graphics, ~analyzer);
~geenLambda = GeenLambda(~mikro, ~decoder, ~dur);

~geenLambda.prepare

)

~analyzer.elapsedTime/60

~mikro.initPerformance(0);

~geenLambda.start


//// clear GEEN ////
~geenLambda.clear


//// SPARSEMATRIX ////

~matrix = SparseMatrix(~decoder, ~graphics, 2, ~ncoef);

Document.open("/Users/alo/Development/lambda/supercollider/sparsematrix/_-_LamBdaMaTrIx_-_.scd")

(
//// CLEANUP GEEN ////
~analyzer = nil;
~mikro = nil;
~input = nil;
)

//// prepare SKISM /////
(Document.current.dir +/+ "activateSkismDebug.scd").load


//// SKISM ////

~graphics.stopRotation

~graphics.initWorld(20, 20, 20, ~skismCoef)

~graphics.initContinuous;

~graphics.setViewpoint(0.0, 0.0, 80.0, 0.0, 0.0, 0.0);

~skismDecoder.start;

~skismInput.quit

(
~mikroLambda.group = Group.before(~skismDecoder.synth);

~skismInput.prepare(~mikroLambda.group);
)

//// START SKISM
~mikroLambda.start(-60.dbamp, 0.05, 30);

~recognizer.run

~composer.run



~skismrot = Rotation(30.0, 0.05, 20.0, 60.0, 0.0, 0.02, 0.0, 0.02);
~graphics.setCameraRotation(~skismrot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera

~graphics.stopRotation

~graphics.setFrameRate(32.0)

~graphics.setInterpolation(1, 2)

//// FX ////

~fx = FxLambda(~decoder, ~graphics, ~geenLambda.geen, ~nano)

IPhoneConnect()
