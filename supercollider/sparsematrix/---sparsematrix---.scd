~graphics = CinderApp(mode: 1)
~matrix = SparseMatrix(FoaDecoder(decoderType: 'stereo'), ~graphics).assignCodeWindow(Document.current);

~graphics.open
~matrix.startDecoder

~graphics.initWorld(24, 24, 24, 8);

~graphics.initGenerations([4,6,8], [3,5,7,9], 16);

~graphics.setSymmetry(11)



(
~matrix.addPatternSynthDef('r00', 
	sourcenames: ['kpanilogo', 'yole', 'diansa', 'sorsornet'], prefix: "r0");

~matrix.addPatternSynthDef('r01', div: 4, 
	sourcenames: ['diansa', 'liberte', 'macrou'], prefix: "r1");

~matrix.addPatternSynthDef('r02', 
	sourcenames: ['raboday'], subpatterns: 3, prefix: 'r2');

~matrix.addPatternSynthDef('r03', 48, 8, 8, ['kpanilogo', 'yole'], 2, "r3");
)

(
~matrix.addPatternCycleDef('c00', 4, ~matrix.buffers.cycles[[1, 2, 7, 8]], 'frag05', "c0")

)

(
~matrix.addPatternBufferDef('b00',
	size: 32, groupsize: 4, 
	sourcenames: ['kokou', 'soli', 'macrou'],
	prefix: "b0", protoname: 'fragproto',
	buffers: ~matrix.buffers.frags, defname: 'frag02'
);

~matrix.addPatternBufferDef('b01',
	size: 32, groupsize: 4, div: 2,
	sourcenames: ['kokou', 'soli', 'macrou'],
	prefix: "b1", protoname: 'fragproto01',
	buffers: ~matrix.buffers.frags, defname: 'frag01'
);

~matrix.addPatternBufferDef('b02', 
	size: 64, groupsize: 8,
	sourcenames: ['kpanilogo', 'yole', 'diansa', 'kokou', 'kakilambe', 'soli', 'mandiani'], 
	prefix: "b2", protoname: 'argproto',
	buffers: ~matrix.buffers.bits, defname: 'bit01'
);

~matrix.addPatternBufferDef('b03', 
	size: 32, groupsize: 4, div: 4,
	sourcenames: ['sokou', 'cassa'], 
	subpatterns: 1, protoname: 'argproto',
	prefix: "b3", buffers: ~matrix.buffers.bits.keep(32), defname: 'bit00'
);

~matrix.addPatternBufferDef('b04', 
	size: 32, groupsize: 4, div: 4,
	sourcenames: ['sokou', 'cassa'], 
	prefix: "b4", buffers: ~matrix.buffers.bits.drop(32), defname: 'bit00'
);

)

Pdef('matrixplayer', Ppar([ Pdef('c00')]))


Pdef('matrixplayer', Ppar([ Pdef('r02') ]))

Pdef('matrixplayer', Ppar([Pdef('r00'), Pdef('efx')]))

Pdef('matrixplayer', Ppar([Pdef('r00'), Pdef('r01'), Pdef('r02'), Pdef('r03'), Pdef('efx')]))

Pdef('matrixplayer', Ppar([ Pdef('r02'), Pdef('c00'), Pdef('') Pdef('efx')]))

Pdef('matrixplayer', Ppar([ Pdef('r00'), Pdef('b01'), Pdef('b02'), Pdef('efx')]))

Pdef('matrixplayer', Ppar([ Pdef('r00'), Pdef('r02'), Pdef('r03'), Pdef('b02'), Pdef('b03')]))

~graphics.setPattern(10, 0, 1.0, 0, 0, 0.5, 0.8, 1.0);

Pdef('matrixplayer').play

~matrix.setBPM(132)

~matrix.patterndefs['c00'].ctrls['c003'].buf = ~matrix.buffers.cycles[14]

~matrix.patterndefs['c00'].ctrls['c001'].amp = 0.3

~matrix.patterndefs['c00'].ctrls['c001'].active = 0

~matrix.patterndefs['c00'].ctrls['c003'].amp = 0.1

~matrix.patterndefs['c00'].ctrls['c003'].active = 0

~matrix.patterndefs['c00'].ctrls['c000'].amp = 0.3

~matrix.patterndefs['c00'].ctrls['c000'].active = 0


~matrix.defsAt('r00').setControls(
	{ [0, 1].wchoose([0.2, 0.8]) },
	{ rrand(0.1, 0.5) },
	{ rrand(0.01, 0.2) }
)

~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([0.5, 0.5]) },
	{ exprand(0.05, 0.8) },
	{ rrand(0.05, 0.2) }
)

