~nano = NanoKONTROL();
~graphics = CinderApp(1024, 768, mode: 0);
~decoder = FoaDecoder(false, normalize: false);
~fx = FxLambda(~decoder, ~graphics, ~nano)


IPhoneConnect()


~graphics.rotate