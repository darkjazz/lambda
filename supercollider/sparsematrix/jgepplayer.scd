(
~ncoef = 20;
~headsize = 16;
~numgenes = 1;
~decoder = FoaDecoder(decoderType:'stereo');
)

MasterEQ(2)

(

~foa = #[zoom,push];
~player = JGepPlayer(~decoder, dbname: "ges_00");
~player.getDefNamesByHeader(~headsize, ~numgenes);
)

~player.defnames.size

~player.setBPM(142);

~decoder.start

~player.start(~foa)

~player.setFoa('zoom', 1.0)
~player.setFoa('push', 1.0)

/////// GEP SPARSE ROUTINE //////////

~indices = (0..3);

~indices = (45..48);

~indices = [69, 9, 71, 72]


Tdef('loadData', {
	~indices.do({|ind|
		~player.loadData(ind);
		1.wait;
	})
}).play

~player.playSparseRoutines(
	~indices , 'diansa', (0..3), 4, 'zoom', #[1.0, 0.25, 0.75, 0.5], #[0.2, 0.25, 0.1, 0.1]
);

~player.stopSparseRoutines(~indices)




~indices2 = [45, 25, 53, 59]


Tdef('loadData', {
	~indices2.do({|ind|
		~player.loadData(ind);
		1.wait;
	})
}).play


~player.playSparseRoutines(
	~indices , 'diansa', (0..3), 4, 'zoom', #[1.0, 0.25, 0.75, 0.5], #[0.4, 0.5, 0.2, 0.2]
);

 
~player.playSparseRoutines(
	~indices2 , 'kokou', (0..3), 8, 'zoom', #[0.25, 0.25, 0.25, 1.0], #[0.2, 0.0, 0.15, 0.2]
);

~player.stopSparseRoutines(~indices2)


SparseMatrix.patterns16.keys


s.scope