Document.current.keyDownAction = {|...args|
	if ((args[3] == 3) and: { args[4] == 76 }) {
		args.postln
	}
}

