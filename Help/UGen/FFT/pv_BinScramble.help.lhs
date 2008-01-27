pv_BinScramble buffer wipe width trig

Randomizes the order of the bins.  The trigger will select a new
random ordering.

buffer - fft' buffer.
wipe   - scrambles more bins as wipe moves from zero to one.
width  - a value from zero to one, indicating the maximum randomized
         distance of a bin from its original location in the spectrum.
trig   - a trigger selects a new random ordering.

> let fileName = "/home/rohan/audio/metal.wav"
> in withSC3 (\fd -> do { async fd (b_alloc 10 2048 1)
>                       ; async fd (b_allocRead 12 fileName 0 0) })

> let { a = playBuf 1 12 (bufRateScale KR 12) 1 0 Loop
>     ; f = fft' 10 a
>     ; x = mouseX KR 0.0 1.0 Linear 0.1
>     ; y = mouseY KR 0.0 1.0 Linear 0.1 }
> in do { g <- pv_BinScramble f x y (impulse KR 4 0)
>       ; audition (out 0 (pan2 (ifft' g) 0 0.5)) }
