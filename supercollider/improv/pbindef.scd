b = Bc()

Wrp('w0', 36)

Wrp.set('w0', 'wamp', 1.0)
Wrp.set('w0', 'iamp', 1.0)

Wrp.free('w0')


Pb('a', 'amp', Pw(0.3, 1.5))

Pb('a', 'dur', Pw(0.3, 0.5))
.play

Pb('a', 'delta', Pr(1/[1,2,4,6] * ~mx.beatdur, inf))
Pb('a', 'env', Pr(~mx.envs['perc00'].bubble, inf));
Pb('a', 'bufind', Pw(140, 145, 11))
Pb('a', 'buf', Pkey('bufind'))
Pb('a', Pf({|ev| ev['buf'].postln }))
Pp(\a, \b)

Pb('a', 'delta', Pr(1/[1,2,3,4],inf))

s.scope(2)


Wrp.wrps


Dj.dur('b03', 0.1, 0.2)
Dj.amp('b03', 0.5, 1.0)

Dj.on('b03', 0.2)

Dj.dur('b04', 2.0, 4.0)
Dj.amp('b04', 0.4, 0.8)
Dj.on('b04', 0.2)

Dj.off('b03')

Dj.off('b04')

Wrp.free('w0')