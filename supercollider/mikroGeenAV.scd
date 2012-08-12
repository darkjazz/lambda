~decoder = FoaDecoder(decoderType: 'stereo');

~geen = MikroGeen();
~geen.loadClusters;
//~geen.updateClusters;

////~geen.saveClusters
~geen.loadEventData;
~geen.trainSets;

~ncoef = 8;
~sx = ~sy = ~sz = 24;

~ciapp = CinderApp(fps: 24).open;

~analyzer = MikroAnalyzer(numcoef: ~ncoef, recordInput: false, isMono: false);

~ciapp.initWorld(~sx, ~sy, ~sz, ~ncoef);

(
~cameraActions = (
	rotateCam: {|rhoRate, rhoMin, rhoRange, thetaRate, phiRate|
		~rotation = Rotation(rrand(rhoMin, rhoMin + rhoRange), rhoRate, rhoMin, rhoRange, 
			2pi.rand, thetaRate, 2pi.rand, phiRate);
		~ciapp.setCameraRotation(~rotation, 200.0, 200.0, 200.0, 200.0, 200.0, 200.0);
		~ciapp.rotateCamera;
	},
	attachCam: {|lookAtCenter=true|
		~ciapp.setBoidCam(true, lookAtCenter);
	},
	stopCam: {|x, y, z|
		~ciapp.setBoidCam(false, false);
		~ciapp.stopRotation;
		~ciapp.stopMove;
		~ciapp.setViewpoint(x, y, z, 200.0, 200.0, 200.0);
	},
	moveCam: {|startcoords, endcoords, time, rate, done|
		~ciapp.moveCamera(startcoords, endcoords, time, rate, done)
	}
);
~cameraWeights = (
	0.5: \rotateCam,
	0.3: \attachCam,
	0.08: \stopCam,
	0.12: \moveCam
);
~cameraActionParams = (
	rotateCam: {  
		[ 
		~flats.mean.explin(0.001, 0.6, 1/31, 1/11), 
		~amps.mean.explin(0.001, 1.0, 50.0, 500.0), 
		~amps.mean.explin(0.001, 1.0, 50.0, 300.0),
		~freqs.mean.explin(20.0, 20000.0, 1/31, 1/11),
		~flats.mean.explin(0.001, 0.6, 0.0, 1/23)
		]
	},
	attachCam: { [true] },
	stopCam: { 
		var sp = Spherical(~amps.mean.explin(0.001, 1.0, 50.0, 200.0) + 200.0, 2pi.rand, 2pi.rand);
		[sp.x, sp.y, sp.z]
	},
	moveCam: {  
		[
			[800.0.rand, 800.0.rand, 800.0.rand, 200.0, 200.0, 200.0], 
			[400.0.rand, 400.0.rand, 400.0.rand, 200.0, 200.0, 200.0],
			rrand(10, 30),
			10
		]
	}
)
)


(

~decoder.start;
~mfc = (0.25 ! 8);
~amps = (0 ! 20);
~freqs = (0 ! 20);
~flats = (0 ! 20);

~analyzer.addMFCCResponderFunction({|ti, re, ms, an|
	~mfc = ms[3..~ncoef+2];
	~ciapp.sendSOMVector(~mfc);
	~ciapp.setSwarm(0.9, 50.0, 8.0, (0.25 - ~mfc[0] ).abs.linlin(0.1, 1.0, 5.0, 40.0), 100.0)
});

~analyzer.putEventResponderFunction(\geenstats, {|ti, re, ms, an|
	if (ms[2] == 2) {
		~amps.pop;
		~amps.insert(0, ms[3]);
		if (~amps.keep(5).mean < 0.001) {
			~ciapp.setBoidCam(false, false);
			~ciapp.stopRotation;
			~ciapp.stopMove;			
		}
	};
	if (ms[2] == 5) {
		~freqs.pop;
		~freqs.insert(0, ms[3]);
	};
	if (ms[2] == 4) {
		~flats.pop;
		~flats.insert(0, ms[3])
	}
});

~analyzer.onsetAction = {
	var action;
	if (~amps.mean.coin) {
		action = ~cameraWeights.values.wchoose(~cameraWeights.keys(Array));
		if (action != 'stopCam') {  
			~ciapp.setBoidCam(false, false);
			~ciapp.stopRotation;
			~ciapp.stopMove;			
		};
		~cameraActions[action].(*~cameraActionParams[action].())
	};
	
	if (~amps.mean > 0.7) {
		~ciapp.activateSwarm(rrand(16, 32), 400.0, 400.0, 400.0, 0.9, 50.0, 8.0, 5.0, 100.0);
	}
};

~cameraActions.stopCamera.(200.0, 550.0, 200.0);
SystemClock.sched(20, {
	~analyzer.start(~geen.globalbus, ~geen.group, \addAfter, -3.dbamp);
	~geen.play(false, 2.0, ~decoder.bus);
	~ciapp.activateSwarm(24, 400.0, 400.0, 400.0, 0.9, 50.0, 8.0, 5.0, 100.0);
	nil
})
)

~geen.stop
~analyzer.free
~decoder.free
~ciapp.quit

