(
~ncoef = 20;
~rate = 20;
~headsize = 16;
~numgenes = 4;
~populationSize = 4;

~ugens = [ LFCub, LFPar, LFSaw, SinOsc, LFTri, LFPulse, Formant, Pulse, LFNoise1, LFNoise2, LFNoise0, SyncSaw, SawDPW, Dust2, Crackle, Blip, Saw, PMOsc, Resonz, BPF, HPF, LPF, DelayL, CombL, CombN, CombC, Logist0, CML0, QuadL, CuspL, GbmanL, HenonL, StandardL, Spring, Ball, Pluck, LFClipNoise, LFDNoise0, LFDNoise1, SinGrain, FMGrain, InGrain ];

~methods = ~ugens.collect({|ugen| 
	var ar;
	ar = ugen.class.methods.select({|mth| mth.name == 'ar' }).first;
	if (ar.isNil) {
		ar = ugen.superclass.class.methods.select({|mth| mth.name == 'ar' }).first
	};
	ar
});

~terminals = (~methods.collect(_.argNames).collect(_.size).maxItem + ~headsize).collect({|i|
	(97 + i).asAscii.asSymbol
});

~gep = UGEP.newValid(~populationSize, ~numgenes, ~headsize, ~ugens, ~terminals, 
	AbstractFunction.methods.select({|meth| meth.name == '*' }).first
);

~gep.mutationRate = 1.0;
~gep.recombinationRate = 1.0;
~gep.transpositionRate = 1.0;
~gep.rootTranspositionRate = 1.0;
~gep.geneRecombinationRate = 1.0;
~gep.geneTranspositionRate = 1.0;


~paramheadsize = 5;
~paramnumgenes = ~terminals.size;
~paramterminals = ['w', 'x', 'y', 'z'];

~paramethods = ['*', '-', '+', '/'].collect({|opname|
	AbstractFunction.methods.select({|meth| meth.name == opname }).first
}) ++ ControlSpec.methods.select({|mth| mth.name == 'map' });

~paramgep = GEP(~populationSize, ~paramnumgenes, ~paramheadsize, ~paramethods, ~paramterminals, 
	Array.class.methods.select({|mth| mth.name == 'with' }).first
);

~maps = #[freq, lofreq, midfreq, widefreq, phase].collect({|name|
	ControlSpec.specs[name]
});

~paramgep.chromosomes.do({|chrom| 
	chrom.fillConstants(~paramterminals.size, { rrand(0.0, 1.0) }); 
	chrom.addExtraDomain(Array.with(~maps.choose))
});

~paramgep.mutationRate = 0.25;
~paramgep.recombinationRate = 1.0;
~paramgep.transpositionRate = 0.3;
~paramgep.rootTranspositionRate = 0.3;
~paramgep.geneRecombinationRate = 0.25;
~paramgep.geneTranspositionRate = 0.2;
)


