(
~data= FileReader.read("/Users/alo/Data/protein/androgen-receptor/apo/trajectory.pdb", skipBlanks:true);
~prot = ~data.select({|row| row[0] == "ATOM" });
"finished loading"
)


(

~map = ('S': LFSaw, 'O': SinOsc, 'C': LFCub, 'H': LFTri, 'N': LFNoise0);

~defs = ~map.collect({|ugen|
	SynthDef((ugen.name.asString.toLower).asSymbol, {arg out, freq, amp, dur, pan;
		Out.ar(out, PanB2.ar(ugen.ar(freq, mul: amp), pan)
			* EnvGen.kr(Env.sine, timeScale: dur, doneAction: 2)
		)
	})
});

~defs.do(_.add)

)

(
Tdef('protein', {
	~current = 1;
	~delta = 0.1;
	~prot.do({|row|
		var ltr;
		ltr = row[2].select({|ch| ch.asString.asInt == 0 });
		Synth(~defs[ltr[0].asSymbol].name, [\freq, row[5].asFloat * 2, \amp, row[6].asFloat.reciprocal * 4, \dur, row[7].asFloat.reciprocal * 10, \pan, rrand(-1.0, 1.0)]);
		if (~current != row[4]) { ~current = row[4]; rrand(~delta * 0.5, ~delta * 2.0).wait; };
		{ (~delta / 4).rand.wait }
	});
	"finished".postln
})
)

Tdef('protein').play

Tdef('protein').clear
