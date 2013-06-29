(
~decoder = FoaDecoder(decoderType: 'stereo');

~input = MikroFoaInput(~decoder, "/Users/alo/sounds/voice/2012/8MinVersion1.aiff");
)

(
~grp = Group();
~decoder.start(~grp, \addAfter);
~input.prepare(~grp);

)

(

~ncoef = 20;
~dur = ~input.testBuffers.first.duration;

~analyzer = MikroAnalyzer(
	maxdur: ~dur, 
	numcoef: ~ncoef, 
	recordInput: false, 
	isMono: false
);

~graphics = CinderApp();

~mikro = Mikro(
	input: ~input,
	graphics: ~graphics,
	analyzer: ~analyzer
);

~mikro.group = ~grp;

)

(
MikroData.loadPath = "/Users/alo/Data/mikro/lib001/";
~geen = MikroGeen();
~geen.updateClusters;
~geen.loadEventData;
~geen.trainSets;

~procs = "/Users/alo/Development/mikro/audio/procs01.scd".load;
~composer = MikroComposer(~mikro, ~procs);
~graphics.open;
)

(
~isPlaying = false;
// start
~analyzer.start(~input.bus, ~grp, \addToHead, -60.dbamp, 0.05, 30);
~input.mainamp_(-3.dbamp);
~input.auxamp_(-6.dbamp);
~input.start;

~graphics.initWorld(20, 20, 20, ~ncoef);

~geen.prepareForPlay(false, 1, ~decoder.bus, {
	~analyzer.onsetAction = {
		if ((~isPlaying.not) and: { ~analyzer.events.size > 4 }) {
			~isPlaying = true;
			~geen.playPreparedSequence( (4..8).wchoose([2, 0.5, 1.0, 0.3, 0.7].normalizeSum), 
				2, ~analyzer.events.last, ~analyzer.eventIntervals.last, {
					~isPlaying = false
				}
			)
		}
	}	
}, -6.dbamp);


Tdef(\liveprocs, {
	var names;
	names = #[ fbgverb, cliq, grains, arhythmic, latch, fbgverb, streamverb ];
	3.wait;
	~analyzer.addMFCCResponderFunction({|ti, re, ms, an|
		var argstr = Pseq(ms[3..~ncoef+2].clip(0.0, 1.0), inf).asStream;
		~composer.activeSynths.do({|synth|
			var args;
			args = ~composer.descLib[synth.defName.asSymbol].metadata.specs.collect(_.map(argstr.next));
			synth.set(*args.asKeyValuePairs)
		});
		
	});
	names.do({|name|
		var id;
		id = ~composer.play(name, argstream: Pn(0.25, inf).asStream);
		(~dur / names.size - 15).wait;
		~composer.releaseSynth(id, 15);
	})
}).play;

Tdef(\space, {
	loop({
		~input.synth.set(\xang, rrand(-pi, pi), \yang, rrand(-pi, pi), \zang, rrand(-pi, pi));
		rrand(0.5, 3.0).wait;
	})
}).play;

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

(
~grp.free;
~input.stop;
~input.free;
~analyzer.free;
~decoder.free;
~geen.stop;
)
