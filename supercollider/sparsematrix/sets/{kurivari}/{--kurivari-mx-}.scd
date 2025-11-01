(
~matrix.patterndefs.keys.select({|key| key.asString.contains("d")}).do({|name|
	var pat = e.getPat(name);
	pat.ctrls.keysValuesDo({|key, ctrl|
		var len, on;
		on = pat.patterns[key].select(_.odd).size;
		len = pat.patterns[key].size;
		ctrl.dur = (1.0 / on).linlin(1/len, 1, 0.05, 0.2);
	})
});
~matrix.patterndefs.keys.select({|key| key.asString.contains("u")}).do({|name|
	var pat = e.getPat(name);
	pat.ctrls.keysValuesDo({|key, ctrl|
		var len, on;
		on = pat.patterns[key].select(_.odd).size;
		len = pat.patterns[key].size;
		ctrl.dur = (1.0 / on).linlin(1/len, 1, 0.05, 0.2);
	})
});

)



(
~rdefs = ( {|i| ("r" ++ i.asString.padLeft(2, "0")).asSymbol } ! 18 );
~bdefs = ( {|i| ("b" ++ i.asString.padLeft(2, "0")).asSymbol } ! 18 );
~ddefs = ( {|i| ("d" ++ (i+1).asString.padLeft(2, "0")).asSymbol } ! 9 );
~odefs = ( {|i| ("o" ++ (i+1).asString.padLeft(2, "0")).asSymbol } ! 9 );
~mdefs = (0..3).collect({|i| ("m0" ++ i.asString).asSymbol });
~udefs = ~matrix.patterndefs.keys(Array).select({|key| key.asString.contains("u") });
~udefs.sort;
~matrix.patterndefs.keys.select({|key| key.asString.contains("d")}).do({|name|
	var pat = e.getPat(name);
	pat.ctrls.keysValuesDo({|key, ctrl|
		var len, on;
		on = pat.patterns[key].select(_.odd).size;
		len = pat.patterns[key].size;
		ctrl.dur = (1.0 / on).linlin(1/len, 1, 0.05, 0.2);
	})
});



)



(
Pdef('mx22',
	Ppar(~rdefs.keep(4).collect({|nm| Pdef(nm) }) ++ ~udefs.keep(4).collect({|nm| Pdef(nm) }))
).play
)

Pdef('efx').play


~matrix.efxamps['efx1'] = 0.05

~matrix.defsAt('r00').assignEfx(
	(efx1: (0..15))
)

~matrix.defsAt('r01').assignEfx(
	(efx1: (0..15))
)


(
e.setPat('r00', 0.0, [0.3, 0.6], [0.05, 0.1], 0.1);
e.setPat('r01', 0.0, [0.3, 0.6], [0.04, 0.2], 0.0);
e.setPat('r02', 0.0, [0.4, 0.7], [0.05, 0.1], 0.0);
e.setPat('r03', 0.0, [0.4, 0.7], [0.01, 0.1], 0.0);

e.setPat('u00', 0.0, [0.3, 0.5], [0.01, 0.2], 0.0);
e.setPat('u01', 0.0, [0.3, 0.5], [0.05, 0.1], 0.0);
e.setPat('u02', 0.0, [0.3, 0.5], [0.1, 0.3], 0.0);
e.setPat('u03', 0.0, [0.4, 0.7], [0.05, 0.1], 0.0);

)


Pdef('mx7',
	Ppar(['r04', 'r05', 'r06'].collect({|nm|
		Pdef(nm)
	}))
).play

Pdef('mx22').stop

~actives = ['r00', 'r01', 'r03', 'r06'].collect({|nm|
	~matrix.defsAt(nm).ctrls.select({|ctr| ctr.active == 1 })
})




Pdef('mx0').stop


~matrix.activateSkismSynth('roosaBufWrp')

~matrix.setSkismAmp('roosaBufWrp', 0.0)

~matrix.deactivateSkismSynth('roosaBufWrp')




~matrix.activateSkismSynth('primeTam')

~matrix.setSkismAmp('primeTam', 0.4 )

~matrix.deactivateSkismSynth('primeTam')





Pdef('mx1',
	Ppar(~bdefs.keep(4).collect({|nm| Pdef(nm) }))
).play

(
e.setPat('b00', 0.1, [0.05, 0.1], [0.1, 0.2], 0.0);
e.setPat('b01', 0.1, [0.05, 0.1], [0.1, 0.4], 0.0);
e.setPat('b02', 0.1, [0.1, 0.2], [0.1, 0.2], 0.0);
e.setPat('b03', 0.1, [0.01, 0.2], [0.1, 0.3], 0.0);
)

