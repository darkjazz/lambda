(

Routine({
	var file, dur, num, sect = 15;
	file = Buffer.readChannel(s,
		"/Users/alo/snd/STE-008.wav",
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
		buf.write("/Users/alo/snd/mskf_" ++ (i + 1).asString ++ ".aif");
		s.sync;
		("Wrote " ++ "/Users/alo/snd/mskf_" ++ (i + 1).asString ++ ".aif").postln;
	})
}).play

)


(
~analyser = MikroBatchAnalyzer("/Users/alo/snd/dnb/*".pathMatch);
~analyser.paths.do({|path|
	~analyser.convertMP3(path)
})
)

(

Tdef('extract_samples', {
	var file, dur, num, sect = 4, index = 0;
	"/Users/alo/snd/decode/*".pathMatch.do({|path|
		file = Buffer.readChannel(s, path, channels:[0]);
		s.sync;
		dur = file.numFrames / file.sampleRate;
		sect.do({|i|
			var buf, start, end;
			buf = Buffer.alloc(s, 4.rand + 1 * s.sampleRate);
			s.sync;
			start = s.sampleRate * 40 + (sect * s.sampleRate * i);
			end = start + (sect * s.sampleRate - buf.numFrames);
			file.copyData(
				buf,
				0,
				rrand(start, end),
				buf.numFrames
			);
			buf.write("/Users/alo/snd/dnb_samples/dnb_" ++ (index + 1).asString ++ ".aif");
			s.sync;
			("Wrote " ++ "/Users/alo/snd/dnb_samples/dnb_" ++ (index + 1).asString ++ ".aif").postln;
			index = index + 1;
		})
	});
}).play

)


(
	f = FileToAts("/Users/alo/sounds/fx_loops/fxloop*".pathMatch);
	f.process
)


