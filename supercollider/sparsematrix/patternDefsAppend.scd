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


	matrix.addPatternBufferDef('b00', (0..63), 8, 8,
		['kpanilogo', 'yole', 'diansa', 'kokou', 'kakilambe', 'soli', 'mandiani'],
		2, "b0", 'argproto', matrix.buffers.bits, 'bit01', true
	);

	matrix.addPatternBufferDef('b01', (32..63), 4, 4,
		['sokou', 'cassa', 'sokou', 'cassa', 'doudoumba', 'mandiani', 'foret', 'tiriba'],
		2, "b1", 'argproto', matrix.buffers.frags.keep(32), 'bit01', true
	);

	matrix.addPatternBufferDef('b02', (0..31), 4, 4,
		['rumba', 'liberte', 'rumba', 'liberte','rumba', 'liberte', 'rumba', 'liberte' ],
		2, "b2", 'argproto', matrix.buffers.frags.drop(32), 'bit01', true
	);

	matrix.addPatternBufferDef('b03', (0..31), 4, 4,
		['kpanilogo', 'diansa', 'yole', 'rumba', 'kpanilogo', 'diansa', 'yole', 'rumba'],
		2, "b3", 'argproto', matrix.buffers.evo.keep(32), '\bitSt2', true
	);

	matrix.addPatternBufferDef('b04', (32..63), 4, 4,
		['kpanilogo', 'diansa', 'yole', 'rumba'].reverse.mirror2,
		2, "b4", 'argproto', matrix.buffers.evo.drop(32), '\bitSt0', true
	);

	matrix.addPatternBufferDef('b05', (0..31), 4, 4,
		['doudoumba', 'basikolo', 'foret', 'cassa', 'yole', 'diansa', 'rumba', 'sokou'].reverse,
		2, "b5", 'argproto', matrix.buffers.msk.keep(32), 'bit02', true
	);

	matrix.addPatternBufferDef('b06', (0..31), 4, 8,
		['doudoumba', 'basikolo', 'foret', 'cassa', 'yole', 'diansa', 'rumba', 'sokou'],
		2, "b6", 'argproto', matrix.buffers.msk.drop(16), 'bit00', true
	);

}