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

~gespaths.size

~buffers = ~gespaths.collect({|path|
	Buffer.read(s, path)
});

~buffers.size

~current = ~buffers[0]
~buffers.indexOf(~current) - 1
~current = ~buffers[527]
~current = ~findCurrent.(~base +/+ "gep_gen000_056_170827_095255.aiff")

SynthDef('loop', {|buf, amp|
	var sig = PlayBuf.ar(~buffers.first.numChannels, buf, loop:1);
	Out.ar(0, sig * amp)
}).add


~synth = Synth('loop', ['buf', ~current = ~buffers.first, 'amp', 1.0])

~synth = Synth('loop', ['buf', ~current, 'amp', 1.0])


~next.()

~select.()

~selectPi.()

// index 27 pix!!

(
~next = {
	var index = ~buffers.indexOf(~current);
	if (index == ~buffers.lastIndex) {
		Post << "Already at last buffer!!" << Char.nl
	}
	{
		~current = ~buffers[index + 1];
		~synth.set('buf', ~current)
	}
};

~select = {
	var src, dst;
	src = ~current.path;
	dst = src.replace("gep_", "wrp/gep_");
	("cp " ++ src ++ " " ++ dst).unixCmd;
};

~selectPi = {
	var src, dst;
	src = ~current.path;
	dst = src.replace("gep_", "pix/gep_");
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

~synth.free

~synth.set('amp', 1.0)

MasterEQ(2)