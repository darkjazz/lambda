//// SETUP ////

(
~ncoef = 20;
~dur = 20 * 60;

// ~nano = NanoKONTROL();
~decoder = FoaDecoder(decoderType:'stereo');
~graphics = CinderApp(1024, 768, mode: 0);
)

~graphics.open

~graphics.quit

//// GEEN /////

(
~input = MikroFoaInput(~decoder);

~analyzer = MikroAnalyzer(maxdur: ~dur, numcoef: ~ncoef, recordInput: false, isMono: false);

~mikro = Mikro(~input, ~graphics, ~analyzer);
~geenLambda = GeenLambda(~mikro, ~decoder, ~dur);

~geenLambda.prepare

)

Server.killAll


~geenLambda.geen.eventData.datalib


~analyzer.elapsedTime/60

~mikro.initPerformance(1);

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
(Document.current.dir +/+ "activateSkism.scd").load


//// SKISM ////

~graphics.stopRotation

~graphics.initWorld(20, 20, 20, ~skismCoef)

~graphics.initContinuous;

~graphics.setViewpoint(0.0, 0.0, 80.0, 0.0, 0.0, 0.0);

~skismDecoder.start;

(
~mikroLambda.group = Group.before(~skismDecoder.synth);

~skismInput.prepare(~mikroLambda.group);
)

//// START SKISM
~mikroLambda.start(-60.dbamp, 0.05, 30);

~recognizer.run

~composer.run



~skismrot = Rotation(30.0, 0.02, 20.0, 80.0, 0.0, 0.01, 0.0, 0.02);
~graphics.setCameraRotation(~skismrot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera

~graphics.stopRotation

s.queryAllNodes

~graphics.setFrameRate(32.0)

~graphics.setInterpolation(1, 2)

//// FX ////

~fx = FxLambda(~decoder, ~graphics, ~geenLambda.geen, ~nano)


IPhoneConnect()


s.queryAllNodes