~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([0.8, 0.2]) },
	{ exprand(0.05, 0.4) },
	{ rrand(0.005, 0.1) }
)

~matrix.defsAt('r00').recall(0)

~matrix.defsAt('r02').setControls(
	{ [0, 1].wchoose([0.2, 0.8]) },
	{ exprand(0.1, 0.8) },
	{ exprand(0.05, 0.3) }
)


~matrix.defsAt('r03').setControls(
	{ [0, 1].wchoose([1.0, 0.0]) },
	{ exprand(0.1, 0.7) },
	{ exprand(0.05, 0.2) }
)

~matrix.defsAt('b02').setControls(
	{ [0, 1].wchoose([0.5, 0.5]) },
	{ rrand(0.1, 0.3) },
	{ rrand(0.05, 0.3) }
)

~matrix.defsAt('r03').setControls(
	{ [0, 1].wchoose([0.5, 0.5]) },
	{ exprand(0.2, 0.7) },
	{ exprand(0.05, 0.4) }
)


~matrix.defsAt('r02').recall(0)
~matrix.defsAt('r03').recall(0)
~matrix.defsAt('r02').recall(2)
~matrix.defsAt('r00').recall(3)

~matrix.activateSkismSynth('neuralFilter')

~matrix.activateSkismSynth('latchOnset')

~matrix.setSkismAmp('neuralFilter', 0.4)

~matrix.setSkismAmp('latchOnset', 0.5)

~matrix.deactivateSkismSynth('neuralFilter')

~matrix.deactivateSkismSynth('latchOnset')


~matrix.defsAt('r00').setActives(
	{ rrand(0.1, 0.9) },
	{ rrand(0.05, 0.15) }
)

~matrix.defsAt('r00').setActives(0, 0.0, 0.01)

~matrix.defsAt('r02').setActives(0, 0.0, 0.01)


~matrix.defsAt('r01').setControls(
	{ [0, 1].wchoose([0.5, 0.5]) },
	{ rrand(0.3, 0.8) },
	{ rrand(0.05, 0.1) }
});

~matrix.defsAt('r01').setActives(
	{ rrand(0.2, 0.8) },
	{ rrand(0.01, 0.3)	}
)

~matrix.defsAt('r02').setActives(
	{ rrand(0.2, 0.8) },
	{ rrand(0.01, 0.3)	}
)

~matrix.defsAt('r03').setGroups( [0, 1], 1,
	{ rrand(0.1, 0.6) }, 
	{ rrand(0.4, 2.0) }
)

~matrix.defsAt('r03').setGroups( [3, 4], 1,
	{ rrand(0.5, 1.0) }, 
	{ rrand(0.4, 1.0) }
)

~matrix.defsAt('r03').setGroups( 3, 1,
	{ rrand(0.5, 1.0) }, 
	{ rrand(0.05, 0.3) }
)


~matrix.defsAt('r03').setControls(0, 0.0, 0.01)

~matrix.defsAt('b00').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ rrand(0.1, 0.4) },
	{ rrand(0.05, 0.2) }
);

~matrix.defsAt('b01').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ rrand(0.1, 0.4) },
	{ rrand(0.05, 0.2) }
);

~matrix.defsAt('b02').setControls(
	{ [0, 1].wchoose([0.7, 0.3]) },
	{ rrand(0.2, 0.6) },
	{ rrand(0.05, 0.2) }
);


~matrix.efxamps['rev00'] = 0.0
~matrix.efxamps['rev01'] = 0.0
~matrix.efxamps['del00'] = 0.0
~matrix.efxamps['del01'] = 0.0



~graphics.setPattern(8, 1, 0.2, 1, 1, 0.6, 0.7, 0.9);

~graphics.setPattern(9, 0, 1.0, 1, 1, 0.3, 0.7, 0.9);

~graphics.setPattern(10, 1, 1.0, 1, 0, 0.5, 0.8, 1.0);

~graphics.setPattern(11, 0, 1.0, 0, 0, 0.0, 0.3, 0.5);

~graphics.setPattern(12, 0, 1.0, 1, 1, 0.44, 0.32, 0.66);

~graphics.setPattern(13, 0, 0.7, 0, 0, 0.6, 0.8, 1.0);

~graphics.setPattern(14, 0, 1.0, 1, 1, 0.0, 0.5, 0.5);

~graphics.setPattern(15,0, 1.0,0, 0, 0.0, 0.5, 0.7);


~graphics.setViewpoint(40.0, 40.0, 0.0, 0.0, 0.0, 0.0)

~rot = Rotation(40.0, 0.01, 20.0, 60.0, 0.0, 0.02, 0.0, 0.02);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera

~graphics.stopRotation

Pdef('matrixplayer').stop

~matrix.quit

