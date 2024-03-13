(
~ca = CA(OneDWorld.single(5*7, [0, 1], (5*7/2).asInt));
// ~ca = CA(OneDWorld.rand(5*7, [0, 1], 0.9));
~cellSize = 10;
~gens = 128;
// ~rule = 90;

~rules = Pstutter(16, Pseq([30], inf)).asStream;
~states = ~gens.collect({
	var states = ~ca.world.collect(_.state);
	~ca.next(~rules.next, 'clip');
	// ~ca.next(~rule, 'clip');
	states
});

~wn = Window("1d", Rect(20, 20, ~gens*~cellSize, ~ca.world.size*~cellSize)).front;
~vw = CompositeView(~wn, Rect(0, 0, ~gens*~cellSize, ~ca.world.size*~cellSize));
~wn.view.background = Color.grey(0.2);

~wn.drawFunc = {
	~states.do({|gen, y|
		gen.do({|state, x|
			if (state == 1) {
				Pen.color = Color.grey(0.8);
				Pen.fillRect(Rect(y*~cellSize, x*~cellSize, ~cellSize, ~cellSize ));
				Pen.color = Color.black;
				Pen.strokeRect(Rect(y*~cellSize, x*~cellSize, ~cellSize, ~cellSize ))

			}
		})
	})
};
~wn.refresh;
)

(
SynthDef('sinres', {|out, frq, dur, amp, dec, pan|
	var sig, frc, src;
	frc = frq*pi.exp().reciprocal;
	src = LFSaw.ar(frq+LFNoise2.kr(frq).range(frc.neg, frc));
	sig =  Ringz.ar(
		src,
		frq,
		dec);
	Out.ar(out, Pan2.ar(
		sig*EnvGen.kr(Env.perc, timeScale: dur, doneAction: 2), pan, amp)
	)
}).add;
~makeScale = {|note = "a", octave = 0|
	var degs, freqs, fund, mul;
	mul = 2**octave;
	fund = (note ++ " 3").notemidi.midicps;
	degs = Scale.dorian.degrees;
	freqs = Array.geom(12, fund, 2**(1/12))[degs] * mul;
	freqs.collect(_.nearestPrime)
};
~scale = 5.collect({|i|
	~makeScale.("d", i)
}).flat;

)
~sy = Synth('sinres', ['out', 0, 'frq', 247, 'dur', 2, 'amp', 1, 'dec', 0.001, 'pan', 0])

~makeScale.("f")

10.do({|i|
	(i*3).neg.dbamp.postln
});
-3.dbamp


Tdef('sinres').clear

(
Tdef('sinres', {
	~delta = 1;
	~amp = 0.3;
	~states.do({|states, i|
		if ((i%4)==0) {
			var frqs = ~scale[states.selectIndices({|it, i| (it == 1).and((states.wrapAt(i+1) == 0).or (states.wrapAt(i-1) == 0) ) })];
			frqs.scramble.do({|frq|
				Synth('sinres', [
					'out', 0, 'frq', frq, 'dur', ~delta*rrand(0.9, 1.1),
					'dec', rrand(0.002, 0.007), 'pan', 0,
					'amp', 0.5 * (frqs.size * 3).neg.dbamp
				]);
				rrand(0.001, 0.005).wait;
			});
			~delta.wait
		}
	})
}).play
)

~scale[~states[0].selectIndices({|it| it == 1})]