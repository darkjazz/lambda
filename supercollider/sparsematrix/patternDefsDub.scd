{|matrix|

	matrix.addPatternDubDef('b00', (0..15), 4, 4,
		SparseMatrix.patternsDub.keys(Array).scramble.keep(4),
		0, "b0", 'bufproto', ~matrix.buffers.evo[0..15], 'bitSt2', false
	);

	matrix.addPatternDubDef('b01', (0..15), 4, 4,
		SparseMatrix.patternsDub.keys(Array).scramble.keep(4),
		0, "b1", 'bufproto', matrix.buffers.evo[16..31], 'bitSt2', false
	);

	matrix.addPatternDubDef('b02', (0..15), 4, 4,
		SparseMatrix.patternsDub.keys(Array).scramble.keep(4),
		0, "b2", 'bufproto', matrix.buffers.evo[32..47], 'bitSt2', false
	);

	matrix.addPatternDubDef('b03', (0..15), 4, 4,
		SparseMatrix.patternsDub.keys(Array).scramble.keep(4),
		0, "b3", 'bufproto', matrix.buffers.evo[48..63], 'bitSt2', false
	);

	matrix.addPatternDubDef('b04', (0..15), 4, 4,
		SparseMatrix.patternsDub.keys(Array).scramble.keep(4),
		0, "b4", 'bufproto', matrix.buffers.evo[64..79], 'bitSt2', false
	);

	matrix.addPatternDubDef('b05', (0..15), 4, 4,
		SparseMatrix.patternsDub.keys(Array).scramble.keep(4),
		0, "b5", 'bufproto', matrix.buffers.evo[80..95], 'bitSt2', false
	);

	matrix.addPatternDubDef('b06', (0..15), 4, 4,
		SparseMatrix.patternsDub.keys(Array).scramble.keep(4),
		0, "b6", 'bufproto', matrix.buffers.evo[96..111], 'bitSt2', false
	);

	matrix.addPatternDubDef('b07', (0..15), 4, 4,
		SparseMatrix.patternsDub.keys(Array).scramble.keep(4),
		0, "b7", 'bufproto', matrix.buffers.evo[112..127], 'bitSt2', false
	);

	matrix.addPatternBufferDef('b08', (0..31), 4, 2,
		['doudoumba', 'basikolo', 'foret', 'cassa', 'yole', 'diansa', 'rumba', 'sokou'],
		2, "b8", 'argproto', matrix.buffers.evo[(32..63)], 'bitSt0', true
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


}