Pdef('mx1').stop


Pdef('mx2',
	Ppar(~bdefs.drop(4).keep(3).collect({|nm| Pdef(nm) }))
).play

(
e.setPat('b04', 0.1, [0.3, 0.7], [2.0, 4.0], 0.0);
e.setPat('b05', 0.2, [0.2, 0.4], [0.1, 0.3], 0.0);
e.setPat('b06', 0.1, [0.1, 0.3], [3.0, 6.0], 0.0);
)

Pdef('mx2').stop




Pdef('efx').play

~matrix.efxamps['efx3'] = 0.4

~matrix.defsAt('b12').assignEfx(
	(efx3: (0..15))
)


~matrix.efxamps['efx2'] = 0.4

~matrix.defsAt('b11').assignEfx(
	(efx2: (0..15))
)


~matrix.efxamps['efx1'] = 0.1

~matrix.defsAt('b07').assignEfx(
	(efx1: (0..31))
)



~matrix.defsAt('b07').ctrls.size

Pdef('mx3',
	Ppar(~bdefs.drop(6).keep(8).collect({|nm| Pdef(nm) }))
).play





(
e.setPat('b07', 0.0, [0.3, 0.4], [0.01, 0.3], 0.3);
e.setPat('b08', 0.0, [0.2, 0.6], [0.01, 0.1], 0.1);
e.setPat('b09', 0.0, [0.3, 0.5], [0.01, 0.3], 0.3);
e.setPat('b10', 0.0, [0.7, 1.0], [0.01, 0.2], 0.4);
e.setPat('b11', 0.0, [0.7, 1.0], [0.05, 0.2], 0.1);
e.setPat('b12', 0.0, [0.7, 1.0], [0.1, 0.2], 0.2);
e.setPat('b13', 0.0, [0.3, 0.7], [0.1, 0.2], 0.0);
e.setPat('b14', 0.0, [0.3, 0.6], [0.1, 0.2], 0.0);
)


~matrix.defsAt('b07').recall(0);
~matrix.defsAt('b08').recall(0);

~matrix.defsAt('b09').recall(0);
~matrix.defsAt('b10').recall(0);



Pdef('mx3').stop



Pdef('mx4',
	Ppar(~mdefs.collect({|nm| Pdef(nm) }))
).play


(
e.setPat('m00', 0.3, [0.2, 0.4], [0.2, 0.3], 0.0);
e.setPat('m01', 0.0, [0.2, 0.4], [0.2, 0.8], 0.0);
e.setPat('m02', 0.0, [0.1, 0.2], [0.2, 0.3], 0.0);
e.setPat('m03', 0.0, [0.1, 0.3], [0.2, 0.3], 0.0);
)


Pdef('mx4').stop




~pat = ['Offbeat_0006', 'Toms_0001', 'Breakbeat_0002', 'Halftime_0008', 'Basicbeat_0005'].collect({|key|
	SparseMatrix.patternsDnB[key]
}).collect(_.size).sum


~pat = SparseMatrix.patternsDnB.keys(Array).select({|key| (key.asString.last == $9).and(key.asString.find("fill").isNil)}).keep(6).collect({|key|SparseMatrix.patternsDnB[key] }).collect(_.size).sum


SparseMatrix.patternsDnB.keys(Array).select({|key| (key.asString.last == $1).and(key.asString.find("fill").isNil)}).drop(4)

nil.booleanValue
'fill_0002'.asString.find("fill")




(
(0..15).do({|num|
	var pat, name;
	name = ("d" ++ num.asString.padLeft(2, "0")).asSymbol;
	pat = e.getPat(name);
	e.setPat(name, 0.0, [1.0, 2.0], [0.2, 0.2], 0.1);
	pat.ctrls.keysValuesDo({|key, ctrl|
		var on = pat.patterns[key].select(_.odd).size;
		ctrl.dur = 1.0 / on;
		ctrl.amp = ctrl.dur.linlin(0, 1, 0.5, 0.0);
		// key.post; "  ".post; ctrl.dur.postln;
		// ctrl.dur.linlin(0, 1, 0.5, 0.0).postln
	})

})
)


s.queryAllNodes

~matrix.setBPM(137)

Pdef('efx').play

~matrix.efxamps['efx3'] = 0.1

~matrix.defsAt('d08').assignEfx(
	(efx3: (0..15))
)


~matrix.efxamps['efx2'] = 0.1

~matrix.defsAt('d09').assignEfx(
	(efx2: (0..15))
)


~matrix.efxamps['efx1'] = 0.1

~matrix.defsAt('d12').assignEfx(
	(efx1: (0..15))
)


