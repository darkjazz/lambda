{|matrix|

	matrix.addPatternSynthDef('r99', (0..10), 4, 8,
		['djakandi'], 0, "re", 'r00', false);

	matrix.addPatternSynthDef('r00', (0..31), 8, 8,
		['kpanilogo', 'yole', 'kpanilogo', 'yole'], 2, "r0", 'r00', true);

	matrix.addPatternSynthDef('r01', (0..31), 8, 8,
		['sokou', 'liberte', 'sokou', 'liberte'], 2, "r1", 'r01', true);

	matrix.addPatternSynthDef('r02', (16..47), 8, 8,
		['kokou', 'raboday', 'kakilambe', 'tiriba'], 2, "r2", 'r02', true);

	matrix.addPatternSynthDef('r03', (16..47), 8, 8,
		['djakandi', 'kakilambe', 'macrou', 'cassa'], 2, "r3", 'r03', true);

	matrix.addPatternSynthDef('r04', (32..63), 8, 8,
		['tiriba', 'foret', 'soli', 'rumba'], 2, "r4", 'r04', true);

	matrix.addPatternSynthDef('r05', (32..63), 8, 8,
		['basikolo', 'djakandi', 'basikolo', 'djakandi'], 2, "r5", 'r05', true);

	matrix.addPatternSynthDef('r06', (0,2..63), 8, 8,
		['doudoumba', 'mandiani', 'foret', 'tiriba'], 2, "r6", 'r06', true);

	matrix.addPatternSynthDef('r07', (0,2..63), 8, 8,
		['sokou', 'doudoumba', 'sorsornet', 'cassa'], 2, "r7", 'r07', true);


	matrix.addPatternBufferDef('b00', (0..63), 8, 8,
		['kpanilogo', 'yole', 'diansa', 'kokou', 'kakilambe', 'soli', 'mandiani'],
		2, "b0", 'argproto', matrix.buffers.bits, 'bit01', true
	);

	matrix.addPatternBufferDef('b01', (32..63), 8, 8,
		['sokou', 'cassa', 'sokou', 'cassa', 'doudoumba', 'mandiani', 'foret', 'tiriba'],
		2, "b1", 'argproto', matrix.buffers.frags.keep(32), 'bit01', true
	);

	matrix.addPatternBufferDef('b02', (0..31), 8, 8,
		['rumba', 'liberte', 'rumba', 'liberte','rumba', 'liberte', 'rumba', 'liberte' ],
		2, "b2", 'argproto', matrix.buffers.frags.drop(32), 'bit01', true
	);

	matrix.addPatternBufferDef('b03', (0..31), 4, 8,
		['kpanilogo', 'diansa', 'yole', 'rumba', 'kpanilogo', 'diansa', 'yole', 'rumba'],
		2, "b3", 'argproto', matrix.buffers.evo.keep(32), 'bitSt2', true
	);

	matrix.addPatternBufferDef('b04', (32..63), 4, 2,
		['kpanilogo', 'diansa', 'yole', 'rumba'].reverse.mirror2,
		2, "b4", 'argproto', matrix.buffers.evo.keep(32), 'bitSt0', true
	);

	matrix.addPatternBufferDef('b05', (0..31), 4, 8,
		['doudoumba', 'basikolo', 'foret', 'cassa', 'yole', 'diansa', 'rumba', 'sokou'].reverse,
		2, "b5", 'argproto', matrix.buffers.evo.drop(32), 'bitSt2', true
	);

	matrix.addPatternBufferDef('b06', (0..31), 4, 4,
		['doudoumba', 'basikolo', 'foret', 'cassa', 'yole', 'diansa', 'rumba', 'sokou'],
		2, "b6", 'argproto', matrix.buffers.evo.drop(64), 'bitSt0', true
	);

	matrix.addPatternMelodyDef('m00', (0..31), 4, 16,
		['basikolo', 'cassa', 'diansa', 'sokou'],
		0, "m0", 'argproto', false, 'd30', Prand(Array.primeSeries(3, 201, 5), inf)
	);

	matrix.addPatternMelodyDef('m01', (0..31), 4, 16,
		['mandiani', 'tiriba', 'doudoumba', 'liberte'],
		0, "m1", 'argproto', false, 'd31',  Pseq(Array.primeSeries(3, 401, 1), inf)
	);

	matrix.addPatternMelodyDef('m02', (0..31), 4, 16,
		['kpanilogo', 'yole', 'kpanilogo', 'yole'],
		0, "m2", 'argproto', false, 'd35', Pseq(Array.primesN(20, 201).scramble.keep(3), inf)
	);

	matrix.addPatternMelodyDef('m03', (0..31), 4, 16,
		['cassa', 'yole', 'diansa', 'rumba'],
		0, "m3", 'argproto', false, 'd38', Pseq(Array.primesN(20, 101).scramble.keep(5), inf)
	);

}