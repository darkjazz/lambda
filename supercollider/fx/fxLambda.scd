~nano = NanoKONTROL();
~graphics = CinderApp(1024, 768, mode: 0);
~decoder = FoaDecoder(decoderType: 'stereo', normalize: false);
~fx = FxLambda(~decoder, ~graphics, ~nano)


IPhoneConnect()

