~lib = MadmomFeatureLib("/Users/alo/dev/reveries/audio.json")

~set = ~lib.sets['everything']


~lib.sets


~observations = ~lib.sets['everything'].collectChordEnums

~set = MarkovSet


~hmmc = HMM(17, Chord.basicTriads.size)


(
{
	~hmmc.train(~observations.bubble, 100)
}.fork
)



(
{
	~seq = ~hmmc.generate(64)
}.fork;
~seq
)

~hmmc.generate(64)


~set.collectChord ~seq.collect({|index| Chord.triadEnum[index] })

~fseq = ~set.collectChordsFreqs(5).collect(_.chord).select(_.isEmpty.not)



~intervals = ~set.collectChordsTimeIntervals.round(0.1)

~intervalEnum = ~intervals.asSet.asArray.sort

~intervalObservations = ~intervals.collect({|interval| ~intervalEnum.indexOf(interval) });



~hmmi = HMM(5, ~intervalEnum.size);


(
{
	~hmmi.train(~intervalObservations.bubble, 10)
}.fork
)

(
{
	~seqi = ~hmmi.generate(64)
}.fork
)


~seqi.collect({|index| ~intervalEnum[index] })



