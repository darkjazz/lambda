// SuperCollider example for using the music generation model

(
// Path to the generate script
~genScript = "/Users/kurivari/dev/lambda/supercollider/analyze";
~pythonBin = "/opt/anaconda3/envs/music-gen/bin/python";

// Function to generate sequences
~generateSeq = {|numNotes=20, seedNotes=nil, seedIOI=nil, pitchTemp=2.0, rhythmTemp=0.5|
	var cmd, result, data;

	// Build command
	cmd = "cd" + ~genScript + "&& " ++ ~pythonBin + "generate.py" + numNotes.asString;

	// Add optional seed sequences
	if(seedNotes.notNil, {
		cmd = cmd + "--seed-notes" + seedNotes.join(",");
	});
	if(seedIOI.notNil, {
		cmd = cmd + "--seed-ioi" + seedIOI.join(",");
	});

	// Add temperature parameters
	cmd = cmd + "--pitch-temp" + pitchTemp.asString;
	cmd = cmd + "--rhythm-temp" + rhythmTemp.asString;

	// Execute and parse JSON
	result = cmd.unixCmdGetStdOut;
	data = result.parseYAML;  // JSON is valid YAML

	// Return dictionary with ratios and rhythms
	(
		ratios: data["ratios"],
		rhythms: data["rhythms"],
		// Also include original data for reference
		notes: data["notes"],
		ioi: data["ioi"]
	)
};

// Example 1: Generate 20 notes with default seed
~seq1 = ~generateSeq.value(20);
~seq1.notes.postln;
~seq1.ioi.postln;

// Example 2: Generate with custom seed
~seq2 = ~generateSeq.value(
	numNotes: 16,
	seedNotes: [60, 64, 67, 72, 69],  // C, E, G, C, A
	seedIOI: [0.5, 0.5, 1.0, 0.5, 0.5]
);

// Example 3: Conservative generation (low temperature)
~seq3 = ~generateSeq.value(
	numNotes: 20,
	pitchTemp: 1.0,  // More predictable, stays closer to learned patterns
	rhythmTemp: 0.3
);

// Example 4: Wild generation (high temperature)
~seq4 = ~generateSeq.value(
	numNotes: 20,
	pitchTemp: 4.0,  // More chaotic, wider pitch jumps
	rhythmTemp: 1.0
);

// Example 5: Using ratios to modulate a base frequency
(
~baseFreq = 440;  // A4
~seq = ~generateSeq.value(16);

// Apply frequency ratios cumulatively
~freqs = [~baseFreq];
~seq.ratios.do { |ratio|
	~freqs = ~freqs.add(~freqs.last * ratio);
};

// Play with MIDI note conversion
Pbind(
	\instrument, \default,
	\freq, Pseq(~freqs, 1),
	\dur, Pseq(~seq.ioi, 1),
	\amp, 0.3
).play;
)

// Example 6: Using rhythm patterns for amplitude modulation
(
~seq = ~generateSeq.value(12);

// Extract delta and amp patterns
~deltas = ~seq.rhythms.collect(_["delta"]);
~amps = ~seq.rhythms.collect(_["amp"]).flat;

// Use for iamp/wamp modulation
Pbind(
	\instrument, \yourSynth,  // Your playbuf synth
	\freq, Pseq(~seq.notes.midicps, inf),
	\iamp, Pseq(~amps * 0.7, inf),  // Original signal amp
	\wamp, Pseq(~amps.reverse * 0.5, inf),  // Warped signal amp
	\dur, Pseq(~deltas, inf) * 0.5  // Delta as beat fraction
).play;
)
)
