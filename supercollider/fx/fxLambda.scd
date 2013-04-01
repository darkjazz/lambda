~geen = MikroGeen();
~nano = NanoKONTROL();
~graphics = CinderApp(1024, 768, mode: 1);
~decoder = FoaDecoder(decoderType: 'stereo', normalize: false);
~fx = FxLambda(~decoder, ~graphics, ~geen, ~nano)