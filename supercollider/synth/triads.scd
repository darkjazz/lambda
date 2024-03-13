~makeScale = {|note = "a", octave = 0|
	var degs, freqs, fund, mul;
	mul = 2**octave;
	fund = (note ++ " 3").notemidi.midicps;
	degs = Scale.minor.degrees;
	freqs = Array.geom(12, fund, 2**(1/12))[degs] * mul;
	freqs.collect(_.nearestPrime)
}

Tdef('scales', {
	"cdefgab".do({|l|
		var scale, dur;
		dur = 0.5;
		scale = ~makeScale.(l, 1);
		Pbind('freq', Pseq(scale), 'dur', dur).play;
		(scale.size * dur + 1).wait
	})
}).play


Tdef('chords', {
	var keys, dur = 0.25;
	keys = "abcdefg".scramble.keep(3);
	keys = Pseq(keys ++ keys[0], inf).asStream;
	loop({
		var scale;
		scale = ~makeScale.(keys.next, 1);
		Pbind('freq', Pseq(scale.scramble.keep(3) ! 4), 'dur', dur).play;
		(dur * 4).wait
	})
}).play


Tdef('triads', {
	var keys, dur = 0.125;
	keys = "abcdefg".scramble.keep(3);
	keys = Pseq(keys ++ keys[0], inf).asStream;
	loop({
		var scale;
		scale = ~makeScale.(keys.next, 1);
		Pbind('freq', Pseq(scale[[0, 2, 4]], 4), 'dur', dur).play;
		(dur * 3 * 4).wait
	})
}).play


Tdef(\triads).clear


Server.killAll



