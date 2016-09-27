SynthDef('vox', {|efx|
	var input;
	input = SoundIn.ar(0);
	Out.ar(efx, input);
	Out.ar(0, input.dup)
}).add

z = Synth.tail(~matrix.efxgroup, 'vox', ['efx', ~decoder.bus])

Ndef('vox', {
	SoundIn.ar(0).dup
})

.play

Ndef('vox').clear

Server.killAll

Quarks.gui