(
~ncoef = 20;
~dur = 8 * 60;

//~netaddr = NetAddr("98.151.254.234", 7000);
~decoder = FoaDecoder(decoderType: 'stereo');
~graphics = CinderApp(mode: 1);
)


(
{
~input = MikroFoaInput(~decoder);

~analyzer = MikroAnalyzer(maxdur: ~dur, numcoef: ~ncoef, recordInput: false, isMono: false);

~mikro = Mikro(~input, ~graphics, ~analyzer);
~geenLambda = GeenLambda(~mikro, ~decoder, ~dur);

~geenLambda.prepare
}.bench
)

MikroData.loadPath = "/Users/alo/Data/mikro/lib001/";

~geen = MikroGeen()

{ ~geen.loadClusters }.bench	// time to run: 2.1901387089999 seconds.

{ ~geen.updateClusters }.bench	// time to run: 58.466470958 seconds.

{ ~geen.loadEventData }.bench

{ ~geen.trainSets }.bench // time to run: 24.328915094 seconds.

{ ~geen.loadSets }.bench // time to run: 0.85765976499533 seconds.


MikroData.loadPath = "/Users/alo/Data/mikro/lib001/";

~geen = MikroGeen()

~geen
~geen.updateClusters

~geen.clusters.saveData


~geenLambda.geen.eventData

~geenLambda.geen.durSet.dict

a=MikroData.loadPath.split($/)
a.pop
a.last


~geenLambda.geen.archiveSets

