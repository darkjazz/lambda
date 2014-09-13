~data = UGepLoader(16, 4).load

~pl = GepPlayer(~data, FoaDecoder(decoderType: 'stereo'), CinderApp());

~pl.decoder.start

~kinds = #['zoom', 'focus', 'press', 'push'];

~pl.start(~kinds)

#['zoom', 'focus', 'press', 'push'].do({|kind| ~pl.setFoa(kind, 1.0) })


// AREA 00: zoom
~ind0 = 0

~pl.play(~ind0, 1.0, 'zoom', 0)

~pl.set(~ind0, 0.5)

~pl.free(~ind0)


s.queryAllNodes



// AREA 01: focus
~ind1 = 1

~pl.play(~ind1, 0.0, 'zoom', 0)

~pl.set(~ind1, 0.5)

~pl.free(~ind1)



s.queryAllNodes


// AREA 02: press
~ind2 = 2

~pl.play(~ind2, 0.0, 'press', 0)

~pl.set(~ind2, 0.5)

~pl.free(~ind2)



s.queryAllNodes



// AREA 03: push
~ind3 = 3

~pl.play(~ind3, 0.0, 'press', 0)

~pl.set(~ind3, 0.5)

~pl.free(~ind3)
