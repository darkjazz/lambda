~sparsedata = UGepLoader(headsize: 12, numgenes: 2).load;

~sparsedata.keep(16).do({|item|
	~prepareGepDef.(item.defname, item.data)
});

~first = ~sparsedata.first

~prepareGepDef = {|name, dataitem|
	var fnc, chrom, str;
	chrom = GEPChromosome(dataitem.code, dataitem.terminals, 
		dataitem.header.numgenes, dataitem.linker);
	str = chrom.asUgenExpressionTree.asFunctionString;
	fnc = str.interpret;
	{
		~makeDef.(name, fnc, dataitem.terminals.size);
	}.try({
		Post << "ERROR: " << str << Char.nl;
	})	
};

~makeDef = {|name, func, nargs = 8|
	Post << "Making def " << name << Char.nl;
	SynthDef(name, {|out, efx, dur = 0.1, amp = 1.0, emp = 0.0, rotx = 0.0, roty = 0.0, rotz = 0.0| 
		var sig;
		sig = SynthDef.wrap(func, prependArgs: ArrayControl.kr('gepargs', nargs, 0.0) ) 
			* EnvGen.kr(EnvControl.kr, timeScale: dur, doneAction: 2);
		Out.ar(efx, sig * emp);
		Out.ar(out, FoaTransform.ar(
			FoaEncode.ar(sig * amp, FoaEncoderMatrix.newDirection), 'rtt', rotx, roty, rotz)
		)
	}).add;		
}

~prepareGepDef.(~first.defname, ~first.data)

~synth = Synth(~first.defname, [\amp, 0.1, \out, 0, \efx, 512, \dur, 5, \emp, 0])
	.setn(\env, Env.sine)
	.setn(\gepargs, ~first.args.args)