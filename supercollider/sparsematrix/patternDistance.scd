// djembe pattern distance

~flat = DjembeLib.patterns.collect({|coll|
	coll.select({|arr, i| i.even }).flat
})

~distanceMatrix = ();

~flat.keysValuesDo({|keyA, valA|
	~distanceMatrix[keyA] = ();
	~flat.keysValuesDo({|keyB, valB|
		~distanceMatrix[keyA][keyB] = (valA - valB).abs.sum
	})	
})

~min = ~distanceMatrix.values.collect(_.values).collect(_.asArray).flat.select({|num|
	num > 0
}).minItem.reciprocal;
~max = ~distanceMatrix.values.collect(_.values).collect(_.asArray).flat.maxItem.reciprocal


(
var win;
win = Window("", Rect(100, 100, 410, 410)).front;
win.drawFunc = {
	~distanceMatrix.keysValuesDo({|keyA, valA, i|
		valA.keysValuesDo({|keyB, dist, j|
			dist.reciprocal.linlin(1.0 - ~min, 1.0 - ~max, 0.0, 1.0).postln;
			Pen.color = Color.grey(dist.reciprocal.linlin(1.0 - ~min, 1.0 - ~max, 0.0, 1.0));
			Pen.fillRect(Rect(i*20+5, j*20+5, 20, 20));
		})
	})
}
)

~distanceMatrix['yole'].collect(_.reciprocal)