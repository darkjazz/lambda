(
~file = File("/Users/alo/dev/lambda/supercollider/reveries/reveries_2.text", "r");
~text = ~file.readAllString;
~file.close;
~poems = ~text.split($+);
~poemstr = Pseq(~text.split($+), 1).asStream;
~sendText = {|i|
	~sendarr = ~poems[i].split(Char.nl);
	~sendarr.do({|text|
		~graphics.sendCodeLine(text);
	})
};
~sendTextTimed = {|i|
	Tdef('code').clear;
	Tdef('code', {
		~sendarr = ~poems[i].split(Char.nl);
		~sendarr.do({|line|
			~graphics.sendCodeLine(line);
			rrand(1.0, 3.0).wait;
		})
	}).play
};
~path = "/Users/alo/dev/lambda/xcode/DerivedData/lambdaApp/Build/Products/Release/lambda.app";
~wrldsz = 7;
~initMsg = {
	Tdef(\sendVector, {
		loop({
			~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
			[ 0.0625, 0.125, 0.25].choose.wait;
		});
	}).play;
};


~bufs = "/Users/alo/snd/reveries/kings/*".pathMatch.collect({|path|
	Buffer.read(s, path)
});

SynthDef('play', {|buf, amp|
	var sig;
	sig = PlayBuf.ar(2, buf, doneAction: 2);
	Out.ar(0, sig);
}).add;

Tdef('init', {
	~graphics = CinderApp(800, 600, mode: 1, path: ~path);
	~graphics.open;
	3.wait;
	~graphics.initWorld(~wrldsz, ~wrldsz, ~wrldsz, 20);
	0.3.wait;
	~graphics.initGenerations( [ 4, 7, 14 ], [ 8, 10, 12, 14, 15, 17, 18, 22, 26 ], 16 );
	0.3.wait;
	~graphics.setSymmetry(11);
	~graphics.setViewpoint(0.0, 90.0, 80.0, 0.0, 0.0, 0.0);
	~initMsg.();
	1.wait;
	~graphics.setFrameRate(17.0);
	s.sync;
	Post << "Initialised..." << Char.nl;
}).play


)

~graphics.hideCodePanel;
~graphics.setViewpoint(0.0, 220.0, 170.0, 0.0, 0.0, 0.0);
~graphics.mapCodePanel;
~sendText.(0);

s.scope

~synth = Synth('play', ['buf', ~bufs[0], 'amp', 0.2]);
~synth.set('amp', 0.8)
~synth.free

(
~graphics.showCodePanel;
~synth = Synth('play', ['buf', ~bufs[0], 'amp', 1.0]);
~graphics.setPattern(0, 1, 1.0, 0, 0, 0.3, 0.6, 1.0);
~graphics.setPattern(1, 1, 1.0, 1, 1, 1.0, 0.1, 0.4);
)

~sendTextTimed.(0);

~sendTextTimed.(1);

~sendTextTimed.(2);


~graphics.setPattern(0, 0, 1.0, 0, 0, 0.3, 0.6, 1.0);
~graphics.setPattern(1, 0, 1.0, 1, 1, 1.0, 0.1, 0.4);



~graphics.showCodePanel

(
~synth = Synth('play', ['buf', ~bufs[2], 'amp', 1.0]);
~graphics.setPattern(9, 1, 1.0, 1, 1, 0.1, 0.6, 1.0);
~graphics.setPattern(12, 1, 1.0, 1, 1, 0.2, 0.4, 0.6);
)

~sendTextTimed.(3);

~sendTextTimed.(4);

~sendTextTimed.(5);


~graphics.setPattern(9, 0, 1.0, 1, 1, 0.1, 0.6, 1.0);
~graphics.setPattern(12, 0, 1.0, 1, 1, 0.2, 0.4, 0.6);



(
~synth = Synth('play', ['buf', ~bufs[3], 'amp', 1.0]);
~graphics.setPattern(18, 1, 1.0, 1, 1, 0.2, 0.8, 1.0);
~graphics.setPattern(22, 1, 1.0, 1, 1, 0.4, 0.8, 1.0);
~graphics.setPattern(7, 1, 1.0, 0, 0, 0.9, 0.1, 0.5);
~graphics.setPattern(11, 1, 0.2, 1, 1, 0.1, 0.8, 1.0);

)

~sendTextTimed.(6);

~sendTextTimed.(7);

~sendTextTimed.(8);


(
~graphics.setPattern(18, 0, 1.0, 1, 1, 0.2, 0.8, 1.0);
~graphics.setPattern(22, 0, 1.0, 1, 1, 0.4, 0.8, 1.0);
~graphics.setPattern(7, 0, 1.0, 0, 0, 0.9, 0.1, 0.5);
~graphics.setPattern(11, 0, 0.2, 1, 1, 0.1, 0.8, 1.0);
)




(
~synth = Synth('play', ['buf', ~bufs[1], 'amp', 1.0]);
~graphics.setPattern(0, 1, 0.6, 1, 1, 1.0, 0.1, 0.4);
~graphics.setPattern(32, 1, 1.0, 0, 0, 1.0, 1.0, 1.0);
)

~graphics.setPattern(32, 0, 1.0, 0, 0, 1.0, 1.0, 1.0);
~graphics.setPattern(0, 0, 0.6, 1, 1, 1.0, 0.1, 0.4);

~sendTextTimed.(9);

~sendTextTimed.(10);
