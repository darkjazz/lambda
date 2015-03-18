(
~decoder = FoaDecoder(decoderType: 'stereo');
~graphics = CinderApp(1024, 768, mode: 1);
~input = MikroFoaInput(~decoder, "/Users/alo/sounds/voice/2012/8MinVersion1.aiff");
~nano = NanoKONTROL();
~fx = FxLambda(~decoder, ~graphics, ~nano);
)


~input.prepare

// start fx

~input.start
~input.mainamp = 0.5


~rot = Rotation(140.0, 0.008, 100.0, 60.0, 0.0, 0.0094, 0.0, 0.008);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera


~graphics.stopRotation

~graphics.activateSwarm(15, 200.0, 200.0, 200.0, 0.8, 50.0, 8.0, 5.0, 100.0);


~graphics.sendBoidPattern(0, 1, 0);

~graphics.sendBoidPattern(3, 0, 0);

~graphics.sendBoidPattern(4, 0, 0);
~graphics.sendBoidPattern(5, 0, 4);

~graphics.setSwarm(0.9, 50.0, 15.0, 25.0, 100.0)



~graphics.resetWorld(9, 9, 9, 4, 4, 4)


~graphics.open


~graphics.setBoidCam(true, false)

~graphics.setBoidCam(false, false)


MasterEQ(2)