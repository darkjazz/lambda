Ndef(\hit, {|rate=60,size=20,rule=30,del=0.0625,amp=0.3,dur=0.3,freq=59|
	var trig;
	trig = Impulse.kr(1);
	(VarSaw.ar(Select.kr(TIRand.kr(0,7), Array.primesN(7, 60)), 0.25, 0.01, 20).clip(-0.5, 0.5)).dup 
		* EnvGen.kr(Env.perc, trig, timeScale: dur)
})

(181*2).nextPrime
5423.nextPrime
588.nextPrime
(181+30).nextPrime
764.prevPrime
(23**2).asInt.nextPrime
(13*4+7).asInt.nextPrime

(443+100).asInt.nextPrime

Ndef(\efx, {|amp=0.1, del=0.25, rmp=0.1, rt=4.0|
	var input, sig, n = 5;
	input = Ndef.ar(\hit) * amp;
	sig = Decimator.ar(DelayL.ar(input, del, del), 8800, 8);
	sig = Decimator.ar(Reverb.ar(sig * rmp, rt), 44100, 24);
	input.dup + sig.dup
}).ar(2)



Ndef(\hit).play

Ndef(\hit).stop

Ndef(\hit).clear

Ndef('efx').stop

Ndef(\efx).play

Ndef(\efx).set(\amp, 1.0, \del, 0.25, \rmp, 0.1, \rt, 2.0)



{Out.ar(0,Pan2.ar(0.5*TermanWang.ar(2.0,Impulse.kr(MouseX.kr(1,1000)),0.1,0.01,1.0,1.0,1.0,MouseX.kr(0.4,1.2), MouseY.kr(2.0,4.0)),0.0))}.play;

(
{Out.ar(0,Pan2.ar(

CombN.ar(
Resonz.ar(DoubleWell.ar(Impulse.kr(2),MouseX.kr(0.01,1,'exponential'),MouseY.kr(0.01,1,'exponential'),3.9,MouseX.kr(0.0001,0.01,'exponential'),0.25,LFNoise0.kr(1,0.4,0.5),LFNoise0.kr(1,10.4,10.5)),500,0.1),
0.05,0.05,2
)
,0.0))}.play
)

rrand(16, 32).round()

Array.geom(5, 16.0, 2**(1/5))



Ndef(\hit).set(\dur, 0.1)

Ndef(\hit).set(\rate,440,\size,200,\rule,165,\del,0.01,\amp,0.6)

Ndef(\efx).clear
165.asCA

{ Logist0.ar(1000 * IRand(1, 5), 1.8) }
{ CML0.ar(Select.kr(TIRand.kr(0, 4, trig), Scale.jiao.ratios * 120), 1.2, 0.05, 1.0) }
{ GCM0.ar(Select.kr(TIRand.kr(0, 4, trig), Scale.jiao.ratios * 880), 1.5, 0.01) }
{ HCM0.ar(Select.kr(TIRand.kr(0, 4, trig), Scale.jiao.ratios * 256), 1.1, 0.3) }
{ Nagumo.ar(0.01, 0.01, LFPulse.ar(10).range(0, 1)) }
{ FIS.ar(LFSaw.ar(4).range(1,4),LFNoise0.ar(10).abs,SinOsc.ar(2**11).range(1,10).round(1)) }
{ CombN.ar(CA1.ar(800,20,SinOsc.kr(30, 0.5pi).range(30, 60).round(1)),0.2,0.125,0.25) }
{ Mix(GVerb.ar(LPF.ar(Impulse.ar(1),800,20),5)) }

{ Logist0.ar(50 * IRand(1, 5), 1.1) }
{ CML0.ar(Select.kr(TIRand.kr(0, 4, trig), Scale.jiao.ratios * 880), 1.99, 0.01, 0.1) }
{ GCM3.ar(Select.kr(TIRand.kr(0, 4, trig), Scale.jiao.ratios * 660), 1.7, 0.1) }
{ HCM3.ar(Select.kr(TIRand.kr(0, 4, trig), Scale.jiao.ratios * 1024), 1.99, 0.8) }
{ Nagumo.ar(0.01, 0.001, LFPulse.ar(110).range(0, 1)) }
{ FIS.ar(LFSaw.ar(1).range(1,4),Crackle.ar(1.99).abs,LFSaw.ar(64).range(1,10).round(1)) }
{ Mix(DelayN.ar(CombN.ar(CA1.ar(440,200,165),0.2,0.01,0.2),0.05,(0.01,0.02..0.04))) }
{ Mix(GVerb.ar(HPF.ar(Impulse.ar(1),500,20),5)) }