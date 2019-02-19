~xpath = "/Users/alo/dev/lambda/xcode/";
~path = ~xpath ++ "DerivedData/lambdaApp/Build/Products/";
~graphics = CinderApp(1024, 576, mode: 0, path:~path ++ "Release/lambda.app");
~graphics.open;

(
~file = File("/Users/alo/dev/lambda/supercollider/sparsematrix/sets/codehack.scd", "r");
~code = ~file.readAllString;
~file.close;
~sendarr = ~code.split($%);
~sendCode = {
	Tdef('code', {
		loop({
			~sendarr.do({|code|
				var usr = ["poni$ ", "roosa$ "].choose;
				code.split(Char.nl).do({|line|
					if (line.size > 0) {
						~graphics.sendCodeLine(usr ++ line)
					}
				});
				rrand(4.0, 15.0).wait;
			})
		})
	}).play
};
~ncoef = 13;
~initAudio = {
	~buffer = Buffer.read(s, "/Users/alo/snd/poni/poni.wav");

	SynthDef('poni', {|buffer, amp|
		var sig = PlayBuf.ar(2, buffer, doneAction: 2);
		Out.ar(0, sig * amp)
	}).add;

	SynthDef(\mfcc, {|in, th|
		var fft, mfcc, onsets;
		fft = FFT(LocalBuf(1024), In.ar(in));
		mfcc = MFCC.kr(fft, ~ncoef ? 8);
		onsets = Onsets.kr(fft, th);
		SendReply.kr(onsets, '/mfcc', mfcc);
	}).add;
	SystemClock.sched(1.0, {
		~synth = Synth('poni', ['buffer', ~buffer, 'amp', 1.0]);
		~listener = Synth.after(~synth, \mfcc, [\in, 0, \th, -24.dbamp]);
		~mfccresp = OSCFunc({|ms|
			~graphics.sendSOMVector(ms[3..(~ncoef+2)]);
		}, '/mfcc', Server.default.addr ).add;
		nil
	});
};

~size = 17;
~startMessaging = {
	Tdef(\sendVector, {
		loop({
			~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
			[ 0.0625, 0.125, 0.25].choose.wait;
		});
	});

	Tdef(\sendVector).play
};
Tdef('run', {
	3.wait;
	~graphics.initWorld(~size, ~size, ~size, ~ncoef);
	0.5.wait;
	~graphics.initGenerations( [ 4, 7, 17 ], [ 5, 8 ], 16 );
	0.5.wait;
	~graphics.setSymmetry(11);
	~graphics.setViewpoint(0.0, 0.0, -40.0, 0.0, 0.0, 0.0);
	~graphics.sendCodeTitle("roosa poni");
	// ~startMessaging.();
	Post << "Initialised.." << Char.nl;
	1.0.wait;
	~initAudio.();
	~graphics.setPattern(2, 1, 1.0, 0, 0, 0.4, 0.5, 0.7);
	~graphics.setPattern(7, 1, 1.0, 0, 0, 0.4, 1.0, 1.0);
	~graphics.setPattern(8, 1, 0.5, 1, 1, 0.6, 0.0, 0.0);
	~graphics.showCodePanel;
	~sendCode.();
	SystemClock.sched(145, {
		// section 2
		~graphics.setPattern(2, 0, 1.0, 0, 0, 0.4, 0.5, 0.7);
		~graphics.setPattern(7, 0, 1.0, 0, 0, 0.4, 1.0, 1.0);
		~graphics.setPattern(8, 0, 0.5, 1, 1, 0.6, 0.0, 0.0);
		~graphics.setPattern(1, 1, 1.0, 1, 1, 1.0, 0.1, 0.4);
		~graphics.setPattern(34, 1, 0.3, 1, 1, 0.4, 0.4, 1.0);
		~graphics.setPattern(27, 1, 0.1, 0, 0, 0.4, 0.7, 0.1);
		~graphics.sendGenRule(*
			[ [ 4, 10, 11, 13, 14, 15, 18 ], [ 3, 7, 13 ], 22 ]
		);
		~graphics.mapCodePanel;
		~rot = Rotation(50.0, 0.17, 40.0, 90.0, 0.2, 0.13, 0.1, 0.15);
		~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
		~graphics.rotateCamera;
		nil
	});
	SystemClock.sched(309, {
		// section 3
		~graphics.activateSwarm(17, 200.0, 200.0, 200.0, 0.8, 50.0, 8.0, 15.0, 100.0);
		~graphics.sendBoidPattern(3, 1, 0);
		~graphics.setPattern(34, 0, 0.3, 1, 1, 0.4, 0.4, 1.0);
		~graphics.setPattern(27, 0, 0.1, 0, 0, 0.4, 0.7, 0.1);
		~graphics.setPattern(3, 1, 1.0, 1, 1, 1.0, 0.1, 0.5);
		~graphics.setPattern(18, 1, 0.4, 1, 1, 0.2, 0.8, 1.0);
		~graphics.setPattern(19, 1, 0.5, 0, 1, 0.1, 1.0, 0.4);
		~graphics.stopRotation;
		~graphics.sendGenRule(*
			[ [ 4, 12, 20 ], [ 8, 10, 20 ], 24 ]
		);
		~onsetresp = OSCFunc({|ms|
			if(0.2.coin) {
				~graphics.setBoidCam(false, false);
				~graphics.setViewpoint(
					rrand(-80.0, 80.0),
					rrand(-80.0, 80.0),
					rrand(-80.0, 80.0),
					rrand(-20.0, 20.0),
					rrand(-20.0, 20.0),
					rrand(-20.0, 20.0)
				);
			};
			if(0.2.coin) {
				~graphics.setBoidCam(true, true);
			}
		}, '/mfcc', Server.default.addr ).add;
		nil
	});
	SystemClock.sched(520, {
		~graphics.setPattern(1, 0, 1.0, 1, 1, 1.0, 0.1, 0.4);
		~graphics.setPattern(3, 0, 1.0, 1, 1, 1.0, 0.1, 0.5);
		~graphics.setPattern(18, 0, 0.4, 1, 1, 0.2, 0.8, 1.0);
		~graphics.setPattern(19, 0, 0.5, 0, 1, 0.1, 1.0, 0.4);
		~graphics.sendBoidPattern(3, 0, 0);
		~graphics.hideCodePanel;
	})
}).play
)

