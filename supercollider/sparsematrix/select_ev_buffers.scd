Server.killAll

~base = Paths.soundDir +/+ "evolver";

(
~gespaths = (~base +/+ "*.aiff").pathMatch.select({|path|
	(~base +/+ "perc/*.aiff").pathMatch.collect({|other|
		(other.basename == path.basename).binaryValue
	}).sum == 0
}).select({|path|
	(~base +/+ "pi/*.aiff").pathMatch.collect({|other|
		(other.basename == path.basename).binaryValue
	}).sum == 0
}).select({|path|
	(~base +/+ "wrp/*.aiff").pathMatch.collect({|other|
		(other.basename == path.basename).binaryValue
	}).sum == 0
})
)

(

~gespaths = (Paths.soundDir +/+ "evolver/*").pathMatch;
~gespaths.size.postln;
~gesbufs = GESBufferLoader([]);
~gesbufs.loadByDate("231101", "240101");

)


~buffers = ~gesbufs.buffers
~buffers.size
~gesbufs.size

(
~next = {
	var index = ~buffers.indexOf(~current);
	if (index == ~buffers.lastIndex) {
		Post << "Already at last buffer!!" << Char.nl
	}
	{
		~current = ~buffers[index + 1];
		Post << index << " :: " << ~current.path.basename << Char.nl;
		~synth.set('buf', ~current)
	}
};

~select = {
	var src, dst;
	src = ~current.path;
	dst = src.replace("gep_", "sbt/gep_");
	("cp " ++ src ++ " " ++ dst).unixCmd;
};

~selectPi = {
	var src, dst;
	src = ~current.path;
	dst = src.replace("gep_", "pix/gep_");
	("cp " ++ src ++ " " ++ dst).unixCmd;
};

~selectWrp = {
	var src, dst;
	src = ~current.path;
	dst = src.replace("gep_", "wrp/gep_");
	("cp " ++ src ++ " " ++ dst).unixCmd;
};

~findCurrent = {|path|
	var finished, curr, seq = Pseq(~buffers, 1).asStream;
	finished = false;
	while({ finished.not }, {
		curr = seq.next;
		if (curr.isNil) { finished = true };
		if (curr.path == path) { finished = true };
	});
	curr
}
)


~buffers = ~gespaths.collect({|path|
	Buffer.read(s, path)
});

~buffers.size

~ind = 0

~ind = ~ind + 1

~current = ~buffers[~ind]

~buffers.indexOf(~current) - 1
~current = ~buffers[528]
~current = ~findCurrent.(~base +/+ "gep_gen007_013_231120_181628.aiff") // <- last one selected

SynthDef('loop', {|buf, amp|
	var sig = PlayBuf.ar(~buffers.first.numChannels, buf, loop:1);
	Out.ar(0, sig.dup * amp)
}).add


~synth = Synth('loop', ['buf', ~current = ~buffers[0], 'amp', 1.0])

~synth = Synth('loop', ['buf', ~current, 'amp', 2])

~synth.set('amp', 2.0)

~synth.free

~current

s.scope(2)


Tdef('play', {
	loop({
		~next.();
		33.wait;
	})
}).play



Tdef('play').clear


~next.()

~select.()

~selectPi.()


~selectWrp.()

// index 27 pix!!

MasterEQ(2)

6, 14


~synth.free

~synth.set('amp', 1.0)

MasterEQ(2)

b = Buffer.read(Server.default, "/Users/alo/snd/evolver/gep_gen003_006_231111_123839.aiff")


b.sampleRate

~paths = (Paths.matrixDir +/+ "sets/___ei_saa_aru_synths.scd").load

~paths.class