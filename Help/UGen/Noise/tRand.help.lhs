tRand lo hi trig

Generates a random float value in uniform distribution from lo each
time the trig signal changes from nonpositive to positive values

> f <- tRand (MCE [200, 1600]) (MCE [500, 3000]) =<< dust KR (MCE [5, 12])
> audition (out 0 (sinOsc AR f 0 * 0.2))
