forest sounds (paul jones)

> let insects = do { n1 <- brownNoise AR
>                  ; n2 <- lfNoise2 KR 50
>                  ; let o = sinOsc KR (n2 * 50 + 50) 0 * 100 + 2000
>                    in return (bpf n1 o 0.001 * 10) }
> in audition . (out 0) =<< clone 2 insects

{ var insects = { var n1 = BrownNoise.ar
                ; var n2 = LFNoise2.kr(50)
                ; var o = SinOsc.kr(n2 * 50 + 50, 0) * 100 + 2000
                ; BPF.ar(n1, o, 0.001) * 10 }
; Out.ar(0, Array.fill(2, insects)) }.play

sc-users, 2007-04-06
