~db = CouchDB(NetAddr("127.0.0.1", 5984), "aafrika", "views")

~dict=~db.get("timeline_id_by_file_id").parseJson

~dict["rows"].do({|dict, i| if (dict["key"].find("Kimpala").notNil) { i.postln } })

~segments = ~db.getParsed("segments_by_timeline_id", ~dict["rows"].first["value"] )

~segments["rows"].do(_.postln)

~notes = ~db.getParsed("notes_by_timeline_id", ~dict["rows"][46]["value"] )

~notes = ~notes["rows"].collect({|dict| dict["value"]  })

~notes.do({|dict| t = dict["event:time"]["tl:at"]; dict["event:time"]["tl:at"] = t[(2..t.size-2)].join.asFloat })

~notes.sort({|dictA, dictB| dictA["event:time"]["tl:at"] < dictB["event:time"]["tl:at"] })

~notes.do(_.postln)

SynthDef('vsaw', {|freq, dur|
	Out.ar(0, VarSaw.ar(freq).dup * EnvGen.kr(Env.perc, timeScale: dur, doneAction: 2))
}).add

SynthDef('sino', {|freq, dur, amp|
	Out.ar(0, SinOsc.ar(freq, mul: amp).dup * EnvGen.kr(Env.perc(0.3, 0.7), timeScale: dur, doneAction: 2))
}).add

Tdef('play', {
	loop({
		~notes.keep(17).do({|dict, i|
			var dur, time, freq, next = 0;
			time = dict["event:time"]["tl:at"];
			if (i < ~notes.lastIndex)
			{ next = ~notes[i + 1]["event:time"]["tl:at"] }
			{ time = 0; next = ~notes[0]["event:time"]["tl:at"] };
			dur = next - time;
			freq = (dict["afo:value"].asInt * 12).nearestPrime;
			[freq, dur].postln;
			Synth('sino', ['freq', freq, 'dur', dur * 0.2, 'amp', rrand(0.4, 0.7)]);
			(dur * 4).wait;
		})
	})
}).play


~rev = SynthDef('reverb', {arg revamp=0.1, revtime=0.5, dry=0.8, tail=0.5;
	var sig;
	sig = In.ar(0, 2);
	ReplaceOut.ar(0, GVerb.ar(sig, 200, revtime, drylevel: dry, earlyreflevel: revamp, taillevel: tail))
}).play

~rev.free

s.scope(2)

~rev.set('revamp', 0.1, 'revtime', 1.0, 'dry', 0.1, 'tail', 1.0)

Tdef('play').clear