~graphics.stopRotation

~sendarr.do(_.postln)

~graphics.hideCodePanel

~graphics.mapCodePanel

~graphics.unmapCodePanel


(

)

~rot = Rotation(90.0, 0.015, 90.0, 50.0, 0.01, 0.002, 0.01, 0.01);

~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera

~graphics.stopRotation

~graphics.setPattern(34, 1, 0.1, 1, 1, 0.2, 0.4, 1.0);

(
Tdef('loopgraph', {
	var settings, select, indices;
	settings = (
		17: [ 0.7, 0, 1, 0.7, 0.9, 0.3],
		18: [ 0.4, 1, 1, 0.4, 0.7, 0.4],
		25: [ 1.0, 1, 1, 0.9, 0.8, 0.7],
		26: [ 0.5, 1, 1, 0.1, 0.2, 0.3]
	);
	indices = [];
	loop({
		if (select.notNil)
		{
			~graphics.setPattern(select, 0, *settings[select])
		};
		if (indices.size == 0) { indices = [17, 18, 25, 26].scramble };
		select = indices.pop;
		~graphics.setPattern(select, 1, *settings[select]);
		rrand(30.0, 45.0).wait
	})
}).play
)

Tdef('loopgraph').clear


(
~graphics.setViewpoint(0.0, 30.0, 0.0, 0.0, 0.0, 0.0);
~graphics.setPattern(2, 1, 1.0, 0, 0, 1.0, 1.0, 1.0);
)

~graphics.sendPredefined3DRule(\nova)
~graphics.sendPredefined3DRule(\sedimental)
~graphics.sendPredefined3DRule(\xtasy)



(
Tdef(\sendVector, {
	loop({
		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		[ 0.0625, 0.125, 0.25].choose.wait;
	});
}).play;
)


~graphics.activateSwarm(17, 200.0, 200.0, 200.0, 0.8, 50.0, 8.0, 15.0, 100.0);

~graphics.sendBoidPattern(3, 1, 0);

~graphics.setBoidCam(true, true)


