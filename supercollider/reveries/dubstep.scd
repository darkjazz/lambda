~loader = PatternReader(Noisefunk.pattern_db);
~patterns = ~loader.loadDub



~patterns = ~patterns.collect({|pat|
	pat.collect({|arr|  arr.collect({|num| if (num > 0) { 1 } { 0 }  }) })
});


~patterns.do({|pat|
	pat.do(_.postln);
	"--".postln
})


SparseMatrix.sparseObjects.do()

SparsePattern
