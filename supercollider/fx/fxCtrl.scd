(
~graphics = CinderApp();

~loadstruct = (
	detloop: (1..16), 
	fbloop: (0..7),
	monooop: [3, 4, 5, 6, 15, 22, 33, 36],
	sume: [27, 28, 3, 4, 7, 8, 12, 13],
	nime: [14, 15, 16, 17, 5, 6, 7, 9],
	tehis: [15, 19, 21, 23, 25, 28, 40, 42],
	fxloop: [0, 11, 22, 23, 24, 25, 26, 27]
);

~loops = ~loadstruct.collect({|inds, key|
	("/Users/alo/sounds/fx_loops/" ++ key.asString ++ "*").pathMatch[inds].collect({|path|
		Buffer.read(s, path)
	})
});

~loops['detloop2'] = ~loops['detloop'].drop(8);
~loops['detloop'] = ~loops['detloop'].keep(8);

~loopstreams = 4.collect({
	(
		current: 'detloop',
		stream: Pseq(['detloop', 'detloop2', 'fbloop', 'monooop', 'sume', 'nime', 'tehis', 'fxloop'], inf).asStream
	)
});

~fxdef = SynthDef(\zone01wrp, {|out, efx, amp, aamp, eamp, dur, buf, str, end, wrp, frq, rate, wsz, dns, rnd, xang, yang, zang|
	var ptr, sig, src, bf, filter, fft, af, del;
	filter = [ [BLowShelf, 100, 0.65], [BPeakEQ, 600, 2], [BPeakEQ, 2000, 2], [BHiShelf, 7500, 1] ];
	del = ArrayControl.kr(\del, 4, 1);
	ptr = LFSaw.kr(wrp).range(str, end);
	src = Normalizer.ar(LeakDC.ar(Warp1.ar(1, buf, ptr, frq*rate, wsz, -1, dns, rnd), 0.995, aamp), amp);
//	Out.ar(efx, src * eamp);
	sig = Mix.fill(4, {|i|
		DelayC.ar(filter[i][0].ar(src, filter[i][1], filter[i][2]), delaytime: del[i] )
	});
	fft = FFT(LocalBuf(1024), sig);
	af = Array.fill(4, {
		IFFT(PV_Diffuser(fft, Dust.kr(Rand(10.0, 20.0))))
	});
	bf = FoaEncode.ar(af, FoaEncoderMatrix.newAtoB);
	Out.ar(out, FoaTransform.ar(bf, 'rtt', xang, yang, zang))
}, metadata: (
	maps: (
		aamp: Array.fill(8, { ControlSpec(0.3, 1.0, \exp) }),
		str: Array.fill(8, { ControlSpec(0.0, 0.5) }),
		end: Array.fill(8, { ControlSpec(0.5, 1.0) }),
		eamp: Array.fill(8, { ControlSpec(8.0, 1.0) }),
		rate: Array.fill(8, { ControlSpec((35/36)**2, (35/36)**2, 'lin', 36/35) }),
		xang: Array.fill(8, {|i| ControlSpec((0 + (pi/7*i)).wrap(0, 2pi) - pi, (pi+(pi/7*i)).wrap(0, 2pi) - pi) }),
		yang: Array.fill(8, {|i| ControlSpec((0 + (pi/7*i)).wrap(0, 2pi) - pi, (pi+(pi/7*i)).wrap(0, 2pi) - pi) }),
		zang: Array.fill(8, {|i| ControlSpec((0 + (pi/7*i)).wrap(0, 2pi) - pi, (pi+(pi/7*i)).wrap(0, 2pi) - pi) })
	);
)).add;

~mapSynths = {|values|
	var states = values.clump(8);
	if (~fxsynths.notNil) {
		~fxsynths.do({|ev, i|
			var args, stream = Pseq(states.wrapAt(i), inf).asStream;
			args = ~fxdef.metadata.maps.collect({|array| array.wrapAt(i).map(stream.next) });
			ev['synth'].set(*args.asKeyValuePairs)
		})
	}
};

~fxReady = false;

~prepareFx = {
	Routine({
		~graphics.open;
		1.wait;
		~decoder = ~decoder ? FoaDecoder();
		Server.default.sync;
		~decoder.start;
		Server.default.sync;		
		~agrp = Group.before(~decoder.synth);
		Server.default.sync;
		~freqs = Array.geom(8, 0.125, 55/34);
		~fxsynths = 8.collect({|i|
			(
			active: false,
			synth: Synth.newPaused(\zone01wrp, [\out, ~decoder.bus, \amp, 0, \efx, 511, \gate, 1.0, 
				\aamp, 0.5, \eamp, 0.1, \dur, 1.0, \buf, ~loops['detloop'][i], \str, 0, \end, 1.0, 
				\wrp, 0.001, \frq, ~freqs@i, \rate, 1.0, \wsz, 0.1, \dns, rrand(2, 10), \rnd, 0.01, 
				\doneAction, 2], ).setn(\del, [0.0, 0.001, 0.002, 0.003], ~agrp)
			)
		});
		0.25.wait;
		~graphics.initWorld(24, 24, 24, 8);
		0.25.wait;
		~graphics.initContinuous;
		0.25.wait;
		~graphics.setAdd(0.05);
		~graphics.resetWorld(9, 9, 9, 4, 4, 4);
		0.25.wait;
		~mapiPhone.();
		2.wait;
		~graphics.queryStates(QueryStates.sides2D(~graphics.world.sizeX, 4), {|msg|
			~mapSynths.(msg.drop(1))
		});		
		"f(x) initialized".postln;
	}).play
};

~cleanup = {
	~graphics.stopQuery;
	~graphics.stopRotation;
	~fxsynths.do({|ev| ev['synth'].free;  });
	~fxsynths = nil;
	~decoder.free;
	~oscfncs.do(_.disable);
	~agrp.free;
	~loops.do({|lib|
		lib.do(_.free);
	});
	~loops = nil;
	SystemClock.sched(3, {
		~graphics.quit;
		~nano.knobs[0].do({|ctr| ctr.action = {}  });
		~nano.sliders[0].do({|ctr| ctr.action = {}  });
		~nano.buttons[0].do({|ctr| ctr.action = {}  });
		"Cleanup finished".postln;
		nil
	})
};

~mapNANO = {
	var addspec, interspec, ampspec;
	~nano = NanoKONTROL();
	addspec = ControlSpec(0.001, 0.999, \cos);
	interspec = ControlSpec(1, 24, 'lin', 1);
	ampspec = FaderWarp();
	~nano.knobs[0][0].action = {|knob|
		if (knob.value > 0.1) {
			~graphics.setPattern(0, 1, knob.value, 0, 0, 0.6, 0.8, 1.0);
		}
		{
			~graphics.setPattern(0, 0, knob.value, 0, 0, 0.6, 0.8, 1.0);
		}
	}; 
	~nano.knobs[0][1].action = {|knob|
		if (knob.value > 0.1) {
			~graphics.setPattern(1, 1, knob.value, 1, 1, 0.9, 0.1, 0.4);
		}
		{
			~graphics.setPattern(1, 0, knob.value, 1, 1, 0.9, 0.1, 0.4);
		}
	}; 
	~nano.knobs[0][2].action = {|knob|
		if (knob.value > 0.1) {
			~graphics.setPattern(2, 1, knob.value, 0, 0, 0.8, 0.8, 0.85);
		}
		{
			~graphics.setPattern(2, 0, knob.value, 0, 0, 0.8, 0.8, 0.85);
		}
	};
	~nano.knobs[0][3].action = {|knob|
		if (knob.value > 0.1) {
			~graphics.setPattern(3, 1, knob.value, 1, 1, 0.6, 0.8, 0.8);
		}
		{
			~graphics.setPattern(3, 0, knob.value, 1, 1, 0.6, 0.8, 0.8);
		}
	};
	~nano.knobs[0][4].action = {|knob|
		if (knob.value > 0.1) {
			~graphics.setPattern(4, 1, knob.value, 0, 0, 1.0, 1.0, 0.3);
		}
		{
			~graphics.setPattern(4, 0, knob.value, 0, 0, 1.0, 1.0, 0.3);
		}
	};
	
	~nano.knobs[0][5].action = {|knob|
		~graphics.setAdd( addspec.map(knob.value)); 
	};
	~nano.knobs[0][6].action = {|knob|
		~graphics.setInterpolation(1, interspec.map(knob.value).asInt); 
	};
	~nano.knobs[0][7].action = {|knob|
		~graphics.setBackground(knob.value, knob.value, knob.value + 0.05); 
	};
	~nano.knobs[0][8].action = {|knob|

	};
	
	~nano.sliders[0][0].action = {|slider|
		if (~fxsynths.notNil) {
			~fxsynths[[0, 1]].do({|ev| 
				ev.active = slider.value > 0.1;
				ev['synth'].run(ev.active);
				ev['synth'].set('amp', ampspec.map(slider.value) ) 
			})
		}
	};

	~nano.sliders[0][1].action = {|slider|
		if (~fxsynths.notNil) {
			~fxsynths[[2, 3]].do({|ev| 
				ev.active = slider.value > 0.1;
				ev['synth'].run(ev.active);
				ev['synth'].set('amp', ampspec.map(slider.value) ) 
			})
		}
	};

	~nano.sliders[0][2].action = {|slider|
		if (~fxsynths.notNil) {
			~fxsynths[[4, 5]].do({|ev| 
				ev.active = slider.value > 0.1;
				ev['synth'].run(ev.active);
				ev['synth'].set('amp', ampspec.map(slider.value) ) 
			})
		}
	};

	~nano.sliders[0][3].action = {|slider|
		if (~fxsynths.notNil) {
			~fxsynths[[6, 7]].do({|ev| 
				ev.active = slider.value > 0.1;
				ev['synth'].run(ev.active);
				ev['synth'].set('amp', ampspec.map(slider.value) ) 
			})
		}
	};
	
	~nano.buttons[0][0].action = {|btn|
		if (btn.value == 0) {
			if (~fxsynths.notNil) {
				~loopstreams[0]['current'] = ~loopstreams[0]['stream'].next;
				Post << "synths 0 & 1 set to buffers " << ~loopstreams[0]['current'] << Char.nl;
				~fxsynths[0]['synth'].set(\buf, ~loops[~loopstreams[0]['current']][0]);
				~fxsynths[1]['synth'].set(\buf, ~loops[~loopstreams[0]['current']][1]);
			}
		}
	};

	~nano.buttons[0][1].action = {|btn|
		if (btn.value == 0) {
			if (~fxsynths.notNil) {
				~loopstreams[1]['current'] = ~loopstreams[1]['stream'].next;
				Post << "synths 2 & 3 set to buffers " << ~loopstreams[1]['current'] << Char.nl;
				~fxsynths[2]['synth'].set(\buf, ~loops[~loopstreams[1]['current']][2]);
				~fxsynths[3]['synth'].set(\buf, ~loops[~loopstreams[1]['current']][3]);
			}
		}
	};

	~nano.buttons[0][2].action = {|btn|
		if (btn.value == 0) {
			if (~fxsynths.notNil) {
				~loopstreams[2]['current'] = ~loopstreams[2]['stream'].next;
				Post << "synths 4 & 5 set to buffers " << ~loopstreams[2]['current'] << Char.nl;
				~fxsynths[4]['synth'].set(\buf, ~loops[~loopstreams[2]['current']][4]);
				~fxsynths[5]['synth'].set(\buf, ~loops[~loopstreams[2]['current']][5]);
			}
		}
	};

	~nano.buttons[0][3].action = {|btn|
		if (btn.value == 0) {
			if (~fxsynths.notNil) {
				~loopstreams[3]['current'] = ~loopstreams[3]['stream'].next;
				Post << "synths 6 & 7 set to buffers " << ~loopstreams[3]['current'] << Char.nl;
				~fxsynths[6]['synth'].set(\buf, ~loops[~loopstreams[3]['current']][6]);
				~fxsynths[7]['synth'].set(\buf, ~loops[~loopstreams[3]['current']][7]);
			}
		}
	};
	
	~nano.buttons[0][19].action = {|btn|
		if (btn.value == 1 and: { ~fxReady.not }) {
			~prepareFx.()
		}
	};
	
	~nano.buttons[0][22].action = {|btn|
		if (btn.value == 0) {
			~cleanup.()
		}
	}	

};

~mapiPhone = {
	~accActive = false;
	~radius = (min: 20.0, max: 200.0, step: 1.0, current: 100.0);
	~oscfncs = (
		acc: OSCFunc({|msg|
			var cx, cy, cz;
			if (~accActive) {
				cx = msg[1] * ~radius.current;
				cy = msg[2] * ~radius.current;
				cz = msg[3] * ~radius.current;
				~graphics.setViewpoint(cx, cy, cz, 0.0, 0.0, 0.0);
			};
		}, '/accxyz'),
		
		push1: OSCFunc({
			~radius.current = (~radius.current - ~radius.step).clip(~radius.min, ~radius.max);
		}, '/fxone/push1'),
		push2: OSCFunc({
			~radius.current = (~radius.current + ~radius.step).clip(~radius.min, ~radius.max);
		}, '/fxone/push2'),
		toggle1: OSCFunc({|msg|
			~accActive = msg[1].booleanValue;
			if (~accActive.not) {
				~rot = Rotation(rrand(40.0, 80.0), rrand(0.001, 0.01), rrand(40.0, 80.0), rrand(60.0, 120.0), 2pi.rand, 
					rrand(0.001, 0.01), 2pi.rand, rrand(0.001, 0.01));
				~graphics.setCameraRotation(~rot, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
				~graphics.rotateCamera;	
			}
			{
				~graphics.stopRotation;
			}
		}, '/fxone/toggle1')
	);
	
	
	
};

~mapNANO.();

)




~fx = FxLambda()

~graphics.open