(
var arrA, arrB, size;
size = 24;
arrA = Array();
arrB = Array();
~arr = Array();

forBy(1, size-1, size/4, {|j|
	forBy(1, size-1, size/4, {|k|
		~arr = ~arr.add([0, j, k])
	})
});

forBy(1, size-1, size/4, {|i|
	forBy(1, size-1, size/4, {|j|
		arrA = arrA.add([i, j, 0])
	})
});

forBy(1, size-1, size/4, {|i|
	forBy(1, size-1, size/4, {|j|
		arrB = arrB.add([i, j, size-1])
	})
});

~arr = ~arr.addAll([arrA, arrB].lace(arrA.size + arrB.size) );

forBy(1, size-1, size/4, {|j|
	forBy(1, size-1, size/4, {|k|
		~arr = ~arr.add([size-1, j, k])
	})
});				

~arr = ~arr.collect({|arr|
	~enc.(arr, size).asInteger
})


)

~arr.do({|int|
	~dec.(int, 24).postln
})

~arr.flatten(1).do(_.postln)

(
var size = 24;
~arr = Array.fill(size, {|x| Array.fill(size, {|y| [x, y, size/2-1] }) });
~arr.postln;
~arr = ~arr.flatten(1).collect({|arr|
	~enc.(arr, size).asInteger
})

)

~arr[23]

~arr.size

~enc = {|arr, max|
	arr[0]*max+arr[1]*max+arr[2]
}

~dec = {|int, max|
	[(int/(max*max)).floor, (int/max).floor.mod(max), int.mod(max) ]
}

~dec.(7, 15)

~enc.([0, 0, 7], 15)