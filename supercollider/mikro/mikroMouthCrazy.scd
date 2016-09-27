~ncoef = 13;
~graphics = CinderApp(1024, 768);
~decoder = FoaDecoder(decoderType: 'stereo');
~input = MikroInput(~decoder, "/Users/alo/snd/sharon");
~analyzer = MikroAnalyzer(1200, ~ncoef);
~mikro = Mikro(~input, ~graphics, ~analyzer, 1000, ~ncoef);