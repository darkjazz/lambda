{|matrix|

	matrix.addPatternSynthDef('r00', (0..31), 8, 8,
		['kpanilogo', 'yole', 'kpanilogo', 'yole'], 2, "r0", 'r00', true);

	matrix.addPatternSynthDef('r01', (0..31), 8, 8,
		['sokou', 'liberte', 'sokou', 'liberte'], 2, "r1", 'r01', true);

	matrix.addPatternSynthDef('r02', (16..47), 8, 8,
		['kokou', 'raboday', 'kakilambe', 'tiriba'], 2, "r2", 'r02', true);

	matrix.addPatternSynthDef('r03', (16..47), 8, 16,
		['djakandi', 'kakilambe', 'macrou', 'cassa'], 2, "r3", 'r03', true);

	matrix.addPatternSynthDef('r04', (32..63), 8, 8,
		['tiriba', 'foret', 'soli', 'rumba'], 2, "r4", 'r04', true);

	matrix.addPatternSynthDef('r05', (32..63), 8, 8,
		['basikolo', 'djakandi', 'basikolo', 'djakandi'], 2, "r5", 'r05', true);

	matrix.addPatternSynthDef('r06', (0,2..63), 8, 8,
		['doudoumba', 'mandiani', 'foret', 'tiriba'], 2, "r6", 'r06', true);

	matrix.addPatternSynthDef('r07', (0,2..63), 8, 16,
		['sokou', 'doudoumba', 'sorsornet', 'cassa'], 2, "r7", 'r07', true);


	matrix.addPatternBufferDef('b00', (0..63), groupsize: 8,
		sourcenames: ['kpanilogo', 'yole', 'diansa', 'kokou', 'kakilambe', 'soli', 'mandiani'],
		prefix: "b0", protoname: 'argproto',
		buffers: matrix.buffers.bits, defname: 'bit01'
	);

	matrix.addPatternBufferDef('b01', (0,2..63), 4, 8,
		sourcenames: ['sokou', 'cassa', 'sokou', 'cassa', 'doudoumba', 'mandiani', 'foret', 'tiriba'],
		subpatterns: 2, protoname: 'argproto',
		prefix: "b1", buffers: matrix.buffers.bits.keep(32), defname: 'bit01',
		append: true
	);

	matrix.addPatternBufferDef('b02', (0..31), 4, 4,
		sourcenames: ['rumba', 'liberte', 'rumba', 'liberte','rumba', 'liberte', 'rumba', 'liberte' ],
		subpatterns: 2,
		prefix: "b2", buffers: matrix.buffers.bits.drop(32), defname: 'bit01',
		append: true
	);

	matrix.addPatternBufferDef('b03', (0..31), 4, 8,
		sourcenames: ['kpanilogo', 'diansa', 'yole', 'rumba'],
		subpatterns: 2,
		prefix: "b3", buffers: matrix.buffers.evo.keep(32), defname: 'bit01',
		append: true
	);


}