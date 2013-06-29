(
~gepnames = [
	'gep_gen000_023_120524_202530',
	'gep_gen000_040_120526_001019',
	'gep_gen000_048_120617_122928',
	'gep_gen000_074_120524_193125',
	'gep_gen001_009_120523_232519',
	'gep_gen001_029_120525_224745',
	'gep_gen001_035_120525_232458',
	'gep_gen001_050_120615_144459',
	'gep_gen001_062_120523_232604',
	'gep_gen001_073_120523_232614',
	'gep_gen002_038_120525_123932',
	'gep_gen002_059_120621_001420',
	'gep_gen003_051_120525_230443',
	'gep_gen003_084_120618_093408',
	'gep_gen005_031_120525_235055',
	'gep_gen005_092_120524_003017',
	'gep_gen000_035_120525_121508',
	'gep_gen001_083_120524_142451',
	'gep_gen001_088_120621_105144',
	'gep_gen002_043_120617_124311',
	'gep_gen003_022_120619_122458',
	'gep_gen003_039_120619_122503',
	'gep_gen003_051_120525_230443',
	'gep_gen003_084_120618_093408',
	'gep_gen004_016_120619_163415',
	'gep_gen004_026_120619_124255',
	'gep_gen005_095_120621_134612',
	'gep_gen006_019_120523_223408'
];

)

(
~gepnames.do({|name|
	var source, target;
	source = ("/Users/alo/Data/gep/synthdefs" +/+ name ++ ".scsyndef").pathMatch.first;
	target = ("/Users/alo/Data/subgep/synthdefs" +/+ name ++ ".scsyndef");
	("cp" + source + target).unixCmd
})
)

(
~gepnames.do({|name|
	var source, target;
	source = ("/Users/alo/Data/gep/metadata" +/+ name ++ ".gepmeta").pathMatch.first;
	target = ("/Users/alo/Data/subgep/metadata" +/+ name ++ ".gepmeta");
	("cp" + source + target).unixCmd
})
)