Pdef('mxd',
	Ppar(~ddefs.drop(8).keep(8).collect({|nm| Pdef(nm) }))
).play


(
e.setPat('d08', 0.1, [0.2, 0.4], nil, 0.1);
e.setPat('d09', 0.1, [0.2, 0.3], nil, 0.1);
e.setPat('d10', 0.1, nil, nil, 0.0);
e.setPat('d11', 0.1, nil, nil, 0.0);
e.setPat('d12', 0.3, [0.2, 0.4], nil, 0.1);
e.setPat('d13', 0.2, nil, nil, 0.0);
e.setPat('d14', 0.0, nil, nil, 0.0);
e.setPat('d15', 0.0, [0.3, 0.5], nil, 0.0);
)

Pdef('mxd').clear



~matrix.buffers.perc.drop(24).keep(4).collect(_.path).do(_.postln)

(
~rdefs = ( {|i| ("r" ++ i.asString.padLeft(2, "0")).asSymbol } ! 18 );
~bdefs = ( {|i| ("b" ++ i.asString.padLeft(2, "0")).asSymbol } ! 18 );
~ddefs = ( {|i| ("d" ++ (i+1).asString.padLeft(2, "0")).asSymbol } ! 9 );
~odefs = ( {|i| ("o" ++ (i+1).asString.padLeft(2, "0")).asSymbol } ! 9 );
~mdefs = (0..3).collect({|i| ("m0" ++ i.asString).asSymbol });
~udefs = ~matrix.patterndefs.keys(Array).select({|key| key.asString.contains("u") });
~udefs.sort
)

(
~matrix.patterndefs.keys.select({|key| key.asString.contains("u")}).do({|name|
	var pat = e.getPat(name);
	pat.ctrls.keysValuesDo({|key, ctrl|
		var len, on;
		on = pat.patterns[key].select(_.odd).size;
		len = pat.patterns[key].size;
		ctrl.dur = (1.0 / on).linlin(1/len, 1, 0.05, 0.15);
	})
})
)

~udefs.size

Pdef('mxdub', Ppar(~udefs.keep(8).collect({|nm| Pdef(nm) }) )).play

Pdef('mxdub').clear

ERRORS: 'u03'


~matrix.patterndefs['u03'].


(
e.setPat('u00', 0.0, [0.3, 0.5], nil, 0.0);
e.setPat('u01', 0.0, [0.3, 0.5], nil, 0.0);
e.setPat('u02', 0.0, [0.3, 0.5], nil, 0.0);
e.setPat('u03', 0.0, [0.3, 0.5], nil, 0.0);
e.setPat('u04', 0.0, [0.3, 0.5], nil, 0.0);
e.setPat('u05', 0.0, [0.3, 0.5], nil, 0.0);
e.setPat('u06', 0.0, [0.3, 0.5], nil, 0.0);
e.setPat('u07', 0.0, [0.3, 0.5], nil, 0.0);
)





Pdef('mxdub', Ppar(~udefs.drop(8).keep(8).collect({|nm| Pdef(nm) }) )).play

Pdef('efx').play


~matrix.efxamps['efx1'] = 0.05

~matrix.defsAt('u08').assignEfx(
	(efx1: (0..6))
)

~matrix.defsAt('u13').assignEfx(
	(efx1: (0..4))
)


~matrix.defsAt('u13').ctrls.size



(
e.setPat('u08', 1.0, [0.5, 0.7], nil, 0.1);
e.setPat('u09', 0.0, [0.3, 0.5], nil, 0.0);
e.setPat('u10', 0.0, [0.1, 0.3], nil, 0.0);
e.setPat('u11', 0.0, [0.3, 0.5], nil, 0.0);
e.setPat('u12', 0.0, [0.3, 0.5], nil, 0.0);
e.setPat('u13', 0.0, [0.4, 0.7], nil, 0.1);
e.setPat('u14', 0.0, [0.3, 0.5], nil, 0.0);
e.setPat('u15', 0.0, [0.3, 0.5], nil, 0.0);
)



Pdef('mxdub', Ppar(~udefs.drop(16).keep(8).collect({|nm| Pdef(nm) }) )).play

