a = Array();
n = 1000;

while ({ n < 10000 }, { n = (n + 1).nextPrime; a = a.add(n); })

a.do(_.postln)

p = Array();

a.doAdjacentPairs({|x, y|
	if (y - x == 2) {
		p = p.addAll([x, y]);
	}
});


p.do(_.postln)

