{|matrix|

	matrix.addPatternSynthDef('r00', (0..31), 8, 8, ['kpanilogo', 'yole', 'kpanilogo', 'yole'], 2, "r0", 'r00', true);

	matrix.addPatternSynthDef('r01', (0..31), 8, 8, ['sokou', 'liberte', 'sokou', 'liberte'], 2, "r1", 'r01', true);

	matrix.addPatternSynthDef('r02', (16..47), 8, 8, ['kokou', 'raboday', 'kakilambe', 'tiriba'], 2, "r2", 'r02', true);

	matrix.addPatternSynthDef('r03', (16..47), 8, 8, ['djakandi', 'kakilambe', 'macrou', 'cassa'], 2, "r3", 'r03', true);

	matrix.addPatternSynthDef('r04', (32..63), 8, 8, ['tiriba', 'foret'], 2, "r4", 'r04');

	matrix.addPatternSynthDef('r05', (32..63), 8, 8, ['basikolo', 'djakandi'], 2, "r5", 'r05');

	matrix.addPatternSynthDef('r06', (0,2..63), 8, 8, ['doudoumba', 'mandiani'], 2, "r6", 'r06');

	matrix.addPatternSynthDef('r07', (0,2..63), 8, 8, ['sokou', 'doudoumba'], 2, "r7", 'r07');

	matrix.addPatternBufferDef('b00', (0..31), groupsize: 4, div: 1,
		sourcenames: ['kokou', 'soli', 'macrou'],
		prefix: "b0", protoname: 'fragproto00',
		buffers: matrix.buffers.frags, defname: 'frag04'
	);

	matrix.addPatternBufferDef('b01', (0..31), groupsize: 4, div: 4,
		sourcenames: ['mandiani', 'kakilambe', 'basikolo'],
		prefix: "b1", protoname: 'fragproto01',
		buffers: matrix.buffers.frags.drop(28).reverse, defname: 'frag04'
	);

	matrix.addPatternBufferDef('b02', (0..63), groupsize: 8,
		sourcenames: ['kpanilogo', 'yole', 'diansa', 'kokou', 'kakilambe', 'soli', 'mandiani'],
		prefix: "b2", protoname: 'argproto',
		buffers: matrix.buffers.bits, defname: 'bit01'
	);

	matrix.addPatternBufferDef('b03', (0..63), 4, 4,
		sourcenames: ['sokou', 'cassa'],
		subpatterns: 1, protoname: 'argproto',
		prefix: "b3", buffers: matrix.buffers.bits.keep(32), defname: 'bit00'
	);

	matrix.addPatternBufferDef('b04', (0..31), 4, 4,
		sourcenames: ['rumba', 'liberte'],
		subpatterns: 1,
		prefix: "b4", buffers: matrix.buffers.bits.drop(32), defname: 'bit00'
	);

}