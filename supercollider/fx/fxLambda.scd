~nano = NanoKONTROL();
~graphics = CinderApp(1024, 768, mode: 0);
~decoder = FoaDecoder(decoderType: 'binaural', normalize: false);
~fx = FxLambda(~decoder, ~graphics, ~nano)


PhoneConnect()




