~graphics = CinderApp();
~graphics.open

~matrix = SparseMatrix(graphics: ~graphics).makeWindow;

~matrix.addPatternSynthDef('r00', sourcenames: ['kpanilogo', 'yole', 'diansa', 'sorsornet'], prefix: "r0")

~matrix.addPatternSynthDef('r01', div: 4, sourcenames: ['diansa', 'liberte', 'macrou'], prefix: "r1")

~matrix.addPatternSynthDef('r02', sourcenames: ['raboday'], subpatterns: 3, prefix: 'r2')

~matrix.addPatternSynthDef('r03', 48, 8, 8, ['kpanilogo', 'yole'], 2, "r5")


~matrix.addPatternBufferDef('b00', 
	size: 64, groupsize: 8,
	sourcenames: ['kpanilogo', 'yole', 'diansa', 'kokou', 'kakilambe', 'soli', 'mandiani'], 
	prefix: "b1", buffers: ~matrix.buffers.bits, defname: 'bit01'
)


~matrix.addPatternBufferDef('b01', 
	size: 32, groupsize: 4,
	sourcenames: ['sokou', 'cassa'], 
	subpatterns: 1,
	prefix: "b2", buffers: ~matrix.buffers.bits.keep(32), defname: 'bit00'
)

~matrix.addPatternBufferDef('b02', 
	size: 32, groupsize: 4,
	sourcenames: ['sokou', 'cassa'], 
	prefix: "b3", buffers: ~matrix.buffers.bits.drop(32), defname: 'bit00'
)

~matrix.addPatternBufferDef('buf')


~graphics.initWorld(24, 24, 24, 8);

~graphics.initGenerations([4,6,8], [3,5,7,9], 16);

~graphics.setPattern(8, 0, 1.0, 1, 1, 0.6, 0.7, 0.9);

~graphics.setPattern(9, 1, 1.0, 0, 0, 0.3, 0.7, 0.9);

~graphics.setPattern(10, 0, 1.0, 0, 0, 0.5, 0.8, 1.0);

~graphics.setPattern(11, 1, 1.0, 0, 0, 0.0, 0.3, 0.5);

~graphics.setPattern(12, 0, 1.0, 0, 0, 0.8, 0.6, 0.0);

~graphics.setPattern(13, 0, 1.0, 0, 0, 0.6, 0.8, 1.0);

~graphics.setPattern(14, 0, 1.0, 0, 0, 0.0, 0.5, 0.5);

~graphics.setPattern(15, 0, 1.0,1, 1, 0.0, 0.5, 0.7);

~graphics.setSymmetry(11)
