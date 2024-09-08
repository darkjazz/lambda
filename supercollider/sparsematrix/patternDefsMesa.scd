{|matrix|

	matrix.addPatternSynthDef('r00', (0..3).lace(32), 8, 4,
		SparseMatrix.patterns16.keys(Array).keep(4), 2, "r0", 'r00', false);

	matrix.addPatternSynthDef('r01', (4..7).lace(32), 8, 4,
		SparseMatrix.patterns16.keys(Array).drop(4).keep(4), 2, "r1", 'r01', false);

	matrix.addPatternSynthDef('r02', (8..15).lace(32), 8, 4,
		SparseMatrix.patterns16.keys(Array).drop(8).keep(4), 2, "r2", 'r02', false);

	matrix.addPatternSynthDef('r03', (16..20).lace(32), 8, 4,
		SparseMatrix.patterns16.keys(Array).drop(12).keep(4), 2, "r3", 'r03', false);

	matrix.addPatternSynthDef('r04', (21..23).lace(32), 8, 4,
		SparseMatrix.patterns16.keys(Array).drop(16).keep(4), 2, "r4", 'r04', false);

	matrix.addPatternSynthDef('r05', (24..7).lace(32), 8, 4,
		SparseMatrix.patterns16.keys(Array).drop(20).keep(4), 2, "r5", 'r05', false);

	matrix.addPatternSynthDef('r06', (8..15).lace(32), 8, 4,
		SparseMatrix.patterns16.keys(Array).drop(24).keep(4), 2, "r6", 'r06', false);

	matrix.addPatternSynthDef('r07', (16..20).lace(32), 8, 4,
		SparseMatrix.patterns16.keys(Array).drop(28).keep(4), 2, "r7", 'r07', false);

	matrix.addPatternSynthDef('r08', (21..29).lace(32), 8, 4,
		SparseMatrix.patternsDub.keys(Array).sort.keep(8), 2, "r8", 'r00', false, true);

	matrix.addPatternSynthDef('r09', (30..37).lace(32), 8, 4,
		SparseMatrix.patternsDub.keys(Array).sort.drop(8).keep(8), 2, "r9", 'r01', false, true);

	matrix.addPatternSynthDef('r10', (38..46).lace(32), 8, 4,
		SparseMatrix.patternsDub.keys(Array).sort.drop(16).keep(8), 2, "r10", 'r02', false, true);

	matrix.addPatternSynthDef('r11', (47..55).lace(32), 8, 4,
		SparseMatrix.patternsDub.keys(Array).sort.drop(24).keep(8), 2, "r11", 'r03', false, true);

	matrix.addPatternSynthDef('r12', (21..29).lace(32), 8, 4,
		SparseMatrix.patterns12.keys(Array).keep(8), 2, "r12", 'r04', false, true);

	matrix.addPatternSynthDef('r13', (30..37).lace(32), 8, 4,
		SparseMatrix.patterns12.keys(Array).drop(8).keep(8), 2, "r13", 'r05', false, true);

	matrix.addPatternSynthDef('r14', (38..46).lace(32), 8, 4,
		SparseMatrix.patterns12.keys(Array).drop(16).keep(8), 2, "r14", 'r06', false, true);

	matrix.addPatternSynthDef('r15', (47..55).lace(32), 8, 4,
		SparseMatrix.patternsDnB.keys(Array).keep(8), 2, "r15", 'r03', false, true);

	matrix.addPatternSynthDef('r16', (47..55).lace(32), 8, 4,
		SparseMatrix.patternsDnB.keys(Array).drop(8).keep(8), 2, "r16", 'r00', false, true);

	matrix.addPatternSynthDef('r17', (47..55).lace(32), 8, 4,
		SparseMatrix.patternsDnB.keys(Array).drop(16).keep(8), 2, "r17", 'r05', false, true);

	matrix.addPatternBufferDef('b00', (0..59), 8, 4,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b0", 'bufproto', matrix.buffers.frags, 'bit01', true
	);

	matrix.addPatternBufferDef('b01', (64..127), 8, 4,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b1", 'bufproto', matrix.buffers.bits, 'bit00', true
	);

	matrix.addPatternBufferDef('b02', (0..31), 8, 4,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b2", 'bufproto', matrix.buffers.evo.keep(4), 'bitSt3', true
	);

	matrix.addPatternBufferDef('b03', (0..31), 4, 4,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b3", 'argproto', matrix.buffers.evo.drop(4).keep(6), 'bitSt3', true
	);

	matrix.addPatternBufferDef('b04', (32..63), 4, 1,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b4", 'argproto', matrix.buffers.evo.drop(10).keep(8), 'bitSt0', true
	);

	matrix.addPatternBufferDef('b05', (0..31), 4, 4,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b5", 'argproto', matrix.buffers.evo.drop(18).keep(4), 'bitSt3', true
	);

	matrix.addPatternBufferDef('b06', (0..31), 4, 2,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b6", 'argproto', matrix.buffers.evo.drop(22).keep(8), 'bitSt0', true
	);

	matrix.addPatternBufferDef('b07', (0..31), 4, 4,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b7", 'argproto', matrix.buffers.evo.drop(30).keep(4), 'bitSt3', true
	);

	matrix.addPatternBufferDef('b08', (0..31), 4, 4,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b8", 'argproto', matrix.buffers.evo.drop(34).keep(6), 'bitSt3', true
	);

	matrix.addPatternBufferDef('b09', (0..31), 4, 4,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b9", 'argproto', matrix.buffers.evo.drop(40).keep(4), 'bitSt3', true
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

	matrix.addPatternBufferDef('b13', (0..31), 4, 4,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b13", 'argproto', matrix.buffers.evo.drop(60).keep(6), 'bitSt3', true
	);

	matrix.addPatternBufferDef('b14', (0..31), 4, 4,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b14", 'argproto', matrix.buffers.evo.drop(44).keep(4), 'bitSt3', true
	);

	matrix.addPatternBufferDef('b15', (0..31), 4, 4,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b15", 'argproto', matrix.buffers.evo.drop(48).keep(4), 'bitSt4', true, true
	);

	matrix.addPatternBufferDef('b16', (0..31), 4, 4,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b16", 'argproto', matrix.buffers.evo.drop(52).keep(4), 'bitSt4', true, true
	);

	matrix.addPatternBufferDef('b17', (0..31), 4, 4,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b17", 'argproto', matrix.buffers.evo.drop(56).keep(4), 'bitSt4', true, true
	);



	matrix.addPatternDubDef('d00', (0..15), 4, 4,
		SparseMatrix.patternsDub.keys(Array).keep(6),
		0, "d0", 'bufproto', matrix.buffers.perc.keep(4), 'bitSt3', false
	);

	matrix.addPatternDubDef('d01', (0..15), 4, 4,
		SparseMatrix.patternsDub.keys(Array).drop(6).keep(6),
		0, "d1", 'bufproto', matrix.buffers.perc.drop(4).keep(4), 'bitSt3', false
	);

	matrix.addPatternDubDef('d02', (0..15), 4, 4,
		SparseMatrix.patternsDub.keys(Array).drop(12).keep(6),
		0, "d2", 'bufproto', ~matrix.buffers.perc.drop(8).keep(4), 'bitSt3', false
	);

	matrix.addPatternDubDef('d03', (0..15), 4, 4,
		SparseMatrix.patternsDub.keys(Array).drop(18).keep(6),
		0, "d3", 'bufproto', ~matrix.buffers.perc.drop(12).keep(4), 'bitSt3', false
	);

	matrix.addPatternDubDef('d04', (0..15), 4, 4,
		SparseMatrix.patternsDub.keys(Array).drop(24).keep(6),
		0, "d4", 'bufproto', matrix.buffers.perc.drop(76).keep(4), 'bitSt3', false
	);

	matrix.addPatternDubDef('d05', (0..15), 4, 4,
		SparseMatrix.patternsDub.keys(Array).drop(30).keep(6),
		0, "d5", 'bufproto', matrix.buffers.perc.drop(20).keep(4), 'bitSt3', false
	);

	matrix.addPatternDubDef('d06', (0..15), 4, 4,
		SparseMatrix.patternsDub.keys(Array).drop(36).keep(6),
		0, "d6", 'bufproto', matrix.buffers.perc.drop(24).keep(4), 'bitSt3', false
	);

	matrix.addPatternDubDef('d07', (0..15), 4, 4,
		SparseMatrix.patternsDub.keys(Array).drop(42).keep(6),
		0, "d7", 'bufproto', matrix.buffers.perc.drop(28).keep(4), 'bitSt3', false
	);

	matrix.addPatternDubDef('d08', (0..15), 4, 4,
		SparseMatrix.patternsDnB.keys(Array).select({|key| (key.asString.last == $1).and(key.asString.find("fill").isNil)}).keep(4),
		0, "d8", 'bufproto', matrix.buffers.perc.drop(24).keep(4), 'bitSt3', false
	);

	matrix.addPatternDubDef('d09', (0..15), 4, 4,
		SparseMatrix.patternsDnB.keys(Array).select({|key| (key.asString.last == $2).and(key.asString.find("fill").isNil)}).keep(5),
		0, "d9", 'bufproto', matrix.buffers.perc.drop(28).keep(4), 'bitSt3', false
	);

	matrix.addPatternDubDef('d10', (0..15), 4, 4,
		SparseMatrix.patternsDnB.keys(Array).select({|key| (key.asString.last == $3).and(key.asString.find("fill").isNil)}).keep(6),
		0, "d10", 'bufproto', matrix.buffers.perc.drop(32).keep(4), 'bitSt3', false
	);

	matrix.addPatternDubDef('d11', (0..15), 4, 4,
		SparseMatrix.patternsDnB.keys(Array).select({|key| (key.asString.last == $9).and(key.asString.find("fill").isNil)}).keep(6),
		0, "d11", 'bufproto', matrix.buffers.perc.drop(36).keep(4), 'bitSt3', false
	);

	matrix.addPatternDubDef('d12', (0..15), 4, 4,
		SparseMatrix.patternsDnB.keys(Array).select({|key| (key.asString.last == $4).and(key.asString.find("fill").isNil)}).keep(5),
		0, "d12", 'bufproto', matrix.buffers.perc.drop(40).keep(4), 'bitSt3', false
	);

	matrix.addPatternDubDef('d13', (0..15), 4, 4,
		SparseMatrix.patternsDnB.keys(Array).select({|key| (key.asString.last == $5).and(key.asString.find("fill").isNil)}).keep(6),
		0, "d13", 'bufproto', matrix.buffers.perc.drop(44).keep(4), 'bitSt3', false
	);

	matrix.addPatternDubDef('d14', (0..15), 4, 4,
		SparseMatrix.patternsDnB.keys(Array).select({|key| (key.asString.last == $6).and(key.asString.find("fill").isNil)}).keep(5),
		0, "d14", 'bufproto', matrix.buffers.perc.drop(48).keep(4), 'bitSt3', false
	);

	matrix.addPatternDubDef('d15', (0..15), 4, 4,
		SparseMatrix.patternsDnB.keys(Array).select({|key| (key.asString.last == $7).and(key.asString.find("fill").isNil)}).keep(5),
		0, "d15", 'bufproto', matrix.buffers.perc.drop(52).keep(4), 'bitSt3', false
	);

	matrix.addPatternMelodyDef('m00', (0..31), 4, 8,
		['basikolo', 'cassa', 'diansa', 'sokou'],
		0, "m0", 'argproto', false, 'd30', Prand(Array.primeSeries(3, 201, 5), inf)
	);

	matrix.addPatternMelodyDef('m01', (0..31), 4, 8,
		['mandiani', 'tiriba', 'doudoumba', 'liberte'],
		0, "m1", 'argproto', false, 'd31',  Pseq(Array.primeSeries(3, 401, 1), inf)
	);

	matrix.addPatternMelodyDef('m02', (0..31), 4, 8,
		['kpanilogo', 'yole', 'kpanilogo', 'yole'],
		0, "m2", 'argproto', false, 'd00', Pseq(Array.primesN(20, 201).scramble.keep(3), inf)
	);

	matrix.addPatternMelodyDef('m03', (0..31), 4, 8,
		['cassa', 'yole', 'diansa', 'rumba'],
		0, "m3", 'argproto', false, 'd38', Pseq(Array.primesN(20, 101).scramble.keep(5), inf)
	);

}