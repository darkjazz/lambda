s.boot

(

Routine({
	var file, dur, num, sect = 13, target;
	file = Buffer.readChannel(s,
		// "/Users/alo/Music/SuperCollider Recordings/SC_181231_141153.aiff",
		"/Users/alo/snd/poni/blue_planet.wav",
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
		target = "/Users/alo/snd/drn/poni/c_" ++ (i + 1).asString.padLeft(2, "0") ++ ".wav";
		buf.write(target, "wav", "int16");
		s.sync;
		("Wrote " ++ target).postln;
	})
}).play

)

~path = "/Users/alo/snd/lctrnc/01 AS Gardens Need Walls (Original Mix).mp3"

~path.replace(" ", "\\ ")


~analyser = MikroBatchAnalyzer("/Users/alo/snd/lctrnc/*".pathMatch);

~analyser.paths.do({|path|
	("mv " ++ path.replace(" ", "\\ ") ++ " " ++ path.replace(" ", "_")).unixCmd
})



(

~analyser.paths.do({|path|
	if (path.find(".mp3").notNil) {
		~analyser.convertMP3(path)
	};
	if (path.find(".m4a").notNil) {
		~analyser.convertM4A(path)
	}
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
			buf.write("/Users/alo/snd/lctrnc_loops/lctr_" ++ (index + 1).asString ++ ".aif");
			s.sync;
			("Wrote " ++ "/Users/alo/snd/lctrnc_loops/lctr_" ++ (index + 1).asString ++ ".aif").postln;
			index = index + 1;
		})
	});
}).play

)


(
	f = FileToAts("/Users/alo/sounds/fx_loops/fxloop*".pathMatch);
	f.process
)






(

Tdef('extract_samples', {
	var file, dur, buf, start;
	"/Users/alo/snd/evolver/*.aiff".pathMatch.scramble.keep(37).do({|path, i|
		var target;
		file = Buffer.readChannel(s, path, channels:[0]);
		s.sync;
		dur = rrand(0.5, 2.0);
		buf = Buffer.alloc(s, dur * s.sampleRate);
		s.sync;
		start = file.sampleRate * (file.duration * 0.5).rand;
		file.copyData(buf, 0, start, buf.numFrames);
		target = "/Users/alo/dev/snd-play-js/snd/snd_" ++ (i + 1).asString.padLeft(2, "0") ++ ".wav";
		buf.write(target, "wav", "int16");
		s.sync;
		("Wrote " ++ target).postln;
	});
}).play

)


~buffers = "/Users/alo/dev/snd-play-js/snd/snd_*".pathMatch.collect({|path| Buffer.read(s, path) })

Tdef('play-snd', {
	~buffers.do({|buf|
		{ PlayBuf.ar(1, buf, doneAction: 2).dup }.play;
		buf.duration.wait;
	})
}).play