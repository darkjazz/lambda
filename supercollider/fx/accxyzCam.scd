~graphics = CinderApp()
~graphics.open;

~graphics.initWorld(24, 24, 24, 8);

~graphics.initContinuous;

~graphics.setAdd(0.08);

~graphics.resetWorld(9, 9, 9, 4, 4, 4)

~graphics.setPattern(0, 1, 1.0, 1, 1, 0.6, 0.8, 1.0);

(
~mapiPhone = {
	~accActive = false;
	~acctr = (vals: [0.0, 0.0, 0.0], rates:[0.0, 0.0, 0.0], 
		vec: [0.0, 0.0, 0.0], loc: [40.0, 0.0, 0.0],
		min: -20.0, max: 20.0
	);	
	
	~min = 20.0;
	~max = 200.0;
	
	~oscfncs = (
		acc: OSCFunc({|msg|
			if (~accActive) {
				~acctr['rates'] = msg[1..3] - ~acctr['vals'];
				~acctr['vals'] = msg[1..3];
				~acctr['vec'] = ~acctr['vec'] + ~acctr['rates'];
				~acctr['loc'] = (~acctr['loc'] + ~acctr['vec']).clip(~acctr['min'], ~acctr['max']);
				~graphics.setViewpoint(~acctr['loc'][0], ~acctr['loc'][1], ~acctr['loc'][2], 0.0, 0.0, 0.0)
			};
		}, '/accxyz'),
		
		push1: OSCFunc({
			~acctr['min'] = (~acctr['min'] + 5.0).clip(~min.neg, ~max.neg);
			~acctr['max'] = (~acctr['max'] - 5.0).clip(~min, ~max);
		}, '/fxone/push1'),
		push2: OSCFunc({
			~acctr['min'] = (~acctr['min'] - 5.0).clip(~min.neg, ~max.neg);
			~acctr['max'] = (~acctr['max'] + 5.0).clip(~min, ~max);
		}, '/fxone/push2'),
		toggle1: OSCFunc({|msg|
			~accActive = msg[1].booleanValue;
		}, '/fxone/toggle1'),
		fader: OSCFunc({|msg|
			var value = msg[1].linlin(0.0, 1.0, ~min, ~max);
			msg.postln;
			~acctr['min'] = value.neg;
			~acctr['max'] = value;
		}, '/fxone/fader')

	)
	
};
)

~mapiPhone.()



~oscfncs.do(_.disable)
~oscfncs = nil



(
~roc = (vals: [0.0, 0.0, 0.0], rates:[0.0, 0.0, 0.0], 
	vec: [0.0, 0.0, 0.0], loc: [40.0, 0.0, 0.0], time: SystemClock.seconds);

f=OSCFunc({|msg|
	~roc['msgrate'] = (SystemClock.seconds - ~roc['time']).reciprocal;
	~roc['time'] = SystemClock.seconds;
	~roc['rates'] = msg[1..3] - ~roc['vals'];
	~roc['vals'] = msg[1..3];
	~roc['rates'].postln;
	~roc['vec'] = ~roc['vec'] + ~roc['rates'];
	~roc['loc'] = (~roc['loc'] + ~roc['vec']).clip(-100.0, 100.0);
	~graphics.setViewpoint(~roc['loc'][0], ~roc['loc'][1], ~roc['loc'][2], 0.0, 0.0, 0.0);
}, '/accxyz')

)

f.disable

f = nil