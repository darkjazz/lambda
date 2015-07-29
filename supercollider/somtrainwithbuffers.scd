(
~buffers = Array();
"/Users/alo/sounds/eclambone_samples/*".pathMatch.do({|path|
	~buffers = ~buffers.add(Buffer.read(s, path))
});
)

~buffers.collect(_.path).do(_.postln)

(
~inputs = 5;

SynthDef(\playPatch, {|out, buf|
	var sig;
	sig = PlayBuf.ar(1, buf, loop: 0, doneAction: 2);
	Out.ar(out, sig);
	Out.ar(0, sig.dup * 0.1)
}).add;

SynthDef(\train, {|in, th, sombuf|
	var remain, error, input, fft, mfcc, onsets;
	input = In.ar(in);
	fft = FFT(LocalBuf(1024), input);
	onsets = Onsets.kr(fft, th);
	mfcc = MFCC.kr(fft, ~inputs);
	SendReply.kr(onsets, '/mfcc', mfcc);
}).add;
)


(
~som = SOMap(3000, 40, ~inputs, 0.0, 1.0);
~hi = 1.0;
~lo = 0.0;

w = Window("..som..", Rect(100, 100, ~som.size * 10 + 10, ~som.size * 10 + 30)).front;
w.background = Color.grey(0.01);
t = StaticText(w, Rect(5, ~som.size * 10 + 5, ~som.size * 10, 20))
	.font_(Font("Skia", 10))
	.align_(\center)
	.stringColor_(Color.grey(0.7))
	.string_("");
w.drawHook = {
	~som.do({|node, i, j|
		var size, weights, min, max;
		min = node.weights.minItem;
		max = node.weights.maxItem; 
		if (max > ~hi) { ~hi = max };
		if (min < ~lo) { ~lo = min }; 		
		weights = node.weights; //.linexp(~lo, ~hi, 0.05, 0.95);
		Pen.color = Color(*(weights[0..2] ++ (1.0 - weights[3])));
		size = weights[4].linlin(0, 1, 0.25, 2.0);
//		Pen.color = Color.grey(node.weights.mean);
		Pen.fillRect(Rect(node.coords.x*10+5+(10-(size*10)/2),node.coords.y*10+5+(10-(size*10)/2), 10*size, 10*size));
		if (~bmu.notNil)
		{
			if ((i == ~bmu.coords.x).and(j == ~bmu.coords.y))
			{
				Pen.color = Color.grey(0.8, 0.6);
				Pen.fillOval(Rect(node.coords.x*10+5,node.coords.y*10+5, 10, 10));
			}
		}
		
	})	
};

)

~som.trainCount

(

var bus, som, resp, res;
res = OSCresponderNode(s.addr, '/mfcc', {|ti, re, ms| 
	if (~som.trainCount < ~som.trainDuration) { ~bmu = ~som.train(ms[3..7]) }
		{ ~bmu = ~som.findBMU(ms[3..7]) };
	{ w.refresh }.defer;
}).add;
CmdPeriod.add({ res.remove });
bus = Bus.audio(s);
som = Synth(\train, [\in, bus, \th, -40.dbamp]);

Routine({
	inf.do({
		~buffers.scramble.do({|buf|
			var dur;
			dur = buf.numFrames / buf.sampleRate;
			{ t.string_( buf.path.basename ) }.defer;
			Synth.before(som, \playPatch, [\out, bus, \buf, buf]);
			dur.wait;
		})
	})
	
}).play

)

~diffmap = Array.fill(~som.size - 1, { Array.fill(~som.size - 1, { 0.0 }) });

~diffmap.do({|row, i|
	row.do({|item, j|
		var nodeA, nodeB;
		nodeA = ~som.nodes[i][j];
		nodeB = ~som.nodes[i+1][j];
		~diffmap[i][j] = (nodeA.weights - nodeB.weights).squared.sum.sqrt;
	})
})

(
var win;
win = Window("..som..", Rect(100, 100, ~som.size * 10 + 10, ~som.size * 10 + 10)).front;
win.background = Color.white;
win.drawHook = {
	~som.do({|node, i, j|
		var valL, valB;
		if (~som.size - 1 > i)
		{
			valL = (node.weights - ~som.nodes[i+1][j].weights).squared.sum.sqrt;
			Pen.color = Color.grey(1 - valL);
			Pen.line(Point(i*10+15, j*10+5), Point(i*10+15, j*10+15));
			Pen.fillStroke;
		};
		if (~som.nodes.size - 1 > j)
		{
			valB = (node.weights - ~som.nodes[i][j+1].weights).squared.sum.sqrt;
			Pen.color = Color.grey(1 - valB);
			Pen.line(Point(i*10+5, j*10+15), Point(i*10+15, j*10+15));
			Pen.fillStroke;			
		}
	})
};
)

x = 0; n = 0;
~som.do({|no|
	var min, max;
	min = no.weights.minItem;
	max = no.weights.maxItem; 
	if (max > x) { x = max };
	if (min < n) { n = min }; 
})
x
n

a = Array.rand(6, -1.0, 2.0)
a.linlin(-1.0, 2.0, 0.0, 1.0)
