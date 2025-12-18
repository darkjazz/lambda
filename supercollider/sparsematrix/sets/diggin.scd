Server.killAll


'kurivari: digging in the crates of genetic sound'






// PHASE MODULATION
~sy = {SinOsc.ar(199, SinOsc.ar(37), 0.3, 0.0).dup }.play
~sy.free
s.sendMsg("/n_free", 1001)

~arr = [SinOsc, 'a', SinOsc, 'b', 'd', 'e', 'a', 'b', 'c', 'd', 'a', 'b', 'c'];

~terms = ~arr.select(_.isKindOf(Symbol)).asSet.asArray;
~terms.sort;

~chrm = GEPChromosome(
	code: ~arr,
	terminals: ~terms,
	ngenes: 1,
	linker: AbstractFunction.methods.select({|meth| meth.name == '*' }).first
);

~chrm.asUgenExpressionTree.asSynthDefString('ges_gen_0001', Pan2, Normalizer, false);

(
SynthDef('ges_gen_0001', {|out=0,amp=0,dur=1,a,b,c,d,e|
	Out.ar(out,
		Pan2.ar(
			Normalizer.ar(
				LeakDC.ar((
					SinOsc.ar(a,  SinOsc.ar(e, a, b, c ), b, d )
				)
				)
			),
			0,
			amp
		)
	)
}).add
)

~sy = Synth('ges_gen_0001', ['amp', 0.1, 'a', 11, 'b', 37, 'c', 57, 'd', 0.3, 'e', 237])
~sy.free




(
~ev = EvolverEnvir(
	(
		populationSize: 17, numgenes: 3, headsize: 57, ncoef: 20, rate: 20, dbname: "ges_ld_00",
		mutationRate: 1.0, recombinationRate: 1.0, transpositionRate: 0.25,
		rootTranspositionRate: 0.1, geneRecombinationRate: 0.2, geneTranspositionRate: 0.1,
		linker: AbstractFunction.methods.select({|meth| meth.name == '*' }).first,
		numterminals: 13, recordPath: "/Users/kurivari/snd/evolver/"
	)
);

~ev.initializeRandomDbPopulation;

~ugens = ~gep.methods;
~ev.defineFitnessFunction;
~ev.extractTargetFeatures("/Users/kurivari/snd/gep/dilemma.aiff")
)

~buffer = Buffer.read(Server.default, "/Users/kurivari/snd/gep/dilemma.aiff")
~player = {PlayBuf.ar(~buffer.numChannels, ~buffer, loop: 1) * 0.4}.play

~player.free
~ugens.size

~gep[0].asUgenExpressionTree.asSynthDefString('mysynthdef', Pan2, Normalizer, false).postln;
xxxw
~gep.updateScores

(
// for each next generation
~paramgep.nextGeneration;
~gep.nextGeneration;
)

~gep.dra

~gep.drawDistanceMatrix(10)

~gep.draw

~gep.drawCompare(0, 1)

~gep.drawScroll

~terminals

~ev.playOne(2)
