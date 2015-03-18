(
~ncoef = 20;
~dur = 8 * 60;
~dim = 20;
~decoder = FoaDecoder(decoderType: 'quad');
~input = MikroFoaInput(~decoder, "/Users/alo/sounds/voice/2012/8MinVersion1.aiff");

~graphics = CinderApp();
~analyzer = MikroAnalyzer(maxdur: ~dur, numcoef: ~ncoef, recordInput: false, isMono: false);

~mikro = Mikro(~input, ~graphics, ~analyzer);
~geenLambda = GeenLambda(~mikro, ~decoder, ~dur);

~geenLambda.prepare

)


~mikro.initPerformance(0);

~geenLambda.start

24**3



s.queryAllNodes

// test events

~geen = ~geenLambda.geen

~geen.freqSet.dict.keys
~geen.ampSet.dict.keys
~geen.intervalSet.dict.keys.size
~geen.clusterSet.dict.keysValuesDo({|key, val|
	Post << key << ": " << val << Char.nl
})


~geen.initializeChain

~geen.prepareSequence(8)

~geen.currentSequence.collect(_.cluster)

SynthDef(\mtrxbass, {|out, freq, dur, amp, wbl|
	var sig, swp, env, bf;
	swp = SinOsc.ar(wbl).exprange(40, 500);
	sig = LFSaw.ar(freq*[0.99,1,1.01]).sum;
	sig = LPF.ar(sig, swp);
	sig = Normalizer.ar(sig);
	sig = sig + GVerb.ar(sig,10,0.5,0.7,mul:0.5);
	sig = Decimator.ar(sig, 44100/4, 8, LFPulse.ar(freq/2).range(0.1,1));
	sig = (sig.distort + tanh(sig**0.8)) * 
		EnvGen.kr(Env.perc(0.1,1,1,16), timeScale: dur, doneAction: 2);
	Out.ar(0,sig*amp)
}).add;

(

~events = Array();
~events = ~events.add(
	(
	amp: ~geen.ampSet.dict.keys.choose, 
	freq: ~geen.freqSet.dict.keys.choose, 
	dur: ~geen.durSet.dict.keys.choose,
	delta: ~geen.intervalSet.dict.keys.choose
	)
);


16.do({|i|
	~events = ~events.add((
		amp: ~geen.ampSet.next(~events[i].amp) ? ~geen.ampSet.dict.keys.choose, 
		freq: ~geen.freqSet.next(~events[i].freq) ? ~geen.freqSet.dict.keys.choose, 
		dur: ~geen.durSet.next(~events[i].dur) ? ~geen.durSet.dict.keys.choose,
		delta: ~geen.intervalSet.next(~events[i].delta) ? ~geen.intervalSet.dict.keys.choose
	
	))
});

~events.do(_.postln);

p = Pbind(
	\instrument, \mtrxbass,
	\freq, Pseq(~events.collect(_.freq) , 4),
	\amp, Pseq(~events.collect(_.amp), 4),
	\dur, Pseq(~events.collect(_.dur), 4),
	\delta, Pseq(~events.collect(_.delta), 4),
	\wbl, Pseq([Pshuf(7.fib, 16)], 4)
).play
)

~events.collect(_.dur).sum / 2