(

~i00 = [ 
Pluck, Ball, SawDPW, 'e', 'h', 'p', 'v', 'o', HenonL, 's', LFDNoise0, 'a', LFPulse, CuspL, 's', Saw, 't', 'g', 'v', 'k', 'r', 'g', 'w', 'r', 'd', 'n', 'i', 'h', 'u', 'v', 'n', 's', 't', 'a', 'y', 'l', 'g', 'l', 'b', 'g', 'e', 'n', 'u', 't', 'b', 'f', 'u', 'x', 'x', 'w', 'p', 't', 'f', 'p', 'n', 'u', 'i', 'h', 'a', 'g', 'q', 'l', 'p', 'x', 'v', 'a', 'd', 't', 'w', 'i', 's', 'y', 's', 'k', 'o', 'i', 'q', 'i', 'x', 'e', 'p', 'd', 'l', 'm', 'x', 'l', 'w', 'j', 't', 'b', 'l', 'o', 'a', 'c', 'k', 'h', 'p', 's', 'k', 'f', 'j', 'c', 'l', 'x', 'a', 'n', 'v', 'x', 'u', 'f', 'k', 's', 'g', 's', 'f', 'f', 'g', 'd', 'a', 'i', 'f', 'v', 'h', 'k', 'e', 'p', 'v', 'f', 'q', 

Pulse, 'o', HenonL, 'y', 'b', SyncSaw, 'x', 'o', 'o', QuadL, GbmanL, Blip, GbmanL, Dust2, 'm', 'v', 'q', 'j', 'j', 's', 'r', 'q', 'g', 'c', 'q', 'j', 'h', 'q', 'o', 'y', 'b', 'd', 'y', 'o', 'n', 'g', 'w', 'y', 'f', 'l', 'g', 'b', 't', 'i', 'o', 'f', 'x', 'i', 'm', 'l', 'o', 'h', 'a', 'w', 'a', 'a', 'q', 'e', 'h', 'h', 'q', 'n', 't', 'j', 'w', 's', 'v', 'x', 'd', 'm', 'e', 'h', 's', 'd', 'g', 'c', 'n', 'd', 'r', 'j', 'q', 'w', 'y', 'u', 'a', 'c', 'e', 'j', 'x', 'x', 'u', 'o', 'e', 'e', 'i', 'n', 'd', 'k', 'h', 'a', 'y', 'n', 'u', 'f', 'w', 'w', 'l', 'j', 'b', 'w', 'v', 'w', 'p', 'f', 'd', 's', 'b', 'q', 'f', 's', 'i', 'l', 'e', 'y', 'g', 'g', 'p', 'y', 't', 

Blip, 'h', Pluck, Dust2, 'e', 'f', Pulse, Logist0, 's', 'l', Ball, 'u', 'x', QuadL, SinOsc, Logist0, 'a', 'n', 'f', 'l', 'q', 'o', 'n', 'y', 'e', 'f', 'n', 'p', 'u', 'd', 'v', 'n', 'x', 'v', 'h', 'd', 'x', 'h', 'a', 'd', 'v', 'b', 'u', 't', 'k', 'q', 'y', 'l', 't', 'l', 'j', 'q', 'r', 'p', 'n', 'x', 'l', 'k', 'x', 'b', 'm', 'l', 't', 'x', 'a', 'p', 'r', 'd', 'v', 't', 's', 'g', 'a', 'v', 't', 'j', 'u', 'n', 'f', 'e', 'q', 'f', 't', 'c', 'o', 'n', 'i', 'r', 'j', 'x', 's', 'b', 'e', 'm', 'b', 'u', 'l', 'y', 'n', 'r', 'c', 'm', 'u', 'j', 'c', 'd', 't', 'a', 'f', 'l', 't', 'r', 'p', 'v', 'e', 'v', 'd', 'e', 'l', 'w', 'u', 'b', 'd', 'v', 'l', 'w', 't', 'f', 'p', 

BrownNoise, LFNoise0, HPF, Pluck, 'w', 'l', LFDNoise1, LFDNoise0, 'f', LFNoise0, PMOsc, 'x', 'k', Saw, 'y', Dust2, 'w', 'n', 'g', 't', 'y', 'j', 'u', 'y', 'w', 'f', 'o', 't', 'w', 'g', 'v', 'd', 'a', 'f', 'f', 'h', 'r', 'i', 'x', 'e', 'd', 'g', 'd', 'd', 'b', 'd', 'h', 'u', 'e', 'o', 'o', 't', 'f', 'w', 'd', 'g', 'c', 'j', 'x', 't', 'a', 'e', 'p', 'l', 'g', 'm', 'j', 'g', 'q', 'a', 'g', 'w', 'j', 'f', 'b', 'q', 'l', 's', 'y', 'r', 'r', 'c', 'p', 'u', 'y', 'v', 'v', 'b', 'j', 'l', 'y', 'c', 'm', 'e', 'j', 't', 'r', 'e', 'i', 'k', 'h', 'c', 't', 'c', 'g', 't', 'c', 'y', 'c', 'e', 'w', 's', 's', 'p', 'f', 'd', 's', 'd', 'a', 's', 'y', 'q', 'r', 'w', 's', 't', 'u', 't', 'c' ];

~i01 = [ 
LFSaw, 'x', 'q', 'v', 'x', InGrain, HPF, SinOsc, 'o', 'i', 'r', Dust2, LFCub, HenonL, Saw, LFNoise1, 't', 'v', 'r', 't', 'g', 't', 'k', 'k', 'l', 'f', 'k', 'n', 'i', 'm', 'f', 'f', 'c', 'm', 'v', 'r', 'p', 'k', 'u', 'l', 'm', 'x', 'q', 'f', 'd', 'k', 'b', 'q', 't', 'k', 'o', 'b', 'k', 'q', 'b', 'w', 'w', 't', 't', 'l', 't', 'q', 'i', 'v', 'u', 'v', 'f', 'x', 'j', 'e', 'p', 'a', 'm', 'm', 'x', 'd', 'e', 'r', 'c', 's', 't', 'j', 'd', 'e', 'k', 'c', 'l', 'f', 'u', 'x', 'n', 'y', 'm', 'g', 'u', 'u', 'd', 'j', 'h', 'j', 'm', 'v', 'r', 'j', 'q', 'l', 'p', 'd', 'j', 'x', 's', 's', 'v', 'u', 'k', 'v', 'h', 'u', 'k', 'd', 'h', 'w', 'j', 'r', 'h', 'h', 'e', 'q', 'q', 

LPF, InGrain, LFDNoise1, Dust2, LFNoise0, 'e', 'u', 'd', Pulse, 'u', Dust2, LFCub, 'i', LFNoise2, SawDPW, LFDNoise0, 'd', 'c', 'a', 'x', 'h', 's', 'w', 'j', 'r', 's', 'y', 'l', 'd', 'v', 's', 'd', 'g', 'e', 'r', 'c', 'l', 'v', 't', 'o', 'w', 'r', 'e', 'q', 'f', 'y', 'i', 'm', 'h', 'u', 'k', 'n', 't', 'v', 'w', 'r', 'n', 'i', 'l', 'm', 'n', 'n', 'o', 'r', 'e', 'p', 'k', 'g', 'w', 'p', 'c', 'b', 'j', 'l', 'p', 'n', 'w', 's', 'p', 'j', 'o', 'd', 'v', 'b', 'y', 's', 'c', 'a', 't', 'w', 'x', 'e', 'd', 'y', 's', 's', 'x', 'q', 'a', 'i', 'a', 'y', 'c', 'r', 'f', 'b', 'i', 'a', 'n', 'e', 'r', 'i', 'g', 'v', 'b', 'u', 'o', 'f', 'u', 'p', 'l', 'l', 'n', 'c', 'i', 'q', 'y', 'a', 'e', 

Pulse, 'o', LFDNoise1, 'c', 'n', 'n', 'e', LFPulse, 'n', 'b', 'l', QuadL, 's', 'i', 't', 'g', 'i', 'h', 's', 'y', 'l', 'o', 'v', 'm', 'b', 'e', 'u', 'o', 'j', 'q', 'd', 'e', 't', 'd', 'y', 'l', 'b', 'k', 'w', 'h', 'b', 'w', 'y', 'p', 'j', 'r', 'i', 's', 'u', 'g', 'm', 'm', 'k', 'q', 'w', 's', 'm', 'e', 'g', 'i', 't', 'o', 'l', 'd', 'f', 'e', 'a', 'l', 'h', 'i', 'f', 'o', 'v', 'r', 'q', 'x', 'b', 'w', 'a', 'g', 'j', 'd', 'r', 'a', 'f', 'q', 'g', 'q', 'n', 'w', 'r', 'b', 'd', 'v', 'g', 'a', 'o', 't', 'q', 'w', 'v', 'x', 'v', 'v', 'b', 'i', 'o', 'a', 'w', 'h', 'b', 'f', 'f', 'b', 'x', 'i', 'i', 'j', 'o', 'n', 'd', 'o', 'h', 'c', 'r', 'k', 't', 'h', 'v', 

Formant, CombC, 'k', 'k', 'x', 'v', 'w', LFNoise0, SawDPW, GbmanL, LFCub, 'v', 'o', 'r', Formant, SinGrain, 'd', 'r', 'h', 'a', 'a', 'f', 'k', 'o', 's', 'w', 'a', 'b', 'a', 'u', 'p', 'e', 'a', 'c', 't', 'u', 'x', 'y', 'm', 'r', 'a', 'q', 'f', 'l', 'p', 'l', 'v', 'e', 'h', 'j', 'u', 'w', 'c', 'a', 'e', 'c', 'f', 'h', 'h', 's', 'v', 'd', 's', 'm', 'y', 'n', 'w', 'i', 'j', 'o', 'd', 'v', 'd', 'g', 'n', 'v', 'p', 'f', 'c', 'n', 'y', 'o', 'c', 'h', 'j', 'v', 'c', 'r', 'f', 'f', 'u', 'a', 'j', 'i', 'b', 's', 'y', 'o', 'p', 'a', 'c', 'r', 'h', 'e', 'l', 'a', 's', 'a', 'b', 't', 'v', 'c', 'r', 'm', 'g', 'r', 'c', 'g', 'm', 'k', 'h', 'r', 'n', 'h', 'n', 'u', 'e', 'p', 'p' ]

)


