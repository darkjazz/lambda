Server.killAll

~base = Paths.soundDir +/+ "evolver/wav";

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

~gespaths = (Paths.soundDir +/+ "evolver/wav/*").pathMatch;
~paths = ~gespaths.select({|path|
	var date, arr = path.basename.split($_);
	if (arr.size > 2) {
		date = arr[3].asInteger
	}
	{
		date = -1
	};
	(date >= "240420").and(date <= "240430")

});
~paths.size.postln;
~gesbufs = GESBufferLoader(~paths);
~gesbufs.preload
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
		Post << (index + 1) << " :: " << ~current.path.basename << Char.nl;
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

~ind = 500

~ind = ~ind + 1

~current = ~buffers[~ind]

~buffers.indexOf(~current) - 1
~current = ~buffers[528]
~current = ~findCurrent.(~base +/+ "gep_gen004_027_240426_184757.wav") // <- last one selected

SynthDef('loop', {|buf, amp|
	var sig = PlayBuf.ar(~buffers.first.numChannels, buf, loop:1);
	Out.ar(0, sig.dup * amp)
}).add


~synth = Synth('loop', ['buf', ~current = ~buffers[6], 'amp', 1.0])

~synth = Synth('loop', ['buf', ~current, 'amp', 1])

~synth.set('amp', 2.0)

~synth.set('buf', ~buffers[513].postln)

~synth.free

~current

s.scope(2)


Tdef('play', {
	loop({
		~next.();
		33.wait;
	})
}).play


~next.()

(
[
	'gep_gen001_003_240421_153405',
	'gep_gen002_007_240421_172801',
	'gep_gen002_046_240426_180852',
	'gep_gen002_130_240430_210708',
	'gep_gen002_194_240430_210843',
	'gep_gen003_028_240430_213930',
	'gep_gen003_032_240430_213942',
	'gep_gen003_036_240430_213954',
	'gep_gen003_059_240430_214006',
	'gep_gen003_071_240430_214029',
	'gep_gen003_077_240423_153121',
	'gep_gen003_085_240430_214105',
	'gep_gen003_095_240430_214117',
	'gep_gen003_104_240427_162433',
	'gep_gen003_130_240427_162508',
	'gep_gen003_150_240430_214240',
	'gep_gen004_010_240423_183212',
	'gep_gen004_027_240426_184757',
	'gep_gen004_043_240427_173413',
	'gep_gen004_160_240427_173834',
	'gep_gen005_066_240427_183146',
	'gep_gen005_082_240426_191758',
	'gep_gen005_091_240427_183233',
	'gep_gen006_069_240423_215522',
	'gep_gen006_075_240423_215546',
	'gep_gen006_092_240423_215610',
	'gep_gen006_092_240428_115653',
	'gep_gen006_176_240428_115916',
	'gep_gen007_001_240428_152745',
	'gep_gen007_026_240428_152809',
	'gep_gen007_036_240428_152832',
	'gep_gen007_058_240428_152856',
	'gep_gen007_118_240428_153007',
	'gep_gen007_143_240428_153043',
	'gep_gen008_048_240428_163357',
	'gep_gen008_050_240424_104340',
	'gep_gen008_160_240428_163843',
	'gep_gen008_197_240428_164006',
	'gep_gen009_051_240420_184453',
	'gep_gen010_028_240421_105240',
	'gep_gen010_095_240424_181931',
	'gep_gen012_031_240421_125916',
	'gep_gen012_031_240424_210552',
	'gep_gen013_044_240421_150205',
	'gep_gen013_091_240425_082044',
	'gep_gen014_084_240425_084533',
	'gep_gen015_030_240425_212756'
].size
)





elektroelu
(
[
'gep_gen001_003_240419_144047',
'gep_gen001_017_240419_144123',
'gep_gen001_023_240419_144135',
'gep_gen001_033_240414_213422',
'gep_gen001_037_240414_213433',
'gep_gen001_052_240413_164246',
'gep_gen001_061_240419_144321',
'gep_gen002_013_240419_154035',
'gep_gen002_024_240419_154047',
'gep_gen002_026_240419_154111',
'gep_gen002_027_240419_154123',
'gep_gen002_062_240419_154333',
'gep_gen002_065_240413_210155',
'gep_gen003_005_240413_211525',
'gep_gen003_013_240415_093006',
'gep_gen003_039_240419_170249',
'gep_gen003_040_240413_211635',
'gep_gen003_055_240415_192656',
'gep_gen003_062_240415_093252',
'gep_gen003_064_240415_192708',
'gep_gen004_005_240419_174503',
'gep_gen004_009_240419_174515',
'gep_gen004_024_240418_075658',
'gep_gen004_026_240418_075721',
'gep_gen004_030_240413_215848',
'gep_gen004_035_240418_075757',
'gep_gen004_051_240413_215911',
'gep_gen004_061_240413_215923',
'gep_gen005_009_240413_225025',
'gep_gen005_023_240413_225037',
'gep_gen005_052_240418_082654',
'gep_gen005_057_240419_180459',
'gep_gen005_069_240418_082717',
'gep_gen006_025_240414_002702',
'gep_gen006_031_240414_002726',
'gep_gen006_034_240419_111936',
'gep_gen006_041_240419_190023',
'gep_gen006_042_240414_002750',
'gep_gen006_064_240419_112123',
'gep_gen006_066_240414_002837',
'gep_gen007_001_240419_192027',
'gep_gen007_019_240419_125152',
'gep_gen007_026_240419_125215',
'gep_gen007_047_240419_192249',
'gep_gen007_055_240414_115628',
'gep_gen007_068_240419_192325',
'gep_gen008_041_240419_210233',
'gep_gen009_003_240414_130009',
'gep_gen009_026_240420_184342',
'gep_gen009_032_240414_130155',
'gep_gen011_009_240414_141635',
'gep_gen011_059_240414_141909',
'gep_gen013_029_240414_152143',
'gep_gen013_050_240414_152330',
'gep_gen013_060_240414_152353',
'gep_gen014_025_240414_155021',
'gep_gen014_043_240414_155132',
'gep_gen014_064_240414_155207',
'gep_gen014_072_240414_155231',
'gep_gen015_018_240414_161430',
'gep_gen015_065_240414_161553',
'gep_gen016_008_240414_163844',
'gep_gen017_037_240414_174329',
'gep_gen018_018_240414_180404',
'gep_gen019_045_240414_184839',
'gep_gen020_046_240414_195051',
'gep_gen021_042_240414_204147'
].size
)


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