Pdef('mx22',
	Ppar(~rdefs.keep(8).collect({|nm| Pdef(nm) }))
).play


~matrix.efxamps['efx1'] = 0.3

~matrix.defsAt('r00').assignEfx(
	(efx1: (0..15))
)


(
e.setPat('r00', 0.1, [0.5, 0.7], [0.05, 0.3], 0.2);
e.setPat('r01', 0.1, [0.5, 0.7], [0.04, 0.2], 0.0);
e.setPat('r02', 0.1, [0.4, 0.7], [0.05, 0.1], 0.0);
e.setPat('r03', 0.3, [0.4, 0.7], [0.01, 0.3], 0.0);
e.setPat('r04', 0.3, [0.3, 0.5], [0.01, 0.2], 0.0);

e.setPat('r05', 0.2, [0.3, 0.5], [0.05, 0.3], 0.0);
e.setPat('r06', 0.3, [0.3, 0.5], [0.1, 0.3], 0.0);
e.setPat('r07', 0.2, [0.4, 0.7], [0.3, 0.5], 0.0);

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

~matrix.setSkismAmp('roosaBufWrp', 0.5)

~matrix.deactivateSkismSynth('roosaBufWrp')




~matrix.activateSkismSynth('primeTam')

~matrix.setSkismAmp('primeTam', 0.1 )

~matrix.deactivateSkismSynth('primeTam')





Pdef('mx1',
	Ppar(~bdefs.keep(4).collect({|nm| Pdef(nm) }))
).play

(
e.setPat('b00', 0.2, [0.7, 1.0], [0.1, 0.2], 0.0);
e.setPat('b01', 0.0, [0.5, 1.0], [0.1, 0.4], 0.0);
e.setPat('b02', 0.0, [0.5, 1.0], [0.1, 0.2], 0.0);
e.setPat('b03', 0.2, [0.5, 1.0], [0.1, 0.3], 0.0);
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

~matrix.defsAt('b10').assignEfx(
	(efx1: (0..15))
)



Pdef('mx3',
	Ppar(~bdefs.drop(6).keep(8).collect({|nm| Pdef(nm) }))
).play




(
e.setPat('b07', 0.3, [0.1, 0.4], [0.01, 0.1], 0.0);
e.setPat('b08', 0.5, [0.2, 0.6], [0.01, 0.1], 0.0);
e.setPat('b09', 0.1, [0.3, 0.5], [0.01, 0.3], 0.0);
e.setPat('b10', 0.1, [0.7, 1.0], [0.01, 0.2], 0.4);
e.setPat('b11', 0.1, [0.7, 1.0], [0.05, 0.2], 0.1);
e.setPat('b12', 0.1, [0.7, 1.0], [0.1, 0.2], 0.2);
e.setPat('b13', 0.2, [0.3, 0.7], [0.1, 0.2], 0.0);
e.setPat('b14', 0.1, [0.3, 0.6], [0.1, 0.2], 0.0);
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


Pdef('mxdbz',
	Ppar(~ddefs.keep(8).collect({|nm| Pdef(nm) }))
).play


(
e.setPat('d00', 0.3, [0.2, 0.3], nil, 0.0);
e.setPat('d01', 0.2, [0.1, 0.3], nil, 0.0);
e.setPat('d02', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('d03', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('d04', 0.2, [0.2, 0.4], nil, 0.2);
e.setPat('d05', 0.2, [0.2, 0.3], nil, 0.0);
e.setPat('d06', 0.0, [0.2, 0.3], nil, 0.0);
e.setPat('d07', 0.2, [0.3, 0.5], nil, 0.0);
)