(
e.setPat('u16', 0.0, [0.1, 0.3], nil, 0.0);
e.setPat('u17', 0.0, [0.3, 0.5], nil, 0.0);
e.setPat('u18', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('u19', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('u20', 0.0, [0.2, 0.4], nil, 0.0);
e.setPat('u21', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('u22', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('u23', 0.0, [0.3, 0.5], nil, 0.0);
)


Pdef('mxdub', Ppar(~udefs.drop(24).keep(8).collect({|nm| Pdef(nm) }) )).play

(
e.setPat('u24', 0.0, [0.1, 0.3], nil, 0.0);
e.setPat('u25', 0.0, [0.1, 0.3], nil, 0.0);
e.setPat('u26', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('u27', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('u28', 0.0, [0.2, 0.4], nil, 0.0);
e.setPat('u29', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('u30', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('u31', 0.0, [0.1, 0.3], nil, 0.0);
)


Pdef('mxdub', Ppar(~udefs.drop(32).keep(11).collect({|nm| Pdef(nm) }) )).play

(
e.setPat('u32', 0.0, [0.1, 0.3], nil, 0.0);
e.setPat('u33', 0.0, [0.1, 0.3], nil, 0.0);
e.setPat('u34', 0.0, [0.2, 0.4], nil, 0.0);
e.setPat('u35', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('u36', 0.0, [0.2, 0.4], nil, 0.0);
e.setPat('u37', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('u38', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('u39', 0.0, [0.3, 0.5], nil, 0.0);
e.setPat('u40', 0.0, [0.3, 0.5], nil, 0.0);
e.setPat('u41', 0.0, [0.3, 0.5], nil, 0.0);
e.setPat('u42', 0.0, [0.3, 0.5], nil, 0.0);
)


Pdef('mxdub').clear

Pdef('mxdnb',
	Ppar(~ddefs.collect({|nm| Pdef(nm) }))
).play


(
e.setPat('o01', 1.0, [0.1, 0.3], nil, 0.0);
e.setPat('o02', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('o03', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('o04', 0.0, [0.2, 0.4], nil, 0.0);
e.setPat('o05', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('o06', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('o07', 0.0, [0.3, 0.5], nil, 0.0);
e.setPat('o08', 0.0, [0.3, 0.5], nil, 0.0);
e.setPat('o09', 0.0, [0.3, 0.5], nil, 0.0);
)


Pdef('mxdub').clear


(
~matrix.patterndefs.keys.select({|key| key.asString.contains("d")}).do({|name|
	var pat = e.getPat(name);
	pat.ctrls.keysValuesDo({|key, ctrl|
		var len, on;
		on = pat.patterns[key].select(_.odd).size;
		len = pat.patterns[key].size;
		ctrl.dur = (1.0 / on).linlin(1/len, 1, 0.05, 0.2);
	})
})
)

Pdef('mxdnb',
	Ppar(~ddefs.collect({|nm| Pdef(nm) }))
).play


~matrix.patterndefs['d04'].patterns.do({|pat| pat.postln})


Pdef('mxdnb').clear


(
e.setPat('d01', 0.0, [0.1, 0.3], nil, 0.0);
e.setPat('d02', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('d03', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('d04', 0.0, [0.2, 0.4], nil, 0.0);
e.setPat('d05', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('d06', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('d07', 0.0, [0.3, 0.5], nil, 0.0);
e.setPat('d08', 0.0, [0.3, 0.5], nil, 0.0);
e.setPat('d09', 0.0, [0.3, 0.5], nil, 0.0);
)



(
~ddefs.do({|name|
	var pat = e.getPat(name);
	e.setPat(name, 0.0, [0.7, 0.7], [0.1, 0.1], 0.1);
	pat.ctrls.keysValuesDo({|key, ctrl|
		var on = pat.patterns[key].select(_.odd).size;
		ctrl.dur = 0.1 / on;
		ctrl.amp = ctrl.dur.linlin(0, 1, 0.5, 0.0);
		// key.post; "  ".post; ctrl.dur.postln;
		// ctrl.dur.linlin(0, 1, 0.5, 0.0).postln
	})

})
)







e.setPat('o02', 1.0, [0.2, 0.3], [0.05, 0.1], 0.0);

Pdef('o02').play

Pdef('x03').play


e.setPat('x03', 1.0, [0.7, 1.0], [0.05, 0.1], 0.0);


~matrix.patterndefs['x00'].patterns.select({|pat| pat.occurrencesOf(1) == 1}).keysValuesDo({|key, val|
	[key, val].postln
})

Pdef('r17').source.list.first.patternpairs


SparseMatrix.patternsDub.values. .collect(_.size).size keysValuesDo({|key, val| [key, val].postln })

.keys(Array).do(_.postln)

22.do({|i|
	var names;
	names = SparseMatrix.patternsDnB.keys(Array).collect(_.asString).select(_.contains(i.asString.padLeft(4, "0")));
	Post << names.size << "  " << names << Char.nl;
})



	SparseMatrix.patternsDnB.keys(Array).collect(_.asString).select(_.contains("0003")).collect(_.asSymbol)

String

Server.killAll


