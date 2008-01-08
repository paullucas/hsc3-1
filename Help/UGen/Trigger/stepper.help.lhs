stepper trig reset min max step resetval

Stepper pulse counter.  Each trigger increments a counter which is
Soutput as a signal. The counter wraps between min and max.

trig - trigger. Trigger can be any signal. A trigger happens when the
       tsignal changes from non-positive to positive.

reset - resets the counter to resetval when triggered.

min - minimum value of the counter.

max - maximum value of the counter.

step - step value each trigger. May be negative.

resetval - value to which the counter is reset when it receives a
           rreset trigger. If nil, then this is patched to min.

> let f = stepper (impulse KR 10 0) 0 4 16 (-3) 4 * 100
> audition (out 0 (sinOsc AR f 0 * 0.1))

> let compose = foldl (flip (.)) id
>     noisec n l r = randomRs (l,r) (mkStdGen n)
>     rvb s r0 r1 r2 = compose (take 5 (zipWith3 f r0 r1 r2)) s
>         where f dl1 dl2 dc i = allpassN i 0.05 (mce [dl1,dl2]) dc
>     rvb' s = rvb s (noisec 0 0 0.05) (noisec 1 0 0.05) (noisec 2 1.5 2.0)
>     stpr = compose chn top
>         where rate = mouseX KR 1 5 Exponential 0.1
>               clock = impulse KR rate 0
>               envl = decay2 clock 0.002 2.5
>               indx = stepper clock 0 0 15 1 0
>               freq = bufRdN 1 KR 10 indx Loop
>               ffreq = lag2 freq 0.1 + mce [0, 0.3]
>               lfo = sinOsc KR 0.2 (mce [0, pi/2]) * 0.0024 + 0.0025
>               top = mix (lfPulse AR (freq * mce [1, 1.5, 2]) 0 0.3)
>               chn = [ \s -> rlpf s ffreq 0.3 * envl
>                     , \s -> rlpf s ffreq 0.3 * envl
>                     , \s -> s * 0.5
>                     , \s -> combL s 1 (0.66 / rate) 2 * 0.8 + s
>                     , \s -> s + (rvb' s * 0.3)
>                     , \s -> leakDC s 0.1
>                     , \s -> delayL s 0.1 lfo + s
>                     , \s -> onePole s 0.9 ]
>     stprInit fd = do send fd (b_alloc 10 128 1)
>                      wait fd "/done"
>                      send fd (b_setn 10 [(0, n)])
>         where n = [97.999, 195.998, 523.251, 466.164, 195.998,
>                    233.082, 87.307, 391.995, 87.307, 261.626,
>                    195.998, 77.782, 233.082, 195.998, 97.999,
>                    155.563]
> withSC3 (\fd -> do stprInit fd
>                    audition (out 0 stpr))