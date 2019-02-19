{|matrix|

	// matrix.addPatternSynthDef('r99', (0..10), 4, 4,
	// ['djakandi'], 0, "re", 'r00', false);

	matrix.addPatternSynthDef('r00', (0..31), 8, 4,
		['kpanilogo', 'yole', 'kpanilogo', 'yole'], 2, "r0", 'r00', false);

	matrix.addPatternSynthDef('r01', (0..31), 8, 4,
		['sokou', 'liberte', 'sokou', 'liberte'], 2, "r1", 'r01', true);

	matrix.addPatternSynthDef('r02', (16..47), 8, 4,
		['Bolon', 'Timiny', 'Soboniko', 'Fankani'], 2, "r2", 'r02', true);

	// matrix.addPatternSynthDef('r02', (16..47), 8, 8,
	// ['kokou', 'raboday', 'kakilambe', 'tiriba'], 2, "r2", 'r02', true);

	// matrix.addPatternSynthDef('r03', (16..47), 8, 8,
	// ['djakandi', 'kakilambe', 'macrou', 'cassa'], 2, "r3", 'r03', true);

	matrix.addPatternSynthDef('r03', (16..47), 8, 4,
		['Yanvalou', 'Abondan', 'Sofa', 'Kononwulen'], 2, "r3", 'r03', true);

	matrix.addPatternSynthDef('r04', (32..63), 8, 4,
		['tiriba', 'foret', 'soli', 'rumba'], 2, "r4", 'r04', true);

	matrix.addPatternSynthDef('r05', (32..63), 8, 4,
		['basikolo', 'djakandi', 'basikolo', 'djakandi'], 2, "r5", 'r05', true);

	matrix.addPatternSynthDef('r06', (0,2..63), 8, 4,
		['doudoumba', 'mandiani', 'foret', 'tiriba'], 2, "r6", 'r06', true);

	matrix.addPatternSynthDef('r07', (0,2..63), 8, 4,
		['sokou', 'doudoumba', 'sorsornet', 'cassa'], 2, "r7", 'r07', true);

	matrix.addPatternSynthDef('r08', (0..31), 8, 4,
	['kpanilogo', 'yole', 'kpanilogo', 'yole'], 2, "r8", 'r00', true);

	matrix.addPatternBufferDef('b00', (0..63), 8, 4,
		['kpanilogo', 'yole', 'diansa', 'kokou', 'kakilambe', 'soli', 'mandiani'],
		2, "b0", 'bufproto', matrix.buffers.dnb, 'bit01', true
	);

	matrix.addPatternBufferDef('b01', (64..127), 8, 4,
		['Abondan', 'Dennadon', 'Fankani', 'Kakilambe', 'Konkoba', 'Kpatsia'],
		2, "b1", 'bufproto', matrix.buffers.dnb, 'bit01', true
	);

	matrix.addPatternBufferDef('b02', (64..127), 8, 4,
		['Yanvalou', 'Wolosodon', 'Toro', 'Timiny', 'Soli', 'Soboniko'],
		2, "b2", 'bufproto', matrix.buffers.bits, 'bit01', true
	);

	matrix.addPatternBufferDef('b03', (0..31), 4, 4,
		['kpanilogo', 'diansa', 'yole', 'rumba', 'kpanilogo', 'diansa', 'yole', 'rumba'],
		2, "b3", 'argproto', matrix.buffers.evo.keep(32), 'bitSt2', true
	);

	matrix.addPatternBufferDef('b04', (32..63), 4, 1,
		['kpanilogo', 'diansa', 'yole', 'rumba'].reverse.mirror2,
		2, "b4", 'argproto', matrix.buffers.evo.keep(32), 'bitSt0', true
	);

	matrix.addPatternBufferDef('b05', (0..31), 4, 4,
		['doudoumba', 'basikolo', 'foret', 'cassa', 'yole', 'diansa', 'rumba', 'sokou'].reverse,
		2, "b5", 'argproto', matrix.buffers.evo[(32..63)], 'bitSt2', true
	);

	matrix.addPatternBufferDef('b06', (0..31), 4, 2,
		['doudoumba', 'basikolo', 'foret', 'cassa', 'yole', 'diansa', 'rumba', 'sokou'],
		2, "b6", 'argproto', matrix.buffers.evo[(32..63)], 'bitSt0', true
	);

	matrix.addPatternBufferDef('b07', (0..31), 4, 4,
		['Sinte', 'Sabar', 'Madan', 'Lolo', 'Kpatsia', 'Kpanlogo', 'Kononwulen', 'Konkoba'],
		2, "b7", 'argproto', matrix.buffers.evo[(32..63)], 'bitSt2', true
	);

	matrix.addPatternBufferDef('b08', (0..31), 4, 4,
		['Sinte', 'Sabar', 'Madan', 'Lolo', 'Kpatsia', 'Kpanlogo', 'Kononwulen', 'Konkoba'].scramble,
		2, "b8", 'argproto', matrix.buffers.evo[(64..95)], 'bitSt2', true
	);

	matrix.addPatternBufferDef('b09', (0..31), 4, 4,
		['Abondan', 'Dennadon', 'Fankani', 'Kakilambe', 'Konkoba', 'Kpatsia'].scramble,
		2, "b9", 'argproto', matrix.buffers.evo[(96..127)], 'bitSt2', true
	);

	matrix.addPatternBufferDef('b10', (0..31), 4, 4,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b10", 'argproto', matrix.buffers.lctr.keep(32), 'bit01', true
	);

	matrix.addPatternBufferDef('b11', (0..31), 4, 4,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b11", 'argproto', matrix.buffers.lctr[(32..63)], 'bit01', true
	);

	matrix.addPatternBufferDef('b12', (0..31), 4, 4,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b12", 'argproto', matrix.buffers.lctr[(64..95)], 'bit01', true
	);


	// matrix.addPatternMelodyDef('m00', (0..31), 4, 8,
	// 	['basikolo', 'cassa', 'diansa', 'sokou'],
	// 	0, "m0", 'argproto', false, 'd30', Prand(Array.primeSeries(3, 201, 5), inf)
	// );
	//
	// matrix.addPatternMelodyDef('m01', (0..31), 4, 8,
	// 	['mandiani', 'tiriba', 'doudoumba', 'liberte'],
	// 	0, "m1", 'argproto', false, 'd31',  Pseq(Array.primeSeries(3, 401, 1), inf)
	// );
	//
	// matrix.addPatternMelodyDef('m02', (0..31), 4, 8,
	// 	['kpanilogo', 'yole', 'kpanilogo', 'yole'],
	// 	0, "m2", 'argproto', false, 'd35', Pseq(Array.primesN(20, 201).scramble.keep(3), inf)
	// );
	//
	// matrix.addPatternMelodyDef('m03', (0..31), 4, 8,
	// 	['cassa', 'yole', 'diansa', 'rumba'],
	// 	0, "m3", 'argproto', false, 'd38', Pseq(Array.primesN(20, 101).scramble.keep(5), inf)
	// );

}