// recombine
~new=~gep.recombine(~i00, ~i01, 129)

~i02 = ~new.first
~i03 = ~new.last

~gep.mutate(~i02, 4)
~gep.mutate(~i03, 4)

~i02 = ~gep.transposeInsertSequence(~i02, 2, 4)
~i03 = ~gep.transposeInsertSequence(~i03, 2, 4)

~i02 = ~gep.transposeRoot(~i02, 2, 4)
~i03 = ~gep.transposeRoot(~i03, 2, 4)

~i02 = ~gep.transposeGene(~i02)
~i03 = ~gep.transposeGene(~i03)

~i03.postcs

[ 
Formant, CombC, 'k', 'k', 'x', 'v', 'w', LFDNoise0, 'f', LFNoise0, PMOsc, 'x', 'k', 'r', 'y', SinGrain, 'd', 'r', 'h', 't', 'y', 'j', 'k', 'o', 's', 'f', 'o', 't', 'a', 'g', 'v', 'd', 'a', 'f', 'f', 'u', 'r', 'i', 'x', 'e', 'd', 'q', 'f', 'l', 'p', 'l', 'v', 'e', 'h', 'j', 'u', 't', 'f', 'w', 'd', 'g', 'c', 'j', 'x', 't', 'a', 'e', 'p', 'l', 'g', 'm', 'j', 'g', 'q', 'a', 'g', 'w', 'j', 'f', 'b', 'q', 'p', 'f', 'c', 'r', 'r', 'c', 'c', 'h', 'j', 'v', 'v', 'b', 'j', 'l', 'y', 'c', 'm', 'i', 'b', 's', 'y', 'o', 'i', 'k', 'h', 'c', 't', 'c', 'l', 'a', 's', 'a', 'b', 'e', 'w', 's', 'r', 'p', 'f', 'd', 's', 'd', 'a', 'k', 'h', 'q', 'r', 'h', 'n', 'u', 'e', 'p', 'p', 

Pluck, 'l', 'f', 'i', 'h', Ball, SawDPW, 'e', 'h', InGrain, HPF, SinOsc, 'o', 'i', 'r', Dust2, 't', 'g', 'r', 't', 'r', 'g', 'w', 'k', 'l', 'f', 'i', 'h', 'i', 'v', 'n', 's', 't', 'a', 'y', 'l', 'p', 'k', 'u', 'g', 'e', 'n', 'u', 't', 'b', 'k', 'b', 'q', 't', 'k', 'p', 't', 'k', 'p', 'n', 'w', 'i', 't', 'a', 'y', 'q', 'q', 'i', 'x', 'v', 'a', 'f', 'x', 'w', 'i', 'p', 'a', 'm', 'm', 'o', 'i', 'q', 'i', 'c', 'e', 'p', 'd', 'l', 'm', 'x', 'c', 'w', 'f', 'u', 'x', 'l', 'o', 'm', 'g', 'k', 'u', 'p', 'j', 'h', 'j', 'm', 'v', 'r', 'x', 'a', 'n', 'p', 'x', 'u', 'f', 's', 's', 'v', 'u', 'k', 'v', 'h', 'u', 'a', 'i', 'n', 'v', 'h', 'k', 'h', 'p', 'v', 'f', 'q', 

Pulse, 'o', HenonL, 'y', 'b', SyncSaw, 'x', 'o', 'o', QuadL, GbmanL, Blip, GbmanL, LFNoise2, 'm', 'v', 'd', 'c', 'a', 'x', 'r', 'q', 'g', 'c', 'r', 's', 'y', 'q', 'o', 'y', 's', 'd', 'g', 'e', 'r', 'c', 'w', 'v', 't', 'l', 'g', 'b', 't', 'q', 'f', 'y', 'i', 'm', 'm', 'u', 'k', 'n', 't', 'v', 'w', 'r', 'n', 'i', 'l', 'm', 'n', 'n', 'o', 'r', 'e', 'p', 'k', 'g', 'w', 'p', 'c', 'y', 'j', 'l', 'p', 'n', 'w', 'd', 'r', 'j', 'q', 'd', 'y', 'u', 'y', 's', 'c', 'a', 't', 'w', 'x', 'e', 'i', 'y', 's', 'n', 'x', 'q', 'a', 'i', 'y', 'n', 'c', 'r', 'f', 'b', 'i', 'a', 'n', 'e', 'r', 'w', 'p', 'v', 'b', 's', 'o', 'q', 'f', 's', 'l', 'l', 'e', 'y', 'g', 'g', 'p', 'y', 't', 

Pulse, 'o', Pluck, 'c', 'e', 'f', 'e', LFPulse, 'n', 'l', Ball, 'u', 's', 'i', 't', Logist0, 'a', 'h', 'f', 'l', 'l', 'o', 'v', 'm', 'b', 'e', 'n', 'p', 'u', 'd', 'v', 'n', 'x', 'v', 'h', 'l', 'b', 'k', 'w', 'd', 'v', 'b', 'u', 't', 'j', 'r', 'y', 'l', 't', 'l', 'j', 'q', 'r', 'p', 'n', 'x', 'l', 'k', 'x', 'b', 'm', 'o', 'l', 'd', 'a', 'e', 'a', 'l', 'v', 't', 's', 'g', 'v', 'r', 'q', 'j', 'u', 'n', 'a', 'e', 'j', 'd', 'r', 'a', 'f', 'q', 'g', 'q', 'n', 'w', 'r', 'b', 'e', 'm', 'b', 'u', 'o', 't', 'q', 'r', 'c', 'm', 'u', 'j', 'b', 'i', 't', 'a', 'f', 'l', 't', 'r', 'f', 'b', 'e', 'v', 'd', 'e', 'l', 'w', 'u', 'b', 'h', 'c', 'r', 'k', 't', 'h', 'v' ]

