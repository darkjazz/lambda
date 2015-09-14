~graphics = CinderApp(1024, 768, mode: 0);

~graphics.open

~graphics.initWorld(24, 24, 24, 20);

~graphics.initGenerations([4,6,8], [3,5,7,9], 12);

~graphics.setSymmetry(11)

~graphics.setViewpoint(0.0, 0.0, 140.0, 0.0, 0.0, 0.0)


Tdef(\sendVector, {
	loop({
		~graphics.sendSOMVector( Array.rand(20, 0.0, 1.0) );
		[0.0625, 0.125, 0.25, 0.75, 0.35, 0.5].choose.wait;
	});
});

Tdef(\sendVector).play



~graphics.showCodePanel

~graphics.assignCodeWindow(Document.current)


(
// keyDownAction to send evaluated code to the window
Document.current.keyDownAction = {|doc, char, mod, uni, key|
	var sendarray;
	[uni, key].postln;
	if ((uni == 13) and: { key == 36 })
	{
		Post << "Sending: " << doc.selectedString << Char.nl;
		sendarray = doc.selectedString.split(Char.nl);
		sendarray[0] = "alo@ " ++ sendarray[0];
		sendarray.do({|str|
			~graphics.sendCodeLine(str)
		})
	}
}

)
