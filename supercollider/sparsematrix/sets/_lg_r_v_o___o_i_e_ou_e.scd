// nanstep infdub niljazz noisefunk

(
~ncoef = 20;
~rate = 20;
~headsize = 14;
~numgenes = 4;

~decoder = FoaDecoder(decoderType:'stereo');
~graphics = CinderApp(1440, 768, mode: 1);

~matrix = SparseMatrix(~decoder, ~graphics, 2, ~ncoef);
)


MasterEQ(2)



(

~foa = #[zoom,push];
~player = JGepPlayer(~decoder, dbname: "ges_00");
~player.getDefNamesByHeader(~headsize, ~numgenes);
)



~matrix.setBPM(141);
~player.setBPM(141);

~matrix.loadPatternDefs("patternDefsAppend.scd");


~loader = JsonLoader("ges_00");
~defnames = ~loader.getDefNamesByHeader(16, 1).collect({|def| def['value'] });
~matrix.prepareGepDefs(~defnames, ~loader);

~matrix.prepareAudio

s.queryAllNodes



Pdef('matrix', Ppar([ Pdef('r00'), Pdef('r01'),  Pdef('b02'), Pdef('b03')])).quant(64)


Pdef('matrix').play

~buf = Buffer.read(s, Paths.soundDir +/+ "collideroscope_I.aif")

~tbus = Bus.control;


Ndef('meander', {|pos|
	var trig = InTrig.kr(~tbus);
	PlayBuf.ar(2, ~buf, 1.0, trig, trig, loop: 1) * 2;
})

Ndef('meander').play; ~tbus.value = 0;

~pos = Pstutter(
	Pwrand([1, 2, 4, 6, 8, 12, 16], (1..7).reciprocal.normalizeSum, inf),
	Pwhite(0, ~buf.numFrames, inf)
).asStream;

(
~matrix.onsetFunc = {
	var pos;
	if (0.7.coin) {
		pos = ~pos.next;
		~tbus.value = pos;
	}
}
)

Ndef('meander').clear

~seconds = SystemClock.seconds;

~matrix.defsAt('g00').setEfx(0, ['efx0'])
~matrix.defsAt('r00').setEfx(1, ['efx2'])
~matrix.defsAt('r00').setEfx(2, ['efx3', 'efx5'])
~matrix.defsAt('r00').setEfx(3, ['efx1', 'efx4'])



(0..31).do({|index|
	var efxkeys = ['efx0'].select({ 0.2.coin });
	~matrix.defsAt('r00').setEfx(index, efxkeys)
})


(0..31).do({|index|
	var efxkeys = ['efx3'].select({ 0.3.coin });
	~matrix.defsAt('r03').setEfx(index, efxkeys)
})

(0..31).do({|index|
	var efxkeys = ['efx4'].select({ 0.3.coin });
	~matrix.defsAt('r06').setEfx(index, efxkeys)
})

(0..31).do({|index|
	var efxkeys = ['efx5'].select({ 0.5.coin });
	~matrix.defsAt('r01').setEfx(index, efxkeys)
})

~matrix.defsAt('r00').assignEfx(
	(efx0: (1,3..31))
)


~matrix.defsAt('r00').assignEfx(
	(efx0: (1,3..31))
)

~matrix.defsAt('r02').assignEfx(
	(efx3: (1,4..31))
)


~matrix.defsAt('r04').assignEfx(
	(efx4: (0..31))
)


~matrix.defsAt('r07').assignEfx(
	(efx5: (0,2..31))
)

~matrix.defsAt('r04').assignEfx(
	(efx4: (0..31))
)

~matrix.defsAt('r06').assignEfx(
	(efx5: (0..31))
)




~matrix.defsAt('r06').assignEfx(
	(efx4: (0..31))
)


~matrix.defsAt('r01').assignEfx(
	(efx0: [3, 13, 23, 33], efx1: [4, 14, 24, 44], efx3: [6, 16, 26, 56], efx4: [8, 18, 28, 60], efx5: [10, 20, 30, 40])
)


~matrix.efxamps['efx0'] = 0.2

~matrix.efxamps['efx1'] = 0.3

~matrix.efxamps['efx2'] = 0.3

~matrix.efxamps['efx3'] = 0.5

~matrix.efxamps['efx4'] = 0.5

