/*
as of 3.7alpha not implemented yet
*/

(
var ctrlDown = false;

Document.current.keyDownAction = {|doc, char, mod, uni, key|
	if (key == 37) { ctrlDown = true };
};

Document.current.keyUpAction = {|doc, char, mod, uni, key|
	var sendarray;
	if ((key == 36).and(ctrlDown))
	{
		Post << "Start: " << doc.selectionStart << Char.nl;
	};

	if (key == 37) { ctrlDown = false }
}

)



s.queryAllNodes

(
5.do({arg i;
	i**2
})
)