(
~events = [
( 'freq': 359.4614, 'dur': 0.234375, 'delta': 0.15625, 'amp': 1.765625 ),
( 'freq': 89.86535, 'dur': 0.125, 'delta': 0.171875, 'amp': 1.71875 ),
( 'freq': 61.73541, 'dur': 0.15625, 'delta': 0.171875, 'amp': 1.65625 ),
( 'freq': 43.65353, 'dur': 0.15625, 'delta': 0.1875, 'amp': 1.421875 ),
( 'freq': 43.65353, 'dur': 0.140625, 'delta': 0.15625, 'amp': 0.78125 ),
( 'freq': 43.65353, 'dur': 0.25, 'delta': 0.125, 'amp': 0.578125 ),
( 'freq': 44.93267, 'dur': 0.15625, 'delta': 0.140625, 'amp': 0.171875 ),
( 'freq': 44.93267, 'dur': 0.125, 'delta': 0.15625, 'amp': 0.1875 ),
( 'freq': 43.65353, 'dur': 0.203125, 'delta': 0.140625, 'amp': 0.140625 ),
( 'freq': 43.65353, 'dur': 0.140625, 'delta': 0.125, 'amp': 0.125 ),
( 'freq': 53.43426, 'dur': 0.140625, 'delta': 0.15625, 'amp': 0.15625 ),
( 'freq': 349.22823, 'dur': 0.15625, 'delta': 0.125, 'amp': 0.171875 ),
( 'freq': 349.22823, 'dur': 0.15625, 'delta': 0.15625, 'amp': 0.1875 ),
( 'freq': 329.62756, 'dur': 0.28125, 'delta': 0.140625, 'amp': 0.125 ),
( 'freq': 320.2437, 'dur': 0.296875, 'delta': 0.140625, 'amp': 0.15625 ),
( 'freq': 320.2437, 'dur': 0.15625, 'delta': 0.140625, 'amp': 0.109375 ),
( 'freq': 246.94165, 'dur': 0.140625, 'delta': 0.125, 'amp': 0.09375 )

]

[
( 'freq': 55, 'dur': 0.953125, 'delta': 0.53125, 'amp': 1.265625 ),
( 'freq': 47.60451, 'dur': 0.328125, 'delta': 0.25, 'amp': 1.375 ),
( 'freq': 48.99943, 'dur': 0.296875, 'delta': 0.125, 'amp': 0 ),
( 'freq': 48.99943, 'dur': 0.15625, 'delta': 0.15625, 'amp': 0.046875 ),
( 'freq': 51.91309, 'dur': 0.15625, 'delta': 0.25, 'amp': 0.0625 ),
( 'freq': 100.87044, 'dur': 0.15625, 'delta': 0.1875, 'amp': 0.234375 ),
( 'freq': 59.97793, 'dur': 0.21875, 'delta': 0.15625, 'amp': 0.890625 ),
( 'freq': 71.32618, 'dur': 0.25, 'delta': 0.15625, 'amp': 1.765625 ),
( 'freq': 50.43522, 'dur': 0.265625, 'delta': 0.15625, 'amp': 0.09375 ),
( 'freq': 50.43522, 'dur': 0.1875, 'delta': 0.15625, 'amp': 0.25 ),
( 'freq': 55, 'dur': 0.125, 'delta': 0.1875, 'amp': 0.234375 ),
( 'freq': 51.91309, 'dur': 0.203125, 'delta': 0.25, 'amp': 0.625 ),
( 'freq': 127.0888, 'dur': 0.15625, 'delta': 0.140625, 'amp': 0.421875 ),
( 'freq': 195.99772, 'dur': 0.171875, 'delta': 0.140625, 'amp': 0.4375 ),
( 'freq': 146.83238, 'dur': 0.46875, 'delta': 0.140625, 'amp': 0.828125 ),
( 'freq': 213.73703, 'dur': 0.421875, 'delta': 0.140625, 'amp': 0.59375 ),
( 'freq': 254.17759, 'dur': 0.484375, 'delta': 0.15625, 'amp': 0.328125 )
]

~events = [
( 'freq': 452.89298, 'dur': 0.5625, 'delta': 0.296875, 'amp': 0.1875 ),
( 'freq': 538.58356, 'dur': 0.5625, 'delta': 0.1875, 'amp': 0.028125 ),
( 'freq': 640.4874, 'dur': 0.390625, 'delta': 0.15625, 'amp': 0.578125 ),
( 'freq': 8869.84419, 'dur': 0.140625, 'delta': 0.140625, 'amp': 0.040625 ),
( 'freq': 174.61412, 'dur': 0.125, 'delta': 0.15625, 'amp': 0.359375 ),
( 'freq': 80.06093, 'dur': 0.171875, 'delta': 0.15625, 'amp': 0.125 ),
( 'freq': 47.60451, 'dur': 0.34375, 'delta': 0.1875, 'amp': 0.078125 ),
( 'freq': 59.97793, 'dur': 0.296875, 'delta': 0.21875, 'amp': 0.015625 ),
( 'freq': 100.87044, 'dur': 0.171875, 'delta': 0.15625, 'amp': 0.015625 ),
( 'freq': 69.29566, 'dur': 0.171875, 'delta': 0.140625, 'amp': 0.046875 ),
( 'freq': 50.43522, 'dur': 0.34375, 'delta': 0.125, 'amp': 0.03125 ),
( 'freq': 58.27047, 'dur': 0.3125, 'delta': 0.125, 'amp': 0.015625 ),
( 'freq': 63.5444, 'dur': 0.15625, 'delta': 0.28125, 'amp': 0.0625 ),
( 'freq': 67.32294, 'dur': 0.15625, 'delta': 0.265625, 'amp': 0.0625 ),
( 'freq': 75.56745, 'dur': 0.5625, 'delta': 0.203125, 'amp': 0.09375 ),
( 'freq': 84.8216, 'dur': 0.5625, 'delta': 0.171875, 'amp': 0.40625 ),
( 'freq': 103.82617, 'dur': 0.140625, 'delta': 0.328125, 'amp': 0.84375 )
]

)