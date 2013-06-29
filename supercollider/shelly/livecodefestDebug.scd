(
~dir = "2013-03-11";
// load prepared chromosomes
~data = UGEP.loadDataFromDir("/Users/alo/Data/geplib/" ++ ~dir ++ "/data");
~meta = UGenExpressionTree.loadMetadataFromDir("/Users/alo/Data/geplib/" ++ ~dir ++ "/metadata/");

~listIndices = ~meta.selectIndices({|meta| meta.stats == 2 });

~list = ~listIndices.collect({|index| ~data[index].code });

Server.local.boot;
)

(
~ncoef = 20;
~rate = 20;
~headsize = ~data.first.header.headsize;
~numgenes = ~data.first.header.numgenes;
~mode = 0; // CHANGE TO 1 FOR LIVE

~decoder = FoaDecoder(decoderType:'stereo');

~input = MikroFoaInput(~decoder);

~graphics = CinderApp(800, 600, mode: ~mode);

~excludeUGenList = [GaussTrig, BPF, HPF, LPF, OnePole, TwoPole, RHPF, RLPF, Resonz];
~linker = AbstractFunction.methods.select({|meth| meth.name == '*' }).first;

~gep = UGEP.newFromList(~list, ~numgenes, ~headsize, ~linker);

~gep.mutationRate = 0.3;
~gep.recombinationRate = 0.5;
~gep.transpositionRate = 0.1;
~gep.rootTranspositionRate = 0.1;
~gep.geneRecombinationRate = 0.1;
~gep.geneTranspositionRate = 0.1;

~genetic = LiveGenetic(~gep, ~input, ~ncoef, ~rate, "", false, ~decoder, ~graphics, 1, 'addToHead');

~argslist = ~listIndices.collect({|index| 
	var args = ~meta[index].args;
	GEPChromosome(args.code, ~genetic.cospecies.terminals, ~gep.terminals.size, ~genetic.cospecies.linker)
		.constants_(args.constants).extraDomains_(args.extraDomains)
});

~genetic.cospecies.replacePopulation(~argslist);

~genetic.convertArgs;

)

(
~genetic.prepareAnalyzers;
~genetic.assignCodeWindow(Document.current);
~graphics.open;
)

~input.mainamp_(0.0)

MasterEQ(2)

~graphics.showCodePanel

(
~genetic.evaluateCurrentPopulation(3, {|genetic|
	~genetic.meanStats;
	Post << "Analysis completed!" << Char.nl;
})

)

~genetic.distances.keysValuesDo({|key, val| Post << key << ": " << val << Char.nl  })

~genetic.defs.collect(_.name)

~genetic.generateNewDefs(~gep.chromosomes[0], ~gep.chromosomes[1])


~graphics.open

~graphics.sendCodeTitle("live.code.fest")

~graphics.initWorld(20, 20, 20, ~ncoef);

~graphics.initContinuous;

~graphics.setAdd(0.05);

~graphics.resetWorld(9, 9, 9, 4, 4, 4)

~graphics.setPattern(0, 1, 1.0, 1, 1, 0.6, 0.8, 1.0);

~graphics.setPattern(1, 1, 0.5, 1, 1, 0.9, 0.1, 0.4);

~graphics.setPattern(2, 1, 1.0, 1, 1, 0.5, 0.75, 0.9);

~graphics.setPattern(3, 0, 1.0, 1, 0, 0.6, 0.8, 0.8);

~graphics.setPattern(4, 1, 1.0, 0, 0, 1.0, 1.0, 0.3);

~graphics.setPattern(18, 1, 1.0, 0, 0, 0.9, 0.1, 0.4);

~graphics.setPattern(19, 1, 1.0, 1, 0, 0.5, 0.75, 0.9);

~graphics.setPattern(20, 0, 1.0, 1, 1, 0.6, 0.8, 0.8);

~graphics.setPattern(21, 0, 1.0, 1, 1, 0.5, 0.5, 0.5);

~graphics.setPattern(22, 0, 1.0, 1, 1, 0.9, 0.7, 0.9);

~graphics.setPattern(23, 0, 1.0, 1, 1, 0.7, 0.9, 1.0);

~graphics.setPattern(24, 0, 1.0, 0, 0, 0.3, 1.0, 0.8);

~graphics.setPattern(25, 0, 1.0, 0, 0, 0.6, 0.7, 0.9);


Server.killAll


~graphics.activateSwarm(16, 200.0, 200.0, 200.0, 0.8, 50.0, 8.0, 5.0, 100.0);

~graphics.sendBoidPattern(3, 1, 4);

~graphics.setViewpoint(50.0,50.0,50.0, 0.0, 0.0, 0.0)

~graphics.setSwarm(0.5, 50.0, 8.0, 5.0, 100.0)

~graphics.killSwarm

~graphics.setBoidCam(false, false)


~rot = Rotation(140.0, 0.05, 10.0, 60.0, 0.0, 0.055, 0.0, 0.053);
~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
~graphics.rotateCamera

~graphics.stopRotation

~graphics.mapCodePanel

~graphics.setFrameRate(16.0)


s.queryAllNodes

(
~def00 = '000_050';
~genetic.play(~def00, 19.0, 15.0, 9.0);
~genetic.fade(~def00, 0.0, 0.4, 10)
)

~genetic.fade(~def00, 0.4, 0.0, 20)

~genetic.set(~def00, 0.6)

~genetic.free(~def00)

s.queryAllNodes


(
~def02 = '000_020';
~genetic.play(~def02, 15.0, 2.0, 1.5);
~genetic.fade(~def02, 0.0, 0.3, 6)
)

~genetic.fade(~def02, 0.3, 0.0, 10)

~genetic.set(~def02, 0.6)

~genetic.free(~def02)


s.queryAllNodes


(
~def03 = '000_021';
~genetic.play(~def03, 6.0, 8.5, 5.0);
~genetic.fade(~def03, 0.0, 0.6, 10)
)

~genetic.fade(~def03, 0.2, 0.0, 6)

~genetic.set(~def03, 1.0)

~genetic.free(~def03)


s.queryAllNodes


(
~def04 = '000_022';
~genetic.play(~def04, 2.0, 5.0, 4.0);
~genetic.fade(~def04, 0.0, 0.4, 8)
)

~genetic.fade(~def04, 0.4, 0.0, 10)

~genetic.set(~def04, 0.4)

~genetic.free(~def04)

s.stopRecording

s.queryAllNodes


(
~def05 = '000_023';
~genetic.play(~def05, 11.0, 7.0, 13.0);
~genetic.fade(~def05, 0.0, 0.7, 8)
)

~genetic.fade(~def05, 0.3, 0.0, 10)

~genetic.set(~def05, 0.9)

~genetic.free(~def05)


s.sendMsg("/n_free", 1014)


~graphics.unmapCodePanel
