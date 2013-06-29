~decoder = FoaDecoder(decoderType: 'stereo');

~geen = LiveGeen();

~geen.loadClusters

~geen.clusters.assignments

~explore = ~geen.clusters.assignments.selectIndices({|ind| ind == 0  })

~geen.metadata[~explore.first]

~synth = ~geen.playGEPSynth(~geen.metadata[~explore.first].defname)

~synth.free

