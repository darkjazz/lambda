(

Routine({
	var file, dur, num, sect = 15;
	file = Buffer.readChannel(s, 
		"/Users/alo/sounds/gep/evolver00.aif",
		s.sampleRate,
		channels:[0]
	);
	s.sync;
	dur = file.numFrames / file.sampleRate;
	num = (dur / sect).asInt;
	num.do({|i|
		var buf, start, end;
		buf = Buffer.alloc(s, 5.rand + 1 * s.sampleRate);
		s.sync;
		start = sect * s.sampleRate * i;
		end = start + (sect * s.sampleRate - buf.numFrames);
		file.copyData(
			buf, 
			0, 
			rrand(start, end),
			buf.numFrames
		);
		buf.write("/Users/alo/sounds/evo_loops/ev_" ++ (i + 1).asString ++ ".aif");
		s.sync;
		("Wrote " ++ "/Users/alo/sounds/evo_loops/ev_" ++ (i + 1).asString ++ ".aif").postln;
	})
}).play

)

(
	f = FileToAts("/Users/alo/sounds/fx_loops/fxloop*".pathMatch);
	f.process
)