[ 
LPF, 'q', 'q', LPF, InGrain, InGrain, LFDNoise1, Dust2, LFNoise0, 'e', 'u', 'd', Pulse, 'u', Dust2, LFCub, 'q', 'j', 'j', 's', 'h', 's', 'w', 'j', 'q', 'j', 'h', 'l', 'd', 'v', 'b', 'd', 'y', 'o', 'n', 'g', 'l', 'y', 'f', 'o', 'w', 'r', 'e', 'i', 'o', 'f', 'x', 'i', 'h', 'l', 'o', 'h', 'a', 'w', 'a', 'a', 'q', 'e', 'h', 'h', 'q', 'n', 't', 'j', 'w', 't', 'v', 'x', 'd', 'm', 'e', 'h', 's', 'd', 'g', 'c', 'n', 's', 'p', 'j', 'o', 'w', 'v', 'b', 'a', 'c', 'e', 'j', 'x', 'x', 'u', 'o', 'e', 'e', 'i', 's', 'd', 'k', 'h', 'a', 'a', 'y', 'u', 'f', 'w', 'w', 'l', 'j', 'b', 'w', 'v', 'i', 'g', 'f', 'd', 'u', 'b', 'f', 'u', 'p', 'i', 'l', 'n', 'c', 'i', 'q', 'y', 'a', 'e', 

LFSaw, 'x', 'q', 'v', 'x', 'p', 'v', 'o', HenonL, 's', LFDNoise0, 'a', LFPulse, CuspL, 's', LFNoise1, 'v', 'v', 'v', 'k', 'g', 't', 'k', 'r', 'd', 'n', 'k', 'n', 'u', 'm', 'f', 'f', 'c', 'm', 'v', 'r', 'v', 'l', 'b', 'l', 'm', 'x', 'q', 'f', 'd', 'f', 'u', 'x', 'x', 'w', 'o', 'b', 'f', 'q', 'b', 'u', 'w', 'h', 't', 'l', 't', 'l', 'p', 'v', 'u', 'v', 'd', 't', 'j', 'e', 's', 'y', 's', 'k', 'x', 'd', 'e', 'r', 'x', 's', 't', 'j', 'd', 'e', 'k', 'l', 'l', 'j', 't', 'b', 'n', 'y', 'a', 'c', 'u', 'h', 'd', 's', 'k', 'f', 'j', 'c', 'l', 'j', 'q', 'l', 'v', 'd', 'j', 'x', 'k', 's', 'g', 's', 'f', 'f', 'g', 'd', 'k', 'd', 'h', 'w', 'j', 'r', 'e', 'h', 'e', 'q', 'q', 

Blip, 'h', LFDNoise1, Dust2, 'n', 'n', Pulse, Logist0, 's', 'b', 'l', QuadL, 'x', QuadL, SinOsc, 'g', 'i', 'n', 's', 'y', 'q', 'o', 'n', 'y', 'e', 'f', 'u', 'o', 'j', 'q', 'd', 'e', 't', 'd', 'y', 'd', 'x', 'h', 'a', 'h', 'b', 'w', 'y', 'p', 'k', 'q', 'i', 's', 'u', 'g', 'm', 'm', 'k', 'q', 'w', 's', 'm', 'e', 'g', 'i', 't', 'l', 't', 'x', 'f', 'p', 'r', 'd', 'h', 'i', 'f', 'o', 'a', 'v', 't', 'x', 'b', 'w', 'f', 'g', 'q', 'f', 't', 'c', 'o', 'n', 'i', 'r', 'j', 'x', 's', 'b', 'd', 'v', 'g', 'a', 'l', 'y', 'n', 'w', 'v', 'x', 'v', 'v', 'c', 'd', 'o', 'a', 'w', 'u', 'b', 'f', 'p', 'v', 'x', 'i', 'i', 'j', 'o', 'n', 'd', 'o', 'd', 'v', 'l', 'w', 't', 'f', 'p', 

BrownNoise, LFNoise0, HPF, Pluck, 'w', 'l', LFDNoise1, LFNoise0, SawDPW, GbmanL, LFCub, 'v', 'o', Saw, Formant, Dust2, 'w', 'n', 'g', 'a', 'a', 'f', 'u', 'y', 'w', 'w', 'a', 'b', 'w', 'u', 'p', 'e', 'a', 'c', 't', 'h', 'x', 'y', 'm', 'r', 'a', 'g', 'd', 'd', 'b', 'd', 'h', 'u', 'e', 'o', 'o', 'w', 'c', 'a', 'e', 'c', 'f', 'h', 'h', 's', 'v', 'd', 's', 'm', 'y', 'n', 'w', 'i', 'j', 'o', 'd', 'v', 'd', 'g', 'n', 'v', 'l', 's', 'y', 'n', 'y', 'o', 'p', 'u', 'y', 'v', 'c', 'r', 'f', 'f', 'u', 'a', 'j', 'e', 'j', 't', 'r', 'e', 'p', 'a', 'c', 'r', 'h', 'e', 'g', 't', 'c', 'y', 'c', 't', 'v', 'c', 's', 'm', 'g', 'r', 'c', 'g', 'm', 's', 'y', 'r', 'n', 'w', 's', 't', 'u', 't', 'c' ]

