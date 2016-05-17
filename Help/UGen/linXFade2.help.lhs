> Sound.SC3.UGen.Help.viewSC3Help "LinXFade2"
> Sound.SC3.UGen.DB.ugenSummary "LinXFade2"

> import Sound.SC3

> let o = linXFade2 (saw AR 440) (sinOsc AR 440 0) (lfTri KR 0.1 0) * 0.1
> in audition (out 0 o)

> let o = linXFade2 (fSinOsc AR 800 0 * 0.2)
>                   (pinkNoise 'α' AR * 0.2)
>                   (fSinOsc KR 1 0)
> in audition (out 0 o)