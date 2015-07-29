(
~keys = Array();
~file = File.open("/Users/alo/SOVARR/dev/analyze/gentlemanTonicPitch.txt", "r");
~text = ~file.readAllString;
~file.close;

~rows = ~text.split(Char.nl).select({|it| it != "" });

~events = ~rows.collect({|row|
	[#[time, octave, key], row.split(Char.tab)].lace(6).asArgsDict;
}).collect({|ev|
	var note;
	if ((ev['key'].size > 1).and(ev['key'][1] == $#))
	{
		ev['note'] = ev['key'].keep(2).toLower ++ ev['octave']
	}
	{
		ev['note'] = ev['key'][0].asString.toLower ++ " " ++ ev['octave']
	};
	ev['freq'] = ev['note'].notemidi.midicps;
});

)

~events.collect(_.note).collect(_.notemidi).collect(_.midicps)

102.midinote

notemidi