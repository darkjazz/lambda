[
12*60+3,
12*60+47,
8*60+30,
9*60+26,
4*60+55,
5*60+4,
5*60+8,
3*60+43,
8*60+50,
5*60+49
].sum/60

~geenLambda.geen.freqSet.dict.keys

~geen = ~geenLambda.geen
~geen.freqSet.next(~geen.roundFreq(53.434256763448).round(0.000001))

~geen.getNearestMatch(~geen.freqSet, ~geen.roundFreq(53.434256763448))

~geen.freqSet.dict.keys(Array).collect({|key|
	[key, ~geen.freqSet.dict[key]].postln
})

~nearest = {|set, value|
	var index, keys, diff;
	keys = set.dict.keys(Array);
	diff = keys.collect({|num| abs(num-value) });
	index = diff.indexOf(diff.minItem);
	set.next(keys[index])
}

~nearest.(~geen.freqSet, ~geen.roundFreq(53.434256763448))

~geen.freqSet.dict.keys

