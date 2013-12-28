(
~ncoef = 20;
~dur = 8 * 60;
~rate = 20;
~mode = 0; // CHANGE TO 1 FOR LIVE

~decoder = FoaDecoder(decoderType:'stereo');
//~graphics = CinderApp(1024, 768, mode: ~mode);
~graphics = CinderApp(800, 600);


~matrix = SparseMatrix(~decoder, ~graphics, 2, ~ncoef);

Document.open("/Users/alo/Development/lambda/supercollider/sparsematrix/_-_LamBdaMaTrIx_-_.scd")
)

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

~input = MikroFoaInput(~decoder, "/Users/alo/sounds/mikrofunkt/*");

~excludeUGenList = [GaussTrig, BPF, HPF, LPF, OnePole, TwoPole, RHPF, RLPF, Resonz];
~linker = AbstractFunction.methods.select({|meth| meth.name == '*' }).first;

~gep = UGEP.newFromList(~list, ~numgenes, ~headsize, ~linker);

~gep.mutationRate = 0.3;
~gep.recombinationRate = 0.5;
~gep.transpositionRate = 0.1;
~gep.rootTranspositionRate = 0.1;
~gep.geneRecombinationRate = 0.1;
~gep.geneTranspositionRate = 0.1;

~genetic = LiveGenetic(~gep, ~input, ~ncoef, ~rate, "", false, ~decoder, ~graphics, 
	~matrix.efxgroup, 'addAfter');

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
//~genetic.assignCodeWindow(Document.current);
~graphics.open;
)

~input.mainamp_(0.0)

~gep.methods.collect(_.name).sort

~genetic.defs.collect(_.name)


MasterEQ(2)


s.record
s.queryAllNodes
