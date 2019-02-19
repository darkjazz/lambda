b = Bc()
Wrp(\w0, 36)
Wrp.set(\w0, \iamp, 0.0)
Wrp.set(\w0, \ramp, 1.0)

Dj.amp('r00', 0.5, 1.0)
Dj.dur('r00', 0.1, 0.4)
Dj.on('r00', 0.4)

Dj.dur('r00', 0.01, 0.1)

Dj.dur('r00', 0.1, 0.5)

Dj.on('r01', 0.3)
Dj.dur('r01', 0.1, 0.3)
Dj.amp('r01', 0.6, 1.0)

Dj.amp('r02', 0.3, 0.6)

Dj.dur('r02', 0.2, 0.4)

Dj.on('r02', 0.3)

Dj.off('r01')

Dj.dur('b04', 2.0, 4.0)
Dj.amp('b04', 0.3, 0.6)
Dj.on('b04', 0.3)

Wrp.free('w0')
Wrp('w1', 0)
Wrp.set('w1', 'ramp', 1.0)

Pb('a', 'bufind', Pw(140, 145, 11))
Pb('a', 'amp', Pw(0.3, 1.5))
Pb('a', \dur, Pw(0.3, 1.0)).play

Dj.off('r00')

Dj.off('b04')

Wrp.free('w1')

Noisefunk.makeSparsePatterns

Noisefunk.allPatterns

SparsePattern

