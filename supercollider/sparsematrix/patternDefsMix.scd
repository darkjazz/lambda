{|matrix|

	matrix.addPatternSynthDef('r00', (0..31), 8, 4,
		SparseMatrix.patterns16.keys(Array).keep(4), 2, "r0", 'r00', false);

	matrix.addPatternSynthDef('r01', (16..47), 8, 4,
		SparseMatrix.patterns16.keys(Array).drop(4).keep(4), 2, "r1", 'r01', false);

	matrix.addPatternSynthDef('r02', (32..63), 8, 4,
		SparseMatrix.patterns16.keys(Array).drop(8).keep(4), 2, "r2", 'r02', false);

	matrix.addPatternSynthDef('r03', (0..31), 8, 4,
		SparseMatrix.patterns16.keys(Array).drop(12).keep(4), 2, "r3", 'r03', false);

	matrix.addPatternBufferDef('b00', (0..59), 8, 4,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b0", 'bufproto', matrix.buffers.frags, 'bit01', true
	);

	matrix.addPatternBufferDef('b01', (64..127), 8, 4,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b1", 'bufproto', matrix.buffers.bits, 'bit00', true
	);

	matrix.addPatternBufferDef('b02', (0..63), 8, 8,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b2", 'bufproto', matrix.buffers.evo.scramble.keep(64), 'bitSt2', true
	);

	matrix.addPatternBufferDef('b03', (0..31), 4, 4,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b3", 'argproto', matrix.buffers.evo.scramble.keep(32), 'bitSt2', true
	);

	matrix.addPatternBufferDef('b04', (32..63), 4, 1,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b4", 'argproto', matrix.buffers.evo.scramble.keep(32), 'bitSt0', true
	);

	matrix.addPatternBufferDef('b05', (0..31), 4, 4,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b5", 'argproto', matrix.buffers.evo.scramble.keep(32), 'bitSt2', true
	);

	matrix.addPatternBufferDef('b06', (0..31), 4, 2,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b6", 'argproto', matrix.buffers.evo.scramble.keep(32), 'bitSt0', true
	);

	matrix.addPatternBufferDef('b07', (0..31), 4, 4,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b7", 'argproto', matrix.buffers.evo.scramble.keep(32), 'bitSt2', true
	);

	matrix.addPatternBufferDef('b08', (0..31), 4, 4,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b8", 'argproto', matrix.buffers.evo.scramble.keep(32), 'bitSt2', true
	);

	matrix.addPatternBufferDef('b09', (0..31), 4, 4,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b9", 'argproto', matrix.buffers.evo.scramble.keep(32), 'bitSt2', true
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

	matrix.addPatternDubDef('d00', (0..15), 4, 2,
		SparseMatrix.patternsDub.keys(Array).scramble.keep(4),
		0, "d0", 'bufproto', matrix.buffers.dnb.scramble.keep(16), 'bit01', false
	);

	matrix.addPatternDubDef('d01', (0..15), 4, 2,
		SparseMatrix.patternsDub.keys(Array).scramble.keep(4),
		0, "d1", 'bufproto', matrix.buffers.dnb.scramble.keep(16), 'bit01', false
	);

	matrix.addPatternDubDef('d02', (0..15), 4, 4,
		SparseMatrix.patternsDub.keys(Array).scramble.keep(4),
		0, "d2", 'bufproto', matrix.buffers.dnb.scramble.keep(16), 'bit01', false
	);

	matrix.addPatternDubDef('d03', (0..15), 4, 4,
		SparseMatrix.patternsDub.keys(Array).scramble.keep(4),
		0, "d3", 'bufproto', matrix.buffers.dnb.scramble.keep(16), 'bit01', false
	);

	matrix.addPatternDubDef('d04', (0..15), 4, 8,
		SparseMatrix.patternsDub.keys(Array).scramble.keep(4),
		0, "d4", 'bufproto', matrix.buffers.dnb.scramble.keep(16), 'bit01', false
	);

	matrix.addPatternDubDef('d05', (0..15), 4, 8,
		SparseMatrix.patternsDub.keys(Array).scramble.keep(4),
		0, "d5", 'bufproto', matrix.buffers.dnb.scramble.keep(16), 'bit01', false
	);

	matrix.addPatternDubDef('d06', (0..15), 4, 16,
		SparseMatrix.patternsDub.keys(Array).scramble.keep(4),
		0, "d6", 'bufproto', matrix.buffers.dnb.scramble.keep(16), 'bit01', false
	);

	matrix.addPatternDubDef('d07', (0..15), 4, 16,
		SparseMatrix.patternsDub.keys(Array).scramble.keep(4),
		0, "d7", 'bufproto', matrix.buffers.dnb.scramble.keep(16), 'bit01', false
	);

	matrix.addPatternDubDef('d10', (0..15), 4, 4,
		SparseMatrix.patternsDnB.keys(Array).scramble.keep(4),
		0, "d10", 'bufproto', matrix.buffers.dnb.scramble.keep(16), 'bit01', false
	);

	matrix.addPatternDubDef('d11', (0..15), 4, 4,
		SparseMatrix.patternsDnB.keys(Array).scramble.keep(4),
		0, "d11", 'bufproto', matrix.buffers.dnb.scramble.keep(16), 'bit01', false
	);

	matrix.addPatternDubDef('d12', (0..15), 4, 4,
		SparseMatrix.patternsDnB.keys(Array).scramble.keep(4),
		0, "d12", 'bufproto', matrix.buffers.dnb.scramble.keep(16), 'bit01', false
	);

	matrix.addPatternDubDef('d13', (0..15), 4, 4,
		SparseMatrix.patternsDnB.keys(Array).scramble.keep(4),
		0, "d13", 'bufproto', matrix.buffers.dnb.scramble.keep(16), 'bit01', false
	);

	matrix.addPatternDubDef('d14', (0..15), 4, 4,
		SparseMatrix.patternsDnB.keys(Array).scramble.keep(4),
		0, "d14", 'bufproto', matrix.buffers.dnb.scramble.keep(16), 'bit01', false
	);

	matrix.addPatternDubDef('d15', (0..15), 4, 4,
		SparseMatrix.patternsDnB.keys(Array).scramble.keep(4),
		0, "d15", 'bufproto', matrix.buffers.dnb.scramble.keep(16), 'bit01', false
	);

	matrix.addPatternDubDef('d16', (0..15), 4, 4,
		SparseMatrix.patternsDnB.keys(Array).scramble.keep(4),
		0, "d16", 'bufproto', matrix.buffers.dnb.scramble.keep(16), 'bit01', false
	);

	matrix.addPatternDubDef('d17', (0..15), 4, 4,
		SparseMatrix.patternsDnB.keys(Array).scramble.keep(4),
		0, "d17", 'bufproto', matrix.buffers.dnb.scramble.keep(16), 'bit01', false
	);

}