shifting pulses (rd)

> do { [n0, n1, n2] <- replicateM 3 (clone 2 (brownNoise KR))
>    ; t <- dust KR 0.75
>    ; let { warp i = linLin i (-1) 1
>          ; l = latch t t
>          ; p = pulse AR (warp n0 2 (mce2 11 15)) 0.01 * 0.1 
>          ; f = warp n1 300 1800 
>          ; rq = warp n2 0.01 2 }
>      in audition (out 0 (l * rlpf p f rq)) }