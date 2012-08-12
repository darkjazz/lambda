~decoder = FoaDecoder(decoderType: 'stereo');

~geen = MikroGeen();
~geen.updateClusters;
~geen.loadEventData;
~geen.trainSets;

~decoder.start

~geen.initializeChain

~geen.play(false, 2.0, ~decoder.bus)

~geen.stop

~geen.currentEvent

s.queryAllNodes

~decoder = FoaDecoder(decoderType: 'quad', normalizer: true);
~input = MikroFoaInput(~decoder, "/Users/alo/sounds/mikro/christian.aif");


~ncoef = 8;
~sx = ~sy = ~sz = 24;


~ciapp = CinderApp(fps: 10).open;

~analyzer = MikroAnalyzer(numcoef: ~ncoef, recordInput: false, isMono: false);

~ciapp.initWorld(~sx, ~sy, ~sz, ~ncoef);

~analyzer.addMFCCResponderFunction({|ti, re, ms, an|
	~ciapp.sendSOMVector(*ms[3..~ncoef+2])
});

~ciapp.setViewpoint(200.0, 200.0, 0.0, 200.0, 200.0, 200.0);

~ciapp.activateSwarm(40, 400.0, 400.0, 400.0, 0.9, 50.0, 8.0, 10.0, 100.0);

~ciapp.moveCamera([200.0, 200.0, -1200.0, 200.0, 200.0, 200.0], [200.0, 200.0, -200.0, 200.0, 200.0, 200.0], 60, 10, {"finished".postln})


~geen.play(true, 2.0)

~geen.stop

