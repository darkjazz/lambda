(
~dfile = File.open("/home/alo/development/lambda/supercollider/sparsematrix/2014-01-01/defnames00.scd", "r");
~defarray = ~dfile.readAllString.split(Char.nl).reject(_.isEmpty).collect(_.asSymbol);
~dfile.close;
~dfile = nil;

~data = ~defarray.collect({|defname|
	var path, meta, data;
	path = Paths.gepArchDir +/+ defname.asString ++ "." ++ UGEP.fileExt;
	if (File.exists(path)) { data = UGEP.loadData(path) };
	meta = UGenExpressionTree.loadMetadata(defname);
	data['defname'] = defname;
	data['args'] = meta.args.args;
	data['stats'] = meta.stats;
	data
});
)

(
~makeGepDef = {|name, func, nargs = 8|
	SynthDef(name, {|out, efx, dur = 0.1, amp = 1.0, emp = 0.0, rotx = 0.0, roty = 0.0, rotz = 0.0|
		var sig;
		sig = tanh(LeakDC.ar(SynthDef.wrap(func, prependArgs: ArrayControl.kr('gepargs', nargs, 0.0) ) ) ) * 0.9
			* EnvGen.kr(EnvControl.kr, timeScale: dur, doneAction: 2);
		Out.ar(efx, sig * emp);
		Out.ar(out, FoaTransform.ar(
			FoaEncode.ar(sig * amp, FoaEncoderMatrix.newDirection), 'rtt', rotx, roty, rotz)
		)
	}).add;
};


~addGepSynthDef = {|dataitem|
	var fnc, chrom, str;
	chrom = GEPChromosome(dataitem.code, dataitem.terminals, dataitem.header.numgenes, dataitem.linker);
	str = chrom.asUgenExpressionTree.asFunctionString;
	fnc = str.interpret;
	{
		~makeGepDef.(dataitem.defname, fnc, dataitem.terminals.size);
	}.try({
		Post << "ERROR: " << str << Char.nl;
	})
}

)

Routine({


}).play