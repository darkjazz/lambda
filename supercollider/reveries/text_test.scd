~file = File("/Users/alo/dev/lambda/supercollider/reveries/text.text", "r");
~text = ~file.readAllString;
~file.close;
~poems = ~text.split($+);
~sendText = {
	Tdef('code', {
		loop({
			~sendarr = ~poems.choose.split(Char.nl);
			~sendarr.do({|text|
				text.postln;
				rrand(0.5, 2.0).wait;
			})
		})
	}).play
};

~sendText.()