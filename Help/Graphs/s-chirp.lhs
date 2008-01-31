s-chirp (rd)

> let { tChoose t a = do { n <- tiRand 0 (fromIntegral (length a)) t
>                        ; return (select n (mce a)) }
>     ; x = mouseX KR 15 0 Linear 0.1 
>     ; y = mouseY KR 15 27 Linear 0.1 
>     ; scl = [0, 2, 3.2, 5, 7, 9, 10] }
> in do { t <- dust KR 9
>       ; b <- tChoose t [36, 48, 60, 72]
>       ; n <- liftM (* 0.04) (lfNoise1 KR (mce2 3 3.05))
>       ; d <- tiRand x y t
>       ; e <- liftM (decay2 t 0.005) (tRand 0.02 0.15 t)
>       ; o <- let { k = degreeToKey 0 d 12
>                  ; f = midiCPS (b + k + n)
>                  ; m = e * sinOsc AR f 0 * 0.2
>                  ; u = pulseDivider t 9 0 }
>              in do { r0 <- tRand 0.0075 0.125 u
>                    ; r1 <- tRand 0.05 0.15 u
>                    ; return (m * 0.5 + allpassC m 0.15 r0 r1) }
>       ; withSC3 (\fd -> do { async fd (b_alloc 0 7 1)
>                            ; send fd (b_setn 0 [(0, scl)])
>                            ; play fd (out 0 o) }) }