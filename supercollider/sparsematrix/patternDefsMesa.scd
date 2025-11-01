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

	matrix.addPatternSynthDef('r15', (0..7).lace(32), 8, 4,
		SparseMatrix.patterns12.keys(Array).keep(8), 2, "r15", 'r00', false, false);

	matrix.addPatternSynthDef('r16', (8..15).lace(32), 8, 4,
		SparseMatrix.patterns12.keys(Array).drop(8).keep(8), 2, "r16", 'r01', false, false);

	matrix.addPatternSynthDef('r17', (16..23).lace(32), 8, 4,
		SparseMatrix.patterns12.keys(Array).drop(16).keep(8), 2, "r17", 'r02', false, false);

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
		2, "b15", 'argproto', matrix.buffers.evo.drop(48).keep(4), 'bitSt4', true
	);

	matrix.addPatternBufferDef('b16', (0..31), 4, 4,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b16", 'argproto', matrix.buffers.evo.drop(52).keep(4), 'bitSt4', true
	);

	matrix.addPatternBufferDef('b17', (0..31), 4, 4,
		SparseMatrix.patterns16.keys(Array).scramble.keep(8),
		2, "b17", 'argproto', matrix.buffers.evo.drop(56).keep(4), 'bitSt4', true
	);



	matrix.addPatternSynthDef('d00', (47..55).lace(32), 8, 4,
		SparseMatrix.patternsDnB.keys(Array).collect(_.asString).select(_.contains("0001")).collect(_.asSymbol).keep(8),
		2, "d00", 'r03', false, false);


	matrix.addPatternSynthDef('o00', (47..55).lace(32), 8, 4,
		SparseMatrix.patternsDnB.keys(Array).collect(_.asString).select(_.contains("0001")).collect(_.asSymbol).keep(8),
		2, "o00", 'r03', false, true);

	matrix.addPatternSynthDef('d01', (47..55).lace(32), 8, 4,
		SparseMatrix.patternsDnB.keys(Array).collect(_.asString).select(_.contains("0002")).collect(_.asSymbol) ++ ['Double_0001'],
		2, "d01", 'r03', false, false);


	matrix.addPatternSynthDef('o01', (47..55).lace(32), 8, 4,
		SparseMatrix.patternsDnB.keys(Array).collect(_.asString).select(_.contains("0002")).collect(_.asSymbol) ++ ['Double_0001'],
		2, "o01", 'r03', false, true);


	matrix.addPatternSynthDef('d02', (47..55).lace(32), 8, 4,
		SparseMatrix.patternsDnB.keys(Array).collect(_.asString).select(_.contains("0003")).collect(_.asSymbol),
		2, "d02", 'r03', false, false);


	matrix.addPatternSynthDef('o02', (47..55).lace(32), 8, 4,
		SparseMatrix.patternsDnB.keys(Array).collect(_.asString).select(_.contains("0003")).collect(_.asSymbol),
		2, "o02", 'r03', false, true);


	matrix.addPatternSynthDef('d03', (47..55).lace(32), 8, 4,
		SparseMatrix.patternsDnB.keys(Array).collect(_.asString).select(_.contains("0004")).collect(_.asSymbol),
		2, "d03", 'r03', false, false);


	matrix.addPatternSynthDef('o03', (47..55).lace(32), 8, 4,
		SparseMatrix.patternsDnB.keys(Array).collect(_.asString).select(_.contains("0004")).collect(_.asSymbol),
		2, "o03", 'r03', false, true);

	matrix.addPatternSynthDef('d04', (40..47).lace(32), 8, 4,
		SparseMatrix.patternsDnB.keys(Array).collect(_.asString).select(_.contains("0005")).collect(_.asSymbol),
		2, "d04", 'r03', false, false);


	matrix.addPatternSynthDef('o04', (40..47).lace(32), 8, 4,
		SparseMatrix.patternsDnB.keys(Array).collect(_.asString).select(_.contains("0005")).collect(_.asSymbol),
		2, "o04", 'r03', false, true);


	matrix.addPatternSynthDef('d05', (32..39).lace(32), 8, 4,
		SparseMatrix.patternsDnB.keys(Array).collect(_.asString).select(_.contains("0006")).collect(_.asSymbol),
		2, "d05", 'r03', false, false);

	matrix.addPatternSynthDef('o05', (32..39).lace(32), 8, 4,
		SparseMatrix.patternsDnB.keys(Array).collect(_.asString).select(_.contains("0006")).collect(_.asSymbol),
		2, "o05", 'r03', false, true);

	matrix.addPatternSynthDef('d06', (24..31).lace(32), 8, 4,
		SparseMatrix.patternsDnB.keys(Array).collect(_.asString).select(_.contains("0007")).collect(_.asSymbol) ++ ['Offbeat_0011'],
		2, "d06", 'r03', false, false);

	matrix.addPatternSynthDef('o06', (24..31).lace(32), 8, 4,
		SparseMatrix.patternsDnB.keys(Array).collect(_.asString).select(_.contains("0007")).collect(_.asSymbol) ++ ['Offbeat_0011'],
		2, "o06", 'r03', false, true);

	matrix.addPatternSynthDef('d07', (16..23).lace(32), 8, 4,
		SparseMatrix.patternsDnB.keys(Array).collect(_.asString).select(_.contains("0008")).collect(_.asSymbol) ++ ['Breakbeat_0012'],
		2, "d07", 'r03', false, false);

	matrix.addPatternSynthDef('o07', (16..23).lace(32), 8, 4,
		SparseMatrix.patternsDnB.keys(Array).collect(_.asString).select(_.contains("0008")).collect(_.asSymbol) ++ ['Offbeat_0012'],
		2, "o07", 'r03', false, true);

	matrix.addPatternSynthDef('d08', (8..15).lace(32), 8, 4,
		SparseMatrix.patternsDnB.keys(Array).collect(_.asString).select(_.contains("0009")).collect(_.asSymbol) ++ ['Breakbeat_0013'],
		2, "d08", 'r03', false, false);

	matrix.addPatternSynthDef('o08', (8..15).lace(32), 8, 4,
		SparseMatrix.patternsDnB.keys(Array).collect(_.asString).select(_.contains("0009")).collect(_.asSymbol) ++ ['Offbeat_0013'],
		2, "o08", 'r03', false, true);

	matrix.addPatternSynthDef('d09', (0..7).lace(32), 8, 4,
		SparseMatrix.patternsDnB.keys(Array).collect(_.asString).select(_.contains("0010")).collect(_.asSymbol) ++ ['Breakbeat_0014'],
		2, "d09", 'r03', false, false);

	matrix.addPatternSynthDef('o09', (0..7).lace(32), 8, 4,
		SparseMatrix.patternsDnB.keys(Array).collect(_.asString).select(_.contains("0010")).collect(_.asSymbol) ++ ['Offbeat_0014'],
		2, "o09", 'r03', false, true);

	~fncindx = 0;

	SparseMatrix.patternsDub.keysValuesDo({|key, value, i|
		var indxs, name = ("u" ++ i.asString.padLeft(2, "0"));
		indxs = (~fncindx..(~fncindx + value.size -1)).collect(_.wrap(0, matrix.deffuncs.lastIndex));
		matrix.addPatternSynthDef(name.asSymbol, indxs, value.size, 4, [key], 0, name, 'r00', false, false);
		~fncindx = ~fncindx + value.size;
	});

	~fncindx = 0;

	SparseMatrix.patternsDub.keysValuesDo({|key, value, i|
		var indxs, name = ("x" ++ i.asString.padLeft(2, "0"));
		indxs = (~fncindx..(~fncindx + value.size -1)).collect(_.wrap(0, matrix.deffuncs.lastIndex));
		matrix.addPatternSynthDef(name.asSymbol, indxs, value.size, 4, [key], 0, name, 'r03', false, true);
		~fncindx = ~fncindx + value.size;
	});

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