~matrix.efxamps['efx5'] = 0.5

// debug
~graphics.start(0)




~graphics.open

~graphics.initWorld(16, 16, 16, ~ncoef);

~graphics.initGenerations([4,6,8], [3,5,7,9], 16);



~graphics.setSymmetry(11)




~graphics.setViewpoint(0.0, 0.0, -120.0, 0.0, 0.0, 0.0);


~graphics.showCodePanel

~matrix.assignCodeWindow(Document.current);

~matrix.defsAt('g00').gepdata.collect(_.args).select({|arr| arr.select(_.isKindOf(Number)).select(_.isNaN).size > 0  })

~graphics.sendPredefined3DRule(\nova)

~matrix.defsAt('r00').groups.first.do({|name|
	~matrix.defsAt('r00').ctrls[name].amp = 0.8;
	~matrix.defsAt('r00').ctrls[name].dur = 0.2;
	~matrix.defsAt('r00').ctrls[name].active = 1;
	~matrix.defsAt('r00').ctrls[name].emp = 0.6;
})


~matrix.defsAt('g00').ctrls.select({|ctr| ctr.active == 1 }).do({|ct|
	ct.amp = exprand(0.3, 0.8)
})

~matrix.defsAt('g03').setControls(
	{ [0, 1].wchoose([0.5, 0.5]) },
	{ exprand(0.1, 1.0) },
	{ exprand(0.01, 0.3) },
	0.1
);

s.scope

Pdef('matrix').source.list.collect(_.key)

Pdef('matrix').source.list.collect(_.key)[[1, 2]].do({|key|
	~matrix.defsAt(key).setActives(ampFunc: {0})
})

Pdef('matrix').source.list.collect(_.key)[[1, 2]].do({|key|
	~matrix.defsAt(key).recall(0)
});

~matrix.defsAt('r00').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.01, 0.2) },
	0.1
);

~matrix.defsAt('g01').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.3, 1.0) },
	{ exprand(0.03, 0.3) },
	0.1
);

~matrix.defsAt('g02').setControls(
	{ [0, 1].wchoose([0.4, 0.6]) },
	{ exprand(0.3, 1.0) },
	{ exprand(0.05, 0.4) },
	0.1
);






~matrix.defsAt('r07').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.1, 0.3) },
	0.1
);

~matrix.defsAt('b03').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.1, 0.3) },
	0.1
);



~matrix.defsAt('g01').recall(0)

~matrix.defsAt('g00').setActives(ampFunc: { rrand(0.3, 1.0) });


~matrix.defsAt('g01').setActives(durFunc: { rrand(0.01, 0.05) });
~matrix.defsAt('r03').setActives(durFunc: { rrand(0.01, 0.05) });

~matrix.defsAt('g00').recall(0);
~matrix.defsAt('g01').recall(0);

~graphics.mapCodePanel

~matrix.defsAt('r06').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ exprand(0.5, 1.0) },
	{ exprand(0.05, 0.2) },
	0.1
);

~matrix.defsAt('g00').recall(0);
~matrix.defsAt('g01').recall(0)


~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.1, 0.5) },
	{ exprand(0.005, 0.1) },
	0.1
);


~matrix.defsAt('b01').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.2, 1.0) },
	{ exprand(0.03, 0.1) },
	0.1
);


~matrix.defsAt('r07').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.2, 1.0) },
	{ exprand(0.004, 0.1) },
	0.1
);

~matrix.defsAt('b03').setControls(
	{ [0, 1].wchoose([0.9, 0.1]) },
	{ exprand(0.2, 1.0) },
	{ exprand(0.1, 0.1) },
	0.1
);


~matrix.defsAt('b02').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.2, 1.0) },
	{ exprand(0.05, 0.2) },
	0.1
);

~matrix.defsAt('b01').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.2, 1.0) },
	{ exprand(0.1, 0.5) },
	0.1
);

~matrix.defsAt('b03').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.2, 1.0) },
	{ exprand(0.1, 0.5) },
	0.1
);





~matrix.defsAt('r05').recall(0);

~matrix.defsAt('r01').recall(0);

~matrix.defsAt('b03').recall(0);


~graphics.setPattern(26, 0, 1.0, 1, 1, 0.6, 0.9, 1.0);


~graphics.setPattern(8, 1, 1.0, 1, 1, 0.5, 0.9, 0.8);






