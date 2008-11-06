tgrn (rd)

> import Sound.SC3
> import qualified Sound.SC3.UGen.Base as B

> let { fn = "/home/rohan/audio/text.snd"
>     ; tgrn b = let { trate = mouseY kr 2 120 Exponential 0.1
>                    ; dur = 1.2 / trate
>                    ; clk = impulse ar trate 0
>                    ; pos = mouseX kr 0 (bufDur kr b) Linear 0.1
>                    ; pan = B.whiteNoise (uid 1) kr * 0.6
>                    ; n = roundE (B.whiteNoise (uid 2) kr * 3) 1
>                    ; rate = shiftLeft 1.2 n }
>                in tGrains 2 clk b rate pos dur pan 0.25 2 }
> in withSC3 (\fd -> do { async fd (b_allocRead 10 fn 0 0)
>                       ; audition (out 0 (tgrn 10)) })
