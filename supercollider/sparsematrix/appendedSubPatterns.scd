SparseMatrix.makeSparsePatterns(2)

SparseMatrix.patterns16.keys

~ptrn = SparseMatrix.sparseObjects['diansa'].makeSubPatterns


~appendedPatterns = ~ptrn.patterns.copy

~ptrn.makeSubPatterns(3)


~ptrn.subpatterns.do({|subpat|
	subpat.do({|row, i| 
		~appendedPatterns[i] = ~appendedPatterns[i] ++ row
	})
})

~ptrn.subpatterns.first.first.do(_.postln)

~ptrn.patterns.first.size

~appendedPatterns.first.do({|on, i|
	if (on == 1) { i.postln }
})

