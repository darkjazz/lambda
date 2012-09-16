~graphics = CinderApp();

~graphics.open
~graphics.initWorld(24, 24, 24, 8);
~graphics.initContinuous;
~graphics.setAdd(0.98);
~graphics.resetWorld(9, 9, 9, 4, 4, 4)

(
~mapNANO = {
	~nano = NanoKONTROL();
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
			~graphics.setPattern(2, 1, knob.value, 0, 0, 0.6, 0.8, 1.0);
		}
		{
			~graphics.setPattern(2, 0, knob.value, 0, 0, 0.6, 0.8, 1.0);
		}
	}; 
	~nano.knobs[0][2].action = {|knob|
		if (knob.value > 0.1) {
			~graphics.setPattern(3, 1, knob.value, 0, 0, 0.6, 0.8, 1.0);
		}
		{
			~graphics.setPattern(3, 0, knob.value, 0, 0, 0.6, 0.8, 1.0);
		}
	}; 
	~nano.knobs[0][3].action = {|knob|
		if (knob.value > 0.1) {
			~graphics.setPattern(4, 1, knob.value, 0, 0, 0.6, 0.8, 1.0);
		}
		{
			~graphics.setPattern(4, 0, knob.value, 0, 0, 0.6, 0.8, 1.0);
		}
	}; 
};
)
~mapNANO.()
