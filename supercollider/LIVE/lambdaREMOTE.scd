//my ip:  92.236.185.17

(
~ncoef = 20;
~dur = 8 * 60;

//~netaddr = NetAddr("98.151.254.234", 7000);
~decoder = FoaDecoder(decoderType: 'stereo');
~graphics = CinderApp(mode: 1);
)


(
~input = MikroFoaInput(~decoder);

~analyzer = MikroAnalyzer(maxdur: ~dur, numcoef: ~ncoef, recordInput: false, isMono: false);

~mikro = Mikro(~input, ~graphics, ~analyzer);
~geenLambda = GeenLambda(~mikro, ~decoder, ~dur);

~geenLambda.prepare

)

~mikro.initRemote;

~geenLambda.start

~input.mainamp_(0.0)


//// clear GEEN ////
~geenLambda.clear

(
//// CLEANUP GEEN ////
~analyzer = nil;
~mikro = nil;
~input = nil;
)