~graphics.setPattern(0, 1, 1.0, 1, 1, 0.3, 0.6, 1.0);

~graphics.setPattern(1, 1, 1.0, 1, 1, 1.0, 0.1, 0.4);

~graphics.setPattern(2, 1, 1.0, 0, 0, 0.4, 0.5, 0.7);

~graphics.setPattern(3, 1, 1.0, 1, 1, 1.0, 0.1, 0.5);

~graphics.setPattern(4, 0, 1.0, 0, 0, 1.0, 1.0, 1.0);

~graphics.setPattern(5, 0, 1.0, 1, 0, 0, 0.92, 0.42);

~graphics.setPattern(6, 0, 1.0, 1, 1, 0.2, 0.8, 1.0);

~graphics.setPattern(7, 1, 1.0, 0, 0, 0.4, 1.0, 1.0);

~graphics.setPattern(8, 1, 1.0, 1, 1, 0.7, 1.0, 1.0);

~graphics.setPattern(9, 0, 1.0, 1, 1, 0.1, 0.6, 1.0);


~graphics.setPattern(10, 0, 0.4, 0, 0, 0, 0.59, 0.29);

~graphics.setPattern(11, 1, 0.2, 1, 1, 0.0, 0.5, 1.0);

~graphics.setPattern(12, 1, 1.0, 1, 1, 0.0, 0.4, 0.9);

~graphics.setPattern(13, 0, 0.9, 1, 0, 0.2, 0.8, 1.0);

~graphics.setPattern(14, 0, 1.0, 0, 0, 0.0, 0.7, 1.0);

~graphics.setPattern(15, 0, 1.0, 0, 0, 1.0, 1.0, 1.0);

~graphics.setPattern(16, 0, 1.0, 1, 1, 1.0, 1.0, 1.0);

~graphics.setPattern(17, 0, 0.3, 1, 1, 0.4, 0.8, 1.0);

~graphics.setPattern(18, 0, 1.0, 1, 1, 0.2, 0.8, 1.0);

~graphics.setPattern(19, 1, 1.0, 0, 1, 0.1, 1.0, 0.4);

~graphics.setPattern(20, 0, 1.0, 0, 0, 1.0, 0.0, 0.5);

~graphics.setPattern(21, 0, 1.0, 0, 0, 1.0, 1.0, 0.0);

~graphics.setPattern(22, 1, 1.0, 1, 1, 1.0, 0.1, 1.0);

~graphics.setPattern(23, 0, 1.0, 0, 0, 0.9, 0.0, 0.3);

~graphics.setPattern(24, 0, 1.0, 0, 0, 0.5, 0.6, 0.7);

~graphics.setPattern(25, 0, 1.0, 1, 1, 0.8, 0.1, 0.9);

~graphics.setPattern(26, 0, 0.3, 1, 1, 0.9, 0.1, 0.9);

~graphics.setPattern(27, 0, 0.8, 1, 1, 0.4, 0.7, 0.1);

~graphics.setPattern(28, 0, 1.0, 0, 0, 1.0, 1.0, 1.0);

~graphics.setPattern(29, 0, 0.2, 1, 1, 0.0, 1.0, 0.8);

~graphics.setPattern(30, 0, 1.0, 1, 1, 0.3, 0.3, 0.3);

~graphics.setPattern(31, 1, 0.5, 1, 1, 1.0, 0.0, 1.0);

~graphics.setPattern(32, 0, 0.05, 1, 1, 0.0, 0.04, 0.04);

~graphics.setPattern(33, 0, 0.5, 1, 1, 0.4, 0.0, 0.2);

~graphics.setPattern(34, 1, 0.2, 1, 1, 0.2, 0.4, 1.0);

~graphics.setPattern(35, 0, 0.6, 1, 1, 0.0, 0.6, 1.0);

~graphics.setPattern(36, 0, 0.1, 0, 0, 1.0, 0.08, 0.58);

~graphics.setPattern(37, 0, 0.1, 1, 1, 0.1, 0.1, 0.1);

~graphics.setPattern(38, 1, 1.0, 0, 0, 1.0, 0.08, 0.58);

~graphics.setPattern(39, 0, 1.0, 0, 0, 1.0, 1.0, 1.0);