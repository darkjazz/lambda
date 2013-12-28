(
~text = "sparsematrix is a computational experiment in the form of an audiovisual performance that explores computation as an aesthetic substrate for human culture. the dominant principle here is the assumption that all processes in nature are in essence algorithmic, in fact, all general physical processes are dominated by simple algorithmic rules. the algorithm becomes the aesthetic in the process of the human performer interacting with the machine by instructing it in code. transcriptions of traditional rhythmic patterns, which have been subjected to conditions of sparsity, provide the raw structuring material. sparse matrix is a mathematical idea applied here to dense rhythmic patterns in order to discover the skeletal structures of rhythm loops form various african traditions Ð arguably one of the most enduring of cultural practices - filling the event cycles primarily with silences and turning the attention to pure perception of time stripped of the baggage of cultural connotations. perception is inescapably multimodal and audiovisual cognition is a hard-wired reality we may at times wish to inhibit through specialization, nonetheless a reality we invariably inhabit. the visual component of the performance employs another type of a simple (artificial life) algorithm from the theory of computation Ð that of multi-dimensional cellular automata which is essentially a model of complex behaviour. the automata receive data flow from audio analysis of the rhythm loops in the form of onset triggers and spectral analysis and respond in spontaneous patterns of computer graphics which the live coding can only influence to a point, establishing an heterogeneous relationship between performer and this multimodal instrument, rather than the more traditional idea of one-directional flow of control.";

~output = "sparsematrix";

~markov = MarkovSet();

~text.split(Char.space).doAdjacentPairs({|a, b|
	~markov.read(a, b)
});

~word = "is";
200.do({
	~output = ~output + ~word;
	~word = ~markov.next(~word)
});

~output.replace("nil", "")
)