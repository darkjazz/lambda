(
~defs = [
	{|fr, dr| MoogFF.ar(Pulse.ar(fr*0.125, 0.3), SinOsc.kr(1/dr).range(fr, fr*2), 3.0 ) },
	{|fr, dr| PMOsc.ar(fr, SinOsc.kr(1/dr).range(fr, fr*2), LFSaw.kr(1/dr).range(3, 7) ) },
	{|fr, dr| Resonz.ar( Blip.ar(fr, (pi**pi).ceil), fr+Resonz.ar(Blip.ar(fr, (pi**pi).ceil), fr*0.5, 1/fr, pi), 1.exp**pi/fr, 1.exp**pi ) },
	{|fr, dr| BPF.ar( PinkNoise.ar, fr, XLine.kr(pi**pi, pi, dr) / fr, pi**pi )},
	{|fr, dr| VarSaw.ar(LFSaw.kr(pi*pi).range(fr*0.9, fr*1.1), 0, LFTri.kr(pi).range(0.1, 0.9))},
	{|fr, dr| Pulse.ar(SinOsc.kr(pi).range(0.9*fr,1.1*fr), LFSaw.kr(2.exp).range(0.8, 0.2)).distort },
	{|fr, dr| LFNoise1.ar(fr, SinOsc.kr(pi**pi).range(0, 1)) + Dust2.ar(fr) }
];

~defs.do({|fnc, i|
	Sd(("s"++i.asString).asSymbol, {|ou, fr, am, dr, pn|
		Out.ar(ou, Pan2.ar( Sd.wrap(fnc, prependArgs: [fr, dr] )
			* EnvGen.kr(Env.perc, timeScale: dr, levelScale: am, doneAction: 2), pn ))
	}).add
});

~noct = 7;
~lof = 47;
~odiv = 12;
~bps = 111 / 60;
~delta = ~bps.reciprocal / 8;

~fnd = Array.geom(~noct, ~lof, 2);
~frq = ~fnd.collect({|fnd|
	Array.geom(~odiv, fnd, 2**(1/~odiv))[Scale.minor.degrees].collect(_.nearestPrime)
}).reverse;

~amps = Array.fill(~defs.size, 0.4);

~tp = [
	(Eucl(3, 16) ++ Eucl(2, 16)).mirror2 ,
	(Eucl(7, 16) ++ Eucl(3, 16) ++ Eucl(5, 16) ++ Eucl(1, 16).rotate(4)),
	(Eucl(3, 16).rotate ++ Eucl(2, 16) ++ Eucl(3, 16) ++ Eucl(2, 16)).rotate(8),
	(Eucl(7, 16).rotate(4) ++ Eucl(1, 16).rotate(16)).mirror2,
	Array.fill(4, {|i| Eucl(i+1, 8) }).dup.flat.rotate(12),
	(Eucl(7, 16).rotate(1) ++ Eucl(1, 16).rotate(16)).mirror2,
	Eucl(4, 64)
];

~pds = Array.fill(~defs.size, {|i|
	Pd(("p"++i.asString).asSymbol, Pb(
		\instrument, ("s"++i.asString).asSymbol,
		\fr, Ps(~frq[i].scramble.keep(4.rand+1), inf),
		\dr, Pwhite(rrand(0.3, 0.5), rrand(0.5, 0.8), inf),
		\am, Pfunc({ ~amps[i] }),
		\pn, Pwhite(-1.0, 1.0),
		\type, Pseq(~tp[i], inf),
		\delta, Pfunc({ ~delta })
	)).quant(64)
});

Pd(\mix, Pp(~pds))
)


Pd(\mix).play

(
~bps = 111 / 60;
~delta = ~bps.reciprocal / 8;
)

~amps[0] = 0.5



Pd(\p1, Pb(\instrument, \s1,
	\fr, Ps(~fr1.scramble.keep(3), inf),
	\am, 1.0,
	\dr, Ps(~p2.collect({|nm| if (nm == 0) { \r } { nm } }), inf),
	\type,
	\delta, Pfunc({ ~delta }) ));


Pd(\p2, Pb(\instrument, \s2,
	\fr, Ps(~fr1.scramble, inf),
	\am, 0.3,
	\dr, Ps(~p1.collect({|nm| if (nm == 0) { \r } { nm } }), inf),
	\delta, Pfunc({ ~delta })  ));


Pd(\p3, Pb(\instrument, \s3,
	\fr, Ps(~fr2.scramble.keep(4), inf),
	\am, 1.0,
	\dr, Ps(~p3.collect({|nm| if (nm == 0) { \r } { nm } }), inf),
	\delta, Pfunc({ ~delta })  ));

Pd(\p4, Pb(\instrument, \s4,
	\fr, Ps(~fr4.scramble.keep(2), inf),
	\am, 1.0,
	\dr, Ps(~p4.collect({|nm| if (nm == 0) { \r } { nm } }), inf),
	\delta, Pfunc({ ~delta })  ));

