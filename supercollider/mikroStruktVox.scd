(
~decoder = FoaDecoder(
	isLocal: true, 
	decoderType: 'stereo'
);

~input = MikroFoaInput(~decoder, "/Users/alo/sounds/voice/2012/voxmachine.aif");

~nCoef = 12;
~dur = 333;
~isMono = true;

~bpm = 135;
~beatdur = (~bpm / 60).reciprocal;
~round = ~beatdur / 8;

~analyzer = MikroAnalyzer(
	maxdur: ~dur, 
	numcoef: ~nCoef, 
	recordInput: true, 
	isMono: ~isMono
);

~graphics = MikroGraphics(
	width: 800,
	height: 600,
	sizeX: 32,
	sizeY: 32,
	frameRate: 36,
	remoteAddr: NetAddr("127.0.0.1", 7770),
	vectorSize: ~nCoef,
	trainDur: 5000,
	lRate: 0.1
);

~mikro = Mikro(
	input: ~input,
	graphics: ~graphics,
	analyzer: ~analyzer
);

~recognizer = PatchRecognizer(~mikro, 30).load("/Users/alo/Data/mikro/110802_112556.plib");

~procs = "/Users/alo/Development/mikro/audio/procs01.scd".load;

~composer = MikroComposer(~mikro, ~procs, ~recognizer);

~eq = MasterEQ(2);

~mikro.makeGui(~composer, ~recognizer);

)

s.record

(
Tdef(\space, {
	var ang;
	ang = ();
	[\xang, \yang, \zang].do({|name|
		ang[name] = Pbrown(-1.0, 1.0, Pbrown(0.0625, 0.25, 0.0625, inf), inf).asStream
	});
	loop({
		~input.synth.set(*ang.collect(_.next).asKeyValuePairs);
		0.2.wait;
	})
}).play;
)

Tdef(\space).stop

s.stopRecording

~composer.stop

~composer.eventData
~composer.envSet
~composer.intChain.next(1.0)

~composer.allEvents.size

MikroGeen

~graphics.states
~graphics.bmu

~composer.liveprocs.collect(_.activationCount)

~composer.liveprocs[1].name

~mikro.start

~id = ~composer.play(\arhythmic, argstream: Pseq(Array.rand(16, 0.0, 1.0), inf).asStream )

~composer.releaseSynth(~id, 10, { "done".postln })

~analyzer.events.size
