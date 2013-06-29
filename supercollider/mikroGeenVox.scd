(
~decoder = FoaDecoder(decoderType: 'stereo');

~input = MikroFoaInput(~decoder, "/Users/alo/sounds/voice/2012/voxmachine.aif");
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

~mikro.group = ~grp;

)

MikroData.loadPath = "/Users/alo/Data/mikro/lib001/";
~geen = MikroGeen();
~geen.loadClusters;
//~geen.updateClusters;

////~geen.saveClusters
~geen.loadEventData;
~geen.trainSets;

~procs = "/Users/alo/Development/mikro/audio/procs01.scd".load;
~composer = MikroComposer(~mikro, ~procs);




s.record;

(
~isPlaying = false;
// start
~analyzer.start(~input.bus, ~grp, \addToHead, -60.dbamp, 0.05, 30);
~input.mainamp_(-3.dbamp);
~input.auxamp_(-6.dbamp);
~input.start;

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

)

Tdef(\space).stop

Tdef(\space).clear

~analyzer.events.size

s.stopRecording

s.queryAllNodes


(
~grp.free;
~input.stop;
~input.free;
~analyzer.free;
~decoder.free;
~geen.stop;
)

