~nano = NanoKONTROL();
~path = "/Users/alo/dev/lambda/xcode/DerivedData/lambdaApp/Build/Products/Release/lambda.app/";
~graphics = CinderApp(1024, 768, mode: 0, path: ~path);
~decoder = FoaDecoder(decoderType: 'stereo', normalize: false);
~fx = FxBITalino(~decoder, ~graphics, ~nano)


~fx.prepare

~fx.buffers

~graphics.setAdd(0.99)

(
~ind = 4;
~active = true;
~fx.synths[~ind].active = ~active;
~fx.synths[~ind]['synth'].run(~active);
~fx.synths[~ind]['synth'].set('amp', 0.5)
)

s.queryAllNodes

~vals = "504 0 508 319 0 38 269 257 1 504 0 508 319 0 38 270 257 1 499 0 508 319 1 38 271 257 1 499 0 508 319 1 38 256 257 1 499 0 508 319 1 38 257 257 1 504 0 508 319 2 38 258 257 1 508 0 508 319 2 38 259 257 1 510 0 508 319 2 38 260 257 1 512 0 508 319 1 38 261 257 1 512 0 508 319 1 38 262 257 1 512 0 508 319 0 38 263 257 1 512".split(Char.space)

~vals.collect(_.asInt)

~transfer = {|a, n=10|
	var gemg, vcc = 3.3;
	gemg = 1000.0;
	(a/pow(2,n)) * vcc / gemg * 1000
}


~vals.collect(_.asInt).collect({|val| ~transfer.(val) })

~a = Array.primes(20, 20000)
.factors.collect(_.isPrime)




121.factors