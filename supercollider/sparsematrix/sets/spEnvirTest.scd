~settings = ( ncoef: 20, rate: 20, headsize: 14, numgenes: 4, quant: 2, screenX: 1024, screenY: 768, mode: 1, decoderType: 'stereo', bpm: 140, channels: 2, foa: #[zoom,push], dbname: "ges_02", patdefs: "patternDefsAppend.scd", initPdefs: ['r00', 'r01', 'r02', 'b02'], worldDim: 17);


e = SpEnvir(~settings)

s.queryAllNodes

Pdef('efx').play

Pdef('efx').stop

e.initGraphics(true, Document.current)


~matrix.prepareGepDefs(~defnames, ~loader);

~defs['r00'].setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ exprand(0.1, 1.0) },
	{ exprand(0.01, 0.2) },
	0.1
)

~player.start(~foa)

~player.setFoa('zoom', 1.0)
~player.setFoa('push', 1.0)

Tdef('endless', {
	var count = 0;
	loop({
		count = count + 1;
		if (count >= 10) {
			Tdef('endless').clear;
		};
		count.postln;
		1.wait;
	})
}).play