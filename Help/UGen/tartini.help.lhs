> Sound.SC3.UGen.Help.viewSC3Help "Tartini"
> Sound.SC3.UGen.DB.ugenSummary "Tartini"

> import Sound.SC3

Comparison of input frequency (x) and tracked oscillator frequency (f).

> let {x = mouseX KR 440 880 Exponential 0.1
>     ;o = lfSaw AR x 0 * 0.05 {- sinOsc AR x 0 * 0.1 -}
>     ;[f,e] = mceChannels (tartini KR o 0.2 2048 0 1024 0.5)
>     ;r = sinOsc AR f 0 * 0.1
>     ;t = impulse KR 4 0
>     ;pf = poll t f (label "f") 0
>     ;px = poll t x (label "x") 0}
> in audition (mrg [out 0 (mce2 o r),pf,px])

Fast test of live pitch tracking, not careful with amplitude of input

> let {z = soundIn 4
>     ;[f,e] = mceChannels (tartini KR z 0.2 2048 0 1024 0.5)}
> in audition (out 0 (saw AR f * 0.05 * e))