s.queryAllNodes



~matrix.defsAt('r02').recall(0);

~matrix.defsAt('b02').recall(0);

~matrix.defsAt('r05').recall(0)

~matrix.defsAt('r04').recall(0)

~matrix.defsAt('r03').recall(0)


/////////// GEP ROUTINE /////////////

~player.start(~foa)

~player.setFoa('zoom', 1.0)
~player.setFoa('push', 1.0)


// 56-60, 61-62

~indZoom = 48;
~indPush = 49;

~player.loadData(~indZoom);
~player.loadData(~indPush)

(
~player.playRoutine(~indZoom,
	Pseq([1, 0, 1, 0, 0, 1, 0, 0]*0.3, inf), Pseq([0.5, 0.25, 0.25, 0.5, 0.25, 0.25], inf), 'zoom');
~player.playRoutine(~indPush,
	Pseq([0, 1, 0, 1, 1, 0, 1, 0]*0.3, inf), Pseq([0.5, 0.25, 0.25, 0.5, 0.25, 0.25], inf), 'push');
)

~player.stopRoutine(~indZoom);
~player.stopRoutine(~indPush);


// 38-40, 42-43, 44-45, 50-49

~indZoom = 50;
~indPush = 49;

~player.playRoutine(~indZoom, Pseq([0.5, 0, 0.5, 0, 0, 0.5], inf), Pseq([0.5, 0.25, 0.25, 0.5, 0.25, 0.25], inf), 'zoom');
~player.playRoutine(~indPush, Pseq([0, 0.5, 0, 0.5, 0.5, 0], inf), Pseq([0.5, 0.25, 0.25, 0.5, 0.25, 0.25], inf), 'push');


~player.playRoutine(~indZoom, Pseq([1.0, 0, 1.0, 0, 0, 1]*0.3, inf), Pseq([1, 2, 2, 1, 2, 1], inf), 'zoom');
~player.playRoutine(~indPush, Pseq([0, 1.0, 0, 1.0, 0.5,1]*0.3, inf), Pseq([2, 1, 1, 2, 1, 2], inf), 'push');

~player.stopRoutine(~indZoom);
~player.stopRoutine(~indPush);


/////// GEP SPARSE ROUTINE //////////

~indices = (69..72);

~indices = (45..48);

~indices = [69, 70, ]


Tdef('loadData', {
	~indices.do({|ind|
		~player.loadData(ind);
		1.wait;
	})
}).play

~player.playSparseRoutines(
	~indices , 'diansa', (0..3), 8, 'zoom', #[0.5, 0.25, 0.5, 0.25], #[0.1, 0.1, 0.1, 0.1]
);

~player.stopSparseRoutines(~indices)


////////// GEP PLAYER /////////////

~player.start(~foa)

~player.setFoa('zoom', 1.0)
~player.setFoa('push', 1.0)

~player.stop


// start with 10

~ind0 = 59

~player.loadData(~ind0)

~player.play(~ind0, 0, 'zoom', 0)

~player.set(~ind0, 0.0)


~player.setWithPattern(~ind0,
	Pseq([0, 0, 0, 0, 0, 0, 0, 0, 0.2, 0.05, 0.2, 0, 0.2, 0.0, 0.2, 0], inf), ~matrix.beatdur/2)

~player.free(~ind0)


~ind0 = 85

~player.loadData(~ind0)


~player.play(~ind0, 0, 'zoom', 0)

~player.set(~ind0, 0.3)


~player.free(~ind0)


~player.setWithPattern(~ind0,
	Pseq([0.1, 0, 0.1, 0.05, 0.15, 0.5, 0.1, 0, 0.2, 0, 0.6, 0.2].mirror2, inf), ~matrix.beatdur/2)

~player.setWithPattern(~ind0,
	Pseq([0, 0, 0, 0, 0, 0, 0, 0, 0.6, 0.1, 0.6, 0, 0.6, 0.0, 0.6, 0], inf), ~matrix.beatdur/2)


~player.setWithPattern(~ind0, Pwhite(0.05, 0.2, inf), Pbrown(0.03125, 0.25, 0.03125, inf))

~player.setWithPattern(~ind0, Pseq(Array.rand(16, 0.0, 0.3).round(0.1).mirror2, inf), ~matrix.beatdur/2)


