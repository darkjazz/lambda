Pdef('mx0',
	Ppar(~rdefs.keep(8).collect({|nm| Pdef(nm) }))
).play


(
e.setPat('r00', 0.0, [0.5, 0.7], [0.05, 0.1], 0.0);
e.setPat('r01', 0.0, [0.5, 0.7], [0.04, 0.1], 0.0);
e.setPat('r02', 0.0, [0.4, 0.7], [0.01, 0.1], 0.0);
e.setPat('r03', 0.0, [0.4, 0.7], [0.01, 0.1], 0.0);
e.setPat('r04', 0.0, [0.3, 0.5], [0.01, 0.1], 0.0);

e.setPat('r05', 0.0, [0.3, 0.5], [0.05, 0.1], 0.0);
e.setPat('r06', 0.0, [0.3, 0.5], [0.01, 0.1], 0.0);
e.setPat('r07', 0.0, [0.4, 0.7], [0.01, 0.2], 0.0);

)


Pdef('mx7',
	Ppar(['r04', 'r05', 'r06'].collect({|nm|
		Pdef(nm)
	}))
).play

Pdef('mx7').stop

~actives = ['r00', 'r01', 'r03', 'r06'].collect({|nm|
	~matrix.defsAt(nm).ctrls.select({|ctr| ctr.active == 1 })
})




Pdef('mx0').stop


~matrix.activateSkismSynth('roosaBufPl')

~matrix.setSkismAmp('roosaBufWrp', 0.3)

~matrix.deactivateSkismSynth('roosaBufWrp')




~matrix.activateSkismSynth('primeTam')

~matrix.setSkismAmp('primeTam', 0.3 )

~matrix.deactivateSkismSynth('primeTam')





Pdef('mx1',
	Ppar(~bdefs.keep(4).collect({|nm| Pdef(nm) }))
).play

(
e.setPat('b00', 0.0, [0.7, 1.0], [0.1, 0.2], 0.0);
e.setPat('b01', 0.0, [0.5, 1.0], [0.1, 0.4], 0.0);
e.setPat('b02', 0.3, [0.5, 1.0], [0.1, 0.2], 0.0);
e.setPat('b03', 0.2, [0.5, 1.0], [0.1, 0.4], 0.0);
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


Pdef('mx3',
	Ppar(~bdefs.drop(7).keep(8).collect({|nm| Pdef(nm) }))
).play


(
e.setPat('b07', 0.0, [0.1, 0.7], [0.1, 0.3], 0.0);
e.setPat('b08', 0.0, [0.2, 0.6], [0.1, 0.3], 0.0);
e.setPat('b09', 0.0, [0.3, 0.5], [0.1, 0.2], 0.0);
e.setPat('b10', 0.0, [0.7, 1.0], [0.1, 0.3], 0.0);
e.setPat('b11', 0.3, [0.7, 1.0], [0.1, 0.2], 0.0);
e.setPat('b12', 0.3, [0.7, 1.0], [0.1, 0.2], 0.0);
e.setPat('b13', 0.0, [0.3, 0.7], [0.1, 0.2], 0.0);
e.setPat('b14', 0.0, [0.3, 0.6], [0.1, 0.2], 0.0);
)


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