~player.free(~ind0)




// push 1 // 14, 16, 18
~ind1 = 37

~player.loadData(~ind1)

~player.play(~ind1, 0, 'push', 0)

~player.set(~ind1, 0.0)

~player.setWithPattern(~ind1,
	Pseq([0.1, 0, 0.1, 0.05, 0.15, 0.4, 0.1, 0, 0.2, 0, 0.5, 0.2], inf), ~matrix.beatdur/4)

~player.setWithPattern(~ind1, Pwhite(0.001, 0.01, inf), Pbrown(0.03125, 0.25, 0.03125, inf))

~player.setWithPattern(~ind1, Pseq(Array.rand(8, 0.0, 1.0).round(0.1), inf), 0.125)

~player.free(~ind1)



// press 2 //
~ind2 = 26

~player.play(~ind2, 0, 'press', 0)


~player.set(~ind2, 1.0)

~player.setWithPattern(~ind2,
	Pseq([0.1, 0, 0.1, 0.05, 0.15, 0.4, 0.1, 0, 0.2, 0, 0.7, 0.2, 0.1, 0.1, 0.8], inf), 0.125)

~player.setWithPattern(~ind2, Pwhite(0.05, 0.4, inf), Pbrown(0.03125, 0.25, 0.03125, inf))

~player.setWithPattern(~ind2, Pseq(Array.rand(8, 0.0, 1.0).round(0.1), inf), 0.125)

~player.free(~ind2)



// focus 3 //
~ind3 = 35

~player.play(~ind3, 0, 'focus', 0)

~player.set(~ind3, 1.0)

~player.setWithPattern(~ind3,
	Pseq([0.1, 0, 0.1, 1.0, 1.0, 0.4, 0.1, 0, 1.0, 0, 1.0, 0.2, 0.1, 0.6], inf), 0.125)

~player.setWithPattern(~ind3, Pwhite(0.01, 0.4, inf), Pbrown(0.03125, 0.25, 0.03125, inf))

~player.setWithPattern(~ind3, Pseq(Array.rand(8, 0.0, 1.0).round(0.1), inf), 0.125)

~player.free(~ind3)


s.queryAllNodes

s.sendMsg("/n_free", 1021)



////////// SKISM PATCHES /////////////////


~matrix.activateSkismSynth('granularReverb')

~matrix.setSkismAmp('granularReverb', 0.3)

~matrix.deactivateSkismSynth('granularReverb')



~matrix.activateSkismSynth('neuralFilter')


~matrix.setSkismAmp('neuralFilter', 0.1)

~matrix.deactivateSkismSynth('neuralFilter')



~matrix.activateSkismSynth('latchOnset')

~matrix.setSkismAmp('latchOnset',0.6)

~matrix.deactivateSkismSynth('latchOnset')



~matrix.activateSkismSynth('cliqSaw')

~matrix.setSkismAmp('cliqSaw', 0.5)

~matrix.setSkismAmp('cliqSaw', 0.0)

~matrix.deactivateSkismSynth('cliqSaw')









~matrix.activateSkismSynth('flangingDecimator')

~matrix.setSkismAmp('flangingDecimator', 0.2)

~matrix.deactivateSkismSynth('flangingDecimator')




~matrix.activateSkismSynth('feedbackSpectrum')

~matrix.setSkismAmp('feedbackSpectrum', 0.3)

~matrix.deactivateSkismSynth('feedbackSpectrum')


~matrix.activateSkismSynth('cyclicWarp')

~matrix.setSkismAmp('cyclicWarp', 0.03)

~matrix.deactivateSkismSynth('cyclicWarp')




~matrix.activateSkismSynth('fxGrain')

~matrix.setSkismAmp('fxGrain', 0.4)

~matrix.deactivateSkismSynth('fxGrain')


~matrix.activateSkismSynth('arhythmicGendy')

~matrix.setSkismAmp('arhythmicGendy', 0.4)

~matrix.deactivateSkismSynth('arhythmicGendy')


////////// EFX ///////////////


~matrix.efxamps['rev00'] = 0.1
~matrix.efxamps['rev01'] = 0.1
~matrix.efxamps['del00'] = 0.1
~matrix.efxamps['del01'] = 0.1

SystemClock.seconds - ~seconds / 60


Pdef('matrix').stop
